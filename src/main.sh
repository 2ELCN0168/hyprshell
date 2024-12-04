function _colors()
{
        R="\033[91m"
        G="\033[92m"
        Y="\033[93m"
        B="\033[94m"
        P="\033[95m"
        C="\033[96m"
        N="\033[0m"

        INFO="${C}[>]${N}"
        SUC="${G}[*]${N}"
        ERR="${R}[!]${N}"
        WARN="${Y}[?]${N}"

        LOG_I="[INFO] [$(date +%H:%m:%s)]:"
        LOG_S="[SUCCESS] [$(date +%H:%m:%s)]:"
        LOG_W="[WARNING] [$(date +%H:%m:%s)]:"
        LOG_E="[ERROR] [$(date +%H:%m:%s)]:"
}

function main() {
        source "help.sh"
        source "detect_distro.sh"

        # Init colors and else
        _colors

        # Logs
        logfile="../out/log.txt"

        # Options
        opt_v=0 # Verbose
        opt_t=0 # Disable TTY themes
        opt_l=0 # Make a log file

        while getopts "vtl" opt; do
                case "${opt}" in
                        v) opt_v=1 ;;
                        t) opt_t=1 ;;
                        l) opt_l=1 ;;
                        ?) display_help ;;
                esac
        done

        distribution=$(detect_distro)

        echo $distribution
}

main "${@}"