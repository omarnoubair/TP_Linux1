#!/bin/bash

#update to last version
sudo apt update

#install net-tools
sudo apt install net-tools

#install python
sudo apt install python3 python3-pip python3-dev -y

# install git
sudo apt install git-all -y 

#install pre-requis  vagrant et VS
sudo apt install snapd -y
sudo apt install curl -y

#install VS
sudo snap install --classic code
#download vagrant
curl -O https://releases.hashicorp.com/vagrant/2.2.15/vagrant_2.2.15_x86_64.deb

#install vagrant
sudo apt install ./vagrant_2.2.15_x86_64.deb


#KVM
sudo apt install qemu qemu-kvm libvirt-clients libvirt-daemon-system virtinst bridge-utils -y
sudo apt install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev ruby-libvirt ebtables dnsmasq-base -y

sudo systemctl enable libvirtd
sudo systemctl start libvirtd
systemctl status libvirtd

#VirtualBox

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
apt install virtualbox-6.1

#init vagrant 
vagrant plugin install vagrant-libvirt
vagrant plugin install vagrant-mutate

vagrant up --provider=libvirt
#update all install
sudo apt upgrade -y


#clone depot git 
cd
git clone https://github.com/vanessakovalsky/example-python.git
