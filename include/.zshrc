# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -Uz compinit
compinit
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '(%b) '
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
eval "$(dircolors -b)"
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

zmodload zsh/net/tcp

setopt extendedglob
setopt promptsubst
setopt histignoredups

# PLUGINS #

source "/usr/share/zsh/plugins/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh"

# PROMPT

precmd() { vcs_info }
if [[ "${EUID}" -eq 0 ]]; then
        # Root account!
        NEWLINE=$'\n'
        PROMPT='%F{red}%M%f${NEWLINE}'
        PROMPT+='%F{yellow}%*%f %F{red}%B[%n]%b%f %F{white}%B%~%b%f %F{red}${vcs_info_msg_0_}%f${NEWLINE}'
        PROMPT+='%F{red}#%f '
elif id -nG "${USER}" | grep -qE '\b(sudo|wheel)\b'; then
        # Administrative user
        PROMPT='%F{cyan}%*%f %F{green}%B[%n]%b%f %F{white}%B%~%b%f %F{green}${vcs_info_msg_0_}%f${NEWLINE}'
        PROMPT+='%F{yellow}$%f '
else
        # Normal user
        PROMPT='%F{white}[%f%F{cyan}%n%f%F{white}) %B%~%b%f %F{green}${vcs_info_msg_0_}%f${NEWLINE}'
        PROMPT+='%F{cyan}$%f '
fi

# Source every shell/env configuration file in "/etc/shell_conf.d"
for i in /etc/shell_conf.d/*.sh; do
        [[ -r "${i}" ]] && source "${i}"
done