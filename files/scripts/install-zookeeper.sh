echo "installing zookeeper..."

#set path for file location
fileDir=/home/vagrant/shared
echo shared files are at $fileDir

############## ZOOKEEPER ############## 

echo copy zookeeper to /opt/shared directory
sudo cp $fileDir/packages/zookeeper-3.4.6.tar.gz /opt/shared

echo gunzip zookeeper to tar file
sudo gunzip /opt/shared/zookeeper-3.4.6.tar.gz

echo untar zookeeper to /opt/shared directory
sudo tar -C /opt/shared/ -xf /opt/shared/zookeeper-3.4.6.tar

echo delete the zookeeper tar file form /opt/shared
sudo rm -f /opt/shared/zookeeper-3.4.6.tar

echo "zookeeper installation complete"
