#!/bin/bash -eu
# Set up wallpaper (or background color) based on environment
# variables WALLPAPER_DIR and WALLPAPER_MODE

# Either a solid color (specified as #rrggbb) or "random"
WALLPAPER_MODE=${WALLPAPER_MODE:-#101010}

# Wallpaper directory (used when mode is "random")
WALLPAPER_DIR=${WALLPAPER_DIR:-$HOME/.config/wallpapers}

random_wallpaper() {
    local dir=$*

    if [ ! -d "${dir}" ]; then
        echo "error: dir '${dir}' doesn't exist, cannot select wallpaper" >&2
        solid_color
    fi

    find "${dir}" | sort -R | tail -n1 | while read -r file; do
        echo "Setting random wallpaper '${file}'"
        feh --no-fehbg --bg-fill "${file}"
    done
}

solid_color() {
    if ! xsetroot -solid "${WALLPAPER_MODE}"; then
        echo "error: failed to set solid color ${WALLPAPER_MODE}" >&2
        exit 1
    fi
}

fixed_wallpaper() {
    local bg="${HOME}/.config/bg.jpg"
    if [ -e "${bg}" ]; then
        feh --no-fehbg --bg-fill "${bg}"
    else
        solid_color
    fi
}

case "${WALLPAPER_MODE}" in
    fixed)
        fixed_wallpaper
        ;;
    random)
        random_wallpaper "${WALLPAPER_DIR}"
        ;;
    \#*)
        solid_color
        ;;
    *)
        echo "error: bad wallpaper mode ${WALLPAPER_MODE}" >&2
        exit 1
        ;;
esac
