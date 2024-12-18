function bashrc()
{
        _message "I" "Copying ${P}.bashrc${N}"

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
                if cp -f "./include/.bashrc" "${i}"; then
                        _message "S" "Copied ${P}.bashrc${N} to ${P}${i}${N}"
                else
                        _message "W" "Could not copy ${P}.bashrc${N} to ${P}${i}${N}"
                fi
        done

        for i in "${dirs[@]}"; do
                if cp -f "./include/.git-prompt.sh" "${i}"; then
                        _message "S" "Copied ${P}.git-prompt.sh${N} to ${P}${i}${N}"
                else
                        _message "W" "Could not copy ${P}.git-prompt.sh${N} to ${P}${i}${N}"
                fi
        done
}
