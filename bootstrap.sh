#!/bin/bash

sudo locale-gen zh_TW.UTF-8

############### setup mongodb ###############
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list
############### setup mongodb ###############

############### config apt for rethinkdb ###############
source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- http://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
############### config apt for rethinkdb ###############


############### update and install necessary package by apt ###############
sudo apt-get update
sudo apt-get install -y git-core curl nginx rethinkdb build-essential python-pip mongodb-org htop
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
cd ~
rm -rf redis-3.0.1
rm -rf redis-3.0.1.tar.gz
############### setup redis ###############


############### setup rethinkdb ###############
sudo cp /vagrant/rethinkdb/instance1.conf /etc/rethinkdb/instances.d/instance1.conf
sudo service rethinkdb start
sudo pip install rethinkdb # rethinkdb python driver for rethinkdb dump and restore
# rethinkdb restore --force '/vagrant/rethinkdb/rethinkdb_dump_2015-06-09T14:14:37.tar.gz'
############### setup rethinkdb ###############


############### download taipei_steak database ###############
wget http://steak.nukr.tw/taipei_steak-latest.tar.gz
tar zxvf taipei_steak-latest.tar.gz
mongorestore -d taipei_steak --dir taipei_steak
rm -rf taipei_steak
rm -rf taipei_steak-latest.tar.gz
############### download taipei_steak database ###############


############### setup nvm ###############
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash
echo "source /home/vagrant/.nvm/nvm.sh" >> /home/vagrant/.profile
source /home/vagrant/.profile
############### setup nvm ###############


############### setup iojs ###############
nvm install iojs
nvm alias default iojs
############### setup iojs ###############


############### mongodb to rethinkdb ###############
git clone https://github.com/nukr/mongodb2rethinkdb.git
cd mongodb2rethinkdb && npm i && npm start && cd ..
rm -rf mongodb2rethinkdb
sudo service mongod stop
sudo apt-get remove -y mongodb-org
############### mongodb to rethinkdb ###############


############### setup taipei-steak-api ###############
git clone https://github.com/nukr/taipei-steak-api.git
cd taipei-steak-api && cp config.example.js config.js && npm i
npm install pm2 -g
pm2 start app.js --next-gen-js -n taipei-steak-api
cd ~
############### setup taipei-steak-api ###############


############### post install adjust ###############
sudo ntpdate time.stdtime.gov.tw
echo "1 * * * * root ntpdate time.stdtime.gov.tw" | sudo tee -a /etc/crontab
############### post install adjust ###############

