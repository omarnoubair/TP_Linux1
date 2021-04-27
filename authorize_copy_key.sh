#!/bin/sh

# prendre en compte le fichier avec param yes
sudo su
sed -re 's/^(PasswordAuthentication)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config
# restart service
service ssh restart
#wait for the copy
wait 600
# remet config en no
sed -re 's/^(PasswordAuthentication)([[:space:]]+)yes/\1\2no/' -i.`date -I` /etc/ssh/sshd_config

#reboot service
service ssh restart