#!/bin/bash
# Sets up NAT routing for users on ${INT} network interface to ${EXT}
# Any client on ${INT} must setup this machine as its gateway (manually or using dhcp)

INT=$1
EXT=$2

if [ -z "${INT}" -o -z "${EXT}" ]; then
    echo "usage: $0 <internal-network> <external-network>" >&2
    exit 1
fi

if ! which iptables > /dev/null; then
    echo "error: iptables not found" >&2
    exit 1
fi

if [ ! -f "/proc/sys/net/ipv4/ip_forward" ]; then
    echo "error: sysfs does not expose ip_forward. disabled in your kernel?" >&2
    exit 1
fi

echo "IPv4 NAT routing setup ${INT} -> ${EXT}"

enable_ipmasq() {
    local ext
    local int
    int=${1}
    ext=${2}
    if ! echo 1 > /proc/sys/net/ipv4/ip_forward; then
        echo "error: failed to enable ipv4 forwarding. you are probably not root?" >&2
        exit 1
    fi
    iptables -t nat -A POSTROUTING -o ${EXT} -j MASQUERADE
    iptables -A FORWARD -i ${EXT} -o ${INT} -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i ${INT} -o ${EXT} -j ACCEPT
}

enable_ipmasq ${INT} ${EXT}
