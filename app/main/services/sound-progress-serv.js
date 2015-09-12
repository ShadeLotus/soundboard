'use strict';
angular.module('main')
.service('SoundProgress', function () {
  console.log('Hello from your Service: SoundProgress in module main');

  this.getProgress = function (sound) {
    if (! sound.hasOwnProperty('currentTime')) {
      console.log('sound object is not an audio element: ', sound);
      return;
    }

    console.log('getting sound progress');
    var maxTime = sound.duration,
        currentTime = sound.currentTime;
    return Math.ceil((currentTime / maxTime) * 100);
  };
});
