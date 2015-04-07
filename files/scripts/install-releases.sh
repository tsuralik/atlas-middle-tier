echo "installing releases..."

source ./set-vars.sh

############## RELEASES ##############

echo create a dtl3 releases directory
sudo mkdir -p $targetDir/dtl3/releases

echo clone the ingest release to the dtl3 releases directory
sudo cp -R $fileDir/releases/ingest $targetDir/dtl3/releases

echo clone the war file to the tomcat webapps directory
sudo cp -R $fileDir/releases/fccEcfs.war $targetDir/apache-tomcat-8.0.20/webapps

echo "releases installation complete"
