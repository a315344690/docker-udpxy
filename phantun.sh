#!/bin/sh

Sip=45.11.104.129
Port=21799
echo "Container: Server ip is:$Sip, Port is:$Port"

sysctl -w net.ipv4.ip_forward=1
sysctl -p

iptables -t nat -F
iptables -t nat -A POSTROUTING -o eth0 -s 10.0.0.0/24 -j MASQUERADE
RUST_LOG=info phantun_client --local 10.0.2.2:21799 --remote $Sip:$Port  &> /var/log/phantun_client.log &
