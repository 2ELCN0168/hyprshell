function install_packages()
{
        pkg_list=(
                "vim"
                "tmux"
                "autofs"
                "gdisk"
                "hdparm"
        )

        if [[ "${DETECTED_DISTRO}" -eq 1 ]]; then
                # Debian
                pkg_list+=(
                        "nfs-common"
                )
        else
                pkg_list+=(
                        "nfs-utils"
                        "nvim"
                )
        fi

        if [[ "${opt_z}" -ne 1 ]]; then
                # Add zsh
                pkg_list+=(
                        "zsh"
                        "zsh-history-substring"
                )
        fi

        if [[ "${opt_m}" -ne 1 ]]; then
                # Add monitoring pack
                pkg_list+=(
                        "btop"
                        "htop"
                        "top"
                        "nmon"
                        "termshark"
                        "tcpdump"
                        "gping"
                        "bottom"
                        "bmon"
                )
        fi 

        _message "I" "Installing the following packages: ${G}${pkg_list[*]}${N}"

        if [[ "${DETECTED_DISTRO}" -eq 1 ]]; then
                # Debian
                if apt-get install --ignore-missing "${pkg_list[*]}" -y; then
                        _message "S" "Installed packages"
                else
                        _message "E" "Cannot install the packages"
                fi
        elif [[ "${DETECTED_DISTRO}" -eq 2 ]]; then
                # Archlinux
                if pacman -S --noconfirm "${pkg_list[*]}"; then
                        _message "S" "Installed packages"
                else
                        _message "E" "Cannot install the packages"
                fi
        elif [[ "${DETECTED_DISTRO}" -eq 3 ]]; then
                # RHEL
                local cmd=""
                if [[ "$(dnf --version | head -1 | grep -o '^dnf5')" == "dnf5" ]]; then
                        cmd="dnf install -y --skip-unavailable ${pkg_list[*]}"
                else
                        cmd="dnf install -y --skip-broken ${pkg_list[*]}"
                fi

                if ${cmd}; then
                        _message "S" "Installed packages"
                else
                        _message "E" "Cannot install the packages"
                fi
        fi

        return 0
}
