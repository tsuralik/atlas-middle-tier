echo "installing java..."

source ./set-vars.sh

echo install [JDK] via RPM
sudo rpm -Uvh $fileDir/packages/jdk-7u67-linux-x64.rpm

echo "java installation complete"
