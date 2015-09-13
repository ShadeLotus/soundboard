'use strict';
angular.module('main')
.directive('soundButton', function ($interval, SoundProgress, DEFAULT_PROGRESS_DELAY, SOUND_DIR) {
  return {
    template:
      '<div class="sound-button__button button button-positive">' +
        '<div class="sound-button__text"></div>' +
        '<div class="sound-button__progress">' +
          '<div class="sound-button__bar"></div>' +
        '</div>' +
      '</div>',
    restrict: 'E',
    scope: {
      soundAttr: '=sound'
    },
    link: function postLink (scope, element) {
      console.log('Sound directive');
      console.log('Sound attr: ', scope.soundAttr);
      console.log('Sound src: ', scope.soundAttr.src);

      var serviceData = {};
      serviceData.sound = new Audio(SOUND_DIR + '/' + scope.soundAttr.src);
      serviceData.buttonRootElement = element[0];
      serviceData.buttonContainerElement = serviceData.buttonRootElement.children[0];
      serviceData.buttonProgressElement = serviceData.buttonContainerElement.children[1];
      serviceData.buttonProgressBarElement = serviceData.buttonProgressElement.children[0];
      serviceData.buttonTextElement = serviceData.buttonContainerElement.children[0];

      console.log('serviceData.buttonProgressBarElement', serviceData.buttonProgressBarElement);
      console.log('serviceData.buttonProgressElement', serviceData.buttonProgressElement);

      serviceData.sound.loop = scope.soundAttr.loop;

      var hideStop = function () {
        serviceData.buttonTextElement.innerHTML = '';
        element.off('click', playStop);
      };

      var showStop = function () {
        console.log('show stop');
        serviceData.buttonTextElement.innerHTML = 'Stop';
        element.on('click', playStop);
      };

      var hidePlay = function () {
        console.log('hide play');
        serviceData.buttonTextElement.innerHtml = '';
        element.off('click', playStart);
      };

      var showPlay = function () {
        console.log('show play');
        serviceData.buttonTextElement.innerHTML = serviceData.sound.loop ? 'Loop' : 'Play';
        element.on('click', playStart);
      };

      var startProgressBar = function () {
        console.log('starting progress bar');
        updateProgressBar();
        serviceData.progressBarInterval = $interval(function () {
          updateProgressBar();
        }, DEFAULT_PROGRESS_DELAY);
      };

      var stopProgressBar = function () {
        console.log('stopping progress bar');
        updateProgressBar();
        $interval.cancel(serviceData.progressBarInterval);
      };

      var updateProgressBar = function () {
        serviceData.buttonProgressBarElement.style.width = SoundProgress.getProgress(serviceData.sound) + '%';
        console.log('updating progress bar', serviceData.buttonProgressBarElement.style.width);
      };

      var playStop = function () {
        var sound = serviceData.sound;
        console.log('stopping sound', sound);
        sound.pause();
        sound.currentTime = 0;
        hideStop();
        showPlay();
        stopProgressBar();
      };

      var playStart = function () {
        var sound = serviceData.sound;
        console.log('playing sound', sound);
        sound.play();
        hidePlay();
        showStop();
        if (!sound.loop) {
          sound.onended = function () {
            playStop();
          };
        }
        startProgressBar();
      };

      showPlay();
      element.on('click', playStart);
    }
  };
});
