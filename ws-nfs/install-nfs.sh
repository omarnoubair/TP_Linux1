#!/bin/bash

REAL_ID="$(id -u)"
if [ "$REAL_ID" -ne 0 ]; then
1>&2 echo "ERROR: This script must be run as root"
exit 1
fi

apt-get install nfs-kernel-server rpcbind portmap -y
echo "rpcbind mountd nfsd statd lockd rquotad : ALL" >> /etc/hosts.deny

echo "
rpcbind mountd nfsd statd lockd rquotad : 127.0.0.1 : allow
rpcbind mountd nfsd statd lockd rquotad : 192.168.1.10 : allow
rpcbind mountd nfsd statd lockd rquotad : 192.168.1.12 : allow
rpcbind mountd nfsd statd lockd rquotad : ALL : deny
">> /etc/hosts.allow

mkdir /var/web
chown nobody:nogroup /var/web/

mkdir /var/server_ic
chown nobody:nogroup /var/server_ic/

echo "
/var/server_ic 192.168.1.10/17(rw,root_squash,subtree_check)
/var/web 192.168.1.12/17(rw,root_squash,subtree_check)
">> /etc/exports

exportfs -ra

systemctl restart nfs-kernel-server

echo "#!/bin/sh
cd /var
date=\$(date +\"%m_%d_%y\")
rm /var/save/*.gz
sudo tar -czvf /var/save/serveur_web_\$date.tar.gz web/
sudo tar -czvf /var/save/serveur_ic_\$date.tar.gz server_ic/
cd -
">/var/save.sh

mkdir /var/save
chown nobody:nogroup /var/save/

chown nobody:nogroup /var/save.sh

echo "
0 0 * * 6 /var/save.sh" >> /var/spool/cron/crontabs/vagrant
sudo service cron reload