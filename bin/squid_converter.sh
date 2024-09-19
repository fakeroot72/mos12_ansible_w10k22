 #!/bin/sh

exec >> /tmp/ansible-squid_converter.log 2>&1

source bin/config.sh

for d in `ls /usr/share/squidGuard-1.5/db/`
do
    [ -f /usr/share/squidGuard-1.5/db/$d/domains ] && sed '/^[^#].*[a-z]/s/^/./' /usr/share/squidGuard-1.5/db/$d/domains > /usr/share/squidGuard-1.5/db/$d/squid_domains

    [ -f /usr/share/squidGuard-1.5/db/$d/urls ] && sed 's/\./\\./g' /usr/share/squidGuard-1.5/db/$d/urls | sed 's/\//\\\//g' > /usr/share/squidGuard-1.5/db/$d/squid_urls

done
