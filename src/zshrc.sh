function zshrc()
{
        [[ "${opt_z}" -eq 1 ]] && return

        _message "I" "Copying ${P}.zshrc${N}"

        local dirs=(
                "/root"
                "/etc/skel"
        )

        for i in /home/*; do
                if [[ -d "${i}" ]]; then
                        dirs+=("${i}")
                fi
        _message "I" "Detected ${P}${i}${N}"
        done
        
        for i in "${dirs[@]}"; do
                if cp -f "../include/.zshrc" "${i}"; then
                        _message "S" "Copied ${P}.zshrc${N} to ${P}${i}${N}"
                else
                        _message "W" "Could not copy ${P}.zshrc${N} to ${P}${i}${N}"
                fi
        done
}
