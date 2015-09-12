'use strict';
angular.module('main')
.service('SoundProgress', function (sound) {
  console.log('Hello from your Service: SoundProgress in module main');

  if (! sound.hasOwnProperty('currentTime')) {
    console.log('sound object is not an audio element');
  }

  this.getProgress = function () {
    console.log('getting sound progress');
    var maxTime = sound.duration,
        currentTime = sound.currentTime;
    return Math.ceil((currentTime / maxTime) * 100);
  };
});
