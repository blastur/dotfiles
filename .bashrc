export PS1="\u@\h:\W\\$ "

alias ls='ls --color=auto'
alias ll='ls -l'

# This is used by the systemd user service "ssh-agent" (~/.config/systemd/user)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
