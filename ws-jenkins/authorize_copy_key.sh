#!/bin/sh

# prendre en compte le fichier avec param yes
REAL_ID="$(id -u)"
if [ "$REAL_ID" -ne 0 ]; then 
	1>&2 echo "ERROR: This script must be run as root" 
	exit 1
fi
sed -re 's/^(PasswordAuthentication)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config
# restart service
service ssh restart
#wait for the copy
sleep 60
# remet config en no
sed -re 's/^(PasswordAuthentication)([[:space:]]+)yes/\1\2no/' -i.`date -I` /etc/ssh/sshd_config

#reboot service
service ssh restart