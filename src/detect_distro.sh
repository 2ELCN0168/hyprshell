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
                printf "${INFO} Detected os : ${Y}${ID}${N}\n"
        fi

        if [[ "${opt_l}" -eq 1 ]]; then
                echo "${LOG_I} Detected os : ${ID}" >> "${logfile}"
        fi

        DETECTED_DISTRO=""
        case "${ID}" in
                "debian"|"ubuntu"|"linuxmint"|"kali") 
                DETECTED_DISTRO="debian" ;;
                "arch"|"manjaro"|"endeavouros"|"garuda") 
                DETECTED_DISTRO="arch" ;;
                "fedora"|"rhel"|"rocky"|"almalinux") 
                DETECTED_DISTRO="rhel" ;;
                *) 
                DETECTED_DISTRO=0 ;;
        esac

        if [[ "${DETECTED_DISTRO}" -eq 0 ]]; then
                if [[ "${opt_v}" -eq 1 ]]; then
                        printf "${ERR} This distribution is not supported.\n"
                fi
                if [[ "${opt_l}" -eq 1 ]]; then
                        echo "${LOG_E} This distribution is not supported." \
                        >> "${logfile}"
                fi
                exit 1
        fi

        return
}