function set_env_vars()
{
        if [[ ! -d "/etc/shell_conf.d/" ]]; then
                mkdir "/etc/shell_conf.d/" 1> "/dev/null" 2>&1
        fi

        cp -f "./include/env.sh" "/etc/shell_conf.d/" 1> "/dev/null" 2>&1
        cp -f "./include/aliases.sh" "/etc/shell_conf.d/" 1> "/dev/null" 2>&1
        
        # if [[ "${DETECTED_DISTRO}" -eq 3 ]]; then
        #         # RHEL - SELinux context
        #         semanage fcontext -a -t etc_t "/etc/shell_conf.d(/.*)?"
        #         restorecon -R "/etc/shell_conf.d/"
        # fi

        return 0
}
