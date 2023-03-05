#!/bin/bash -eu

CONSERVATION_MODE_FILE="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

toggle_conservation_mode() {
    if ! lsmod | grep -q ideapad_laptop; then
        echo "error: ideapad_laptop kernel module not loaded, abort"  >&2
        return 1
    fi

    if [ ! -f "${CONSERVATION_MODE_FILE}" ]; then
        echo "error: unable to find conservation mode file in sysfs, abort" >&2
        return 1
    fi

    local current_mode
    local new_mode


    current_mode=$(cat "${CONSERVATION_MODE_FILE}")
    if [[ "${current_mode}" == "0" ]]; then
        echo "Battery conservation is disabled, enabling."
        new_mode=1
    else
        echo "Battery conservation is enabled, disabling."
        new_mode=0
    fi

    echo "${new_mode}" | sudo tee  "${CONSERVATION_MODE_FILE}" > /dev/null
}

toggle_conservation_mode "$@"