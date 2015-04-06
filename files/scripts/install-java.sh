echo "installing java..."

#set path for file location
fileDir=/home/vagrant/shared
echo shared files are at $fileDir

echo install [JDK] via RPM
sudo rpm -Uvh $fileDir/packages/jdk-7u67-linux-x64.rpm

echo "java installation complete"