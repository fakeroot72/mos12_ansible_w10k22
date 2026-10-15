#!/usr/bin/env bash

function check_device() {
    MOUNT_POINT="/tmp/usb_check"
    KEY_FILE="key_admin.bin"
    KEY1="f7ed8363362de013c440473c18829ea5f41345a1f1abc28c548250908e91c1af"
    KEY2="1a0a6bfb3cb9bb6301bcf6e5123886c1e150291939fb5a495284ce80ae5a7f59"
    KEY3="45e135d53ce907d3eea90007b4dae8d30cfc9c32f5dec4a7c56d2376c9559674"
    KEY4="cc7a1458abb8ee1ab3032de6df357e62950095e168927ddf7ede4dae0c837bd5"
    KEY5="17e7b2c2b1bea174e96e396198c0cba0e47b54dd847345f5a6f329a47c797147"

    device="$1"

    mkdir -p "$MOUNT_POINT" && chmod 0700 "$MOUNT_POINT"

    if mount -o ro,nosuid,nodev,noexec "$device" "$MOUNT_POINT" 2>/dev/null; then
        if [ -f "$MOUNT_POINT/$KEY_FILE" ] && ;sha256sum $MOUNT_POINT/$KEY_FILE | grep -P "$KEY1|$KEY2|$KEY3|$KEY4|$KEY5" then
            umount "$MOUNT_POINT"
            return 0
        fi
        umount "$MOUNT_POINT"
    fi

    return 1
}

function check_script() {
    MOUNT_POINT="/tmp/usb_script"
    SCRIPT_FILE="autorun.sh"

    device ="$1"

    mkdir -p "$MOUNT_POINT" && chmod 0700 "$MOUNT_POINT"

    if mount -o ro,nosuid,nodev "$device" "$MOUNT_POINT" 2>/dev/null; then
        if [ -f "$MOUNT_POINT/$SCRIPT_FILE" ]; then
            return 0
        fi
        umount "$MOUNT_POINT"
    fi

    return 1
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
    if check_script $1; then
        export SCRIPT_FILE="/tmp/usb_script/autorun.sh"
        export SCRIPT="-e $SCRIPT_FILE; umount /tmp/usb_script/'"
    fi
    export DISPLAY=$(find_display);
    export XAUTHORITY=$(find_xauthority);
    echo "bash -c 'export DISPLAY=$DISPLAY; export XAUTHORITY=$XAUTHORITY; /usr/bin/konsole $SCRIPT & echo \$! > /tmp/admin_terminal.pid; chmod 600 /tmp/admin_terminal.pid'" | at now &
    echo "$1" > /tmp/admin_terminal.dev
    chmod 600 /tmp/admin_terminal.dev
    exit 0
fi
exit 1
