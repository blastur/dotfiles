# Dotfiles

This repo contains my Linux dotfiles. I use it to setup ArchLinux/Manjaro
and Debian/Ubuntu machines the way I want it. Assumes you either use Sway
on Wayland or i3 on x.org and bash as your main shell.

I use [Yet-Another-Dotfiles-Manager
(YADM)](https://thelocehiliosan.github.io/yadm/) to manage dotfiles. Once
you've installed yadm, a clone will initialize the homedir.

    $ yadm clone https://github.com/blastur/dotfiles.git

Set the preferred class, e.g "work".

    $ yadm config local.class work

yadm will automatically select the appropriate configs based on hostname
and class.

Decrypt the sensitive files.

	$ yadm decrypt

## Ubuntu 18.04 LTS server packages

Minimum to get the window manager running:

    $ apt-get install i3 xinit rxvt-unicode x11-xserver-utils feh

Optional (but nice). Redshift gets launched automatically if installed.
NOTE: Redshift has a lot of large dependencies (wpa-supplicant, avahi, ...)

    $ apt-get install redshift

gxkb also gets launched automatically if installed. It displays a country
flag corresponding to the current keyboard layout set.

    $ apt-get install gxkb 

* Download fzf and put it into ~/.local/bin/ or ~/bin (re-login to receive
these on the PATH).

* Enable the ssh-agent systemd service (unless running a display manager).

    $ systemctl --user enable ssh-agent.service
    $ systemctl --user start ssh-agent.service

