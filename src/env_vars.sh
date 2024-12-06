function set_env_vars()
{
        _message "I" "Creating folder ${P}/etc/shell_conf.d${N}"
        if [[ ! -d "/etc/shell_conf.d/" ]]; then
                if mkdir "/etc/shell_conf.d/" 1> "/dev/null" 2>&1; then
                        _message "S" "Created folder ${P}/etc/shell_conf.d${N}"
                else
                        _message "W" "Cannot create folder ${P}/etc/shell_conf.d${N}"
                fi
        fi

        _message "I" "Copying ${P}./include/env.sh${N} to ${P}/etc/shell_conf.d${N}"
        if cp -f "./include/env.sh" "/etc/shell_conf.d/" 1> "/dev/null" 2>&1; then
                _message "S" "Copied ${P}./include/env.sh${N} to ${P}/etc/shell_conf.d${N}"
        else
                _message "W" "Cannot copy ${P}./include/env.sh${N} to ${P}/etc/shell_conf.d${N}"
        fi

        _message "I" "Copying ${P}./include/aliases.sh${N} to ${P}/etc/shell_conf.d${N}"
        if cp -f "./include/aliases.sh" "/etc/shell_conf.d/" 1> "/dev/null" 2>&1; then
                _message "S" "Copied ${P}./include/aliases.sh${N} to ${P}/etc/shell_conf.d${N}"
        else
                _message "W" "Cannot copy ${P}./include/aliases.sh${N} to ${P}/etc/shell_conf.d${N}"
        fi
        
        # if [[ "${DETECTED_DISTRO}" -eq 3 ]]; then
        #         # RHEL - SELinux context
        #         semanage fcontext -a -t etc_t "/etc/shell_conf.d(/.*)?"
        #         restorecon -R "/etc/shell_conf.d/"
        # fi

        return 0
}
