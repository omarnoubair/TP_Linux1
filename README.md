# Sujet TP – Linux
* Michael TONGLE
* Omar NOUBAIR

# Informations Instalations

## Diagramme parc informatique 

![DSI de l'entreprise.](https://raw.githubusercontent.com/omarnoubair/TP_Linux1/main/images/DIAGRAMME_TP_LINUX.png "Diagramme.")


### Créations des Seveurs :
#### Nous avons 3 postes dev avec chacun une @IP :
* POSTEDEV1 : @IP 192.168.1.18
* POSTEDEV2 : @IP 192.168.1.19
* POSTEDEV3 : @IP 192.168.1.20

#### Serveur d'intégration jenkins :
* WSI : @IP 192.168.1.10
#### Serveur NFS :
* WSH : @IP 192.168.1.11
#### Serveur hébergeur :
* WSH : @IP 192.168.1.12

## Serveur web hébergeant le site de l’entreprise 

### Démarrage de la machine

1. Ouvrer le dossier ws-apache
1.Faites un clique droit puis => Git Bash here
1. Lancer la commande suivante : 
```
vagrant up && vagrant ssh
```

### Installation Pré-requis 

* Copier les fichiers install-apache.sh et nfs-client-apache.sh
*  Executer la commande
```
bash install-apache.sh
```
> Installe tous les composants nécessaires au démarrage de apache
> 
>> Apache2
>
> Installe UFW pour la confiration du pare-feu
> 
>>  Ouvre les ports 80 et 443 
*  Executer la commande
```
sudo bash nfs-client-apache.sh
```
> Installe tous les composants nécessaires du client NFS
> 
>> nfs-common
>
> Confiure la sauvegarde du dossier /var/www/html dans le dossier /var/web de NFS 


*  Vérification apache
   1. Avtivation du port 80 sur VirtualBox pour apache
   1. ![IMG](https://raw.githubusercontent.com/omarnoubair/TP_Linux1/main/images/vb-apche.PNG "VB Apache")
  
   1. Accéder à index.html de apache
   1. ![IMG](https://raw.githubusercontent.com/omarnoubair/TP_Linux1/main/images/index-apche.PNG "index Apache")


## Serveur d’intégration continue avec Jenkins

###  Démarrage de la machine

1. Ouvrer le dossier ws-jenkins
1.Faites un clique droit puis => Git Bash here
1. Lancer la commande suivante : 
```
vagrant up && vagrant ssh
```

### Installation Pré-requis 

* Copier les fichiers install-jenkins.sh et nfs-client-jenkins.sh
*  Executer la commande 
```
bash install-jenkins.sh
```
> Créer une partition de type ext4 sur le disque vide
> 
>> sdb
>
> Installe la version stable de Jenkinset tous les composants nécessaires pour le démarrage
> 
>> openjdk-11-jdk, jenkins, gnupg
>
> Créer un utilisateur userjob
>
>>Donne les droit apt au userjob
>
>Afficher à la fin de l'execution du script le mot de passe Jenkins
>>sudo cat /var/lib/jenkins/secrets/initialAdminPassword
>
> Installe UFW pour la confiration du pare-feu
> 
>>  Ouvre les ports 8080 et 22 

*  Executer la commande 
```
sudo bash nfs-client-jenkins.sh
```
> Installe tous les composants nécessaires du client NFS
> 
>> nfs-common
>
>> créer le dossier de partage usr/local/jenkins
>
> Confiure la sauvegarde du dossier usr/local/jenkins dans le dossier /var/server_ic 

* Vérification Jenkins
   1. Avtivation du port 80 sur VirtualBox pour Jenkins
   1. ![IMG](https://raw.githubusercontent.com/omarnoubair/TP_Linux1/main/images/vb-jenkins.PNG "VB Apache")

   1. Accéder à Jenkins
   1. ![IMG](https://raw.githubusercontent.com/omarnoubair/TP_Linux1/main/images/jenkins2.PNG "jenkins2")
   1. ![IMG](https://raw.githubusercontent.com/omarnoubair/TP_Linux1/main/images/jenkins.PNG "jenkins")

* Accéder en ssh depuis les postes de développement


## Postes de développement sous Linux

###  Démarrage de la machine

1. Ouvrer les dossiers ws-dev1 / ws-dev2 / ws-dev3
1.Faites un clique droit puis => Git Bash here
1. Lancer la commande suivante : 
```
vagrant up && vagrant ssh
```

### Installation Pré-requis 

* Copier le fichier install_postdev.sh 
* Executer la commande 
```
bash install_postdev.sh
```
> Installe Tous les composants nécessaires
> 
>> Python, Git, VS, Vagrant, virtualBox
>
> Ce Script clone également le depot git dans le home user

### Les Cles SSH

* Copier le fichier key_gen.sh sur un post_dev
* Copier le fichier authorize_copy_key.sh sur le Serveur d'integration continue
* Executer la commande sur le WSI

```
bash authorize_copy_key.sh 
```
> Permet de changer dans le fichier /etc/ssh/sshd_config la valeur de PasswordAuthentication en yes
> 
> attend 5minutes que la copy de cle soit terminé (côté dev)
> 
> Remet le PasswordAuthentication en no

* Executer la commande sur le post_dev

```
bash key_gen.sh
```
> Cree une Cle devtoWSI
> 
> Contien le nom d'user vers qui envoyé la cle avec son @IP
> 
>> En cas de réexécution : Vérifier les informations de votre USER (nom et password)
>
> Copy la Cle vers l'utilisateur
> 
> ajoute la passphrasse a l'agent 

### Corbeille

* Copier le fichier garbage.sh 
* Executer la commande 
```
bash garbage.sh
```
> Creer les 3 script demande
> 
> Les copies dans le repertoir /usr/bin/
> 
> Ajoute les alias RM, TRASH et RESTORE dans le repertoire ~/.bashrc
> 
>> Fichier contenant tout les alias
>
> Reboot la session pour prendre en compte les alias ajouter


## Serveur de fichier partagé en NFS permettant de faire de la sauvegarde

###  Démarrage de la machine

1. Ouvrer le dossier ws-nfs
1.Faites un clique droit puis => Git Bash here
1. Lancer la commande suivante : 
```
vagrant up && vagrant ssh
```

## Points avec le tuteur
* Mardi 1h
* Mercredi 30 minutes

## Suivi des taches

| Taches           | Temps | Assigné à   | En cours | Fini | 
|----------------|---------------|---------------|----------------|-----------|
| taches2 1 | > 5  | Omar | in progress | - [x]
| taches 2  | > 5  | Omar | in progress | - [x] 
| taches 3  | > 5  | Michael  | in progress | - [x] 
| taches 4   | > 5  | Michael | in progress | - [x]
