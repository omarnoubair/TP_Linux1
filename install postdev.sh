#!/bin/sh


sudo su 

#update to last version
apt update

#install net-tools
apt install net-tools

#install python
apt install python3 python3-pip python3-dev -y

# install git
apt install git-all -y 

#install pre-requis  vagrant et VS
apt install snapd -y
apt install curl -y

#install VS
snap install --classic code

#download vagrant
curl -O https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb

#install vagrant
apt install ./vagrant_2.2.6_x86_64.deb

#VirtualBox

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
apt install virtualbox-6.0


#update all install
apt update



#exit SU
exit


#clone depot git 
cd
git clone https://github.com/vanessakovalsky/example-python.git
