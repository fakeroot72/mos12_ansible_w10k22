#!/bin/sh

exec >> /tmp/ansible-iptables.log 2>&1

source /opt/.lycu1580v2/bin/config.sh

# rm -rf /home/backup*

iptables -F

#iptables -P INPUT ACCEPT
#iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# Разрешаем соединения на этот же компьютер (lo-интерфейс)
iptables -A OUTPUT -o lo -j ACCEPT

# Разрешаем соединения на порт 53 UDP для работы DNS
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
 
# Разрешаем соединения на порт 5353 UDP для работы mDNS
iptables -A OUTPUT -p udp --dport 5353 -j ACCEPT

# Разрешаем соединения на UDP порт 123 для работы NTP
iptables -A OUTPUT -p udp --dport 123 -j ACCEPT

# Разрешаем ping
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT

# Разрешаем соединения на порт 51413 для работы transmission
#iptables -A OUTPUT -p tcp --dport 51413 -j ACCEPT
#iptables -A OUTPUT -p udp --dport 51413 -j ACCEPT
iptables -A OUTPUT -p tcp --match multiport --dports 49152:65535 -j ACCEPT
iptables -A OUTPUT -p udp --match multiport --dports 49152:65535 -j ACCEPT

# Разрешаем sdo.1580.ru
iptables -A OUTPUT -d 217.107.34.59 -j ACCEPT
iptables -A OUTPUT -d 172.18.164.66 -j ACCEPT
iptables -A OUTPUT -d 172.23.105.77 -j ACCEPT
iptables -A OUTPUT -d 172.20.20.101 -j ACCEPT

#hostname | grep -v 1580-1 && hostname | grep -v 1580-2 && iptables -A OUTPUT -d 217.107.34.59 -j ACCEPT
#date +"%F%R" | grep -v 2026-01-17 && date +"%F%R" | grep -v 2026-01-19 && iptables -A OUTPUT -d 217.107.34.59 -j ACCEPT
#hostname | grep 1580-1-215 && iptables -A OUTPUT -d 217.107.34.59 -j ACCEPT

#date +"%F%R" | grep -v 2026-01-17 && date +"%F%R" | grep -v 2026-01-19 && iptables -A OUTPUT -d 172.18.164.66 -j ACCEPT
#hostname | grep 1580-2-427 && iptables -A OUTPUT -d 172.18.164.66 -j ACCEPT

# Разрешаем squid.1580.ru
iptables -A OUTPUT -d 195.161.114.165 -j ACCEPT

#hostname | grep -v 1580-1 && hostname | grep -v 1580-2 && iptables -A OUTPUT -d 195.161.114.165 -j ACCEPT
#date +"%F%R" | grep -v 2026-01-17 && date +"%F%R" | grep -v 2026-01-19 && iptables -A OUTPUT -d 195.161.114.165 -j ACCEPT

#hostname | grep 1580-1-215 && iptables -A OUTPUT -d 195.161.114.165 -j ACCEPT
#hostname | grep 1580-2-427 && iptables -A OUTPUT -d 195.161.114.165 -j ACCEPT
#hostname | grep 1580-2-it && iptables -A OUTPUT -d 195.161.114.165 -j ACCEPT

# Разрешаем zabbix.1580.ru
iptables -A OUTPUT -d 81.177.135.203 -j ACCEPT

# Разрешаем tp.1580.ru
iptables -A OUTPUT -d 81.177.140.242 -j ACCEPT

# Разрешаем hub.mos.ru
iptables -A OUTPUT -d 94.79.51.149 -j ACCEPT

# Разрешаем silvertests.ru
date +"%F%R" | grep -v 2026-04-05 && iptables -A OUTPUT -d 37.79.254.196 -j ACCEPT

#hostname | grep -v 1580-1 && hostname | grep -v 1580-2 && iptables -A OUTPUT -d 37.79.254.196 -j ACCEPT
#date +"%F%R" | grep -v 2026-01-17 && date +"%F%R" | grep -v 2026-01-19 && iptables -A OUTPUT -d 37.79.254.196 -j ACCEPT

#hostname | grep 1580-1-215 && iptables -A OUTPUT -d 37.79.254.196 -j ACCEPT
#hostname | grep 1580-2-427 && iptables -A OUTPUT -d 37.79.254.196 -j ACCEPT
#hostname | grep 1580-2-it && iptables -A OUTPUT -d 37.79.254.196 -j ACCEPT

