#!/bin/sh

#\$1:local port
#\$2:remote address
#\$3:remote port

localPort=\$1
remoteAddr=\$2
remotePort=\$3

#local address
localAddr=\`ip -4 addr show eth0 | awk  '/global/ {print \$2}' | cut -d'/' -f1\`

#clear iptables rules
iptables -t nat -F

#masquerade tun output traffic
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

#RUST_LOG=info
/usr/local/bin/phantun_client --ipv4-only --local \$localAddr:\$localPort --remote \$remoteAddr:\$remotePort
