#!/bin/bash
#CT aka PrototypeActual
#SeedDMS 5.1.9
#December 10th 2019

echo "User/Administrator be advised,
This script deploys SeedDMS only and will need a Database Server with a database table, user and the user permission granted to fully complete the last section of this SeedDMS installation."

sleep 10

echo "Here we go!"

sleep 3

#This section updates the machine and installs the prerequisites for SeedDMS

yum update -y

yum install -y epel-release

yum install -y httpd wget php php-mysql php-pear php-gd php-mbstring php-pdo php-pear-Log php-ZendFramework-Search-Lucene php-pear-Image-Text

#This starts Apache and ensures it starts on reboot/start up of the server

systemctl enable httpd

systemctl start httpd

#This section makes a temporary folder in the current user home directory this script runs under and then downloads the SeedDMS packages

mkdir ~/temp

wget https://sourceforge.net/projects/seeddms/files/seeddms-5.1.9/SeedDMS_Lucene-1.1.13.tgz -O ~/temp/SeedDMS_Lucene-1.1.13.tgz

wget https://sourceforge.net/projects/seeddms/files/seeddms-5.1.9/SeedDMS_Preview-1.2.9.tgz -O ~/temp/SeedDMS_Preview-1.2.9.tgz

wget https://sourceforge.net/projects/seeddms/files/seeddms-5.1.9/seeddms-5.1.9.tar.gz -O ~/temp/seeddms-5.1.9.tar.gz

wget https://sourceforge.net/projects/seeddms/files/seeddms-5.1.9/SeedDMS_Core-5.1.9.tgz -O ~/temp/SeedDMS_Core-5.1.9.tgz

#This section installs SeedDMS and SeedDMS components using pear as well as updating the pear channels

pear update-channels

pear install ~/temp/SeedDMS_Core-5.1.9.tgz

pear install ~/temp/SeedDMS_Lucene-1.1.13.tgz

pear install ~/temp/SeedDMS_Preview-1.2.9.tgz

pear install --alldeps HTTP_WebDAV_Server-1.0.0RC8

pear install Log

#This part extracts the SeedDMS package to the previously mentioned temp folder

tar xvzf ~/temp/seeddms-5.1.9.tar.gz -C ~/temp/

#This section makes the directories for SeedDMS and its components, then it copies over the contents from that previously extracted SeedDMS package 

mkdir /var/www/html/seeddms

cp -r ~/temp/seeddms-5.1.9/. /var/www/html/seeddms/

mkdir /var/www/html/data

mkdir /var/www/html/data/content

mkdir /var/www/html/data/cache

mkdir /var/www/html/data/lucene

mkdir /var/www/html/data/staging

mv /var/www/html/seeddms/conf.template /var/www/html/seeddms/conf

touch /var/www/html/seeddms/conf/ENABLE_INSTALL_TOOL

#This part sets the permissions for the Apache folder, makes Apache the owner of that folder and downward

chown -R apache:apache /var/www

chmod -R 770 /var/www/html/

#This restarts Apache, creates a exception to allow Apache to connect to a remote database, and allows access for SeedDMS to pass through SELinux

systemctl restart httpd

setsebool -P httpd_can_network_connect_db=1

setsebool -P httpd_unified 1

#This last section allows for http and https traffic to pass through Firewalld

firewall-cmd --permanent --add-service=http

firewall-cmd --permanent --add-service=https

firewall-cmd --reload

echo "To get to the installation page enter in Web Browser IPADDRESSOFTHEVM/seeddms/"

echo "-----------------------------------------"

echo "After successfully getting past the installation page and the ENABLE_INSTALL_TOOL file has been removed; enter IPADDRESSOFTHEVM/seeddms/out/out.Login.php to get to the login page."

echo "-----------------------------------------"

echo "The default login should be admin for username and the password"

rm -rf ~/temp
