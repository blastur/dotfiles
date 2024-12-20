# Dotfiles

This repo contains my Linux dotfiles. I use it to setup ArchLinux/Manjaro
and Debian/Ubuntu machines the way I want it. Assumes you either use Sway
on Wayland or i3 on x.org and bash as your main shell.

I use [Yet-Another-Dotfiles-Manager (YADM)](https://yadm.io) to manage my
dotfiles.

If you don't already have YADM installed, it can be run remotely via a curled
pipe to perform the initial clone:

    $ source <(curl -L bootstrap.yadm.io)

Initialize homedir using YADM clone:

    $ yadm clone https://github.com/blastur/dotfiles.git

Set the preferred class, e.g "work".

    $ yadm config local.class work

yadm will automatically select the appropriate configs based on hostname
and class.

Bootstrap environment.

    $ yadm bootstrap

Decrypt the sensitive files.

	$ yadm decrypt

NOTE: This dotfiles repo includes a copy of YADM, so the remotely run YADM is
only used for the initial session.

## Ubuntu 20.04 LTS server packages

Minimum to get the i3 window manager running:

    $ apt install i3 xinit rxvt-unicode x11-xserver-utils feh fzf

Alternatively, sway window manager (Wayland):

    $ apt install sway swaylock rxvt-unicode swaybg fzf i3status

## Debian

Minimum to get the i3 window manager running:

    $ apt  install i3 xinit rxvt-unicode x11-xserver-utils feh fzf

Nice stuff:

    $ apt install sudo htop git firefox-esr network-manager unzip

Disable pc-speaker:

    $ echo "blacklist pcspkr" >>/etc/modprobe.d/blacklist.conf

## ArchLinux

Minimum to get the window manager running:

    $ pacman -Sy i3-wm xorg-server xorg-xinit xorg-xrandr xorg-xrdb rxvt-unicode feh i3status i3lock fzf

Also make sure the correct display drivers are installed.

## Optional stuff

Gets launched automatically if installed, but won't break anything if missing.

### Redshift (X.org only)

Adjust color tint based on location and time of day. NOTE: The Ubuntu Redshift
has a lot of large dependencies (wpa-supplicant, avahi, ...)

Ubuntu:

    $ apt-get install redshift

ArchLinux:

    $ pacman -Sy redshift

### Scrot (X.org only)

Grab screenshots (of screen or selection). Optionally install xclip so keybind
that captures screenshot to clipboard works.

Ubuntu:

    $ apt-get install scrot xclip

Archlinux:

    $ pacman -Sy scrot xclip

### Grim (wayland ony)

Grab screenshots to clipboard on Wayland.

Ubuntu:

    $ apt-get install grim wl-clipboard

Archlinux:

    $ pacman -Sy grim wl-clipboard

### ddcutil

Set monitor input source, used to switch between computer inputs (KVM).

Ubuntu:

    $ apt-get install ddcutil

Archlinux:

    $ pacman -Sy ddcutil

### gxkb (X.org only)

Displays a country flag in the traybar corresponding to the current keyboard
layout set.

Ubuntu:

    $ apt-get install gxkb

ArchLinux:

    $ pacman -Sy gxkb

### brightnessctl

Adjust screen brightness (for laptops etc) using dedicated function keys.

Ubuntu:

    $ apt install brightnessctl

### autorandr (X.org only)

Automatically detect and setup display outputs based on connected monitors.

Ubuntu:

    $ apt install autorandr

Run "autorandr -c" to switch to the first detected configuration. This also
gets automatically run on suspend/resume or when udev detects monitor hotplug
event (at least on Ubuntu).

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


### Firefox profile

Install firefox and start it once to create a profile. Find its
location (for example via about:support) and close Firefox again.

* Delete all files in profile directory.

* Unzip ~/.local/data/firefox/profile.zip.

* Start firefox (should be running sane profile now).

profile.zip is generated from https://ffprofile.com.
