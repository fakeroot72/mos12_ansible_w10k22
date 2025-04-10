#!/bin/sh

source /opt/.lycu1580v2/bin/config.sh

cp -f $base_url/files/grub /etc/default/grub && grub2-mkconfig -o /boot/grub2/grub.cfg && reboot
