cd /opt/shared/apache-tomcat-8.0.20/bin
sudo nohup ./startup.sh > /dev/null 2>&1 &

cd /opt/shared/zookeeper-3.4.6/bin
sudo nohup ./zkServer.sh start > /dev/null 2>&1 &

cd /var/solr/bin
sudo nohup ./ecfsStartLarge.sh > /dev/null 2>&1 &