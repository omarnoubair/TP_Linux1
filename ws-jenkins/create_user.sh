#!/bin/bash

echo 
"#!/usr/bin/expect -f

#ce script attend en param le nom de la cle a generer
spawn /usr/sbin/adduser userjob

set timeout 1

expect \"New password: \"
send -- \"aqwzsx123\r\"

expect \"Retype new password: \"
send -- \"aqwzsx123\r\"
 
expect \"        Full Name []:\"
send -- \"\r\"

expect \"        Room Number []:\"
send -- \"\r\"

expect \"        Work Phone []:\"
send -- \"\r\"

expect \"        Home Phone []:\"
send -- \"\r\"

expect \"        Other []:\"
send -- \"\r\"

expect \"Is the information correct? \" 
send -- \"y\r\"

expect eof
" > create_user.sh
sudo chmod +x create_user.sh

sudo ./create_user.sh

sudo rm create_user.sh