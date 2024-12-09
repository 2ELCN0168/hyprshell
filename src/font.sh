function font_mgmt() 
{
        [[ "${opt_f}" -eq 1 ]] && return

        _message "I" "Installing ${C}Uni3-Terminus16.psf${N}"

        local font="https://www.zap.org.au/projects/console-fonts-distributed/psftx-debian-12.4/Uni3-Terminus16.psf"
        local path=""

        if [[ "${DETECTED_DISTRO}" -eq 1 ]]; then
                # Debian
                {
                        echo "ACTIVE_CONSOLES=\"/dev/tty[1-6]\""
                        echo "CHARMAP=\"UTF-8\""
                        echo "CODESET=\"Uni3\""
                        echo "FONTFACE=\"Terminus\""
                        echo "FONTSIZE=\"8x16\""
                } > "/etc/default/console-setup"
                _message "S" "Installed ${C}Uni3-Terminus16.psf${N}"
                setupcon
        elif [[ "${DETECTED_DISTRO}" -eq 2 ]]; then
                # Archlinux
                if set_vconsole; then
                        _message "S" "Installed ${C}Uni3-Terminus16.psf${N}"
                else
                        _message "W" "Cannot install ${C}Uni3-Terminus16.psf${N}"
                fi
                systemctl restart systemd-vconsole-setup.service
        elif [[ "${DETECTED_DISTRO}" -eq 3 ]]; then
                # RHEL
                if [[ "${ID}" == "ol" ]]; then
                        # Oracle Linux
                        wget "${font}" -P "/usr/lib/kbd/consolefonts"
                        if set_vconsole "Uni3-Terminus16"; then
                                _message "S" "Installed ${C}Uni3-Terminus16.psf${N}"
                        else
                                _message "W" "Cannot install ${C}Uni3-Terminus16.psf${N}"
                        fi
                else
                        dnf install -y terminus-fonts-console
                        if set_vconsole "ter-116n"; then
                                _message "S" "Installed ${C}Uni3-Terminus16.psf${N}"
                        else
                                _message "W" "Cannot install ${C}Uni3-Terminus16.psf${N}"
                        fi
                fi
                systemctl restart systemd-vconsole-setup.service
        fi
}

function set_vconsole()
{
        local file="/etc/vconsole.conf"
        if [[ -f "${file}" ]]; then
                if grep -q "^FONT=" "${file}"; then
                        sed -i "s/^FONT=.*/FONT=${1}/" "${file}"
                else
                        echo "FONT=ter-116n" >> "${file}"
                fi
        else
                echo "FONT=ter-116n" > "${file}"
        fi
}