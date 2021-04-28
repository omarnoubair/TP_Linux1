#!/bin/sh 

# Michael & Omar

# Serveur web apahe2 hébergeant le site de l’entreprise
# Version : v0.1  

function installApache {

	# Installation Apache2
	sudo apt install -y apache2 

	# Demarrage Apache2
	sudo service apache2 start 
	# Si erreur retournée par lors du démarrage de apache sortir en erreur
	if [ $? -gt 0 ]
	then
		echo "Script .bashrc (Function installApache) : Erreur de creation du repertoire de apache"
		exit 1;
	fi

	# Verification d'instalation Apache2
	wget localhost
}
# Appel de la fonction
installApache

function createDirectory {

	# Repertoire contenant html
	HTML_DIRECTORY="/var/www/html"

	# si le repertoire /www/html n'existe pas alors le creer
	if [ ! -d "$HTML_DIRECTORY" ]; then
		mkdir -p $HTML_DIRECTORY

	# Si erreur retournée par mkdir alors sortir en erreur
	if [ $? -gt 0 ]
	then
		echo "Script .bashrc (Function createDirectory) : Erreur de creation du repertoire $HTML_DIRECTORY"
		exit 1;
	fi
	fi
}
# Appel de la fonction
createDirectory

# Création d'un utilisateur user job
sudo adduser userjob

# Ajout du group www-data
sudo usermod -aG www-data userjob
if [ $? -gt 0 ]; then
	echo "Erreur lors de la création du groupe www-data"
	exit 1;
fi 

# Le dossier /var/www/html avec pour groupe www-data et pour le droit de lire / écrire pour le
# groupe (en plus du propriétaire) ainsi que pour tout ses sous-dossiers
sudo chown -R www-data:www-data /var/www/html
if [ $? -gt 0 ] ;then
	echo "Erreur lors de configuration des droits du groupe www-data et du dossier /var/www/html"
	exit 1;
fi 

sudo chmod -R 770 /var/www/html
if [ $? -gt 0 ]; then
	echo "Erreur lors de la modification des droits écriture et lecture du dossier /var/www/html"
	exit 1;
fi 


# Copie du fichier index.html dans /var/www/html
cat << 'EOF' > index.html
!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html>
	<head>
		<title>Ma première page avec du style</title>
	</head>
	<body>
	<!-- Menu de navigation du site -->
		<ul class="navbar">
			<li><a href="index.html">Home page</a>
		</ul>
	<!-- Contenu principal -->
		<h1>Ma première page avec du style</h1>
		<p>Bienvenue sur ma page avec du style!
		<p>Il lui manque des images, mais au moins, elle a du style. Et elle a des
		liens, même s'ils ne mènent nulle part...
		&hellip;
		<p>Je devrais étayer, mais je ne sais comment encore.
		<!-- Signer et dater la page, c'est une question de politesse! -->
		<address>Fait le 22 avril 2021<br>
			par moi.
		</address>
	</body>
</html>
EOF
if [ $? -gt 0 ]; then
	echo "Erreur lors de l'écriture du fichier index.html"
	exit 1;
fi 


# Déplacer le index.html dans le dossier /var/www/html
sudo mv index.html /var/www/html
if [ $? -gt 0 ]; then
	echo "Erreur lors du déplacement du fichier index.html dans /var/www/html"
	exit 1;
fi 

function configurationUFW {

	# Installer et configurer le pare-feu UFW et ouverture des ports 80 et 443
	sudo apt install ufw

	#Activer ufw
	echo y | sudo ufw enable
	if [ $? -gt 0 ]; then
		echo "Erreur lors de l'activation de UFW"
		exit 1;
	fi 

	#Ouverture du port 80
	sudo ufw allow 80

	# Ouverture du port 443
	sudo ufw allow 443

	# Vérification de l'ouverture des ports
	sudo ufw status numbered
}
# Appel de la fonction
configurationUFW