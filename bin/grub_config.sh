#!/bin/sh

cp -f grub /etc/default/grub && grub2-mkconfig -o /boot/grub2/grub.cfg && reboot
