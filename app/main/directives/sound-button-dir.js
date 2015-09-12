'use strict';
angular.module('main')
.directive('soundButton', function ($interval, SoundProgress, DEFAULT_PROGRESS_DELAY, SOUND_DIR) {
  return {
    template: '<div class="sound-button button button-positive"><div class="button-text">Play</div></div>',
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
      serviceData.buttonTextContainerElement = serviceData.buttonRootElement.firstChild;
      serviceData.buttonTextElement = serviceData.buttonTextContainerElement.firstChild;

      serviceData.sound.loop = scope.soundAttr.loop;

      var hideStop = function () {
        serviceData.buttonTextElement.innerHTML = '';
        element.off('click', playStop);
      };

      var showStop = function () {
        serviceData.buttonTextElement.innerHTML = 'Stop';
        element.on('click', playStop);
      };

      var hidePlay = function () {
        serviceData.buttonTextElement.innerHtml = '';
        element.off('click', playStart);
      };

      var showPlay = function () {
        serviceData.buttonTextElement.innerHTML = 'Play';
        element.on('click', playStart);
      };

      var createProgressBar = function () {
        var bar = document.createElement('div');
        bar.classList.add('progress');
        serviceData.buttonRootElement.appendChild(bar);
        serviceData.progressBarElement = bar;
        updateProgressBar();
      };

      var startProgressBar = function () {
        console.log('starting progress bar');
        createProgressBar();
        serviceData.progressBarInterval = $interval(function () {
          updateProgressBar();
        }, DEFAULT_PROGRESS_DELAY);

      };

      var stopProgressBar = function () {
        console.log('stopping progress bar');
        serviceData.progressBarElement.remove();
        delete serviceData.progressBarElement;
        $interval.cancel(serviceData.progressBarInterval);
      };

      var updateProgressBar = function () {
        serviceData.progressBarElement.width = SoundProgress.getProgress(serviceData.sound) + '%';
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
        startProgressBar();
      };
      element.on('click', playStart);
    }
  };
});
