#!/usr/bin/env sh
delete_if_nonsys_conn () {
    if [ ! -e "$1" ]; then
        return
    fi
    conn="$1"
    if [ ! -d "$conn" ]; then
        perms=$(cat "$conn" | grep "permissions=")
        if [ "$perms" != "permissions=" ]; then
            uuid_raw=$(cat "$conn" | grep "uuid=")
            uuid=${uuid_raw:5}
            #echo $uuid
            nmcli connection delete uuid "$uuid"
        fi
    fi

}

for connection in /etc/NetworkManager/system-connections/*
do
    delete_if_nonsys_conn "$connection"
done

for connection in /var/run/NetworkManager/system-connections/*
do
    delete_if_nonsys_conn "$connection"
done
