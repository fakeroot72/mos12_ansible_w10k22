#!/bin/sh

systemctl stop transmission-daemon
cp ege-windows-02-proxy.vdi /opt/.lycu1580v2/local/tdd/ege-windows-02-proxy.vdi
chmod 0644 /opt/.lycu1580v2/local/tdd/ege-windows-02-proxy.vdi
chown transmission:transmission /opt/.lycu1580v2/local/tdd/ege-windows-02-proxy.vdi
systemctl start transmission-daemon
