#!/bin/sh

exec >> /tmp/ansible-iptables.log 2>&1

source bin/config.sh

iptables -F

#iptables -P INPUT ACCEPT
#iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

iptables -A OUTPUT -o lo -j ACCEPT # loopback
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT # DNS

# for sdo.1580.ru
iptables -A OUTPUT -d 81.177.135.190 -j ACCEPT # разрешаем sdo.1580.ru
iptables -A OUTPUT -d 81.177.135.185 -j ACCEPT # разрешаем sdo24.1580.ru
iptables -A OUTPUT -d 81.177.136.113 -j ACCEPT # разрешаем bf726e13342a.hosting.myjino.ru 
iptables -A OUTPUT -d 88.212.202.50 -j ACCEPT # разрешаем liveinternet.ru 
iptables -A OUTPUT -d 88.212.201.204 -j ACCEPT # разрешаем counter.yadro.ru 

# разрешаем cloudflare
# for i in `curl https://www.cloudflare.com/ips-v4`
# do
#     iptables -A OUTPUT -d $i -j ACCEPT
# done

# for i in `curl https://www.cloudflare.com/ips-v6`
# do
#     iptables -A OUTPUT -d $i -j ACCEPT
# done

# for vsosh
# iptables -A OUTPUT -d 194.58.88.173 -j ACCEPT # olympiads.ru - для региона
# iptables -A OUTPUT -d 158.160.74.243 -j ACCEPT # ejudge.msk.ru - для региона

# block
# iptables -A OUTPUT -p tcp --dport 80 -j DROP # блокируем исходящий http
# iptables -A OUTPUT -p tcp --dport 443 -j DROP # блокируем исходящий https

iptables -P OUTPUT DROP # блокируем всё исходящее, кроме разрешенного
