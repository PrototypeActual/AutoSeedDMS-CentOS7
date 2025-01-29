# Automated bash scripts for old assignment

# AutoSeedDMS-CentOS7
Bash script to deploy SeedDMS 5.1.9 on a fresh CentOS 7 machine with very little setting up.
There are messages displayed during the installation of this script to keep you aware of certain things as well as comments in the script to explain what the commands in the script do.

What you will still need to do:
1. Create a database server (installed on the same machine you run this script or on a seperate machine)
2. Create a database table for SeedDMS to use
3. Create a database user for SeedDMS to use for accessing your database/database table
4. Grant that database user access to the database table

# AutoHAProxy-CentOS7
Bash script to deploy HAProxy 2.1.1 with SSL on a fresh CentOS 7 machine with very little setting up. There are messages displayed during the installation of this script to keep you aware of certain things as well as comments in the script to explain what the commands in the script do.

What you will still need to do:
1. During the script it will open up the vi text editor so you can edit the last line
2. The last line needs to have the server ip where it says ENTERIPOFHTTPDSERVER
Ex. server Apache1 192.168.1.10:80 check cookie s1
2a. If you need to add other servers uncomment (remove the #) for the last two lines
2b. If you need to add even more servers you can enter a new line with the same format as the last line
3. If you add more servers make sure to change the name, and IP.
3a. You may also need to change the number after the s to the number that server is in the list
4. You will also need to update the login for the stats page or comment out
stats auth admin:haproxy
4a. This line is located in the haproxy config file under the frontend section

# DigitalOcean
Unfinished playbook to create DigitalOcean droplets and display their IP