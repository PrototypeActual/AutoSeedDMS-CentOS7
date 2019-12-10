#!/bin/bash
#Cristian Torres
#SeedDMS 5.1.10
#December 5th 2019

echo "User/Administrator be advised,
This script deploys SeedDMS only and will need a Database Server with a database table, user and the user permission granted to fully complete the last section of this SeedDMS installation."

sleep 15

yum update -y

echo "Manual EPEL repo installation process was removed in this version but if you're having issues in regards to install EPEL repo or missing packages; try running this manually."
#Run this command but ensure url link to EPEL repo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm is reachable.
#Ex. rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sleep 10

echo "Here we go!"

yum install -y epel-release

yum install -y httpd mod_ssl php php-gd php-mysql php-pear wget php-mbstring poppler-utils php-pear-Log php-pdo php-ZendFramework-Search-Lucene nano

systemctl enable httpd

systemctl start httpd

mkdir ~/temp

wget https://sourceforge.net/projects/seeddms/files/seeddms-5.1.9/SeedDMS_Lucene-1.1.13.tgz -O ~/temp/SeedDMS_Lucene-1.1.13.tgz

wget https://sourceforge.net/projects/seeddms/files/seeddms-5.1.9/SeedDMS_Preview-1.2.9.tgz -O ~/temp/SeedDMS_Preview-1.2.9.tgz

wget https://sourceforge.net/projects/seeddms/files/seeddms-5.1.9/seeddms-5.1.9.tar.gz -O ~/temp/seeddms-5.1.9.tar.gz

wget https://sourceforge.net/projects/seeddms/files/seeddms-5.1.9/SeedDMS_Core-5.1.9.tgz -O ~/temp/SeedDMS_Core-5.1.9.tgz

pear install SeedDMS_Core-5.1.9.tgz

pear install SeedDMS_Lucene-1.1.13.tgz

pear install SeedDMS_Preview-1.2.9.tgz

pear install HTTP_WebDAV_Server-1.0.0RC8

pear install Log

tar xvzf ~/temp/seeddms-5.1.9.tar.gz -C ~/temp/

mkdir /var/www/html/seeddms

cp -r ~/temp/seeddms-5.1.9/. /var/www/html/seeddms/

mkdir /var/www/html/data

mkdir /var/www/html/data/content

mkdir /var/www/html/data/cache

mkdir /var/www/html/data/lucene

mkdir /var/www/html/data/staging

mv /var/www/html/seeddms/conf.template /var/www/html/seeddms/conf

touch /var/www/html/seeddms/conf/ENABLE_INSTALL_TOOL

chown -R apache:apache /var/www

chmod -R 770 /var/www/html/

setenforce 0

service httpd restart

setsebool -P httpd_can_network_connect_db=1

setsebool httpd_execmem on

firewall-cmd --permanent --add-service=http

firewall-cmd --permanent --add-service=https

firewall-cmd --reload

echo "If having issues run setenforce 0 to temporarily disable SELinux"

echo "-----------------------------------------"

echo "To get to the installation page enter in Web Browser IPADDRESSOFTHEVM/seeddms/"

echo "-----------------------------------------"

echo "After successfully getting past the installation page and the ENABLE_INSTALL_TOOL file has been removed; enter IPADDRESSOFTHEVM/seeddms/out/out.Login.php to get to the login page."

echo "-----------------------------------------"

rm -rf ~/temp

#rm -f /root/seed.sh 
