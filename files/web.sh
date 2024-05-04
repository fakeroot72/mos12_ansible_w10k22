#!/bin/sh

read line

hn=`hostname`

url=`echo $line | awk '{print $1}'`

curl -I https://bf726e13342a.hosting.myjino.ru/mos12_ansible/touch/$hn/web/$url/v2/ >> /dev/null 2>&1

