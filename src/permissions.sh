function set_permissions()
{
        local users=()

        for i in /home/*; do
                users+=("${i}")
        done

        local username=""
        for i in "${users[@]}"; do
                username=$(basename "${i}")
                chown -R "${username}": "${i}"
        done

        chown -R root: "/etc/shell_conf.d/" \
        "/etc/tty_themes.d/" "/root" "/etc/skel"
}
