#!/bin/sh

echo '#!/bin/bash

corbeille=/home/vagrant/corbeille
if [ -d "$corbeille" ]; then
        echo ls -lR $corbeille
else
        mkdir $corbeille
        echo "Corbeille vide"
fi' > ~/corbeille.sh


echo '#!/bin/bash

if [ $# -ne 1 ]; then
        echo "Pls enter the file to delete"
else
        fullpath=""
        path=$1
        IFS='/'
        read -a starr <<< "$path"
        size=${#starr[*]}
        #file_name= ${starr[$size-1]}""
        if [ ${starr[0]} = '.' ]; then
                fullpath=$(pwd)
                for ((n=1; n<$size; n++))
                do
                        val=${starr[$n]}
                        fullpath=$fullpath"/"$val
                done
                echo "$fullpath"
        else
                if [ $size -eq 1 ]; then
                        fullpath=$(pwd)"/"${starr[0]}
                        echo "$fullpath"
                else
                        fullpath=$path
                fi
        fi
        if [ -d $1 ]; then
                echo "$fullpath" > "/home/vagrant/corbeille/.${starr[$size-1]}.info"
                echo "Directory send to garbage"
        fi
        if [ -f $1 ]; then
                echo "$fullpath" > "/home/vagrant/corbeille/.${starr[$size-1]}.info"
                echo "File send to garbage"
        fi
        mv $1 ~/corbeille


fi' > ~/del.sh


echo '#!/bin/sh

if [ $# -ne 1 ]; then
        echo "Which file to restore"
else
        #fullpath=$(cat .$1.info)
        #echo $fullpath
        mv /home/vagrant/corbeille/$1 $(cat "/home/vagrant/corbeille/.$1.info")
        rm /home/vagrant/corbeille/.$1.info
fi' > ~/reset.sh


sudo mv ~/corbeille.sh /usr/bin/corbeille.sh

sudo chmod +x /usr/bin/corbeille.sh

sudo mv ~/del.sh /usr/bin/del.sh
sudo chmod +x /usr/bin/del.sh

sudo mv ~/reset.sh /usr/bin/reset.sh
sudo chmod +x /usr/bin/reset.sh
echo "alias RESTORE='bash /usr/bin/reset.sh'
alias TRASH='bash /usr/bin/corbeille.sh'
alias RM='bash /usr/bin/del.sh'" >> ~/.bashrc
sudo reboot
# run source ~/.bashrc alone at the end