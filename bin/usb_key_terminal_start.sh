#!/usr/bin/env bash

function check_device() {
    MOUNT_POINT="/tmp/usb_check"
    KEY_FILE="key_admin.bin"
    KEY1="feb438dae3009275b5ef44622a58fe7f"
    KEY2="71443f74a6fe26dfc75f412d56d4679d"

    device="$1"

    mkdir -p "$MOUNT_POINT" && chmod 0700 "$MOUNT_POINT"

    if mount -o ro,nosuid,nodev,noexec "$device" "$MOUNT_POINT" 2>/dev/null; then
        if [ -f "$MOUNT_POINT/$KEY_FILE" ] && md5sum $MOUNT_POINT/$KEY_FILE | grep -P "$KEY1|$KEY2"; then
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
        export SCRIPT="-e /bin/sh -c \\'$SCRIPT_FILE; umount /tmp/usb_script/\\'"
    fi
    export DISPLAY=$(find_display);
    export XAUTHORITY=$(find_xauthority);
    echo "bash -c 'export DISPLAY=$DISPLAY; export XAUTHORITY=$XAUTHORITY; /usr/bin/konsole $SCRIPT & echo \$! > /tmp/admin_terminal.pid; chmod 600 /tmp/admin_terminal.pid'" | at now &
    echo "$1" > /tmp/admin_terminal.dev
    chmod 600 /tmp/admin_terminal.dev
    exit 0
fi
exit 1
