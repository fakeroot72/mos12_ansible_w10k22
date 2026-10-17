#!/bin/bash

MOUNT_POINT="/tmp/usb_check"
KEY_FILE="key_admin.bin"
KEYS=(
"f7ed8363362de013c440473c18829ea5f41345a1f1abc28c548250908e91c1af"
"1a0a6bfb3cb9bb6301bcf6e5123886c1e150291939fb5a495284ce80ae5a7f59"
"45e135d53ce907d3eea90007b4dae8d30cfc9c32f5dec4a7c56d2376c9559674"
"cc7a1458abb8ee1ab3032de6df357e62950095e168927ddf7ede4dae0c837bd5"
"17e7b2c2b1bea174e96e396198c0cba0e47b54dd847345f5a6f329a47c797147"
"a034fbd79fc74cb0baba8a642ba0206d59937e2b2ea30727fa589edd35cc2273"
"3bc281ba6b5b0b36908ca202a168d4736a44d87568dd028e5c421bf00b8da59a"
"26cb73503b5961f4c3afbe3d2e06a470ce8459a8e2b01b562ef86b3e1303f8a5"

"4355a46b19d348dc2f57c046f8ef63d4538ebb936000f3c9ee954a27460dd865" ####### sha256sum of 1\n VERY DANGEROUS REMOVE IN PROD #######
)

mkdir -p "$MOUNT_POINT" && chmod 0700 "$MOUNT_POINT"

[[ -n "$1" ]] && DEVICES=$1 || DEVICES=$(lsblk -lnpo NAME,RM | awk '$2==1 {print $1}')

for device in $DEVICES; do
    if mount -o ro,nosuid,nodev,noexec "$device" "$MOUNT_POINT"; then
        if [ -f "$MOUNT_POINT/$KEY_FILE" ] && sha256sum $MOUNT_POINT/$KEY_FILE | grep -P "$(echo ${KEYS[@]} | tr ' ' '|')"; then
            umount "$MOUNT_POINT"
            exit 0
        fi
        umount "$MOUNT_POINT"
    fi
done

exit 1

