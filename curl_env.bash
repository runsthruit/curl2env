#! /bin/bash

function curl_env ()
#
#
#
{

	#
	declare __curl_env_locv_{fnc,tmp,ent,var,val,tag,chr_{nln,crt}}=
	for __curl_env_locv_var in __curl_env_locv_{opts,write_vars,cmd{,_{dbg,raw}}}
	do
		eval "declare ${__curl_env_locv_var}=()"
	done
	printf -v __curl_env_locv_chr_nln "\n"
	printf -v __curl_env_locv_chr_crt "\r"
	__curl_env_locv_fnc="${FUNCNAME[0]:-}"
	__curl_env_locv_tag="${RANDOM}${SECONDS}"
	__curl_env_locv_write_vars=(
		url_effective http_code http_connect
		time_total time_namelookup time_connect time_appconnect
		time_pretransfer time_redirect time_starttransfer
		size_download size_upload size_header size_request
		speed_download speed_upload
		content_type num_connects
		num_redirects redirect_url ftp_entry_path ssl_verify_result
	)

	#
	export DEBUG_CURL_ENV="${DEBUG_CURL_ENV:-0}"
	for __curl_env_locv_var in curl_env_{dbg,ext,hin,hdr,out,err,stt}
	do
		eval "export ${__curl_env_locv_var}"
		eval "${__curl_env_locv_var}=()"
	done

	#
	declare __curl_env_locv_flg_{help,init,exec}=0
	for __curl_env_locv_ent in "${@:-}"
	do
		case "${__curl_env_locv_ent}" in
		( -h* | --help )  __curl_env_locv_flg_help=1;;
		( --curl-help )   __curl_env_locv_flg_help=2;;
		( --curl-manual ) __curl_env_locv_flg_help=3;;
		( --init )        __curl_env_locv_flg_init=1;;
		( --exec )        __curl_env_locv_flg_exec=1;;
		( * )             __curl_env_locv_opts[${#__curl_env_locv_opts[@]}]="${__curl_env_locv_ent}";;
		esac
	done

	#
	[ "${__curl_env_locv_flg_init:-0}" -eq 0 -o "${__curl_env_locv_flg_exec:-0}" -eq 1 ] \
	&& {
		[ "${__curl_env_locv_opts[*]}" != "" ] \
		|| __curl_env_locv_flg_help=$((__curl_env_locv_flg_help?${__curl_env_locv_flg_help}:1))
	} \
	|| {
		[ "${BASH_SOURCE[0]}" != "${0}" -a "${#BASH_SOURCE[@]}" -ne 0 ] \
		|| {
			sed "s/^/  /" <<-'EOF'

			###

			You are attempting to run this function as a script.
			It's really meant to be run within your shell session.
			If you really wish to run it as a script, then provide this argument..

			--exec
			EOF
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

		DEBUG::

		Set DEBUG_CURL_ENV to ever greater values to see a bunch of extra output to your session.

		NOTES::
		
		Only run curl_env against *one* URL at a time. ( For now.. =] )

		To force the usage of this function from within its source (as a script)..

		--exec

		###
		EOF
		return 0
	} 2>&1

	#
	__curl_env_locv_cmd_raw=(
		curl
		-sv
		"${__curl_env_locv_opts[@]:-}"
	)

	[ "${DEBUG_CURL_ENV:-0}" -lt 9 ] || echo 1>&2
	for __curl_env_locv_ent in "${__curl_env_locv_cmd_raw[@]}"
	do
		__curl_env_locv_tmp=
		[ "${DEBUG_CURL_ENV:-0}" -lt 9 ] || \
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
			[ "${DEBUG_CURL_ENV:-0}" -lt 9 ] || \
			printf "( %s ) ( %s )\n" "${__curl_env_locv_ent}" "${__curl_env_locv_tmp}" 1>&2
		done
		__curl_env_locv_cmd_dbg[${#__curl_env_locv_cmd_dbg[@]}]='"'"${__curl_env_locv_tmp}${__curl_env_locv_ent}"'"'
	done

	[ "${DEBUG_CURL_ENV:-0}" -lt 9 ] || echo 1>&2
	[ "${DEBUG_CURL_ENV:-0}" -lt 1 ] || \
	echo "+ ${__curl_env_locv_cmd_dbg[*]}" 1>&2
	[ "${DEBUG_CURL_ENV:-0}" -lt 8 ] || echo 1>&2

	__curl_env_locv_tmp="$(
		IFS="${__curl_env_locv_chr_nln}"
		{
			eval "${__curl_env_locv_cmd[@]}" \
				-w "\"$( printf "2 = %s=%%{%s}\\\n" $( for I in "${__curl_env_locv_write_vars[@]}"; do echo "${I}"; echo "${I}"; done ) )\"" \
				-o >( sed "s=^=1 . =" ) \
				2> >( sed "s=^=2 =" )
			echo "3 ${?}"
		} |
		tee >( { [ "${DEBUG_CURL_ENV}" -lt 8 ] && cat - >/dev/null || cat -vet 1>&2; } ) |
		{
			while read -r __curl_env_locv_ent
			do
				[[ "${__curl_env_locv_ent}" =~ ^([123])(.?)(.?)(.?)(.*)$ ]] || :
				case "${BASH_REMATCH[1]:-}" in
				( 3 ) curl_env_ext[${#curl_env_ext[@]}]="${__curl_env_locv_ent:2:1}";;
				( 1 ) {
					case "${BASH_REMATCH[3]:-}" in
					( "." ) curl_env_out[${#curl_env_out[@]}]="${__curl_env_locv_ent:4}";;
					esac
				};;
				( 2 ) {
					__curl_env_locv_ent="${__curl_env_locv_ent%${__curl_env_locv_chr_crt}}"
					case "${BASH_REMATCH[3]:-}" in
					( "*" ) {
						[ "${__curl_env_locv_ent:4}" == "" ] \
						|| curl_env_dbg[${#curl_env_dbg[@]}]="${__curl_env_locv_ent:4}"
					};;
					( "=" ) {
						[ "${__curl_env_locv_ent:4}" == "" ] \
						|| curl_env_stt[${#curl_env_stt[@]}]="${__curl_env_locv_ent:4}"
					};;
					( "<" ) {
						[ "${__curl_env_locv_ent:4}" == "" ] \
						|| curl_env_hdr[${#curl_env_hdr[@]}]="${__curl_env_locv_ent:4}"
					};;
					( ">" ) {
						[ "${__curl_env_locv_ent:4}" == "" ] \
						|| curl_env_hin[${#curl_env_hin[@]}]="${__curl_env_locv_ent:4}"
					};;
					( "{" ) :;;
					( * ) {
						curl_env_err[${#curl_env_err[@]}]="${__curl_env_locv_ent:2}"
						echo "? ${__curl_env_locv_ent:2}" 1>&2
					};;
					esac
				};;
				esac
			done
			for __curl_env_locv_var in curl_env_{dbg,ext,hin,hdr,out,err,stt}
			do
				__curl_env_locv_val="$( declare -p ${__curl_env_locv_var} )"
				__curl_env_locv_val="${__curl_env_locv_val#*\'}"
				__curl_env_locv_val="${__curl_env_locv_val%\'*}"
				echo "${__curl_env_locv_var}=${__curl_env_locv_val}"
			done
		}
	)"

	eval "${__curl_env_locv_tmp}"

	[ "${DEBUG_CURL_ENV}" -lt 4 ] || { echo; printf "* %s\n" "${curl_env_dbg[@]}"; } 1>&2
	[ "${DEBUG_CURL_ENV}" -lt 5 ] || { printf "! %s\n" "${curl_env_ext[@]}"; } 1>&2
	[ "${DEBUG_CURL_ENV}" -lt 6 ] || { echo; printf "= %s\n" "${curl_env_stt[@]}"; } 1>&2
	[ "${DEBUG_CURL_ENV}" -lt 3 ] || { echo; printf "> %s\n" "${curl_env_hin[@]}"; } 1>&2
	[ "${DEBUG_CURL_ENV}" -gt 1 ] || { echo "${curl_env_hdr[0]:-NO_HEADERS}"; } 1>&2
	[ "${DEBUG_CURL_ENV}" -lt 2 ] || { echo; printf "< %s\n" "${curl_env_hdr[@]}"; } 1>&2
	[ "${DEBUG_CURL_ENV}" -lt 2 ] || { echo; } 1>&2
	[ "${DEBUG_CURL_ENV}" -lt 2 -a -t 1 -a "${__curl_env_locv_flg_exec:-0}" -eq 0 ] || printf "%s\n" "${curl_env_out[@]}"
	[ "${DEBUG_CURL_ENV}" -lt 5 -o "${#curl_env_err[*]}" -eq 0 ] \
	|| { echo; printf "? %s\n" "${curl_env_err[@]}"; } 1>&2

	return ${curl_env_ext[0]:-100}

}

curl_env --init ${@:+"${@}"}
