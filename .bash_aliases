# Setup SOCKS 5 proxy on port 9000 to remote network
sshproxy() { 
    while true; do 
        ssh -oTCPKeepAlive=no -oServerAliveInterval=60 -oServerAliveCountMax=10 -D9000 $*
        sleep 1
    done 
}

# Aliases for SSH and SCP to dev-devices that frequently change their fingerprints 
alias devssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias devscp='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

# Cast audio/video to livingroom Chromecast
alias cast='vlc --sout "#chromecast{ip=192.168.1.3,mux=cc_demux}"'

# Toggle touchpad on laptops
alias touchpad_disable='synclient TouchpadOff=1'
alias touchpad_enable='synclient TouchpadOff=0'

# Twitch streaming via streamlink
alias twitch='streamlink --player-passthrough hls'

# Open ze vault
alias vopen='~/.vault/open.sh'

# udisks
alias mnt='udisksctl mount -b'
alias umnt='udisksctl unmount -b'

