#!/bin/sh

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
sudo apt update
# Installation de la jdk
sudo apt -y install openjdk-11-jdk

#Installation de gnup
sudo apt -y install gnupg

#Enregistrement des paquets jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt-get update
sudo apt-get install jenkins

# Démarrage de Jenkins
sudo service jenkins start

# Vérifier l'état du service Jenkins
sudo systemctl status jenkins

# Verification du démarrage en local
wget localhost

# Création d'un utilisateur user job
sudo adduser userjob


# Donner les permissions apt via le fichier sudoers  à l'utilisateur userjob
# Sauvegarde du fichier sudoers
sudo cp /etc/sudoers /etc/sudoers.old
sudo su -c "echo 'userjob  ALL=/usr/bin/apt' >> /etc/sudoers"

# Afficher /var/jenkins_home/secrets/initialAdminPassword pour récuperer le mot de passe
sudo cat cat /var/lib/jenkins/secrets/initialAdminPassword

# Install iptables
sudo apt install -y iptables

# Ouvertures des ports 80 pour jenkins et 22 pour le connexion
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Mise en place une protection contre les intrusions en filtrant les adresses IP
# Installation de fail2ban 
#sudo apt install -y fail2ban 
# Démarrage du service fail2ban
#service fail2ban start


# Déployer sur ce serveur pour l’utilisateur userjob les clés publiques ssh de chacun des postes de développement


