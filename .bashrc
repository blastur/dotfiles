export PS1="\u@\h:\W\\$ "
export PATH=$PATH:~/bin:~/.local/bin

export EDITOR="nano"
# non-standard env used by i3-sensible-terminal
export TERMINAL="termite"

alias ls='ls --color=auto'
alias ll='ls -l'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
