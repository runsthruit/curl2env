#! /bin/bash

function curl_env ()
#
#
#
{

	#
	declare __curl_env_locv_{fnc,tmp,ent,var,val,tag}=
	__curl_env_locv_fnc="${FUNCNAME[0]:-}"
	__curl_env_locv_tag="${RANDOM}${SECONDS}"

	#
	export CURL_ENV_DEBUG="${CURL_ENV_DEBUG:-0}"
	export curl_env_{dbg,ext,hin,hdr,out,err}=
	for __curl_env_locv_var in curl_env_{dbg,ext,hin,hdr,out,err}
	do
		eval "${__curl_env_locv_var}=()"
	done

	#
	declare __curl_env_locv_flg_{help,init}=0
	for __curl_env_locv_ent in "${@:-}"
	do
		case "${__curl_env_locv_ent}" in
		( -h* | --help )  __curl_env_locv_flg_help=1;;
		( --curl-help )   __curl_env_locv_flg_help=2;;
		( --curl-manual ) __curl_env_locv_flg_help=3;;
		( --init )        __curl_env_locv_flg_init=1;;
		esac
	done
	[ "${#@}" -ne 0 ] ||      __curl_env_locv_flg_help=1

	#
	[ "${__curl_env_locv_flg_init:-0}" -eq 0 ] \
	|| {
		[ "${BASH_SOURCE[0]}" != "${0}" -a "${#BASH_SOURCE[@]}" -ne 0 ] \
		|| {
			printf "${BASH_SOURCE[0]:-${0:-}}: %s\n" \
			"This code was made for sourcin'!"
			return 1
		}
		return 0
	}

	#
	[ "${__curl_env_locv_flg_help:-0}" -eq 0 ] \
	|| {
		[ "${__curl_env_locv_flg_help:-0}" -lt 2 ] || { curl --help; }
		[ "${__curl_env_locv_flg_help:-0}" -lt 3 ] || { curl --manual; }
		[ "${__curl_env_locv_flg_help:-0}" -gt 1 ] \
		|| {
		sed "s/^/  /" <<-'EOF'

		###

		To view curl help or manual, provide these options to CURL_ENV..
		
		--curl-help

		--curl-manual

		EOF
		}
		sed "s/^/  /" <<-'EOF'

		###

		The CURL_ENV function sets global shell variables, and therefore must not be run in a subshell.

		Instead, you may do something like this..

		{ TMP="$( curl_env icanhazip.com )"; echo "${TMP}" | __YOUR_PARSER__; }

		If you *do* pipe this command, it will echo its output for use on stdin to other commands.

		{ curl_env icanhazip.com | __YOUR_PARSER__; }

		NOTE: Only run curl_env against *one* URL at a time. ( For now.. =] )

		###
		EOF
		return 0
	} 2>&1

	#
	for __curl_env_locv_var in __curl_env_locv_cmd{,_{dbg,raw}}
	do
		eval "declare ${__curl_env_locv_var}=()"
	done
	__curl_env_locv_cmd_raw=(
		curl
		-sv
		"${@:-}"
	)

	[ "${CURL_ENV_DEBUG:-0}" -lt 9 ] || echo 1>&2
	for __curl_env_locv_ent in "${__curl_env_locv_cmd_raw[@]}"
	do
		__curl_env_locv_tmp=
		[ "${CURL_ENV_DEBUG:-0}" -lt 9 ] || \
		printf "{ %q }\n" "${__curl_env_locv_ent}" 1>&2
		printf -v __curl_env_locv_ent "%q" "${__curl_env_locv_ent}"
		__curl_env_locv_cmd[${#__curl_env_locv_cmd[@]}]="${__curl_env_locv_ent}"
		[[ "${__curl_env_locv_ent}" =~ \\ ]] || \
		{ __curl_env_locv_cmd_dbg[${#__curl_env_locv_cmd_dbg[@]}]="${__curl_env_locv_ent}"; continue; }
		while [[ "${__curl_env_locv_ent}" =~ ([^\\]*)([\\])(.)(.*) ]]
		do
			__curl_env_locv_tmp="${__curl_env_locv_tmp}${BASH_REMATCH[1]}"
			[ "${BASH_REMATCH[3]}" != "\"" ] || \
			__curl_env_locv_tmp="${__curl_env_locv_tmp}\\"
			__curl_env_locv_tmp="${__curl_env_locv_tmp}${BASH_REMATCH[3]}"
			__curl_env_locv_ent="${BASH_REMATCH[4]}"
			[ "${CURL_ENV_DEBUG:-0}" -lt 9 ] || \
			printf "( %s ) ( %s )\n" "${__curl_env_locv_ent}" "${__curl_env_locv_tmp}" 1>&2
		done
		__curl_env_locv_cmd_dbg[${#__curl_env_locv_cmd_dbg[@]}]='"'"${__curl_env_locv_tmp}${__curl_env_locv_ent}"'"'
	done

	[ "${CURL_ENV_DEBUG:-0}" -lt 9 ] || echo 1>&2
	[ "${CURL_ENV_DEBUG:-0}" -lt 1 ] || \
	echo "+ ${__curl_env_locv_cmd_dbg[*]}" 1>&2
	[ "${CURL_ENV_DEBUG:-0}" -lt 8 ] || echo 1>&2

	__curl_env_locv_tmp="$(
		printf -v NLN "\n"
		printf -v CRT "\r"
		IFS="${NLN}"
		{
			eval "${__curl_env_locv_cmd[@]}" \
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

	eval "${__curl_env_locv_tmp}"

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

curl_env --init
