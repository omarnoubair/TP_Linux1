#!bin/bash

echo "#!/usr/bin/expect -f
spawn /usr/bin/ssh-keygen
set timeout 3
expect \"Enter file in which to save the key (/home/vagrant/.ssh/id_rsa): \"
send -- \"/home/vagrant/.ssh/devtoWSI\r\"
expect \"Enter passphrase (empty for no passphrase): \"
send -- \"La passphrasse pour se connecter en ssh au serveur WSI \r\"
expect \"Enter same passphrase again: \"
send -- \"La passphrasse pour se connecter en ssh au serveur WSI \r\"
expect eof" > create_key.sh

sudo chmod +x create_key.sh
./create_key.sh 

echo "#!/usr/bin/expect -f
spawn /usr/bin/ssh-copy-id -i /home/vagrant/.ssh/devtoWSI userjob@192.168.1.10
set timeout 3
#expect \"Are you sure you want to continue connecting (yes/no)? \"
#send -- \"yes\r\"
expect \"userjob@192.168.1.10's password: \"
send -- \"aqwzsx123\r\"
expect eof
" > copy_key.sh

sudo chmod +x copy_key.sh
./copy_key.sh 

#exec ssh-agent bash

echo "#!/usr/bin/expect -f
spawn /usr/bin/ssh-add /home/vagrant/.ssh/devtoWSI
set timeout 3
expect \"Enter passphrase for /home/vagrant/.ssh/devtoWSI: \"
send -- \"La passphrasse pour se connecter en ssh au serveur WSI \\r\"
expect eof
" > add_key.sh

sudo chmod +x add_key.sh
rm copy_key.sh
rm create_key.sh