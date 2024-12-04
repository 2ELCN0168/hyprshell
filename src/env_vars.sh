function set_env_vars()
{
        mkdir "/etc/shell_conf.d/"

        cp "../include/env.sh" "/etc/shell_conf.d/"
        cp "../include/aliases.sh" "/etc/shell_conf.d/"
        
        if [[ "${DETECTED_DISTRO}" -eq 3 ]]; then
                # RHEL - SELinux context
                semanage fcontext -a -t etc_t "/etc/shell_conf.d(/.*)?"
                restorecon -R "/etc/shell_conf.d/"
        fi

        return 0
}
