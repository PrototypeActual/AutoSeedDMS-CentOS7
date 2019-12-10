# AutoSeedDMS-Centos7
Bash script to deploy SeedDMS 5.1.9 on CentOS7 with very little setting up.
There are messages displayed during the installation of this script to keep you aware of certain things.

What it still needs
1. A database server, database table for SeedDMS, a database user account for SeedDMS to use, and for that database user for SeedDMS to have access to those database tables.
2. SELinux needs to be disabled or have an exception to allow SeedDMS to run.
