#!/bin/sh
echo Press any key to install \#UP!
read
echo "Preparing #UP! shell scripts, this may take a sec..."
echo "STOP! this script if you haven't downloaded XCODE 5.0.2 and installed the DMG file - get XCODE running - future builds of UP will include XCODE"
#TODO: try and open xcode in a background window or out of focus.
#TD: If Xcode exists version x > above
open -a "xcode"
echo "I just tried to open xcode, did anything happen? If Xcode 5.0.2 or later is infact installed, hit any key, else, abort"
echo "Installing Homebrew - TODO:test on a new MAC"
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew update
cd /Library/
#TD: If Xcode exists version x > above
brew install node
#TODO: Install GIT - brew install git or make a thinner start.sh program that will fetch the latest source.
echo "Installing cordova. Information on what I am doing now can be found in your browser"
echo "You will need to Sudo from here out - enter password"
cd ~/Desktop/getup
echo "ready to install Cordova?"
read
sudo npm install -g cordova
#TODO: need to escape out of here manually
echo "No Errors? Groovy. Move on."
read
mkdir ~/Desktop/UP
cd ~/Desktop/UP
echo "What is the name of the multi-platform stack or product you are creating?"
read MY_PRODUCT
cordova create $MY_PRODUCT com.example.$MY_PRODUCT $MY_PRODUCT
cd $MY_PRODUCT
cordova platform add ios
cordova prepare
#TODO: open http://stackoverflow.com/questions/10379622/how-to-run-iphone-emulator-without-starting-xcode
cd ~/Desktop/UP/$MY_PRODUCT/platforms/ios/
echo "You may now run project $MY_PRODUCT via the Xcode iOS emulator in your other window"
open $MY_PRODUCT.xcodeproj
echo "OK, we got all the Xcode and ios crap installed, lets move onto android"
echo "Is that cool? You will need to confgire Androids SDK manager manually to install a bunch of crap, cool? Hit any key to proceed"
read
brew rm android-sdk
brew install android-sdk
echo "When the Android ADT manager opens, check and approve sdk tools, build tools, platform tools and select at least one Android version"

#Wrap this android in some sort of if. It hangs here. For now, opening a new tab prior

echo "Once finished installing the Android crap, type Control C (ONE TIME!) to exit this step"
#TODO : this other process needs to be givin time or we need to kick this off after the android SDKs are installed - now we get Error: Missing platform-tools because it fires too early.
android
echo "Once the SDK tools and Android version 4.3 or above ar installed, press any key - DO NOT FUCK THIS PART UP"
read
echo "Moving some files around and getting ready to launch the Android Developer Tools Environment - chill dude and let it happen"
cd /Library/
#TODO: Check if this area exists
sudo mkdir Android
cd ~/Downloads
open adt-bundle-mac-x86_64-20131030.zip
echo "wait for package to unzip - when finished, hit any key"
read
sudo mv -f -v adt-bundle-mac-x86_64-20131030 /Library/Android/
cd /Library/Android/adt-bundle-mac-x86_64-20131030/eclipse/
open eclipse.app
cd ~/Desktop/UP/$MY_PRODUCT/
cordova platform add android
cordova build
echo "For more info on where you are at, check out your browser"
open http://docs.phonegap.com/en/edge/guide_platforms_android_index.md.html#Android%20Platform%20Guide
echo "Ready to continue? Press any key"
read
echo "Let's install IONIC now ontop of Cordova for a better UI experience"
git clone https://github.com/driftyco/ionic.git
cd ionic 
ionic start myproject
npm install
echo "ionic should be installed now - press enter and we'll fire up the local services"
read
cd ~/Desktop/UP/$MY_PRODUCT/ionic
bash run_ionic.sh
echo "Let's see Ionic in the browser for the first time"
#NOTE: this copies ionic over to corodva
# open http://ionicframework.com/docs/guide/installation.html
cd ~/Desktop/UP/$MY_PRODUCt/ionic
cp -R dist/* www/
cd ~/Desktop/UP/$MY_PRODUCT/
cordova plugin add org.apache.cordova.device
cordova plugin add org.apache.cordova.console
echo "Just installed two cordova plugins, device and console"
echo "building android project with Cordova and Ionic. Sec..."

#TODO 1: Move the files correctly and write the new index.html file inside the cordova www folder - 
#TODO 2: run the local emulators and build process for both android and ios in a seperate tab
#TODO 3: npm install -g ios-sim find out what thats about. 
echo "installing something that will allow you to simulate in ios from the cmd line :)"
npm install -g ios-sim
npm install -g ios-deploy
echo "cool, installing ionic seed and injecting seed into cordova www root"
read

cd ~/Desktop/UP/$MY_PRODUCT/
read
git clone git@github.com:frangucc/ionic-angular-cordova-seed.git
cd ~/Desktop/UP/$MY_PRODUCT/
rm -r -f www
cd ionic-angular-cordova-seed

echo "awesome, we shold be able to get a sweet ionic seed running in the browser first. If this works, then we'll emulate in android, ios and blackberry next."
mv -f ~/Desktop/UP/CST/ionic-angular-cordova-seed/* ~/Desktop/UP/CST/

echo "firing up webserver"
cd ~/Desktop/UP/$MY_PRODUCT/www
python -m SimpleHTTPServer 8001
open http://localhost:8001

cd ~/DesktopUP/$MY_PRODUCT/www
npm install -g grunt-cli
npm install grunt --save-dev
npm install grunt-contrib-uglify
npm install grunt-contrib-watch --save-dev
npm install grunt-contrib-jshint
npm install grunt-contrib-nodeunit
npm install grunt-contrib-internal


echo "Opening your new android app in the emulator. Yes?"
read
#TODO: when all goes well, start emulating in as many devices as possible.
cordova build android
cordova emulate android

cordova build ios
cordova emulate ios



###############################################################################
###### now we install yeoman bower, etc. and start injections #################
###############################################################################
# cd ~/Desktop/UP/$MY_PRODUCT/www
# bash yeoman.sh









#TODO: upload xcodes 2gig dmg file and androids SDK on an FTP mirrior and curl that bitch so that the person installing this script dont need to do hardly nothing.

#TODO: this is where i should make sure the directory /Volumes/Xcode/Xcode.app/Contents/Developer exists else create it and make sure the xcode file exists there. cannot run 'phonegap build ios' cmduntil this location exists with the file.


