#!/bin/sh

ssh j3948798@bf726e13342a.hosting.myjino.ru "cat /var/log/httpd/users/j3948798/bf726e13342a.hosting.myjino.ru/access.log" | python3 http.py

