function tty_themes()
{
        [[ "${opt_t}" -eq 1 ]] && return
        
        _message "I" "Copying TTY themes to ${P}/etc${N}"
        if cp -rf "../include/tty_themes.d/" "/etc/"; then
                _message "S" "Copied TTY themes to ${P}/etc${N}"
        else
                _message "W" "Could not copy TTY themes to ${P}/etc${N}"
        fi

        cp -f "../include/tty_themes.sh" "/etc/shell_conf.d/"
        cp -f "../include/tty_themes.sh" "/etc/shell_conf.d/"
}