# Разрешаем bf726e13342a.hosting.myjino.ru
iptables -A OUTPUT -d 81.177.136.113 -j ACCEPT

# Разрешаем arduino ide
iptables -A OUTPUT -d 104.18.10.21 -j ACCEPT
iptables -A OUTPUT -d 104.18.11.21 -j ACCEPT

# Разрешаем vkcalls
iptables -A OUTPUT -d 155.212.200.14 -j ACCEPT

# Разрешаем repo.ascon.ru
iptables -A OUTPUT -d 46.235.186.152 -j ACCEPT
iptables -A OUTPUT -d 46.235.186.158 -j ACCEPT
iptables -A OUTPUT -d 195.209.67.234 -j ACCEPT
iptables -A OUTPUT -d 195.209.67.210 -j ACCEPT
iptables -A OUTPUT -d 46.235.186.159 -j ACCEPT
iptables -A OUTPUT -d 46.235.186.160 -j ACCEPT
iptables -A OUTPUT -d 195.209.66.220 -j ACCEPT
iptables -A OUTPUT -d 212.193.153.73 -j ACCEPT

# Разрешаем wokwi.com
#iptables -A OUTPUT -d 188.114.99.224 -j ACCEPT
#iptables -A OUTPUT -d 188.114.98.224 -j ACCEPT

# Разрешаем codeforces.com - требует проверки
# iptables -A OUTPUT -d 95.163.252.67 -j ACCEPT
# iptables -A OUTPUT -d 172.67.68.254 -j ACCEPT
# iptables -A OUTPUT -d 104.26.6.164 -j ACCEPT
# iptables -A OUTPUT -d 104.26.7.164 -j ACCEPT

# Разрешаем cloudflare
# for i in `curl https://www.cloudflare.com/ips-v4`
# do
#     iptables -A OUTPUT -d $i -j ACCEPT
# done

# ip v6 не срабатывает
# for i in `curl https://www.cloudflare.com/ips-v6`
# do
#     iptables -A OUTPUT -d $i -j ACCEPT
# done

# Локальная сеть ДОНМ для доступа ко всем ресурсам, для простоты конфигурирования
iptables -A OUTPUT -d 10.0.0.0/8 -j ACCEPT

# Разрешаем мэш.mos.ru
iptables -A OUTPUT -d 94.79.51.0/24 -j ACCEPT

# school.mos.ru Необходим для работы тестирующей системы МЭШ и "Магазина приложений" МОС
# uchebnik.mos.ru Необходим для работы тестирующей системы МЭШ
iptables -A OUTPUT -d 94.79.51.184 -j ACCEPT
iptables -A OUTPUT -d 94.79.51.185 -j ACCEPT
iptables -A OUTPUT -d 94.79.51.186 -j ACCEPT

# login.mos.ru Необходим для авторизации в МЭШ. Сам сайт login.mos.ru открывать не нужно, он делает редирект на mos.ru
iptables -A OUTPUT -d 94.79.51.0/24 -j ACCEPT

# online.olimpiada.ru Резервная тестирующая система
iptables -A OUTPUT -d 212.193.155.35 -j ACCEPT
iptables -A OUTPUT -d 46.235.186.69 -j ACCEPT
iptables -A OUTPUT -d 46.235.188.68 -j ACCEPT

#iptables -A OUTPUT -d 78.41.110.69 -j ACCEPT
#iptables -A OUTPUT -d 93.93.88.23 -j ACCEPT
#iptables -A OUTPUT -d 212.193.144.0/20 -j ACCEPT

# fonts.googleapis.com Шрифты для online.olimpiada.ru
iptables -A OUTPUT -d 142.250.184.234 -j ACCEPT

# vos.olimpiada.ru Сайт ВсОШ в Москве
iptables -A OUTPUT -d 185.178.208.183 -j ACCEPT

# всош.цпм.рф Сайт ВсОШ в Москве (xn--b1ayi3a.xn--l1afu.xn--p1ai)
iptables -A OUTPUT -d 185.30.228.25 -j ACCEPT

# olympiads.ru Сайт городской предметно-методической комиссии ВсОШ по информатике
iptables -A OUTPUT -d 194.58.88.173 -j ACCEPT

