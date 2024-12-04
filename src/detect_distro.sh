function detect_distro()
{
        # If cannot read os-release > Exit
        if [[ ! -f "/etc/os-release" ]]; then
                if [[ "${opt_l}" -eq 1 ]]; then
                        echo "${LOG_E} Cannot detect OS distribution. Exiting." \
                        >> "${logfile}"
                        exit 1
                fi 
        fi

        # Source the file to send the variables into environment
        source "/etc/os-release"
        
        if [[ "${opt_v}" -eq 1 ]]; then
                printf "${INFO} Detected os : ${ID}\n"
        fi

        if [[ "${opt_l}" -eq 1 ]]; then
                echo "${LOG_I} Detected os : ${ID}" >> "${logfile}"
        fi

        # Return ID
        echo "${ID}" 1> "/dev/null"
}