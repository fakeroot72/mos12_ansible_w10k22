#!/bin/sh

case $1 in
    pli)
        echo Cloning repository && \
        git clone https://hub.mos.ru/1580/mos12_ansible.git && \
        echo -n Renaming to .lycu1580...&& \
        mv mos12_ansible/ .lycu1580/ && \
        echo Ok && \
        echo -n Crearing archive... &&
        tar cjpf lycu1580.tbz .lycu1580/ && \
        echo Ok && \
        echo -n Copying install.sh... && \
        cp .lycu1580/install.sh ./ && \
        echo Ok && \
        echo -n Removing repositoty... && \
        rm -rf .lycu1580/ && \
        echo Ok && \
        echo Done
        ;;

    li)
        echo Updating packages && \
        dnf -y update && \
        echo Installing ansible and git && \
        dnf -y install ansible git && \
        echo -n Unpacking repository from archive... && \
        tar xjpf lycu1580.tbz -C /opt/ && \
        echo Ok && \
        echo -n Changing repository owner to root... && \
        chown -R root:root /opt/.lycu1580/ && \
        echo Ok && \
        echo Running ansible playbook && \
        ansible-pull -d /opt/.lycu1580/ -U https://hub.mos.ru/1580/mos12_ansible.git && \
        echo Rebooting && \
        reboot
        ;;

    lid)
        echo Updating packages && \
        dnf -y update && \
        echo Installing ansible and git && \
        dnf -y install ansible git && \
        echo -n Unpacking repository from archive... && \
        tar xjpf lycu1580.tbz -C /opt/ && \
        echo Ok && \
        echo -n Changing repository owner to root... && \
        chown -R root:root /opt/.lycu1580/ && \
        echo Ok && \
        echo Running ansible playbook && \
        ansible-pull -d /opt/.lycu1580/ -U https://hub.mos.ru/1580/mos12_ansible.git && \
        echo -n Deleting archive... && \
        rm -f lycu1580.tbz && \
        echo Ok && \
        echo -n Deleting install.sh... && \
        rm -f install.sh && \
        echo Ok && \
        echo Rebooting && \
        reboot
        ;;


    gi)
        echo Updating packages && \
        dnf -y update && \
        echo Installing ansible and git && \
        dnf -y install ansible git && \
        echo -n Changing current directory to /opt/... && \
        cd /opt/ && \
        echo Ok && \
        echo Cloning repository && \
        git clone https://hub.mos.ru/1580/mos12_ansible.git && \
        echo -n Renaming to .lycu1580...&& \
        mv mos12_ansible/ .lycu1580/ && \
        echo Ok && \
        echo Running ansible playbook && \
        ansible-pull -d /opt/.lycu1580/ -U https://hub.mos.ru/1580/mos12_ansible.git && \
        echo Rebooting && \
        reboot
        ;;

    *)
        echo Updating packages && \
        dnf -y update && \
        echo Installing ansible and git && \
        dnf -y install ansible git && \
        echo Downloading repository and running ansible playbook && \
        ansible-pull -d /opt/.lycu1580v2/ -U https://hub.mos.ru/1580/mos12_ansible_w10k22.git && \
        echo Rebooting && \
        reboot
        ;;

esac

