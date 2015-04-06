echo "installing tomcat..."

#set path for file location
fileDir=/home/vagrant/shared
echo shared files are at $fileDir

############## TOMCAT ############## 

echo copy tomcat to /opt/shared directory
sudo cp $fileDir/packages/apache-tomcat-8.0.20.tar.gz /opt/shared

echo gunzip tomcat to tar file
sudo gunzip /opt/shared/apache-tomcat-8.0.20.tar.gz

echo untar tomcat to /opt/shared directory
sudo tar -C /opt/shared/ -xf /opt/shared/apache-tomcat-8.0.20.tar

echo delete the tomcat tar file form /opt/shared
sudo rm -f /opt/shared/apache-tomcat-8.0.20.tar

echo "tomcat installation complete"
