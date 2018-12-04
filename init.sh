#!/bin/sh

wget -c -q https://storage.googleapis.com/harbor-releases/harbor-offline-installer-v1.6.2.tgz -O HAharbor-playbook/files/harbor-offline-installer-v1.6.2.tgz

curl -L "https://github.com/docker/compose/releases/download/1.15.0/docker-compose-$(uname -s)-$(uname -m)" -o HAharbor-playbook/files/docker-compose
