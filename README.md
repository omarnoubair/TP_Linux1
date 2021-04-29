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
1. Lancer la commande suivante : 
  1.Faites un clique droit puis => Git Bash here
```
Lancer la commande 
vagrant up && vagrant ssh
```

## Serveur d’intégration continue avec Jenkins

###  Démarrage de la machine

1. Ouvrer le dossier ws-jenkins
1. Lancer la commande suivante : 
  1.Faites un clique droit puis => Git Bash here
```
Lancer la commande 
vagrant up && vagrant ssh
```

## Postes de développement sous Linux

###  Démarrage de la machine

1. Ouvrer les dossiers ws-dev1 / ws-dev2 / ws-dev3
1. Lancer la commande suivante : 
  1.Faites un clique droit puis => Git Bash here
```
Lancer la commande 
vagrant up && vagrant ssh
```

### Installation Pré-requis 

* Copier le fichier install_postdev.sh 
* Executer la commande 
```
bash install_postdev.sh
```
> Install tout les composant necessaire
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
1. Lancer la commande suivante : 
  1.Faites un clique droit puis => Git Bash here
```
Lancer la commande 
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
