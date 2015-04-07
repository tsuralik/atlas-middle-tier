source ./set-vars.sh

cd $targetDir/apache-tomcat-8.0.20/bin
sudo nohup ./startup.sh > /dev/null 2>&1 &

cd $targetDir/zookeeper-3.4.6/bin
sudo nohup ./zkServer.sh start > /dev/null 2>&1 &

cd /var/solr/bin
sudo nohup ./ecfsStartLarge.sh > /dev/null 2>&1 &

sudo service httpd start
