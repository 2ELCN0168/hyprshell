function set_permissions()
{
        local users=()
        local username=""

        _message "I" "Scanning users in ${P}/home${N}"

        for i in /home/*; do
                username=$(basename "${i}")
                _message "S" "Detected user ${C}${username}${N}"
                users+=("${i}")
        done

        for i in "${users[@]}"; do
                username=$(basename "${i}")
                _message "I" "Correcting permissions for ${C}${username}${N}"
                if chown -R "${username}": "${i}"; then
                        _message "S" "Corrected permissions for ${C}${username}${N}"
                else
                        _message "W" "Cannot correct permissions for ${C}${username}${N}"
                fi
        done

        _message "I" "Correcting permissions for ${C}root${N}"

        if chown -R root: "/etc/shell_conf.d/" \
        "/etc/tty_themes.d/" "/root" "/etc/skel"; then
                _message "S" "Corrected permissions for ${C}root${N}"
        else
                _message "W" "Cannot correct permissions for ${C}root${N}"
        fi
}
