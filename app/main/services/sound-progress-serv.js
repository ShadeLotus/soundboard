'use strict';
angular.module('main')
.service('SoundProgress', function () {
  console.log('Hello from your Service: SoundProgress in module main');

  this.getProgress = function (sound) {
    if (typeof sound.currentTime === 'undefined') {
      console.log('sound object is not an audio element: ', sound);
      return;
    }

    console.log('getting sound progress');
    var maxTime = sound.duration,
        currentTime = sound.currentTime,
        soundProgress = Math.ceil((currentTime / maxTime) * 100);
    console.log('sound progress: ' + soundProgress);

    return soundProgress;
  };
});
