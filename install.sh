#!/bin/sh

# This is the Pool install script.
echo "Pool install script."
echo "Please do NOT run as root, run as the pool user!"

echo "Installing... Please wait!"

sleep 3

sudo rm -rf /usr/lib/node_modules
sudo rm -rf node_modules
sudo apt remove --purge -y nodejs node
sudo rm /etc/apt/sources.list.d/*
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt install -y apt-transport-https software-properties-common build-essential autoconf pkg-config make gcc g++ screen wget curl ntp fail2ban 

sudo add-apt-repository -y ppa:chris-lea/redis-server
sudo add-apt-repository -y ppa:bitcoin/bitcoin
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo apt update
sudo apt install -y libdb-dev libdb++-dev libssl-dev libboost-all-dev libminiupnpc-dev libtool autotools-dev redis-server
sudo apt install -y sudo git npm nodejs nginx certbot python3-certbot-nginx redis-server unzip htop     

sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo systemctl enable redis-server
sudo systemctl start redis-server
sudo systemctl enable ntp
sudo systemctl start ntp

sudo rm -rf ~/.nvm
sudo rm -rf ~/.npm
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile
source ~/.bashrc
sudo chown -R $USER:$GROUP ~/.nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install v14.20.1
nvm use v14.20.1
npm update -g

npm install -g webpack@4.46.0
npm install -g npm@8.19.2
npm install -g pm2@5.2.0

chmod -R +x kawpow-server/
cd kawpow-server

npm install
npm update
npm audit fix
npm install sha3
npm install logger
npm install bignum

echo "Installation completed!"

exit 0
