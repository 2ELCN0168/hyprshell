function _colors()
{
        R="\033[91m"
        G="\033[92m"
        Y="\033[93m"
        B="\033[94m"
        P="\033[95m"
        C="\033[96m"
        N="\033[0m"
}

function _message()
{
        # Usage: ##
        # _message "I" "Some message" "V" -> Print only verbose
        # _message "I" "Some message" "L" -> Print only log 
        # _message "I" "Some message"     -> Print both 

        if [[ "${opt_l}" -ne 1 && "${opt_v}" -ne 1 ]]; then
                return
        fi

        local LOG_I="[INFO] [$(date +%H:%M:%S)]:"
        local LOG_S="[SUCCESS] [$(date +%H:%M:%S)]:"
        local LOG_W="[WARNING] [$(date +%H:%M:%S)]:"
        local LOG_E="[ERROR] [$(date +%H:%M:%S)]:"

        local LOG_HEADER=""

        case "${1}" in
                I) LOG_HEADER="${LOG_I}";;
                S) LOG_HEADER="${LOG_S}";;
                W) LOG_HEADER="${LOG_W}";;
                E) LOG_HEADER="${LOG_E}";;
        esac

        local raw_msg=$(echo "${2}" | sed 's/\\033\[[0-9;]*m//g')

        local INFO="${C}[>]${N}"
        local SUC="${G}[*]${N}"
        local WARN="${Y}[?]${N}"
        local ERR="${R}[!]${N}"

        local MSG_HEADER=""
        local MSG_END=""

        case "${1}" in
                I) MSG_HEADER="${INFO}" ;;
                S) MSG_HEADER="${SUC}" 
                   MSG_END="\n" ;;
                W) MSG_HEADER="${WARN}" ;;
                E) MSG_HEADER="${ERR}" 
                   MSG_END="\n" ;;
        esac

        if [[ "${3}" == "V" ]]; then
                printf "${MSG_HEADER} ${2}\n${MSG_END}"
                # Print only verbose
        elif [[ "${3}" == "L" ]]; then
                # Print only log
                echo "${LOG_HEADER} ${raw_msg}" >> "${logfile}"
        else
                # Print both
                echo "${LOG_HEADER} ${raw_msg}" >> "${logfile}"
                printf "${MSG_HEADER} ${2}\n${MSG_END}"
        fi
}

function main() {
        source "./help.sh"
        source "./clean_logs.sh"
        source "./detect_distro.sh"
        source "./install_packages.sh"
        source "./env_vars.sh"
        source "./bashrc.sh"
        source "./zshrc.sh"
        source "./sudoers.sh"
        source "./tty_themes.sh"

        # Init colors and else
        _colors

        # Logs
        logfile="../out/log-$(date +%Y%m%d_%H%M%S).log"
        
        # Options
        opt_c=0 # Clean log files
        opt_l=0 # Make a log file
        opt_m=0 # No monitoring pack
        opt_v=0 # Verbose
        opt_t=0 # Disable TTY themes
        opt_z=0 # No ZSH

        while getopts "clmvtz" opt; do
                case "${opt}" in
                        c) opt_c=1 ;;
                        l) opt_l=1 ;;
                        m) opt_m=1 ;;
                        v) opt_v=1 ;;
                        t) opt_t=1 ;;
                        z) opt_z=1 ;;
                        h|?) display_help ;;
                esac
        done

        if [[ "${opt_c}" -eq 1 ]]; then
                if clean_logs; then
                        _message "S" "Log files removed" "V"
                else
                        _message "I" "Nothing to remove" "V"
                fi
                exit 0
        fi
        
        # Check user
        if [[ "${EUID}" -ne 0 ]]; then
                _message "E" "This script must be executed as root. Exiting" "V"
                exit 1
        fi

        _message "I" "Welcome to my conf deployment!" "V"

        # - Detect the distribution
        detect_distro # Will upload $ID into env
        
        # - Install the required packages
        install_packages

        # - Deploy environment variables
        set_env_vars

        # - Bashrc management
        bashrc

        # - Zshrc management + plugins
        zshrc

        # - Sudoers management
        sudoers_file

        # - TTY themes management
        tty_themes

        return 0
}

main "${@}"
