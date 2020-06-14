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

Bootstrap environment.

    $ yadm bootstrap

Decrypt the sensitive files.

	$ yadm decrypt

## Ubuntu 18.04 LTS server packages

Minimum to get the window manager running:

    $ apt-get install i3 xinit rxvt-unicode x11-xserver-utils feh

* Download fzf and put it into ~/.local/bin/ or ~/bin (re-login to receive
these on the PATH).

## ArchLinux

Minimum to get the window manager running:

    $ pacman -Sy i3-wm xorg-server xorg-xinit xorg-xrandr xorg-xrdb rxvt-unicode feh i3status i3lock fzf

Also make sure the correct display drivers are installed.

## Optional stuff

Gets launched automatically if installed, but won't break anything if missing.

### Redshift

Adjust color tint based on location and time of day. NOTE: The Ubuntu Redshift
has a lot of large dependencies (wpa-supplicant, avahi, ...)

Ubuntu:

    $ apt-get install redshift

ArchLinux

    $ pacman -Sy redshift

### gxkb

Displays a country flag in the traybar corresponding to the current keyboard
layout set.

Ubuntu:

    $ apt-get install gxkb 

ArchLinux:

    $ pacman -Sy gxkb

### ssh agent

Run SSH authentication agent at login session.

* Make sure ssh-agent is installed by installing openssh.

Ubuntu:

    $ apt-get install openssh-client

ArchLinux:

    $ pacman -Sy openssh

* Enable the ssh-agent systemd service (unless running a display manager).

    $ systemctl --user enable ssh-agent.service
    $ systemctl --user start ssh-agent.service


