export PS1="\u@\h:\W\\$ "

alias ls='ls --color=auto'
alias ll='ls -l'

# Setup SSH agent env unless it's already been setup elsewhere (e.g by Xsession)
if [ -z "${SSH_AUTH_SOCK}" ]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
