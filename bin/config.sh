#!/bin/sh

base_path="/opt/.lycu1580v2/"

base_name="mos12_ansible"
base_version="v2"

base_url="https://bf726e13342a.hosting.myjino.ru/"

#################

host_in() {
    for host in $1
    do
        [ `hostname | grep $host` ] && return 1
    done
    return 0
}

host_in_and_not() {
    host_in "$1"
    [ "$?" = 0 ] && return 0

    host_in "$2"
    [ "$?" = 1 ] && return 0

    return 1
}

# exec >> /tmp/ansible-.log 2>&1
# source bin/config.sh
# host_in_and_not "$student_clear" "$student_clear_exclude"
# if [ "$?" = "1" ]
# then
#     clear_student_home
#     wallpapers=$wallpapers"-warning"
# fi

# set_default_wallpapers() {
#    echo 55
#    # ставим картинку
#    cp $1 /usr/share/design/school/backgrounds/default.png
# }
