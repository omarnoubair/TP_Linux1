#!/bin/bash

REAL_ID="$(id -u)"
if [ "$REAL_ID" -ne 0 ]; then
1>&2 echo "ERROR: This script must be run as root"
exit 1
fi

apt install nfs-common -y

echo "
192.168.1.11:/var/web /var/www/html nfs rw,async,hard,intr,noexec 0 0
" >> /etc/fstab
mount /var/www/html