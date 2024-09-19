#!/bin/sh

exec >> /tmp/ansible-veyon.log 2>&1

veyon-cli config clear

veyon-cli networkobjects clear

veyon-cli config set "Authentication/Method" 1

veyon-cli authkeys delete teacher/public

veyon-cli authkeys import teacher/public files/veyon/teacher_public_key.pem

veyon-cli authkeys setaccessgroup teacher/public teacher

for f in `ls files/veyon/networkobjects/*.local`
do
    place=`echo $f | awk -F"/" '{print $4}'`
    veyon-cli networkobjects import $f location $place format "%name%;%host%"
done

for f in `ls files/veyon/networkobjects/*.mac?`
do
    place=`echo $f | awk -F"/" '{print $4}'`
    veyon-cli networkobjects import $f location $place format "%name%;%host%;%mac%"
done

for f in `ls files/veyon/networkobjects/*.ip?`
do
    place=`echo $f | awk -F"/" '{print $4}'`
    veyon-cli networkobjects import $f location $place format "%name%;%host%"
done

veyon-cli service restart

