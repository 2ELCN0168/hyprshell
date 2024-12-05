# Do nothing if shell is not interactive
[[ "${-}" != *i* ]] && return

# History size
HISTSIZE=10000
HISTFILESIZE=20000

# Ignore consecutive and identical commands
HISTCONTROL=ignoredups:erasedups

# Add timestamps to commands in history
HISTTIMEFORMAT="%d/%m/%Y %H:%M:%S "

# Add history from previous sessions
shopt -s histappend

# Source every shell/env configuration file in "/etc/shell_conf.d"
for i in /etc/shell_conf.d/*.sh; do
        [[ -r "${i}" ]] && source "${i}"
done

source "~/.git-prompt.sh"

# Prompt
if [[ "${EUID}" -eq 0 ]]; then
        # Root account!
        PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'
        PS1='\[\e[93m\][\@]\[\e[91m\][\[\e[1m\]\u\[\e[0m\] \[\e[97;1;2;3m\]\w\[\e[0;91m\]]\[\e[0m\] \[\e[91;2m\]${PS1_CMD1}\[\e[0m\] \[\e[31;2;3m\]\H\n\[\e[22;91m\]\$\[\e[0m\] '
elif id -nG "${USER}" | grep -qE '\b(sudo|wheel)\b'; then
        # Administrative user
        PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'
        PS1='\[\e[96m\][\@][\[\e[92;1m\]\u\[\e[0m\] \[\e[90;3m\]\w\[\e[0;96m\]]\[\e[0m\] \[\e[92;2m\](${PS1_CMD1})\n\[\e[0;93;3m\]\$\[\e[0m\] '
else
        # Normal user
        PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'
        PS1='(\[\e[96m\]\u\[\e[0m\] \[\e[97;2;3m\]\w\[\e[0m\]) \[\e[92;2;3m\]${PS1_CMD1}\n\[\e[22;96m\]\$\[\e[0m\] '
fi
