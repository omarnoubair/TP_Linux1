#!/bin/bash

REAL_ID="$(id -u)"
if [ "$REAL_ID" -ne 0 ]; then 
    1>&2 echo "ERROR: This script must be run as root" 
    exit 1
fi

apt install nfs-common -y

mkdir /usr/local/jenkins

chown nobody:nogroup /usr/local/jenkins

echo "
192.168.1.11:/var/server_ic /usr/local/jenkins nfs rw,async,hard,intr,noexec 0 0
" >> /etc/fstab

mount /usr/local/jenkins