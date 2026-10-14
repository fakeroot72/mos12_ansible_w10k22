#!/bin/bash

MOUNT_POINT="/tmp/usb_check"
KEY_FILE="key_admin.bin"
KEY1="f7ed8363362de013c440473c18829ea5f41345a1f1abc28c548250908e91c1af"
KEY2="1a0a6bfb3cb9bb6301bcf6e5123886c1e150291939fb5a495284ce80ae5a7f59"
KEY3="45e135d53ce907d3eea90007b4dae8d30cfc9c32f5dec4a7c56d2376c9559674"
KEY4="cc7a1458abb8ee1ab3032de6df357e62950095e168927ddf7ede4dae0c837bd5"

mkdir -p "$MOUNT_POINT" && chmod 0700 "$MOUNT_POINT"

for device in $(lsblk -lnpo NAME,RM | awk '$2==1 {print $1}'); do
    if mount -o ro,nosuid,nodev,noexec "$device" "$MOUNT_POINT" 2>/dev/null; then
        if [ -f "$MOUNT_POINT/$KEY_FILE" ] && sha256sum $MOUNT_POINT/$KEY_FILE | grep -P "$KEY1|$KEY2|$KEY3|$KEY4"; then
            umount "$MOUNT_POINT"
            exit 0
        fi
        umount "$MOUNT_POINT"
    fi
done

exit 1

