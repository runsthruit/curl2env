#! /dev/null/bash

function curl_env ()
{

    # BASH_FUNCTION_INIT # INIT # DO NOT TOUCH # {{{

    # Pickup the last command exit code.
    # Don't put *ANYTHING* before this in your function.
    # Otherwise, you will lose the ability to store the previous return value.
    # Will add it to vars_il_ and vars____ later on, so it doesn't get erased.
    declare -ir pre_return=${?}

    # BASH_FUNCTION_INIT # INIT # DO NOT TOUCH # }}}

    # BASH_FUNCTION_INIT # SETUP # YOUR CODE HERE # START

    # Additions to opts_valid go here.
    opts_valid=(
        manual
        out
        curl_help
        curl_manual
    )

    # Additions to string variables go here.
    # Local, Local-export, Global, Global-export
    vars_sl_=(
        rgx_time
        rgx_info
        rgx_xmit
        rgx_stat
        rgx_exit
        stg
    )
    vars_slx=()
    vars_sg_=()
    vars_sgx=()
    # Additions to array variables go here.
    # Local, Local-export, Global, Global-export
    vars_al_=(
	write_out_vars
        curl_cmd
    )
    vars_alx=()
    vars_ag_=(
        curl_env_dbg
        curl_env_ext
        curl_env_hin
        curl_env_hdr
        curl_env_out
        curl_env_stt
        curl_env_ssl
        curl_env_unk
    )
    vars_agx=()
    # Additions to integer variables go here.
    # Local, Local-export
    vars_il_=()
    vars_ilx=()

    # BASH_FUNCTION_INIT # SETUP # YOUR CODE HERE # FINISH

    # BASH_FUNCTION_INIT # SETUP # DO NOT TOUCH # {{{

    # Special variable for setting valid options names.
    # This variable will be added to vars_al_ and vars____ later on.
    declare opts_valid=(
        help    # Flag for common help option.
        debug   # Debug level.
        ${opts_valid[*]}
    )

    # Default local strings.
    declare vars_sl_=(
        fnc         # Shorthand for function name.
        dbg         # Debug level of function, allowing non-integer value.
        tmp         # Default temporary variable.
        tc_spc      # Easy ref to space char.
        tc_tab      # Easy ref to tab char.
        tc_nln      # Easy ref to newline char.
        tc_crt      # Easy ref to carriage-return char.
        tc_tilde    # Easy ref to tilde char.
        tc_fslash   # Easy ref to forward-slash '/' char.
        tc_bslash   # Easy ref to back-slash '\' char.
        tc_dquote   # Easy ref to double-quote '"' char.
        tc_squote   # Easy ref to single-quote "'" char.
        tc_bang     # Easy ref to exclamation '!' char.
        tc_tick     # Easy ref to backtick '`' char.
        tc_dollar   # Easy ref to dollar-sign '$' char.
        IFS_DEF     # Easy ref to default IFS ' \t\n'.
        IFS_TN      # Easy ref to alternate IFS '\t\t\n'.
        IFS_N       # Easy ref to alternate IFS '\n\n\n'.
        IFS_RGX     # Easy ref to alternate IFS '|\n\n', mainly for using globbing to create a regex.
        IFS         # Allows local override of IFS.
        rgx         # Default regex string variable.
        rgx_sess    # An unique(?) string; usually for delimiting.
        ${vars_sl_[*]}
    )
    # Default local export strings.
    declare vars_slx=( ${vars_slx[*]} )
    # Default global strings.
    declare vars_sg_=( ${vars_sg_[*]} )
    # Default global export strings.
    declare vars_sgx=( ${vars_sgx[*]} )

    # Default arrays.
    declare vars_al_=(
        args        # Array of function args, with options removed.
        eargs       # Quoted/Sanitized/Pretty args for eval/debug/print.
        tmps        # Default temporary array.
        ${vars_al_[*]}
    )
    declare vars_alx=( ${vars_alx[*]} )
    declare vars_ag_=( ${vars_ag_[*]} )
    declare vars_agx=( ${vars_agx[*]} )

    # Default integers.
    # Btw, I don't know how to create global integer vars. =]
    declare vars_il_=(
        fnc_return  # Return value for this function.
        I J K       # Common iterators.
        flg_file0   # STDIN  is open?
        flg_file1   # STDOUT is open?
        flg_file2   # STDERR is open?
        ${vars_il_[*]}
    )
    declare vars_ilx=( ${vars_ilx[*]} )

    # Collect variables to be exported.
    declare vars___x=(
        ${vars_slx[*]} ${vars_sgx[*]}
        ${vars_alx[*]} ${vars_agx[*]}
        ${vars_ilx[*]}
    )
    # Collect all variables, mostly for reporting/debug.
    declare vars____=(
        ${vars_sl_[*]}
        ${vars_al_[*]}
        ${vars_il_[*]}
        ${vars_sg_[*]}
        ${vars_ag_[*]}
        ${vars___x[*]}
    )
    # Add options from opts_valid to variable collections.
    vars_sl_=( ${opts_valid[*]/#/opt_} ${vars_sl_[*]} )
    vars____=( ${opts_valid[*]/#/opt_} ${vars____[*]} )

    # Create array variables.
    for tmp in ${vars_ag_[*]} ${vars_agx[*]}
    do
        printf -v tmp '%s=( "${%s[@]}" )' "${tmp}" "${tmp}"
        eval "${tmp}"
    done
    # Create string variables.
    for tmp in ${vars_sg_[*]} ${vars_sgx[*]}
    do
        printf -v tmp '%s="${%s}"' "${tmp}" "${tmp}"
        eval "${tmp}"
    done
    # Localize string variables.
    for tmp in ${vars_sl_[*]} ${vars_slx[*]}; do declare    ${tmp}; done
    # Localize array variables.
    for tmp in ${vars_al_[*]} ${vars_alx[*]}; do declare -a ${tmp}; done
    # Localize integer variables and set (to zero).
    for tmp in ${vars_il_[*]} ${vars_ilx[*]}; do declare -i ${tmp}; eval "${tmp}="; done
    # Export appropriate variables.
    for tmp in ${vars___x[*]}; do export ${tmp}; done
    # Collection of export variables is no longer needed.
    unset vars___x
    tmp=

    # Add opts_valid to variable collections.
    vars_al_=( opts_valid ${vars_al_[*]} )
    vars____=( opts_valid ${vars____[*]} )
    # Add pre_return to variable collections.
    vars_il_=( pre_return ${vars_il_[*]} )
    vars____=( pre_return ${vars____[*]} )

    # Set function name variable.
    fnc="${FUNCNAME[0]}"
    # Set default function return value.
    fnc_return=0

    # Determine all-caps debug variable name for function.
    tmp="DEBUG_${fnc}"
    tmps=( {a..z} {A..Z} )
    for (( I=0; I<26; I++ ))
    do
        tmp="${tmp//${tmps[${I}]}/${tmps[$((I+26))]}}"
    done
    # Set 'dbg' to environment debug level value.
    # Triple-'}' messes with vim folding, so crappy fix is to break this apart.
    printf -v tmp 'dbg="${%s:-${%s:-}}"' "${tmp}" "${tmp#DEBUG_}_DEBUG"
    eval "${tmp}"
    printf -v tmp 'dbg="${dbg:-${DEBUG:-0}}"'
    eval "${tmp}"
    # Clear used variables.
    tmps=()
    tmp=
    I=

    # Set some default term char references.
    printf -v tc_spc    ' '
    printf -v tc_tab    '\t'
    printf -v tc_nln    '\n'
    printf -v tc_crt    '\r'
    printf -v tc_tilde  '~'
    printf -v tc_fslash '/'
    printf -v tc_bslash '\'
    printf -v tc_squote "'"
    printf -v tc_dquote '"'
    printf -v tc_bang   '!'
    printf -v tc_tick   '`'
    printf -v tc_dollar '$'
    printf -v IFS_DEF   ' \t\n'
    printf -v IFS_TN    '\t\t\n'
    printf -v IFS_N     '\n\n\n'
    printf -v IFS_RGX   '|\t\n'
    # Use default IFS
    IFS="${IFS_DEF}"

    # A 'unique'(?) session variable for function.
    rgx_sess="${fnc}_${HOSTNAME:-_}_${UID:-_}_${PPID:-_}_${$:-_}_${SECONDS:-_}_${RANDOM:-_}"

    # Separate args to function into options(opt_*) and arguments(args).
    I=0     # Flag the end of options via '--' argument.
    for tmp in "${@}"
    do
        # If long option (the only kind accepted by this parser) and haven't seen '--'..
        if [[ "${tmp}" == --* && "${I}" -eq 0 ]]
        then
            # If option ender..
            if [[ "${tmp}" == -- ]]
            then
                # Set end-of-options flag and go to next argument.
                I=1
                continue
            fi
            # Remove '--' from option name.
            tmp="${tmp#--}"
            # If valid option name..
            if [[ " ${opts_valid[*]} " =~ ${tc_spc}${tmp%%=*}${tc_spc} ]]
            then
                # Assign '1' to simple options.
                [[ "${tmp}" == *=* ]] || tmp="${tmp}=1"
                # Set 'opt_*' variable based on provided option.
                printf -v tmp -- 'opt_%s=%q' "${tmp%%=*}" "${tmp#*=}"
                eval "${tmp}"
                # Next argument.
                continue
            fi
        fi
        # This is an argument, so add to arguments array.
        args[${#args[@]}]="${tmp}"
    done
    opt=
    tmp=
    I=

    # Create eval-ready (escaped/quoted) array of arguments.
    eargs=( "${args[@]}" )
    for (( I=0; I<${#eargs[@]}; I++ ))
    do
        printf -v tmp '%q' "${eargs[${I}]}"
        # If argument doesn't need escaping, then use simple (unescaped/unquoted).
        [[ "${tmp}" =~ \\ ]] || continue
        eargs[${I}]="${tmp}"
        # If arg is an eval string { $'' }, then use that.
        [[ ! "${tmp}" =~ ^\$${tc_squote}.*${tc_squote}$ ]] || continue
        # If arg doesn't contain single-quote(s), then just quote in single-quotes.
        [[ "${tmp}" =~ ${tc_squote} ]] || {
            eargs[${I}]="'${args[${I}]}'"
            continue
        }
        # Arg contains single-quote(s)..
        tmp="${args[${I}]}"
        # So if it also contains a '!', then single-quote everything but the single-quotes, which get double-quoted.
        # This is so that re-using the args in an interactive shell won't trigger history macros.
        if [[ "${tmp}" == *${tc_bang}* ]]
        then
            tmp="${tmp//${tc_squote}/${tc_squote}${tc_dquote}${tc_squote}${tc_dquote}${tc_squote}}"
            tmp="'${tmp}'"
            tmp="${tmp//${tc_squote}${tc_squote}}"
            eargs[${I}]="${tmp}"
            continue
        fi
        # Otherwise escape eval chars and double-quotes in string, then enclose in double-quotes.
        tmp="${tmp//${tc_dquote}/${tc_bslash}${tc_dquote}}"
        tmp="${tmp//${tc_dollar}/${tc_bslash}${tc_dollar}}"
        tmp="${tmp//${tc_tick}/${tc_bslash}${tc_tick}}"
        eargs[${I}]="${tc_dquote}${tmp}${tc_dquote}"
    done
    tmp=
    I=

    # Set 'dbg' equal to 'opt_debug'
    dbg="${opt_debug:-0}"

    # Flag standard file descriptors as open (or not).
    [[ ! -t 0 ]] || flg_file0=1
    [[ ! -t 1 ]] || flg_file1=1
    [[ ! -t 2 ]] || flg_file2=1

    # }}}

    # BASH_FUNCTION_INIT # FUNCTION # YOUR CODE HERE # START

    # Display help if 'help' or 'manual' options are provided.
    if [[ "${opt_help:-0}" -ne 0 || "${opt_manual:-0}" -ne 0 ]]
    then
            printf -- %s '
    DESCRIPTION::

        This function sets global shell variables, and therefore should not be run in a subshell.

        Instead, you may do something like this..

        { TMP="$( curl_env -s icanhazip.com )"; echo "${TMP}" | __YOUR_PARSER__; }

        If you DO pipe this command, it will echo its output for use on stdin to other commands.

        { curl_env -s icanhazip.com | __YOUR_PARSER__; }

    OPTIONS::

        To produce debug output..

        --debug

        Or set explicitely to a certain level..

        --debug=[0-9]

        Or, use the debug environment variable..

        export DEBUG_CURL_ENV=[0-9]
        export DEBUG=[0-9]

        To view the curl help or manual, provide these options..

        --curl_help

        --curl_manual
            '
            return 1
    fi
    # Display 'curl' help or manual.
    [[ "${opt_curl_help:-0}" -eq 0 ]] || { curl --help; return; }
    [[ "${opt_curl_manual:-0}" -eq 0 ]] || { curl --manual; return; }

    # Variables to use with write-out option in curl.
    write_out_vars=(
            http_code
            url_effective redirect_url
            http_connect
            time_total
            time_namelookup time_connect time_appconnect
            time_pretransfer time_redirect time_starttransfer
            size_download size_upload size_header size_request
            speed_download speed_upload
            content_type
            num_connects num_redirects
            ftp_entry_path ssl_verify_result
    )
    # Regex variables for use in parsing curl trace output.
    rgx_time='^([0-9]{2,2}:[0-9]{2,2}:[0-9]{2,2}\.[0-9]+)'
    rgx_info="${rgx_time}"' == Info: (.*[^[:blank:]].*)'
    rgx_xmit="${rgx_time}"' (<=|=>) ((Send|Recv) (header|data|SSL data)), ([0-9]+).*'
    rgx_stat='^CURL_ENV_STT:(.*)'
    rgx_exit='^CURL_ENV_EXT:(.*)'
    rgx_data='^[0-9a-f]{4,4}:(( [0-9a-f][0-9a-f]){1,16})'

    # Debug output of curl command requested.
    [[ "${dbg}" -lt 2 ]] || {
        printf '+ curl'
        printf ' %s' "${eargs[@]}"
        printf '\n'
    } 1>&2

    # Construct first portion of curl command.
    # Include provided arguments first, allowing for override.
    # Write-out argument is set here to make it easy to parse later.
    curl_cmd=(
        curl
        "${eargs[@]}"
        -w "'$( for tmp in ${write_out_vars[*]}; do printf 'CURL_ENV_STT:%s=%%{%s}\\n' "${tmp}" "${tmp}"; done )'"
    )
    # A quick lazy way of adding enough '-o /dev/null' arguments to redirect output for all requested URIs.
    for tmp in "${eargs[@]}"
    do
        [[ "${tmp}" != -* ]] || continue
        curl_cmd=( "${curl_cmd[@]}" -o /dev/null )
    done
    # Finish out curl command with an extra '-o /dev/null' (just in case).
    # Also add options to turn on tracing and disable buffering of output.
    curl_cmd=(
        "${curl_cmd[@]}"
        -o /dev/null
        --trace-time
        --trace -
        --no-buffer
    )

    # Debug output of curl command to be evaluated. 
    [[ "${dbg}" -lt 8 ]] || {
        printf '+'
        printf ' %s' "${curl_cmd[@]}"
        printf '\n'
    } 1>&2

    # Eval curl command and break output into a temporary array, delimited by newline char.
    IFS="${IFS_N}"
    tmps=( $( eval "${curl_cmd[@]}"; printf 'CURL_ENV_EXT:%s' "${?}" ) )
    IFS="${IFS_DEF}"

    # Clear global curl_env variables.
    for tmp in curl_env_{dbg,ext,hin,hdr,out,stt,ssl,unk}
    do
        printf -v tmp '%s=()' "${tmp}"
        eval "${tmp}"
    done

    # Step through curl output and set global curl_env variables.
    I=-1
    for tmp in "${tmps[@]}"
    do
        #
        # If this is an Info line..
        if [[ "${tmp}" =~ ${rgx_info} ]]
        then
            #
            # If this is the beginning of a new connection..
            if [[ "${BASH_REMATCH[2]}" = 'Adding handle: conn:'* ]]
            then
                stg='conn'
                # Increment array index for this connection.
                let I++
            fi
            [[ "${dbg}" -lt 8 ]] || {
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p BASH_REMATCH
            } 1>&2
            # Add info line to debug variable.
            # Only add newline if variable already set.
            curl_env_dbg[${I}]="${curl_env_dbg[${I}]:+${curl_env_dbg[${I}]}${tc_nln}}${tmp}"
            # Next line.
            continue
            #
        elif [[ "${tmp}" =~ ${rgx_xmit} ]]
        then
            #
            # Set parsing stage based on what kind of transmission this is.
            case "${BASH_REMATCH[3]}" in
                ( 'Send header' )   stg='hin';;
                ( 'Recv header' )   stg='hdr';;
                ( 'Recv data' )     stg='out';;
                ( 'Send data' )     stg='inp';;
                ( 'Recv SSL data' ) stg='ssl';;
                ( 'Send SSL data' ) stg='ssl';;
                ( * )               stg='unk';;
            esac
            [[ "${dbg}" -lt 8 ]] || {
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p BASH_REMATCH
            } 1>&2
            # Add transmit line to debug variable.
            curl_env_dbg[${I}]="${curl_env_dbg[${I}]:+${curl_env_dbg[${I}]}${tc_nln}}${tmp}"
            continue
            #
        elif [[ "${tmp}" =~ ${rgx_stat} ]]
        then
            #
            # This is a status line, parsed from the write-out output.
            stg='stt'
            [[ "${dbg}" -lt 8 ]] || {
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p BASH_REMATCH
            } 1>&2
            curl_env_stt[${I}]="${curl_env_stt[${I}]:+${curl_env_stt[${I}]}${tc_nln}}${BASH_REMATCH[1]}"
            continue
            #
        elif [[ "${tmp}" =~ ${rgx_exit} ]]
        then
            #
            # This is the exit code line, generated during evaluation of curl command.
            stg='ext'
            [[ "${dbg}" -lt 8 ]] || {
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p BASH_REMATCH
            } 1>&2
            curl_env_ext[0]="${BASH_REMATCH[1]}"
            continue
            #
        elif [[ "${tmp}" =~ ${rgx_data} ]]
        then
            #
            [[ "${dbg}" -lt 8 ]] || {
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p BASH_REMATCH
            } 1>&2
            #
            # This is a data/header line.
            # Regex groups only the raw hex codes.
            tmp="${BASH_REMATCH[1]}"
            # Ready the hex codes for conversion to text for storage.
            tmp="${tmp// /\\x}"
            [[ "${dbg}" -lt 8 ]] || {
                declare -p tmp
            } 1>&2
            printf -v tmp "${tmp}"
            # Store data in appropriate header/data variable.
            [[ "${dbg}" -lt 8 ]] || {
                declare -p tmp
            } 1>&2
            printf -v tmp 'curl_env_%s[${I}]="${curl_env_%s[${I}]}"%q' "${stg}" "${stg}" "${tmp}"
            eval "${tmp}"
            continue
            #
        else
            #
            # Catch unidentified lines.
            stg='unk'
            [[ "${dbg}" -lt 8 ]] || {
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p tmp
            } 1>&2
            curl_env_unk[${I}]="${curl_env_unk[${I}]:+${curl_env_unk[${I}]}${tc_nln}}${tmp}"
            continue
            #
        fi
        #
    done

    # Convert '\r\n' to '\n' in header variables; Also remove all '\n' from the very end.
    for (( I=0; I<${#curl_env_hin[@]}; I++ ))
    do
        curl_env_hin[${I}]="${curl_env_hin[${I}]//${tc_crt}${tc_nln}/${tc_nln}}"
        curl_env_hin[${I}]="${curl_env_hin[${I}]%${tc_nln}${tc_nln}}"
    done
    for (( I=0; I<${#curl_env_hdr[@]}; I++ ))
    do
        curl_env_hdr[${I}]="${curl_env_hdr[${I}]//${tc_crt}${tc_nln}/${tc_nln}}"
        curl_env_hdr[${I}]="${curl_env_hdr[${I}]%${tc_nln}${tc_nln}}"
    done

    # Assign curl exit code to function exit code.
    fnc_return="${curl_env_ext[0]:-100}"

    # Debugging output.
    [[ "${dbg}" -gt 7 ]] || {
        for (( I=0; I<${#curl_env_hin[@]}; I++ ))
        do
            {
                [[ "${dbg}" -lt 3 ]] || printf '\n'
                [[ "${dbg}" -lt 4 ]] || printf '* %s\n' "${curl_env_dbg[${I}]//${tc_nln}/${tc_nln}* }"
                [[ "${dbg}" -lt 5 ]] || printf '= %s\n' "${curl_env_stt[${I}]//${tc_nln}/${tc_nln}= }"
                if [[ "${dbg}" -lt 3 ]]
                then
                    [[ "${dbg}" -eq 0 && "${flg_file1}" -eq 0 ]] || {
                        tmp="${curl_env_hdr[${I}]%%${tc_nln}*}"
                        printf '%s\n' "${tmp:-ERR_NO_HEADERS}"
                    }
                else
                    printf '> %s\n' "${curl_env_hin[${I}]//${tc_nln}/${tc_nln}> }"
                    printf '< %s\n' "${curl_env_hdr[${I}]//${tc_nln}/${tc_nln}< }"
                fi
                [[ "${dbg}" -lt 5 || "${#curl_env_unk[${I}]}" -eq 0 ]] || {
                    printf '? %s\n' "${curl_env_unk[${I}]//${tc_nln}/${tc_nln}? }"
                }
            } 1>&2
            [[ "${dbg}" -lt 2 && -t 1 && "${opt_out:-0}" -eq 0 ]] || {
                printf '%s\n' "${curl_env_out[${I}]%${tc_nln}}"
            }
        done
        [[ "${dbg}" -lt 6 ]] || printf '\n! %s\n' "${curl_env_ext[0]//${tc_nln}/${tc_nln}! }" 1>&2
    }

    # BASH_FUNCTION_INIT # FUNCTION # YOUR CODE HERE # FINISH

    # BASH_FUNCTION_INIT # EXIT # DO NOT TOUCH # {{{

    # Return the value of 'fnc_return' variable.
    return "${fnc_return}"

    # }}}

}
