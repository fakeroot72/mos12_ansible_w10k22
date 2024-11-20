 #!/bin/sh

ssh j3948798@bf726e13342a.hosting.myjino.ru "cat /var/log/httpd/users/j3948798/bf726e13342a.hosting.myjino.ru/access.log" > /tmp/mos12_ansible_access.log
 
for i in `cat feedback/hosts.lst`
do
    echo "*** $i ***" 
    cat /tmp/mos12_ansible_access.log | grep "$i/alive" | tail -n 1;
    cat /tmp/mos12_ansible_access.log | grep "$i/start" | tail -n 1;
    cat /tmp/mos12_ansible_access.log | grep "$i/end" | tail -n 1;
done

rm -f /tmp/mos12_ansible_access.log

