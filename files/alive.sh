#!/bin/sh

# exec >> /tmp/ansible-alive_cron.lo 2>&1


hn=`hostname`
disk=`df -h / | awk '{print $4}' | tail -n 1`
ip=`ip addr | grep 'inet ' | grep -v "127.0.0.1" | awk '{print $2}' | tr '/' '=' | tr '\n' '-'`
mac=`ip link | grep link | grep -v loopback | awk '{print $2}' | tr '\n' '-'`
mem=`free -h | head -n 2 | tail -n 1 | awk '{print $2}'`
uptime=`uptime | tr " " "="`

curl -I https://bf726e13342a.hosting.myjino.ru/mos12_ansible/touch/$hn/alive/$disk/$ip/$mac/$mem/$uptime/v2/

