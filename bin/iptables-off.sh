#!/bin/sh

exec >> /tmp/ansible-iptables.log 2>&1

source /opt/.lycu1580v2/bin/config.sh

iptables -F

#iptables -P INPUT ACCEPT
#iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
