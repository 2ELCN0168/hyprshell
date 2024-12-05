function detect_distro()
{
        # If cannot read os-release > Exit
        if [[ ! -f "/etc/os-release" ]]; then
                _message "E" "Cannot detect OS distribution. Exiting."
                exit 1
        fi

        # Source the file to send the variables into environment
        source "/etc/os-release"
        
        _message "S" "Detected os: ${Y}${ID}${N}"

        # LEGEND: ##
        # debian = 1
        # arch   = 2
        # rhel   = 3
        DETECTED_DISTRO=""
        case "${ID}" in
                "debian"|"ubuntu"|"linuxmint"|"kali") 
                DETECTED_DISTRO=1 ;;
                "arch"|"manjaro"|"endeavouros"|"garuda") 
                DETECTED_DISTRO=2 ;;
                "fedora"|"rhel"|"rocky"|"almalinux") 
                DETECTED_DISTRO=3 ;;
                *) 
                DETECTED_DISTRO=0 ;;
        esac

        if [[ "${DETECTED_DISTRO}" -eq 0 ]]; then
                _message "E" "This distribution is not supported."
                exit 1
        fi

        return 0
}
