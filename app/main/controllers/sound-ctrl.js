'use strict';
angular.module('main')
.controller('SoundCtrl', function (Api) {

  console.log('Sounds controller loaded');
  var ctrl = this;

  Api.getPackages().then(function (packages) {
    ctrl.packages = packages;
  }, function (error) {
    console.log('error retrieiving packages: ' + error);
  });

  console.log('Packages: ', this.packages);

});

