#!/bin/bash -eu
# Set up wallpaper (or background color) based on environment
# variables WALLPAPER_DIR and WALLPAPER_MODE

# Either a solid color (specified as #rrggbb) or "random"
WALLPAPER_MODE=${WALLPAPER_MODE:-#101010}

# Wallpaper directory (used when mode is "random")
WALLPAPER_DIR=${WALLPAPER_DIR:-$HOME/.config/wallpapers}

random_wallpaper() {
    dir=$*

    if [ ! -d "${dir}" ]; then
        echo "error: dir '${dir}' doesn't exist, cannot select wallpaper" >&2
        exit 1
    fi

    find "${dir}" |sort -R | tail -n1 | while read -r file; do
        echo "Setting random wallpaper '${file}'"
        feh --no-fehbg --bg-fill "${file}"
    done
}

case "${WALLPAPER_MODE}" in
    \#*)
        xsetroot -solid "${WALLPAPER_MODE}"
        ;;
    random)
        random_wallpaper "${WALLPAPER_DIR}"
        ;;
esac
