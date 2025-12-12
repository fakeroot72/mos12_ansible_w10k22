#!/bin/sh

systemctl stop transmission-daemon
cp olymp-linux-2025-11-11.vdi /opt/.lycu1580v2/local/tdd/olymp-linux-2025-11-11.vdi
chmod 0644 /opt/.lycu1580v2/local/tdd/olymp-linux-2025-11-11.vdi
chown transmission:transmission /opt/.lycu1580v2/local/tdd/olymp-linux-2025-11-11.vdi
systemctl start transmission-daemon
