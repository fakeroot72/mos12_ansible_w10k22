#!/bin/sh

#exec >> /dev/null 2>&1

exec >> /tmp/ansible-web.log 2>&1
source /opt/.lycu1580v2/bin/config.sh

read line

hn=`hostname`

url=`echo $line | awk '{print $1}'`

curl -I $base_url/$base_name/touch/$hn/web/$url/$base_version/
