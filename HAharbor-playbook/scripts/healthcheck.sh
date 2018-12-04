#!/bin/sh
curl --fail -s 'http://ui:8080/api/ping' > /dev/null || exit 1
curl --fail -s 'http://registry:5000/' > /dev/null || exit 1
curl --fail -s 'http://adminserver:8080/api/ping' > /dev/null || exit 1

nginx 

while true;do
curl --fail -s 'http://ui:8080/api/ping' > /dev/null || exit 1
curl --fail -s 'http://registry:5000/' > /dev/null || exit 1
curl --fail -s 'http://adminserver:8080/api/ping' > /dev/null || exit 1
echo ok
sleep 3
done