# mc.yandex.ru Метрика яндекса, если заблокировать, то браузер будет долго загружать страницу os.mos.ru
iptables -A OUTPUT -d 87.250.250.119 -j ACCEPT
iptables -A OUTPUT -d 87.250.251.119 -j ACCEPT
iptables -A OUTPUT -d 93.158.134.119 -j ACCEPT
iptables -A OUTPUT -d 77.88.21.119 -j ACCEPT

# os.mos.ru repo.os.mos.ru Репозитории МОС, для установки пакетов, если возникнет необходимость доставить приложения.
iptables -A OUTPUT -d 37.230.149.17 -j ACCEPT

# marketplace.visualstudio.com Магазин расширений для VSCode
iptables -A OUTPUT -d  150.171.73.16 -j ACCEPT
iptables -A OUTPUT -d  150.171.74.16 -j ACCEPT

# main.vscode-cdn.net Необходим для скачивания расширений для VSCode
iptables -A OUTPUT -d 13.107.246.53 -j ACCEPT
iptables -A OUTPUT -d 13.107.213.53 -j ACCEPT

# ms-python.gallerycdn.vsassets.io Необходим для скачивания расширений для VSCode
iptables -A OUTPUT -d 2.23.167.106/24 -j ACCEPT
iptables -A OUTPUT -d 212.188.39.24/24 -j ACCEPT

# it-help-school.ru Этот сайт, для доступа к техническим инструкциям
iptables -A OUTPUT -d 91.221.70.4 -j ACCEPT

# ejudge-msk.ru
iptables -A OUTPUT -d 158.160.12.212 -j ACCEPT

# vsoch reg 2025
#iptables -A OUTPUT -d 194.58.88.173 -j ACCEPT # olympiads.ru
#iptables -A OUTPUT -d 89.169.165.116 -j ACCEPT # msk-ejudge.ru

# vos - ii
ext.contest.yandex.ru contest.yandex *
iptables -A OUTPUT -d 87.250.250.200 -j ACCEPT
iptables -A OUTPUT -d 2a02:6b8::360 -j ACCEPT

# clck.yandex.ru
iptables -A OUTPUT -d 77.88.21.14 -j ACCEPT
iptables -A OUTPUT -d 87.250.250.14 -j ACCEPT
iptables -A OUTPUT -d 87.250.251.14 -j ACCEPT
iptables -A OUTPUT -d 93.158.134.14 -j ACCEPT
iptables -A OUTPUT -d 213.180.193.14 -j ACCEPT
iptables -A OUTPUT -d 213.180.204.14 -j ACCEPT
iptables -A OUTPUT -d 2a02:6b8::14 -j ACCEPT

# yastatic.net yandex.st
iptables -A OUTPUT -d 37.9.64.225 -j ACCEPT
iptables -A OUTPUT -d 2a02:6b8:23::225 -j ACCEPT

# contest-problem-files.s3-private.mds.yandex.net contest-hidden.s3-private.mds.yandex.net contest-public.s3-private.mds.yandex.net
iptables -A OUTPUT -d 87.250.251.158 -j ACCEPT
iptables -A OUTPUT -d 2a02:6b8::3:158 -j ACCEPT

# vos - inf - ib
#test
#iptables -A OUTPUT -d 84.201.144.118 -j ACCEPT
#olymp
#iptables -A OUTPUT -d 58.160.212.177 -j ACCEPT
#iptables -A OUTPUT -d 158.160.193.221 -j ACCEPT
#iptables -A OUTPUT -d 158.160.195.100 -j ACCEPT
#iptables -A OUTPUT -d 130.193.57.26 -j ACCEPT

# Разрешаем test-soop.fioco.ru
iptables -A OUTPUT -d 80.250.167.50 -j ACCEPT

hostname | grep m1580-2-it3 && date +"%F%R" | grep 2026-03-21 && exit
hostname | grep m1580-2-it4 && date +"%F%R" | grep 2026-03-21 && exit

# block
iptables -A OUTPUT -p tcp --dport 80 -j REJECT # блокируем исходящий http
iptables -A OUTPUT -p tcp --dport 443 -j REJECT # блокируем исходящий https

iptables -P OUTPUT DROP # блокируем всё исходящее, кроме разрешенного

