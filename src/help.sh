function display_help()
{
        printf "${R}This script must be executed as root!${N}\n"
        printf "Tested on: ${G}Fedora, Archlinux, Debian, Oracle Linux.${N}\n"
        printf "Usage :\n"
        printf "  ${Y}-c${N}        Clean log files only\n"
        printf "  ${Y}-f${N}        Do not install font (Uni3-Terminus16.psf)\n"
        printf "  ${Y}-h${N}        Display this help\n"
        printf "  ${Y}-l${N}        Enable logging\n"
        printf "  ${Y}-m${N}        No monitoring pack\n"
        printf "  ${Y}-v${N}        Enable verbose mode\n"
        printf "  ${Y}-t${N}        Disable TTY themes installation\n"
        printf "  ${Y}-z${N}        Do not install ZSH\n"

        return 0
}
