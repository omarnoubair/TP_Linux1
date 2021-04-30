#!/bin/bash

# Michael & Omar

# Serveur d’intégration continue avec Jenkins
# Version : v0.1 

# Création d'une partition de type ext4 sur le disque sdb1
(echo n
echo p
echo
echo
echo
echo t
echo
echo 83
echo w ) | sudo fdisk /dev/sdb
sudo mkfs.ext4 /dev/sdb1

# Installation de Jenkins
sudo apt -y update

# Installation de la jdk
sudo apt -y install openjdk-11-jdk

#Installation de gnup
sudo apt -y install gnupg

#Enregistrement des paquets jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt-get -y update
sudo apt-get -y install jenkins

# Démarrage de Jenkins
sudo systemctl start jenkins

# Démarrage de Jenkins au démarrage de la machine
sudo systemctl enable jenkins

# Vérifier l'état du service Jenkins
sudo systemctl status jenkins

# Verification du démarrage en local
curl http://127.0.0.1:8080

sudo apt-get install -y expect

# Création d'un utilisateur user job
# sudo useradd userjob
bash  user_create.sh

# Donner les permissions apt via le fichier sudoers  à l'utilisateur userjob
sudo su -c "echo 'userjob  ALL=/usr/bin/apt' >> /etc/sudoers"

# Afficher /var/jenkins_home/secrets/initialAdminPassword pour récuperer le mot de passe
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Installer un pare feu et ouvrir le port qu’utilise Jenkins ainsi 
# que le port utilisé pour la connexion ssh
function configurationUFW {

	sudo apt -y install ufw

	#Activer ufw
	echo y | sudo ufw enable
	if [ $? -gt 0 ]; then
		echo "Erreur lors de l'activation de UFW"
		exit 1;
	fi 

    #Ouverture du port 8080
    sudo ufw allow 8080

    # Ouverture OpenSSH
    sudo ufw allow OpenSSH
	
    # Ouverture de la connexion ssh
	sudo ufw allow ssh 

	# Ouverture de la connexion 22
	sudo ufw allow 22 

	# Vérification de l'ouverture des ports
	sudo ufw status numbered
}
# Appel de la fonction
configurationUFW

# Afficher /var/jenkins_home/secrets/initialAdminPassword pour récuperer le mot de passe
echo " Le mot de passe Jenkins est : " && sudo cat /var/lib/jenkins/secrets/initialAdminPassword 

# Déployer sur ce serveur pour l’utilisateur userjob les clés 
# publiques ssh de chacun des postes de développement
