[[ "${TERM}" != "linux" ]] && return

if [[ "${EUID}" -eq 0 ]]; then
        _dracula
else
        _synth
fi
