#!/usr/bin/env bash
if [[ "$(cat /tmp/admin_terminal.dev)" == "$1"* ]]; then
    kill -9 "$(cat /tmp/admin_terminal.pid)"
    rm -f /tmp/admin_terminal.pid
    rm -f /tmp/admin_terminal.dev
fi
