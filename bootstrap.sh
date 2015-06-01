#!/bin/bash

sudo locale-gen zh_TW.UTF-8

############### config apt for rethinkdb ###############
source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- http://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
############### config apt for rethinkdb ###############


############### update and install necessary package by apt ###############
sudo apt-get update
sudo apt-get install -y git-core curl nginx rethinkdb build-essential python-pip
############### update and install necessary package by apt ###############


############### setup redis ###############
## download and extract
wget http://download.redis.io/releases/redis-3.0.1.tar.gz
tar zxvf redis-3.0.1.tar.gz

## install redis
cd /home/vagrant/redis-3.0.1
make && sudo make install
cp /vagrant/redis/install_server.sh /home/vagrant/redis-3.0.1/utils/vagrant_install_server.sh
cd /home/vagrant/redis-3.0.1/utils && sudo ./vagrant_install_server.sh
############### setup redis ###############


############### setup rethinkdb ###############
sudo cp /vagrant/rethinkdb/instance1.conf /etc/rethinkdb/instances.d/instance1.conf
sudo service rethinkdb start
sudo pip install rethinkdb # rethinkdb python driver for rethinkdb dump and restore
rethinkdb restore --force '/vagrant/rethinkdb/rethinkdb_dump_2015-06-01T17:19:20.tar.gz'
############### setup rethinkdb ###############


############### setup nvm ###############
curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash
echo "source /home/vagrant/.nvm/nvm.sh" >> /home/vagrant/.profile
source /home/vagrant/.profile
############### setup nvm ###############


############### setup iojs ###############
nvm install iojs
nvm alias default iojs
############### setup iojs ###############
