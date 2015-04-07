echo "installing releases..."

source ./set-vars.sh

############## RELEASES ##############

#echo create a dtl3 releases directory
sudo mkdir -p $targetDir/dtl3/releases

#echo clone the ingest release to the dtl3 releases directory
sudo cp -R $fileDir/releases/ingest $targetDir/dtl3/releases

#echo clone the war file to the tomcat webapps directory
sudo cp -R $fileDir/releases/web/fccEcfs.war $targetDir/apache-tomcat-8.0.20/webapps

echo copy the servlet context stub to the servlet\'s configuration directory
mkdir -p $targetDir/apache-tomcat-8.0.20/conf/Catalina/localhost
sudo cp $fileDir/releases/web/fccEcfs-context-stub.xml $targetDir/apache-tomcat-8.0.20/conf/Catalina/localhost/fccEcfs.xml

echo "releases installation complete"
