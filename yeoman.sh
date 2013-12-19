#!/bin/sh

#get in all the yeoman shit and start angular widget injections
#open http://yeoman.io/
npm install -g yo
sudo npm install -g generator-angular
yo angular
bower install angular-ui
grunt test
grunt server
grunt


