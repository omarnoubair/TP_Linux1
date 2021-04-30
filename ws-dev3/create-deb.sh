#!/bin/bash


# Droits d'exécution
chmod og+x install_postdev.sh

mkdir postedev

mkdir -p postedev/DEBIAN

mkdir -p postedev/usr/bin
mv install_postdev.sh postedev/usr/bin

mkdir -p postedev/usr/share/doc

echo 'Package: postedev
Version: 0.1
Section: base
Priority: optional
Architecture: all
Depends: bash
Maintainer: dev <michael-omar@yahoo.fr>
Description: Installation python3, python3-pip, python3-dev, git, visual studio code' > postedev/DEBIAN/control

# Exécution avant l'installation
echo '#!/bin/bash
echo "Début installation"' > ~/postedev/DEBIAN/preinst

# Exécution après l'installation
echo '#!/bin/bash
echo "Fin installation"' > ~/postedev/DEBIAN/postinst

chmod 755 postedev/DEBIAN/preinst
chmod 755 postedev/DEBIAN/postinst

echo '# Programme packet DEB ' > postedev/usr/share/doc/README

dpkg-deb --build postedev

