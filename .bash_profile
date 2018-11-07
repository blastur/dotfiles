if [[ -z $DISPLAY ]] && [[ $(tty) == "/dev/tty1" ]]; then
    if which sway; then
        export XKB_DEFAULT_LAYOUT=se
        exec ssh-agent sway
    elif which startx; then
        exec ssh-agent startx
    fi
fi
