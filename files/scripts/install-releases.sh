echo "installing releases..."

#set path for file location
fileDir=/home/vagrant/shared
echo shared files are at $fileDir

############## RELEASES ##############

echo create a dtl3 releases directory
sudo mkdir -p /opt/shared/dtl3/releases

echo clone the ingest release to the dtl3 releases directory
sudo cp -R $fileDir/releases/ingest /opt/shared/dtl3/releases

echo clone the war file to the tomcat webapps directory
sudo cp -R $fileDir/releases/fccEcfs.war /opt/shared/apache-tomcat-8.0.20/webapps

echo "releases installation complete"