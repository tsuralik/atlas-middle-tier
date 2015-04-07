echo "installing tomcat..."

source ./set-vars.sh
echo shared files are at $fileDir

############## TOMCAT ############## 

echo copy tomcat to $targetDir directory
sudo cp $fileDir/packages/apache-tomcat-8.0.20.tar.gz $targetDir 

echo gunzip tomcat to tar file
sudo gunzip $targetDir/apache-tomcat-8.0.20.tar.gz

echo untar tomcat to $targetDir directory
sudo tar -C $targetDir -xf $targetDir/apache-tomcat-8.0.20.tar

echo delete the tomcat tar file form $targetDir
sudo rm -f $targetDir/apache-tomcat-8.0.20.tar

echo "tomcat installation complete"
