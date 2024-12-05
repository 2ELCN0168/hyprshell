function zshrc()
{
        [[ "${opt_z}" -eq 1 ]] && return


        if [[ "${DETECTED_DISTRO}" -eq 1 ]]; then
                # Debian
                git clone "https://github.com/zdharma-continuum/fast-syntax-highlighting" \
                "/usr/share/zsh-fast-syntax-highlighting"
                git clone "https://github.com/MichaelAquilina/zsh-you-should-use" \
                "/usr/share/zsh-you-should-use"
                {
                        echo -e "\n# PLUGINS #\n"

                        echo "source \"/usr/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh\""
                        echo "source \"/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh\""
                        echo "source \"/usr/share/zsh-you-should-use/you-should-use.plugin.zsh\""
                } >> "../include/.zshrc"
        elif [[ "${DETECTED_DISTRO}" -eq 2 ]]; then
                # Archlinux
                git clone "https://github.com/zdharma-continuum/fast-syntax-highlighting" \
                "/usr/share/zsh/plugins/zsh-fast-syntax-highlighting"
                git clone "https://github.com/MichaelAquilina/zsh-you-should-use" \
                "/usr/share/zsh/plugins/zsh-you-should-use"
                {
                        echo -e "\n# PLUGINS #\n"

                        echo "source \"/usr/share/zsh/plugins/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh\""
                        echo "source \"/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh\""
                        echo "source \"/usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh\""
                } >> "../include/.zshrc"

        elif [[ "${DETECTED_DISTRO}" -eq 3 ]]; then
                # RHEL
                git clone "https://github.com/zdharma-continuum/fast-syntax-highlighting" \
                "/usr/share/zsh/zsh-fast-syntax-highlighting"
                git clone "https://github.com/MichaelAquilina/zsh-you-should-use" \
                "/usr/share/zsh/zsh-you-should-use"
                {
                        echo -e "\n# PLUGINS #\n"

                        echo "source \"/usr/share/zsh/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh\""
                        echo "source \"/usr/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh\""
                        echo "source \"/usr/share/zsh/zsh-you-should-use/you-should-use.plugin.zsh\""
                } >> "../include/.zshrc"
        fi

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
