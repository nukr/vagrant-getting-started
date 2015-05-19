#!/bin/bash

sudo apt-get update
sudo apt-get install -y git-core curl
sudo locale-gen zh_TW.UTF-8

curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash

echo "source /home/vagrant/.nvm/nvm.sh" >> /home/vagrant/.profile
source /home/vagrant/.profile

nvm install iojs
nvm alias default iojs
