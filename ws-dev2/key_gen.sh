#!/usr/bin/expect -f

#ce script attend en param le nom de la cle a generer
spawn /usr/bin/ssh-keygen

set timeout 3

expect "Enter file in which to save the key (/home/vagrant/.ssh/id_rsa): "

send -- "/home/vagrant/.ssh/devtoWSI\r"

expect "Enter passphrase (empty for no passphrase): "

send -- "La passphrasse pour se connecter en ssh au serveur WSI \r"

expect "Enter same passphrase again: "

send -- "La passphrasse pour se connecter en ssh au serveur WSI \r"

expect eof

spawn /usr/bin/ssh-copy-id -i /home/vagrant/.ssh/devtoWSI userjob@192.168.1.10

expect "userjob@192.168.1.10's password: "

send -- "aqwzsx123\r"

expect eof

#exec ssh-agent bash

spawn /usr/bin/ssh-add .ssh/devtoWSI

expect -- "Enter passphrase for /home/vagrant/.ssh/devtoWSI: "

send -- "La passphrasse pour se connecter en ssh au serveur WSI \r"

expect eof
