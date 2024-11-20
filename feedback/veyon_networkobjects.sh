 #!/bin/sh

ssh j3948798@bf726e13342a.hosting.myjino.ru "cat /var/log/httpd/users/j3948798/bf726e13342a.hosting.myjino.ru/access.log" > /tmp/mos12_ansible_access.log

rm -rf files/veyon/networkobjects/
mkdir files/veyon/networkobjects/

for i in `cat feedback/hosts.lst`
do
    data=`cat /tmp/mos12_ansible_access.log | grep "$i/alive" | tail -n 1 | awk '{print $7}'`

    place=`echo $i | awk -F"-" '{print $2"-"$3}'`

    echo "$i;$i.local" >> files/veyon/networkobjects/$place.local

    [ "$data" = "" ] && continue

    host=`echo $data | awk -F"/" '{print $4}'`
    echo $host

    macs=`echo $data | awk -F"/" '{print $8}'`
    mac1=`echo $macs | awk -F"-" '{print $1}'`
    mac2=`echo $macs | awk -F"-" '{print $2}'`

    ips=`echo $data | awk -F"/" '{print $7}'`
    ip1=`echo $ips | awk -F"-" '{print $1}' | awk -F"=" '{print $1}'`
    ip2=`echo $ips | awk -F"-" '{print $2}' | awk -F"=" '{print $1}'`

    echo "$host;$host.local;$mac1" >> files/veyon/networkobjects/$place.mac1
    echo "$host;$host.local;$mac2" >> files/veyon/networkobjects/$place.mac2
    echo "$host;$ip1" >> files/veyon/networkobjects/$place.ip1
    [ "$ip2" = "" ] || echo "$host;$ip2" >> files/veyon/networkobjects/$place.ip2

done

rm -f /tmp/mos12_ansible_access.log

