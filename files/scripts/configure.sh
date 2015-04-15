echo "configuring..."

source ./set-vars.sh

localip="$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"
echo local IP is: $localip

############### PROMPTS ############### 

read -p "Provide the desired zookeeper port: " zookPort
echo "zookPort is $zookPort"

read -p "Provide the number of solr shards: " solrShards
echo "solrShards is $solrShards"

read -p "Provide the number of solr devices: " solrDevices
echo "solrDevices is $solrDevices"

read -p "Provide the desired solr port: " solrPort
echo "solrPort is $solrPort"

read -p "Provide the desired mysql server port: " mySQLPort
echo "mySQLPort is $mySQLPort"

read -p "Provide the mysql root password: " mysqlPassword
echo "mysqlPassword is $mysqlPassword"

#set path for file location
fileDir=/home/vagrant/shared
echo shared files are at $fileDir

################ MYSQL ################ 

echo replace MYSQL_PASSWORD with the specified mysql password
sudo sed -i "s/MYSQL_PASSWD/$mysqlPassword/g" configure-mysql.sh

############## ZOOKEEPER ############## 

echo copy the zoo_sample.cfg to zoo.cfg
sudo cp $targetDir/zookeeper-3.4.6/conf/zoo_sample.cfg $targetDir/zookeeper-3.4.6/conf/zoo.cfg 

echo replace zookeeper PORT with specified zookeeper port
sudo sed -i "s/2181/$zookPort/g" $targetDir/zookeeper-3.4.6/conf/zoo.cfg

################ SOLR ################# 

echo copy the startSolrCloud script to /var/solr/bin
sudo cp $fileDir/solr-files/startSolrCloud.sh /var/solr/bin

echo copy the stopSolrCloud script to /var/solr/bin
sudo cp $fileDir/solr-files/stopSolrCloud.sh /var/solr/bin

echo copy the ecfsStartLarge script to /var/solr/bin
sudo cp $fileDir/solr-files/ecfsStartLarge.sh /var/solr/bin

echo grant execute permissions to all files in /var/solr/bin
sudo chmod +x /var/solr/bin/*

echo copy solrconfig.xml to /var/solr/conf/ecfs_solrconfig.xml
sudo cp $fileDir/solr-files/solrconfig.xml /var/solr/conf/ecfs_solrconfig.xml

echo copy ecfs_schema_large.xml to /var/solr/conf/ecfs_schema_large.xml
sudo cp $fileDir/solr-files/ecfs_schema_large.xml /var/solr/conf/ecfs_schema_large.xml

echo replace ZK_HOST IP with system IP
sudo sed -i "s/127.0.0.1/$localip/g" /var/solr/bin/startSolrCloud.sh

echo replace ZK_HOST PORT with specified zookeeper port
sudo sed -i "s/2181/$zookPort/g" /var/solr/bin/startSolrCloud.sh

echo replace TARGET_DIR with specified solr install directory
formattedTargetDir=`echo $targetDir | sed -e 's/\//\\\\\//g'`
echo formattedTargetDir: $formattedTargetDir
sudo sed -i "s/TARGET_DIR/$formattedTargetDir/g" /var/solr/bin/startSolrCloud.sh

echo replace NUM_OF_SHARDS with specified num of shards 
sudo sed -i "s/NUM_OF_SHARDS/$solrShards/g" /var/solr/bin/ecfsStartLarge.sh

echo replace NUM_OF_DEVICES with specified zookeeper port
sudo sed -i "s/NUM_OF_DEVICES/$solrDevices/g" /var/solr/bin/ecfsStartLarge.sh

echo replace SOLR_PORT with specified zookeeper port
sudo sed -i "s/SOLR_PORT/$solrPort/g" /var/solr/bin/ecfsStartLarge.sh

############### SCRIPTS ############### 

echo replace ZOOKEEPER_IP with system IP
sudo sed -i "s/ZOOKEEPER_IP/$localip/g" $targetDir/dtl3/releases/ingest/runSolrIngest.sh

echo replace ZK_HOST PORT with specified zookeeper port
sudo sed -i "s/ZOOKEEPER_PORT/$zookPort/g" $targetDir/dtl3/releases/ingest/runSolrIngest.sh

########### TOMCAT CONTEXT ############ 

echo replace SOLR-IP-VARIABLE IP with system IP
sudo sed -i "s/SOLR-IP-VARIABLE/$localip/g" $targetDir/apache-tomcat-8.0.20/conf/Catalina/localhost/fccEcfs.xml

echo replace SOLR-PORT-VARIABLE IP with system IP
sudo sed -i "s/SOLR-PORT-VARIABLE/$solrPort/g" $targetDir/apache-tomcat-8.0.20/conf/Catalina/localhost/fccEcfs.xml

echo replace ZOOKEEPER-IP-VARIABLE IP with system IP
sudo sed -i "s/ZOOKEEPER-IP-VARIABLE/$localip/g" $targetDir/apache-tomcat-8.0.20/conf/Catalina/localhost/fccEcfs.xml

echo replace ZOOKEEPER-PORT-VARIABLE IP with system IP
sudo sed -i "s/ZOOKEEPER-PORT-VARIABLE/$zookPort/g" $targetDir/apache-tomcat-8.0.20/conf/Catalina/localhost/fccEcfs.xml

echo replace MYSQL_IP_VARIABLE IP with system IP
sudo sed -i "s/MYSQL_IP_VARIABLE/127.0.0.1/g" $targetDir/apache-tomcat-8.0.20/conf/Catalina/localhost/fccEcfs.xml

echo replace MYSQL_PORT_VARIABLE IP with system IP
sudo sed -i "s/MYSQL_PORT_VARIABLE/$mySQLPort/g" $targetDir/apache-tomcat-8.0.20/conf/Catalina/localhost/fccEcfs.xml

echo "configuration complete"
