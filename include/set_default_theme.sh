[[ "${TERM}" != "linux" ]] && return

if [[ "${EUID}" -eq 0 ]]; then
        source "/etc/tty_themes.d/dracula.sh" 
else
        source "/etc/tty_themes.d/synthwave86.sh" 
fi
