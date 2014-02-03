#! /bin/bash

[ "${BASH_SOURCE[0]}" != "${0}" -a "${#BASH_SOURCE[@]}" -ne 0 ] \
|| {
	printf "${BASH_SOURCE[0]:-${0:-}}: %s\n" \
		"This code was made for sourcin'!"
	exit 1
}

function curl_env ()
#
#
#
{
	#
	export curl_env_{dbg,ext,hin,hdr,out,err}=
	for VAR in curl_env_{dbg,ext,hin,hdr,out,err}
	do
		eval "${VAR}=()"
	done

	#
	for ENT in "${@:-}"
	do
		case "${ENT}" in
		( -h* | --help )  curl_env_flg_help=1;;
		( --curl-help )   curl_env_flg_help=2;;
		( --curl-manual ) curl_env_flg_help=3;;
		esac
	done

	#
	[ "${curl_env_flg_help:-0}" -eq 0 ] \
	|| { {
		printf "\n"
		printf "${FUNCNAME[0]:-${BASH_SOURCE[0]:-${0:-}}}: %s\n" \
		"This function sets global shell variables," \
		"and therefore must not be run in a subshell." \
		"Do not pipe the output of this function." \
		"Instead, you may do something like this.." \
		"{ TMP=\"\$( curl_env icanhazip.com )\"; echo \"\${TMP}\" | __YOUR_PARSER__; }" \
		"NOTE: Only run curl_env against *one* URL at a time. =]"
		printf "\n"
	} 1>&2; return 1; }

	#
	declare CURL_ENV_DEBUG="${CURL_ENV_DEBUG:-0}"
	declare {TMP,ENT,TAG}=
	declare TAG="${RANDOM}${SECONDS}"

	#
	for VAR in CURL_{DBG,CMD,RAW}
	do
		eval "declare ${VAR}=()"
	done
	CURL_RAW=(
		curl
		-sv
		"${@:-}"
	)

	[ "${CURL_ENV_DEBUG:-0}" -lt 9 ] || echo 1>&2
	for ENT in "${CURL_RAW[@]}"
	do
		TMP=
		[ "${CURL_ENV_DEBUG:-0}" -lt 9 ] || \
		printf "{ %q }\n" "${ENT}" 1>&2
		printf -v ENT "%q" "${ENT}"
		CURL_CMD[${#CURL_CMD[@]}]="${ENT}"
		[[ "${ENT}" =~ \\ ]] || \
		{ CURL_DBG[${#CURL_DBG[@]}]="${ENT}"; continue; }
		while [[ "${ENT}" =~ ([^\\]*)([\\])(.)(.*) ]]
		do
			TMP="${TMP}${BASH_REMATCH[1]}"
			[ "${BASH_REMATCH[3]}" != "\"" ] || \
			TMP="${TMP}\\"
			TMP="${TMP}${BASH_REMATCH[3]}"
			ENT="${BASH_REMATCH[4]}"
			[ "${CURL_ENV_DEBUG:-0}" -lt 9 ] || \
			printf "( %s ) ( %s )\n" "${ENT}" "${TMP}" 1>&2
		done
		CURL_DBG[${#CURL_DBG[@]}]='"'"${TMP}${ENT}"'"'
	done

	[ "${CURL_ENV_DEBUG:-0}" -lt 9 ] || echo 1>&2
	[ "${CURL_ENV_DEBUG:-0}" -lt 1 ] || \
	echo "+ ${CURL_DBG[*]}" 1>&2
	[ "${CURL_ENV_DEBUG:-0}" -lt 8 ] || echo 1>&2

	TMP="$(
		printf -v NLN "\n"
		printf -v CRT "\r"
		IFS="${NLN}"
		{
			eval "${CURL_CMD[@]}" \
				-o >( while read -r ENT; do echo "1 ${ENT}"; done ) \
				2> >( while read -r ENT; do echo "2 ${ENT}"; done )
			echo "3 ${?}"
		} |
		tee >( { [ "${CURL_ENV_DEBUG}" -lt 8 ] && cat - >/dev/null || cat -vet 1>&2; } ) |
		{
			while read -r ENT
			do
				[[ "${ENT}" =~ ^([123])(.?)(.?)(.?)(.*)$ ]] || :
				case "${BASH_REMATCH[1]:-}" in
				( 3 ) curl_env_ext[${#curl_env_ext[@]}]="${ENT:2:1}";;
				( 1 ) curl_env_out[${#curl_env_out[@]}]="${ENT:2}";;
				( 2 ) {
					ENT="${ENT%${CRT}}"
					case "${BASH_REMATCH[3]:-}" in
					( "*" ) curl_env_dbg[${#curl_env_dbg[@]}]="${ENT:4}";;
					( "<" ) [ "${ENT:4}" == "" ] || curl_env_hdr[${#curl_env_hdr[@]}]="${ENT:4}";;
					( ">" ) [ "${ENT:4}" == "" ] || curl_env_hin[${#curl_env_hin[@]}]="${ENT:4}";;
					( "{" ) :;;
					( * ) { curl_env_err[${#curl_env_err[@]}]="${ENT:2}"; echo "? ${ENT:2}" 1>&2; };;
					esac
				};;
				esac
			done
			for VAR in curl_env_{dbg,ext,hin,hdr,out,err}
			do
				VAL="$( declare -p ${VAR} )"
				VAL="${VAL#*\'}"
				VAL="${VAL%\'*}"
				echo "${VAR}=${VAL}"
			done
		}
	)"

	eval "${TMP}"

	[ "${CURL_ENV_DEBUG}" -lt 4 ] || { echo; printf "* %s\n" "${curl_env_dbg[@]}"; } 1>&2
	[ "${CURL_ENV_DEBUG}" -lt 5 ] || { printf "! %s\n" "${curl_env_ext[@]}"; } 1>&2
	[ "${CURL_ENV_DEBUG}" -lt 3 ] || { echo; printf "> %s\n" "${curl_env_hin[@]}"; } 1>&2
	[ "${CURL_ENV_DEBUG}" -gt 1 ] || { echo "${curl_env_hdr[0]:-NO_HEADERS}"; } 1>&2
	[ "${CURL_ENV_DEBUG}" -lt 2 ] || { echo; printf "< %s\n" "${curl_env_hdr[@]}"; } 1>&2
	[ "${CURL_ENV_DEBUG}" -lt 2 ] || { echo; } 1>&2
	[ "${CURL_ENV_DEBUG}" -lt 2 -a -t 1 ] || printf "%s\n" "${curl_env_out[@]}"
	[ "${CURL_ENV_DEBUG}" -lt 5 -o "${#curl_env_err[*]}" -eq 0 ] || { echo; printf "? %s\n" "${curl_env_err[@]}"; } 1>&2

	return ${curl_env_ext[0]:-100}

}
