function config_files()
{
        local userdirs=(
                "/root"
                "/etc/skel"
        )
        
        # Get every user home
        for i in /home/*; do
                if [[ -d "${i}" ]]; then
                        userdirs+=("${i}")
                fi
        done

        # For each user directory...
        for i in "${userdirs[@]}"; do
                mkdir -p "${a}/.config" 2> "/dev/null"
                # ...copy it in each user home + /etc/skel and /root...
                for a in ./include/.config/*; do
                        if [[ -d "${a}" ]]; then
                                cp -rf "${a}" "${i}/.config"
                        fi
                done
                # ...and copy the rest of the files to those dirs.
                for b in ./include/.config/*; do
                        if [[ -f "${b}" ]]; then
                                cp -f "${b}" "${a}"
                        fi
                done
        done
}
