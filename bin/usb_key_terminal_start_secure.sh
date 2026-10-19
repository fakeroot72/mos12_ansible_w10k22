#!/usr/bin/env bash

function check_device() {
    "$(dirname -- "${BASH_SOURCE[0]}")/usb_key_check.sh" "$1"
    return $?
}

function find_xauthority() {
    for file in $(ls -a /tmp/xauth_*); do
        if [ -f "$file" ] && [ $(stat -c %U "$file") = "student" ]; then
            echo "$file"
        fi
    done;
}

function find_display() {
    for file in /tmp/.X11-unix/*; do
        echo ":${file/#"/tmp/.X11-unix/X"}"
        return 0
    done;
}

if check_device $1; then
    export DISPLAY=$(find_display);
    export XAUTHORITY=$(find_xauthority);
    echo "bash -c 'export DISPLAY=$DISPLAY; export XAUTHORITY=$XAUTHORITY; /usr/bin/konsole & echo \$! > /tmp/admin_terminal.pid; chmod 600 /tmp/admin_terminal.pid'" | at now &
    echo "$1" > /tmp/admin_terminal.dev
    chmod 600 /tmp/admin_terminal.dev
    exit 0
fi
exit 1
