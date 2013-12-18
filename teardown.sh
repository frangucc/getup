#!/bin/sh
# tear down the environment saftely so I can run main again freely
# only works if the environment was rolled
npm cache clean
brew uninstall node
cd /Library/
sudo rm -r -f Android
cd ~/Desktop
sudo rm -r -f UP
cd /usr/local/lib/
sudo rm -r -f node_modules
cd /usr/local/share
sudo rm -r -f man
cd /usr/local/lib/dtrace/
sudo rm -r -f node.d
cd ~/Desktop/getup/
sudo rm -r -f node_modules
sudo rm -r -f npm-debug.log
echo "cool, tried to delete a bunch of crap."
