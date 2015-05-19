#!/usr/bin/env bash

apt-get update
apt-get install -y git
locale-gen zh_TW.UTF-8

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | bash
. /home/vagrant/.bashrc

nvm install iojs
