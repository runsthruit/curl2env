#! /dev/null/bash

function curl2env ()
{

    # BASH_FUNCTION_INIT # INIT # YOUR CODE HERE # START

    # Additions to opts_valid go here.
    opts_valid=(
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
    # Local and Global
    vars_al_=(
        write_out_vars
        curl_cmd
    )
    vars_ag_=(
        curl2env_dbg
        curl2env_ext
        curl2env_hdr
        curl2env_hin
        curl2env_out
        curl2env_stt
        curl2env_unk
    )
    # Additions to integer variables go here.
    # Local and Global
    vars_il_=()
    vars_ig_=()

    # BASH_FUNCTION_INIT # INIT # YOUR CODE HERE # FINISH

    # BASH_FUNCTION_INIT # SETUP # DO NOT TOUCH # {{{

    # Special variable for setting valid options names.
    # This variable will be added to vars_al_ and vars____ later on.
    local opts_valid=(
    help    # Flag for common help option.
    debug   # Debug level.
    ${opts_valid[*]}
    )

    # Default local strings.
    local vars_sl_=(
    fnc         # Shorthand for function name.
    fnctag      # All-caps version of function name.
    dbg         # Debug level of function, allowing non-integer value.
    ent         # Default temporary variable for array iteration.
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
    local vars_slx=( ${vars_slx[*]} )
    # Default global strings.
    local vars_sg_=( ${vars_sg_[*]} )
    # Default global export strings.
    local vars_sgx=( ${vars_sgx[*]} )

    # Default arrays.
    local vars_al_=(
    opts_invalid    # List of invalid options supplied, if any.
    args            # Array of function args, with options removed.
    eargs           # Quoted/Sanitized/Pretty args for eval/debug/print.
    tmps            # Default temporary array.
    ${vars_al_[*]}
    )
    local vars_alx=( ${vars_alx[*]} )
    local vars_ag_=( ${vars_ag_[*]} )
    local vars_agx=( ${vars_agx[*]} )

    # Default integers.
    # Btw, I don't know how to create global integer vars. =]
    local vars_il_=(
    fnc_return  # Return value for this function.
    I J K       # Common iterators.
    flg_file0   # STDIN  is open?
    flg_file1   # STDOUT is open?
    flg_file2   # STDERR is open?
    ${vars_il_[*]}
    )
    local vars_ilx=( ${vars_ilx[*]} )

    # Collect variables to be exported.
    local vars___x=(
    ${vars_slx[*]} ${vars_sgx[*]}
    ${vars_alx[*]} ${vars_agx[*]}
    ${vars_ilx[*]}
    )
    # Collect all variables, mostly for reporting/debug.
    local vars____=(
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
    for tmp in ${vars_sl_[*]} ${vars_slx[*]}; do local    ${tmp}; done
    # Localize array variables.
    for tmp in ${vars_al_[*]} ${vars_alx[*]}; do local -a ${tmp}; done
    # Localize integer variables and set (to zero).
    for tmp in ${vars_il_[*]} ${vars_ilx[*]}; do local -i ${tmp}; eval "${tmp}="; done
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

    # Determine all-caps debug variable name for function and function tag.
    tmp="DEBUG_${fnc}"
    tmps=( {a..z} {A..Z} )
    for (( I=0; I<26; I++ ))
    do
        tmp="${tmp//${tmps[${I}]}/${tmps[$((I+26))]}}"
    done
    # Set function tag variable.
    fnctag="${tmp#DEBUG_}"
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
        if [[ "${tmp}" == --* && "${I}" -eq 0 ]]; then
            # If option ender..
            if [[ "${tmp}" == -- ]]; then
                # Set end-of-options flag and go to next argument.
                I=1
                continue
            fi
            # Remove '--' from option name.
            tmp="${tmp#--}"
            # If valid option name..
            if [[ " ${opts_valid[*]} " =~ ${tc_spc}${tmp%%=*}${tc_spc} ]]; then
                # Assign '1' to simple options.
                [[ "${tmp}" == *=* ]] || tmp="${tmp}=1"
                # Set 'opt_*' variable based on provided option.
                printf -v tmp -- 'opt_%s=%q' "${tmp%%=*}" "${tmp#*=}"
                eval "${tmp}"
            else
                # Add to arguments array, can be excluded in comp to opts_invalid.
                args[${#args[@]}]="${tmp}"
                # If not valid option name, add to invalid list.
                tmp="${tmp%%=*}"
                opts_invalid[${#opts_invalid[@]}]="${tmp}"
            fi
            # Next argument.
            continue
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
        if [[ ! "${tmp}" =~ ${tc_squote} ]]; then
            eargs[${I}]="'${args[${I}]}'"
            continue
        fi
        # Arg contains single-quote(s)..
        tmp="${args[${I}]}"
        # So if it also contains a '!', then single-quote everything but the single-quotes, which get double-quoted.
        # This is so that re-using the args in an interactive shell won't trigger history macros.
        if [[ "${tmp}" == *${tc_bang}* ]]; then
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

    # BASH_FUNCTION_INIT # SETUP # DO NOT TOUCH # }}}

    # BASH_FUNCTION_INIT # MAIN # YOUR CODE HERE # START

    # Backup STDIN/STDOUT/STDERR
    exec 6>&0
    exec 7>&1
    exec 8>&2

    # Display 'curl' help or manual.
    {
        if [[ "${opt_curl_help:-0}"   -ne 0 ]]; then curl --help;   return; fi
        if [[ "${opt_curl_manual:-0}" -ne 0 ]]; then curl --manual; return; fi
    } 1>&8

    # Display help if 'help' or 'manual' options are provided.
    {
        if [[ "${opt_help:-0}" -ne 0 ]]; then
            printf -- %s '
    DESCRIPTION::

    This function sets global shell variables, and therefore should not be run in a subshell.

    Instead, you may do something like this..

    { TMP="$( curl2env -s icanhazip.com )"; echo "${TMP}" | __YOUR_PARSER__; }

    If you DO pipe this command, it will echo its output for use on stdin to other commands.

        { curl2env -s icanhazip.com | __YOUR_PARSER__; }

        OPTIONS::

        To produce debug output..

        --debug

        Or set explicitely to a certain level..

        --debug=[0-9]

        Or, use the debug environment variable..

        export DEBUG_curl2env=[0-9]
        export DEBUG=[0-9]

        To view the curl help or manual, provide these options..

        --curl_help

        --curl_manual
            '
            return 1
        fi
    } 1>&8

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
    rgx_stat='^CURL2ENV_STT:(.*)'
    rgx_exit='^CURL2ENV_EXT:(.*)'
    rgx_data='^[0-9a-f]{4,4}:(( [0-9a-f][0-9a-f]){1,16}).*$'
    rgx_hdr_chunked='^([^'"${tc_nln}"']*['"${tc_nln}"'])*[Tt]ransfer-[Ee]ncoding:[[:blank:]]*[Cc]hunked'

    # Debug output of curl command requested.
    {
        if [[ "${dbg}" -gt 1 ]]; then
            printf '+ curl'
            printf ' %s' "${eargs[@]}"
            printf '\n'
        fi
    } 1>&8

    # Construct first portion of curl command.
    # Include provided arguments first, allowing for override.
    # Write-out argument is set here to make it easy to parse later.
    curl_cmd=(
    curl
    "${eargs[@]}"
    -w "'$( for tmp in ${write_out_vars[*]}; do printf 'CURL2ENV_STT:%s=%%{%s}\\n' "${tmp}" "${tmp}"; done )'"
    )

    # A quick lazy way of adding enough '-o /dev/null' arguments to redirect output for all requested URIs.
    for tmp in "${eargs[@]}"; do
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
    {
        if [[ "${dbg}" -gt 6 ]]; then
            printf '+'
            printf ' %s' "${curl_cmd[@]}"
            printf '\n'
        fi
    } 1>&8

    # Eval curl command and break output into a temporary array, delimited by newline char.
    IFS="${IFS_N}"
    tmps=( $( eval "${curl_cmd[@]}"; printf 'CURL2ENV_EXT:%s' "${?}" ) )
    IFS="${IFS_DEF}"

    # Clear global curl2env variables.
    for tmp in curl2env_{dbg,ext,hin,hdr,out,stt,ssl,unk}; do
        printf -v tmp '%s=()' "${tmp}"
        eval "${tmp}"
    done

    # Step through curl output and set global curl2env variables.
    # I=-1 # Maybe for multiple calls in the future
    I=0
    for tmp in "${tmps[@]}"; do
        #
        if [[ "${dbg}" -gt 7 ]]; then
            printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
            declare -p tmp
        fi 1>&8
        #
        # If this is an Info line..
        if [[ "${tmp}" =~ ${rgx_info} ]]; then
            #
            # If this is the beginning of a new connection..
            if [[ "${BASH_REMATCH[2]}" = 'Adding handle: conn:'* ]]; then
                stg='conn'
                # Increment array index for this connection.
                # let I++ # Maybe for multiple calls in the future
                let I=0
            fi
            if [[ "${dbg}" -gt 7 ]]; then
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p BASH_REMATCH
            fi 1>&8
            # Add info line to debug variable.
            # Only add newline if variable already set.
            curl2env_dbg[${I}]="${curl2env_dbg[${I}]:+${curl2env_dbg[${I}]}${tc_nln}}${tmp}"
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
            if [[ "${dbg}" -gt 7 ]]; then
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p BASH_REMATCH
            fi 1>&8
            # Add transmit line to debug variable.
            curl2env_dbg[${I}]="${curl2env_dbg[${I}]:+${curl2env_dbg[${I}]}${tc_nln}}${tmp}"
            continue
            #
        elif [[ "${tmp}" =~ ${rgx_stat} ]]
        then
            #
            # This is a status line, parsed from the write-out output.
            stg='stt'
            if [[ "${dbg}" -gt 7 ]]; then
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p BASH_REMATCH
            fi 1>&8
            curl2env_stt[${I}]="${curl2env_stt[${I}]:+${curl2env_stt[${I}]}${tc_nln}}${BASH_REMATCH[1]}"
            continue
            #
        elif [[ "${tmp}" =~ ${rgx_exit} ]]
        then
            #
            # This is the exit code line, generated during evaluation of curl command.
            stg='ext'
            if [[ "${dbg}" -gt 7 ]]; then
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p BASH_REMATCH
            fi 1>&8
            curl2env_ext[0]="${BASH_REMATCH[1]}"
            continue
            #
        elif [[ "${tmp}" =~ ${rgx_data} ]]
        then
            #
            if [[ "${dbg}" -gt 7 ]]; then
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p BASH_REMATCH
            fi 1>&8
            #
            # This is a data/header line.
            # Regex groups only the raw hex codes.
            tmp="${BASH_REMATCH[1]}"
            # Ready the hex codes for conversion to text for storage.
            tmp="${tmp// /\\x}"
            if [[ "${dbg}" -gt 7 ]]; then
                declare -p tmp
            fi 1>&8
            printf -v tmp "${tmp}"
            # Store data in appropriate header/data variable.
            if [[ "${dbg}" -gt 7 ]]; then
                declare -p tmp
            fi 1>&8
            printf -v tmp 'curl2env_%s[${I}]="${curl2env_%s[${I}]}"%q' "${stg}" "${stg}" "${tmp}"
            eval "${tmp}"
            continue
            #
        else
            #
            # Catch unidentified lines.
            stg='unk'
            if [[ "${dbg}" -gt 7 ]]; then
                printf '\n# itr [ %s ]\tstg ( %s )\n' "${I}" "${stg}"
                declare -p tmp
            fi 1>&8
            curl2env_unk[${I}]="${curl2env_unk[${I}]:+${curl2env_unk[${I}]}${tc_nln}}${tmp}"
            continue
            #
        fi
        #
    done

    # Convert '\r\n' to '\n' in header variables; Also remove all '\n' from the very end.
    for (( I=0; I<${#curl2env_hin[@]}; I++ ))
    do
        curl2env_hin[${I}]="${curl2env_hin[${I}]//${tc_crt}${tc_nln}/${tc_nln}}"
        curl2env_hin[${I}]="${curl2env_hin[${I}]%${tc_nln}${tc_nln}}"
    done
    for (( I=0; I<${#curl2env_hdr[@]}; I++ ))
    do
        curl2env_hdr[${I}]="${curl2env_hdr[${I}]//${tc_crt}${tc_nln}/${tc_nln}}"
        curl2env_hdr[${I}]="${curl2env_hdr[${I}]%${tc_nln}${tc_nln}}"
        curl2env_out[${I}]="${curl2env_out[${I}]//${tc_crt}${tc_nln}/${tc_nln}}"
        if [[ "${curl2env_hdr[${I}]}" =~ ${rgx_hdr_chunked} ]]; then
            curl2env_out[${I}]="${curl2env_out[${I}]#*${tc_nln}}"
            curl2env_out[${I}]="${curl2env_out[${I}]%${tc_nln}*}"
            curl2env_out[${I}]="${curl2env_out[${I}]%${tc_nln}*}"
            curl2env_out[${I}]="${curl2env_out[${I}]%${tc_nln}*}"
        fi
    done

    # Assign curl exit code to function exit code.
    fnc_return="${curl2env_ext[0]:-100}"

    # Debugging output.
    if [[ "${dbg}" -lt 8 ]]; then
        I=0
        #[[ "${dbg}" -lt 3 ]] || printf '\n'
        [[ "${dbg}" -lt 4 ]] || printf '* %s\n' "${curl2env_dbg[${I}]//${tc_nln}/${tc_nln}* }"
        [[ "${dbg}" -lt 5 ]] || printf '= %s\n' "${curl2env_stt[${I}]//${tc_nln}/${tc_nln}= }"
        if [[ "${dbg}" -gt 2 ]]; then
            printf '> %s\n' "${curl2env_hin[${I}]//${tc_nln}/${tc_nln}> }"
            printf '< %s\n' "${curl2env_hdr[${I}]//${tc_nln}/${tc_nln}< }"
        elif [[ "${dbg}" -gt 0 ]]; then
            printf '< %s\n' "${curl2env_hdr[${I}]%%${tc_nln}*}"
        fi
        if [[ "${dbg}" -gt 4 && "${#curl2env_unk[${I}]}" -gt 0 ]]; then
            printf '? %s\n' "${curl2env_unk[${I}]//${tc_nln}/${tc_nln}? }"
        fi
        printf '%s\n' "${curl2env_out[${I}]%${tc_nln}}" 1>&7
        [[ "${dbg}" -lt 6 ]] || printf '! %s\n' "${curl2env_ext[${I}]//${tc_nln}/${tc_nln}! }"
    fi 1>&8

    # Return the value of 'fnc_return' variable.
    return "${fnc_return}"

    # BASH_FUNCTION_INIT # MAIN # YOUR CODE HERE # FINISH

}
