echo "installing zookeeper..."

source ./set-vars.sh

############## ZOOKEEPER ############## 

echo copy zookeeper to $targetDir directory
sudo cp $fileDir/packages/zookeeper-3.4.6.tar.gz $targetDir

echo gunzip zookeeper to tar file
sudo gunzip $targetDir/zookeeper-3.4.6.tar.gz

echo untar zookeeper to $targetDir directory
sudo tar -C $targetDir/ -xf $targetDir/zookeeper-3.4.6.tar

echo delete the zookeeper tar file form $targetDir
sudo rm -f $targetDir/zookeeper-3.4.6.tar

echo "zookeeper installation complete"
