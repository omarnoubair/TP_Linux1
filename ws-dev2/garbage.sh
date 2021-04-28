#Script Gestion Corbeille

#Omar & Michael
#!/bin/bash


# Créer rep Corbeille
mkdir ~/corbeille

#Cree le Script affichage du contenu
echo '#!/bin/bash
ls -lR ~/corbeille' > ~/corbeille.sh

#Cree le Script envoyé a la Corbeille
echo '#!/bin/bash
if [ $# -ne 1 ]; then
        echo "Pls enter the file to delete"
else
        fullpath=""
        path=$1
        IFS="/"
        read -a starr <<< "$path"
        size=${#starr[*]}
        #file_name= ${starr[$size-1]}""
        if [ ${starr[0]} = "." ]; then
                fullpath=$(pwd)
                for ((n=1; n<$size; n++))
                do
                        val=${starr[$n]}
                        fullpath=$fullpath"/"$val
                done
        else
                if [ $size -eq 1 ]; then
                        fullpath=$(pwd)"/"${starr[0]}
                else
                        fullpath=$path
                fi
        fi
        if [ -d $1 ]; then
                echo "$fullpath" > ~/corbeille/.${starr[$size-1]}.info
                echo "Directory send to garbage"
        fi
        if [ -f $1 ]; then
                echo "$fullpath" > ~/corbeille/.${starr[$size-1]}.info
                echo "File send to garbage"
        fi
        mv $1 ~/corbeille
fi' > ~/del.sh


#Cree le Script Restauration
echo '#!/bin/bash
if [ $# -ne 1 ]; then
        echo "Which file to restore"
else
        info=$(cat ~/corbeille/.$1.info)
        mv ~/corbeille/$1 $info
        rm ~/corbeille/.$1.info
fi' > ~/reset.sh

# Deplace les Scripts a /usr/bin
sudo mv ~/corbeille.sh /usr/bin/corbeille
sudo mv ~/del.sh /usr/bin/del
sudo mv ~/reset.sh /usr/bin/reset

#ajoute dans le fichier .bashrc les alias
echo "alias RESTORE='bash /usr/bin/reset'
alias TRASH='bash /usr/bin/corbeille'
alias RM='bash /usr/bin/del'" >> ~/.bashrc

#reboot pour prendre en compte les alias
sudo reboot