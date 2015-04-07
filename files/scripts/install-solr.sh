echo "installing solr..."

source ./set-vars.sh

############## SOLR ############## 

echo unzip solr to $targetDir directory
sudo unzip -q $fileDir/packages/solr-4.10.4.zip -d $targetDir

echo delete the example* files and directories from solr/example
sudo rm -Rf $targetDir/solr-4.10.4/example/example*

echo delete the logs directory from solr/example
sudo rm -Rf $targetDir/solr-4.10.4/example/logs

echo delete the multicore directory from solr/example
sudo rm -Rf $targetDir/solr-4.10.4/example/multicore

echo delete the scripts directory from solr/example
sudo rm -Rf $targetDir/solr-4.10.4/example/scripts

echo copy the example solr.xml in from example/solr to example
sudo cp $targetDir/solr-4.10.4/example/solr/solr.xml $targetDir/solr-4.10.4/example

echo create a cores directory under solr-4.10.4/examples
sudo mkdir $targetDir/solr-4.10.4/example/cores

echo create a /var/solr directory
sudo mkdir /var/solr

echo copy the example colletion config directory to /var/solr
sudo cp -R $targetDir/solr-4.10.4/example/solr/collection1/conf /var/solr 

echo delete the example directory from solr
sudo rm -Rf $targetDir/solr-4.10.4/example/solr

echo create the data directory for the solr core
sudo mkdir -p /var/solr/FCC/ECFS/data

echo create the logs directory for the solr core
sudo mkdir -p /var/solr/FCC/ECFS/logs

echo create the solr bin directory 
sudo mkdir -p /var/solr/bin

echo copy the solr log4j.properties file to the solr/example/resources directory
sudo cp $fileDir/solr-files/log4j.properties $targetDir/solr-4.10.4/example/resources

echo copy the solr DIH clean file to solr/example directory
sudo cp $fileDir/solr-files/ecfs-clean-dih-config.xml /var/solr/conf

echo copy the solr DIH clean file to solr/example directory
sudo cp $fileDir/solr-files/ecfs-clean-dih-config.xml /var/solr/conf

echo copy the solr DIH clean file to solr/example directory
sudo cp $fileDir/solr-files/ecfs-blank-dih-data-file.xml /var/solr/conf

echo "solr installation complete"
