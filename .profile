# This file gets sourced by bash when a new shell is started, but also by the
# display manager (if available).

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR="nano"
# non-standard env used by i3-sensible-terminal
export TERMINAL="urxvt"

if [ -n "$BASH_VERSION" ]; then
	# Bash-only stuff

	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi

	if [[ -z $DISPLAY ]] && [[ $(tty) == "/dev/tty1" ]]; then
		if which startx; then
			exec startx
		elif which sway; then
			export XKB_DEFAULT_LAYOUT=se
			exec sway --unsupported-gpu
        fi
	fi
fi
