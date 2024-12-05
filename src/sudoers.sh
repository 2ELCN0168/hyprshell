function sudoers_file()
{
        _message "I" "Adding options to ${P}/etc/sudoers${N}"
        {
                echo "# Options added by Hyprshell"
                echo "Defaults timestamp_timeout=0"
                echo "Defaults insults" 
                echo "Defaults pwfeedback"
        } >> "/etc/sudoers"

        if [[ "${?}" -eq 0 ]]; then
                _message "S" "Added options to ${P}/etc/sudoers${N}"
        else
                _message "W" "Could not add options to ${P}/etc/sudoers${N}"
        fi
}
