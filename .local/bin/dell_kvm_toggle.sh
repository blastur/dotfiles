#!/bin/bash -eu

# Serialnumber of my DELL U2722DE (with built-in kvm)
KVM_SN="5PZ84P3"

# ddc feature for "Input source"
FEATURE_INPUT=60

INPUT_SOURCE_USBC="x1b"
INPUT_SOURCE_DP="x0f"
INPUT_SOURCE_HDMI="x11"

set_input() {
    local input="${1:-}"

    ddcutil -l "DELL U2722DE" setvcp ${FEATURE_INPUT} "${input}"
}

get_input() {
    ddcutil -l "DELL U2722DE" getvcp ${FEATURE_INPUT} -t | cut -d" " -f4
}

main() {
    local current_input

    current_input=$(get_input)

    case ${current_input} in
        ${INPUT_SOURCE_DP} )
            echo "Switching to input source USB-C"
            set_input ${INPUT_SOURCE_USBC}
            ;;
        ${INPUT_SOURCE_USBC} )
            echo "Switching to input source Display port"
            set_input ${INPUT_SOURCE_DP}
            ;;

        ${INPUT_SOURCE_HDMI} )
            echo "Current input source is HDMI, skip toggle."
            ;;

        *)
            echo "Unknown input source, switching to DP"
            set_input ${INPUT_SOURCE_DP}
    esac
}

main "$@"
