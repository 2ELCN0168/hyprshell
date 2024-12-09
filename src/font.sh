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
        elif [[ "${DETECTED_DISTRO}" -eq 2 ]]; then
                # Archlinux
                set_vconsole
        elif [[ "${DETECTED_DISTRO}" -eq 3 ]]; then
                # RHEL
                if [[ "${ID}" == "ol" ]]; then
                        # Oracle Linux
                        wget "${font}" -P "/usr/lib/kbd/consolefonts"
                        set_vconsole "Uni3-Terminus16"
                else
                        dnf install -y terminus-font
                        set_vconsole "ter-116n"
                fi
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