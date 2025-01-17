#!/bin/sh

exec >> /tmp/ansible-iptables.log 2>&1

source bin/config.sh

iptables -F

#iptables -P INPUT ACCEPT
#iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
