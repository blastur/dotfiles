# Make sure bashrc is sourced even for login-shells
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [[ -z $DISPLAY ]] && [[ $(tty) == "/dev/tty1" ]]; then
    if which sway; then
        export XKB_DEFAULT_LAYOUT=se
        exec sway
    elif which startx; then
        exec startx
    fi
fi
