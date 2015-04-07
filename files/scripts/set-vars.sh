#set path for file location
fileDir=/home/vagrant/shared
echo shared files are at $fileDir

#set path for target location
targetDir=/opt/shared
echo files to be deployed at $targetDir

#create the target directory
mkdir -p $targetDir
