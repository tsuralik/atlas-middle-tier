echo "installing unzip..."

#set path for file location
fileDir=/home/vagrant/shared
echo shared files are at $fileDir

echo install [unzip] via yum
sudo yum install unzip

echo "unzip installation complete"
