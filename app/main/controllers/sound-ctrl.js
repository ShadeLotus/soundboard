'use strict';
angular.module('main')
.controller('SoundCtrl', function () {

  console.log('Sounds controller loaded');

  this.packages = {
    'default': {
      sounds: [
        {loop: true, src: 'default/bell.mp3'},
        {loop: true, src: 'default/bell.mp3'},
        {loop: false, src: 'default/bell.mp3'},
        {loop: false, src: 'default/bell.mp3'}
      ]
    },
    'christmas': {
      sounds: [
        {loop: false, src: 'default/bell.mp3'},
        {loop: false, src: 'default/bell.mp3'},
        {loop: true, src: 'default/bell.mp3'},
        {loop: true, src: 'default/bell.mp3'}
      ]
    }
  };

  console.log('Packages: ', this.packages);

});
