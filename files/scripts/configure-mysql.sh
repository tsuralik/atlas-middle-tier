echo "configuring..."

source ./set-vars.sh

################ MYSQL ################ 

mysqlPassword=MYSQL_PASSWD

echo configure mysql root password
sudo /usr/bin/mysqladmin -u root password $mysqlPassword &

sleep 5
mysql -u root -p$mysqlPassword -e 'show databases;'
mysql -u root -p$mysqlPassword -e 'create database ecfs;'
sleep 2
mysql -u root -p$mysqlPassword -e 'show databases;'
mysql -u root -p$mysqlPassword ecfs < ../mysql-files/ECFS-table-generation.sql
sleep 2
mysql -u root -p$mysqlPassword ecfs < ../mysql-files/ECFS-atlas-addendum.sql
sleep 2
mysql -u root -p$mysqlPassword -e 'show tables;' ecfs;

echo replace MYSQL_USER_VARIABLE with user name
sudo sed -i "s/MYSQL_USER_VARIABLE/root/g" $targetDir/apache-tomcat-8.0.20/conf/Catalina/localhost/fccEcfs.xml

echo replace MYSQL_PASSWORD_VARIABLE  with user password
sudo sed -i "s/MYSQL_PASSWORD_VARIABLE/$mysqlPassword/g" $targetDir/apache-tomcat-8.0.20/conf/Catalina/localhost/fccEcfs.xml
