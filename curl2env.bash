#! /dev/null/bash

function curl2env ()
{

    # BASH_FUNCTION_INIT # INIT # YOUR CODE HERE # START

    # Additions to opts_valid go here.
    opts_valid=(
        curl_help
        curl_manual
        out
    )

    # Additions to string variables go here.
    # Local, Local-export, Global, Global-export
    vars_sl_=(
        tc_crlf
        stg
        wrt_arg
        trc_arg
        curl2env_tmp
        hdr_ct
        hdr_te
        rgx_ent
        rgx_dbg
        rgx_wrt
        rgx_ext
        rgx_ent_time
        rgx_ent_info
        rgx_ent_xmit
        rgx_ent_data
        rgx_dbg_slice
        rgx_hdr_ct
        rgx_hdr_te
        rgx_wrt_fe_nil
        rgx_wrt_redirs
    )
    vars_slx=()
    vars_sg_=()
    vars_sgx=()
    # Additions to array variables go here.
    # Local and Global
    vars_al_=(
        wrt_vars
        curl_cmd
    )
    vars_ag_=(
        curl2env_dbg
        curl2env_ext
        curl2env_hdr
        curl2env_hin
        curl2env_inp
        curl2env_out
        curl2env_wrt
        curl2env_unk
    )
    # Additions to integer variables go here.
    # Local and Global
    vars_il_=(
        flg_rgx_nomatch
        flg_out_keep
        flg_chnk_enc
        cnt_chnk_size
        cnt_xmit_done
        cnt_xmit_size
        cnt_wrt_redirs
        err_rgx
    )
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
    printf -v tmp 'dbg="${dbg:-${DEBUG:-}}"'
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
    dbg="${dbg:-${opt_debug:-0}}"

    # Flag standard file descriptors as open (or not).
    [[ ! -t 0 ]] || flg_file0=1
    [[ ! -t 1 ]] || flg_file1=1
    [[ ! -t 2 ]] || flg_file2=1

    # BASH_FUNCTION_INIT # SETUP # DO NOT TOUCH # }}}

    # BASH_FUNCTION_INIT # MAIN # YOUR CODE HERE # START

    # Backup STDIN/STDOUT/STDERR
    {
        exec 6>&0
        exec 7>&1
        exec 8>&2
    } 1>&2

    # Display 'curl' help or manual.
    {
        if [[ "${opt_curl_help:-0}"   -ne 0 ]]; then curl --help;   return; fi
        if [[ "${opt_curl_manual:-0}" -ne 0 ]]; then curl --manual; return; fi
    } 1>&2

    # Display help.
    {
        if [[ "${opt_help:-0}" -ne 0 ]]; then
            printf -- %s '
    DESCRIPTION

    This function sets global shell variables, and therefore should not be run in a subshell.

    Instead, you may do something like this..

    { TMP="$( curl2env -s icanhazip.com )"; echo "${TMP}" | __YOUR_PARSER__; }

    If you DO pipe this command, it will echo its output for use on stdin to other commands.

        { curl2env -s icanhazip.com | __YOUR_PARSER__; }

    OPTIONS

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
            return "${fnc_return}"
        fi
    } 1>&2

    # Initialize variables.
    {
        # Clear global curl2env variables.
        for tmp in ${vars_ag_[*]}; do
            printf -v tmp '%s=()' "${tmp}"
            eval "${tmp}"
        done
        # Generate write-out argument.
        wrt_vars=(
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

        filename_effective
        local_ip
        local_port
        remote_ip
        remote_port

        )
        wrt_arg=
        for ent in ${wrt_vars[*]}; do
            printf -v wrt_arg '%s%s=%%{%s}\\n' "${wrt_arg}" "${ent}" "${ent}"
        done
        printf -v wrt_arg %s \
            '"' \
            ":${rgx_sess}" \
            ':CURL2ENV_WRT:' \
            "${wrt_arg}" \
            ':CURL2ENV_WRT:' \
            "${rgx_sess}:" \
            '"'
        # Generate trace argument.
        printf -v trc_arg %s \
            '>( printf %s "' \
            ":${rgx_sess}" \
            ':CURL2ENV_DBG:' \
            '$( cat - )' \
            ':CURL2ENV_DBG:' \
            "${rgx_sess}:" \
            '" )'
        # Regex variables for use in parsing curl trace output.
        for ent in 'dbg:DBG' 'wrt:WRT' 'ext:EXT'; do
            printf -v "rgx_${ent%:*}" %s \
                '^(.*):' \
                "${rgx_sess}" \
                ":CURL2ENV_${ent#*:}:" \
                '(.*)' \
                ":CURL2ENV_${ent#*:}:" \
                "${rgx_sess}" \
                ':(.*)$'
        done
        rgx_crlf="${tc_crt}${tc_nln}"
        rgx_ent='^([^'"${tc_nln}"']*)['"${tc_nln}"'](.*)|([^'"${tc_nln}"']+)$'
        rgx_ent_time='[0-9]{2,2}:[0-9]{2,2}:[0-9]{2,2}\.[0-9]{1,6}'
        rgx_ent_info='^('"${rgx_ent_time}"') == Info: (.*[^[:blank:]].*)$'
        rgx_ent_xmit='^('"${rgx_ent_time}"') (<=|=>) ((Send|Recv) (header|data|SSL data)), ([0-9]+).*$'
        rgx_ent_data='^[0-9a-f]{4,4}:(( [0-9a-f][0-9a-f]){1,16}).*$'
        rgx_dbg_close="${rgx_ent_time}"' == Info: ((Closing|Closed) connection|Connection)[^'"${tc_nln}"']*'
        rgx_wrt_fe_nil='^(.*'"${tc_nln}"')*filename_effective=('"${tc_nln}"'.*)*$'
        rgx_wrt_redirs='^(.*'"${tc_nln}"')*num_redirects=([^'"${tc_nln}"']*)('"${tc_nln}"'.*)*$'
        printf -v rgx_hdr_ct %s \
            '^([^'"${tc_nln}"']*['"${tc_nln}"'])*' \
            '([Cc]ontent-[Tt]ype):[[:blank:]]*' \
            '([^'"${tc_nln}"']*)' \
            '(.*)$'
        printf -v rgx_hdr_te %s \
            '^([^'"${tc_nln}"']*['"${tc_nln}"'])*' \
            '([Tt]ransfer-[Ee]ncoding):[[:blank:]]*' \
            '([^'"${tc_nln}"']*)' \
            '(.*)$'
        printf -v tc_crlf   '\r\n'
        err_dbg=250
    } 1>&2

    # Debug output of curl command requested.
    {
        if [[ "${dbg}" -gt 1 ]]; then
            printf '+ curl'
            printf ' %s' "${eargs[@]}"
            printf '\n'
        fi
    } 1>&2

    # Construct curl command.
    {
        # Construct first portion of curl command.
        # Include provided arguments first, allowing for override.
        # Also add options to turn on tracing and disable buffering of output.
        curl_cmd=(
        curl
        "${eargs[@]}"
        --write-out  "${wrt_arg}"
        --trace-time
        --trace      "${trc_arg}"
        )
    } 1>&2

    # Debug output of curl command to be evaluated.
    {
        if [[ "${dbg}" -ge 7 ]]; then
            printf '+'
            printf ' %s' "${curl_cmd[@]}"
            printf '\n'
        fi
    } 1>&2

    # Call curl and perform initial parse of output.
    {
        #
#if [[ -r curl2env_out ]]; then
#curl2env_out="$( sed "s/___RGX_SESS___/${rgx_sess}/g" curl2env_out )"
#else
        # Eval curl command and store output.
        curl2env_out="$(
            eval "${curl_cmd[@]}"
            printf %s \
                ":${rgx_sess}" \
                ":CURL2ENV_EXT:" \
                "${?}" \
                ":CURL2ENV_EXT:" \
                "${rgx_sess}:"
        )"
#printf '%s\n' "${curl2env_out}" | sed "s/${rgx_sess}/___RGX_SESS___/g" > curl2env_out
#fi
        #
        I=-1
        flg_rgx_nomatch=0
        while [[ "${flg_rgx_nomatch}" -eq 0 ]]; do
            #
            let I++
            flg_rgx_nomatch=1

            if [[ "${curl2env_out}" =~ ${rgx_ext} ]]; then
                curl2env_ext[${I}]="${BASH_REMATCH[2]}"
                curl2env_out="${BASH_REMATCH[1]}${BASH_REMATCH[3]}"
                flg_rgx_nomatch=0
            elif [[ "${I}" -eq 0 ]]; then
                printf -- "${fnc}: %s\n" "Could not parse out exit code. { ${?} }"
                return "${err_rgx}"
            fi

            if [[ "${curl2env_out}" =~ ${rgx_wrt} ]]; then
                curl2env_wrt[${I}]="${BASH_REMATCH[2]%${tc_nln}}"
                curl2env_out="${BASH_REMATCH[1]}${BASH_REMATCH[3]}"
                flg_rgx_nomatch=0
            elif [[ "${I}" -eq 0 ]]; then
                printf -- "${fnc}: %s\n" "Could not parse write-out. { ${?} }"
                return "${err_rgx}"
            fi

            if [[ "${curl2env_out}" =~ ${rgx_dbg} ]]; then
                curl2env_dbg[${I}]="${BASH_REMATCH[2]}"
                curl2env_out="${BASH_REMATCH[1]}${BASH_REMATCH[3]}"
                flg_rgx_nomatch=0
            elif [[ "${I}" -eq 0 ]]; then
                printf -- "${fnc}: %s\n" "Could not parse out debug/trace. { ${?} }"
                return "${err_rgx}"
            fi

        done
        #
    } 1>&2

    # Check if we can keep the content of _out, or if it needs to be parsed from _dbg.
    {
        if [[ "${I}" -eq 1 && "${curl2env_wrt[0]}" =~ ${rgx_wrt_fe_nil} ]]; then
            flg_out_keep=1
#curl2env_out=()
        else
            flg_out_keep=0
            curl2env_out=()
        fi
    } 1>&2

    # Further parsing of curl output.
    {
        #
        while [[ "${I}" -gt 0 ]]; do
            #
            let I--
            #
            if [[ "${curl2env_wrt[${I}]}" =~ ${rgx_wrt_redirs} ]]; then
                cnt_wrt_redirs="${BASH_REMATCH[2]}"
            else
                cnt_wrt_redirs=0
            fi
            #
            if [[ "${dbg}" -ge 8 ]]; then
                printf '\n# itr [ %s ]\trdr ( %s )\n' "${I}" "${cnt_wrt_redirs}"
            fi
            #
            printf -v rgx_dbg_slice %s \
                '^' \
                '((.*['"${tc_nln}"']'"${rgx_dbg_close}"')*['"${tc_nln}"'])?' \
                '((.*['"${tc_nln}"']'"${rgx_dbg_close}"')['"${tc_nln}"'])' \
                '{'"${cnt_wrt_redirs}"'}' \
                '(.*['"${tc_nln}"']'"${rgx_dbg_close}"')' \
                '(['"${tc_nln}"'].*)?' \
                '$'
            #
            if [[ "${curl2env_dbg}" =~ ${rgx_dbg_slice} ]]; then
                curl2env_dbg[${I}]="${BASH_REMATCH[9]}"
                if [[ "${I}" -ne 0 ]]; then
                    curl2env_dbg="${BASH_REMATCH[2]}"
                    curl2env_ext[${I}]="${curl2env_ext[0]}"
                fi
            else
                printf -- "${fnc}: %s\n" "Could not parse out debug/trace for this call. { ${?} }"
                return "${err_rgx}"
            fi
            #
            curl2env_tmp="${curl2env_dbg[${I}]}"
            curl2env_dbg[${I}]=
            stg='???'
            #
            while [[ "${curl2env_tmp}" =~ ${rgx_ent} ]]; do
                #
                curl2env_tmp="${BASH_REMATCH[2]}"
                ent="${BASH_REMATCH[1]:-${BASH_REMATCH[3]}}"
                #
                if [[ "${dbg}" -ge 8 ]]; then
                    printf '\n# itr [ %s ]\tstg > %s >\n' "${I}" "${stg}"
                fi
                #
                # If this is an Info line..
                if [[ "${ent}" =~ ${rgx_ent_info} ]]; then
                    #
                    stg='dbg'
                    if [[ "${dbg}" -ge 8 ]]; then
                        printf '# itr [ %s ]\t%s ( %s )\n' "${I}" "${stg}" "${ent}"
                    fi
                    # Add info line to debug variable.
                    # Only add newline if variable already set.
                    curl2env_dbg[${I}]="${curl2env_dbg[${I}]:+${curl2env_dbg[${I}]}${tc_nln}}${ent}"
                    #
                elif [[ "${ent}" =~ ${rgx_ent_xmit} ]]; then
                    #
                    cnt_xmit_size="${BASH_REMATCH[6]}"
                    cnt_xmit_done=0
                    #
                    # Set parsing stage based on what kind of transmission this is.
                    case "${BASH_REMATCH[3]}" in
                        ( 'Send header' )   stg='hin';;
                        ( 'Recv header' )   stg='hdr';;
                        ( 'Recv data' )     stg='out';;
                        ( 'Send data' )     stg='inp';;
                        ( * )               stg='unk';;
                    esac
                    if [[ "${dbg}" -ge 8 ]]; then
                        printf '# itr [ %s ]\t%s ( %s )\n' "${I}" "${stg}" "${ent}"
                        printf '# itr [ %s ]\t%s = %s/%s\n' "${I}" "${stg}" "${cnt_xmit_done}" "${cnt_xmit_size}"
                    fi
                    # Add transmit line to debug variable.
                    curl2env_dbg[${I}]="${curl2env_dbg[${I}]:+${curl2env_dbg[${I}]}${tc_nln}}${ent}"
                    #
                elif [[ "${ent}" =~ ${rgx_ent_data} ]]; then
                    #
                    if [[ "${stg}" == 'out' && "${flg_out_keep}" -eq 1 ]]; then
                        continue
                    fi
                    #
                    if [[ "${dbg}" -ge 8 ]]; then
                        printf '# itr [ %s ]\t%s ( %s )\n' "${I}" "${stg}" "${ent}"
                    fi
                    #
                    # This is a data/header line.
                    # Regex groups only the raw hex codes.
                    tmp="${BASH_REMATCH[1]}"
                    # Ready the hex codes for conversion to text for storage.
                    tmp="${tmp// /\\x}"
                    if [[ "${dbg}" -ge 8 ]]; then
                        printf '# itr [ %s ]\t%s > %s >\n' "${I}" "${stg}" "${tmp}"
                    fi
                    printf -v tmp "${tmp}"
                    #
                    let cnt_xmit_done+=${#tmp}
                    #
                    if [[ "${dbg}" -ge 8 ]]; then
                        printf '# itr [ %s ]\t%s < %q <\n' "${I}" "${stg}" "${tmp}"
                        printf '# itr [ %s ]\t%s = %s/%s\n' "${I}" "${stg}" "${cnt_xmit_done}" "${cnt_xmit_size}"
                    fi
                    #
                    # Store data in appropriate header/data variable.
                    printf -v tmp 'curl2env_%s[${I}]="${curl2env_%s[${I}]}"%q' "${stg}" "${stg}" "${tmp}"
                    eval "${tmp}"
                    #
                    if [[ "${cnt_xmit_done}" -eq "${cnt_xmit_size}" ]]; then
                        if [[ "${stg}" == 'hdr' || "${stg}" == 'hin' ]]; then
                            printf -v tmp 'tmp="${curl2env_%s[${I}]}"' "${stg}"
                            eval "${tmp}"
                            if [[ "${tmp}" =~ ${tc_crlf}${tc_crlf}$ ]]; then
                                tmp="${tmp//${tc_crlf}/${tc_nln}}"
                                tmp="${tmp%${tc_nln}${tc_nln}}"
                                if [[ "${stg}" == 'hdr' ]]; then
                                    hdr_stat="${tmp%%${tc_nln}*}"
                                    if [[ "${tmp}" =~ ${rgx_hdr_ct} ]]; then
                                        hdr_ct="${BASH_REMATCH[3]}"
                                    else
                                        hdr_ct=
                                    fi
                                    if [[ "${tmp}" =~ ${rgx_hdr_te} ]]; then
                                        hdr_te="${BASH_REMATCH[3]}"
                                    else
                                        hdr_te=
                                    fi
                                    if [[ "${hdr_te}" == *[Cc]hunked* ]]; then
                                        flg_chnk_enc=1
                                    else
                                        flg_chnk_enc=0
                                    fi
                                fi
                            fi
                            printf -v tmp 'curl2env_%s[${I}]=%q' "${stg}" "${tmp}"
                            eval "${tmp}"
                        fi
                        stg='dbg'
                    else
                        continue
                    fi
                    #
                else
                    #
                    # Catch unidentified lines.
                    stg='unk'
                    if [[ "${dbg}" -ge 8 ]]; then
                        printf '# itr [ %s ]\t%s ( %s )\n' "${I}" "${stg}" "${ent}"
                    fi
                    curl2env_unk[${I}]="${curl2env_unk[${I}]:+${curl2env_unk[${I}]}${tc_nln}}${ent}"
                    #
                fi
                #
                if [[ "${dbg}" -ge 8 ]]; then
                    printf '# itr [ %s ]\tstg < %s <\n' "${I}" "${stg}"
                fi
                #
            done
            #
            if [[ "${flg_chnk_enc}" -eq 1 && "${flg_out_keep}" -eq 0 ]]; then
                tmp="${curl2env_out[${I}]}"
                curl2env_out[${I}]=
                while [[ "${tmp}" =~ ^([^${tc_crlf}]*)${tc_crlf}(.*)$ ]]; do
                    printf -v cnt_chnk_size %d "0x${BASH_REMATCH[1]}"
                    tmp="${BASH_REMATCH[2]}"
                    rgx='^(.{'"${cnt_chnk_size}"'})'"${tc_crlf}"'(.*)$'
                    if [[ "${tmp}" =~ ${rgx} ]]; then
                        if [[ "${dbg}" -ge 8 ]]; then
                            printf '\n# chnk [ %s ]\n' "${cnt_chnk_size}"
                            if [[ -n "${BASH_REMATCH[1]}" ]]; then
                                printf '%s\n' "${BASH_REMATCH[1]}"
                            fi
                        fi
                        curl2env_out[${I}]="${curl2env_out[${I}]}${BASH_REMATCH[1]}"
                        tmp="${BASH_REMATCH[2]}"
                    else
                        printf -- "${fnc}: %s\n" "Could not parse out chunk encoding. { ${?} }"
                        return "${err_rgx}"
                    fi
                done
            fi
            #
        done
        #
        if [[ "${dbg}" -ge 8 ]]; then
            for tmp in ${vars_ag_[*]}; do
                printf '\n#\n## %s\n#\n' "${tmp}"
                printf -v tmp 'tmps=( "${%s[@]}" )' "${tmp}"
                eval "${tmp}"
                for (( tmp=0; tmp<${#tmps[@]}; tmp++ )); do
                    printf '[%s]\n%s\n' "${tmp}" "${tmps[${tmp}]}"
                done
            done
        fi
        #
    } 1>&2

#for (( K=1; K<${#BASH_REMATCH[@]}; K++ )); do printf '[%s]\n%q\n' "${K}" "${BASH_REMATCH[${K}]}"; done

    {
        #
        for (( I=0; I<${#curl2env_dbg[@]}; I++ )); do
            #
            # Debugging output.
            if [[ "${dbg}" -eq 1 ]]; then
                printf '%s | %s | %s\n' "${hdr_stat}" "${hdr_ct}" "${hdr_te}"
            elif [[ "${dbg}" -le 7 ]]; then
                if [[ "${dbg}" -ge 4 && "${#curl2env_dbg[${I}]}" -gt 0 ]]; then
                    printf "*${I}* %s\n" "${curl2env_dbg[${I}]//${tc_nln}/${tc_nln}*${I}* }"
                fi
                if [[ "${dbg}" -ge 6 && "${#curl2env_unk[${I}]}" -gt 0 ]]; then
                    printf "?${I}? %s\n" "${curl2env_unk[${I}]//${tc_nln}/${tc_nln}?${I}? }"
                fi
                if [[ "${dbg}" -ge 5 && "${#curl2env_wrt[${I}]}" -gt 0 ]]; then
                    printf "=${I}= %s\n" "${curl2env_wrt[${I}]//${tc_nln}/${tc_nln}=${I}= }"
                fi
                if [[ "${dbg}" -ge 3 && "${#curl2env_hin[${I}]}" -gt 0 ]]; then
                    printf ">${I}> %s\n" "${curl2env_hin[${I}]//${tc_nln}/${tc_nln}>${I}> }"
                fi
                if [[ "${dbg}" -ge 2 && "${#curl2env_hdr[${I}]}" -gt 0 ]]; then
                    printf "<${I}< %s\n" "${curl2env_hdr[${I}]//${tc_nln}/${tc_nln}<${I}< }"
                fi
                if [[ "${dbg}" -ge 4 && "${#curl2env_out[${I}]}" -gt 0 ]]; then
                    printf ".${I}. %s\n" "${curl2env_out[${I}]//${tc_nln}/${tc_nln}.${I}. }"
                fi
                if [[ "${dbg}" -ge 4 && "${#curl2env_ext[${I}]}" -gt 0 ]]; then
                    printf "!${I}! %s\n" "${curl2env_ext[${I}]//${tc_nln}/${tc_nln}!${I}! }"
                fi
            fi
            #
        done
        #
        # Assign curl exit code to function exit code.
        fnc_return="${curl2env_ext[0]}"
        #
    } 1>&2

    {
        #
        if [[ "${opt_out:-0}" -eq 0 ]]; then
            if [[ "${flg_file1}" -eq 0 ]]; then
                declare -p ${vars_ag_[*]}
            fi
        else
            printf '%s\n' "${curl2env_out[@]}"
        fi
        #
    }

    # Return the value of 'fnc_return' variable.
    return "${fnc_return}"

    # BASH_FUNCTION_INIT # MAIN # YOUR CODE HERE # FINISH

}
