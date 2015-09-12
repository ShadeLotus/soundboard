'use strict';
angular.module('main')
.controller('MoreSoundCtrl', function (Main, Config) {

  // bind data from services
  this.someData = Main.someData;
  this.ENV = Config.ENV;
  this.BUILD = Config.BUILD;

  console.log('Hello from your Controller: MoreSoundCtrl in module main:. This is your controller:', this);
  // TODO: do your controller thing

});
