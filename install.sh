#!/bin/sh


        echo Updating packages && \
        dnf -y update && \
        echo Installing ansible and git && \
        dnf -y install ansible git && \
        echo Downloading repository and running ansible playbook && \
        ansible-pull -d /opt/.lycu1580v2/ -U https://hub.mos.ru/1580/mos12_ansible_w10k22.git && \
        echo Rebooting && \
        reboot


