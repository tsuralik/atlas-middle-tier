echo "configuring..."

source ./set-vars.sh

################ MYSQL ################ 

mysqlPassword=fcc2014!

echo configure mysql root password
sudo /usr/bin/mysqladmin -u root password $mysqlPassword &

mysql -u root -p$mysqlPassword -e 'show databases;'
mysql -u root -p$mysqlPassword -e 'create database ecfs;'
mysql -u root -p$mysqlPassword -e 'show databases;'
mysql -u root -p$mysqlPassword ecfs < ../mysql-files/ECFS-table-generation.sql
mysql -u root -p$mysqlPassword -e 'show tables;' ecfs;

