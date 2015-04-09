source ./set-vars.sh

############### TOMCAT ################ 

cd $targetDir/apache-tomcat-8.0.20/bin
sudo nohup ./startup.sh > /dev/null 2>&1 &

############## ZOOKEEPER ############## 

cd $targetDir/zookeeper-3.4.6/bin
sudo nohup ./zkServer.sh start > /dev/null 2>&1 &

################ SOLR ################# 

cd /var/solr/bin
sudo nohup ./ecfsStartLarge.sh > /dev/null 2>&1 &

################ HTTPD ################ 

sudo service httpd start

################ MYSQL ################ 

sudo service mysqld start
