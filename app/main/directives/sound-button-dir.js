'use strict';
angular.module('main')
.directive('soundButton', function ($interval, SoundProgress, DEFAULT_PROGRESS_DELAY) {
  return {
    controller: 'SoundButtonCtrl as ctrl',
    template: '<div class="sound-button button button-positive"><div class="button-text">Play</div></div>',
    restrict: 'E',
    scope: {
      soundAttr: '=',
      delay: '@'
    },
    link: function postLink (scope, element, attrs) {
      var directive = this;
      var sound = new Audio(soundAttr.src);
      var progress = new SoundProgress(sound);
      var buttonRootElement = element[0];
      var buttonTextContainerElement = buttonRootElement.firstChild;
      var buttonTextElement = buttonTextContainerElement.firstChild;
      var delay = delay || DEFAULT_PROGRESS_DELAY;

      sound.loop = soundAttr.loop;

      var hideStop = function () {
        buttonTextElement.innerHTML = '';
        element.off('click', playStop);
      };

      var showStop = function () {
        buttonTextElement.innerHTML = 'Stop';
        element.on('click', playStop);
      };

      var hidePlay = function () {
        buttonTextElement.innerHtml = '';
        element.off('click', playStart);
      };

      var showPlay = function () {
        buttonTextElement.innerHTML = 'Play';
        element.on('click', playStart);
      };

      var createProgressBar = function () {
        var bar = document.createElement('div');
        bar.classList.add('progress');
        buttonRootElement.appendChild(bar);
        directive.progressBarElement = bar;
        updateProgressBar();
      };

      var startProgressBar = function () {
        createProgressBar();
        directive.progressBarInterval = $interval(function () {
          updateProgressBar();
        }, delay);

      };

      var stopProgressBar = function () {
        directive.progressBarElement.remove();
        delete directive.progressBarElement;
        directive.progressBarInterval.cancel();
      };

      var updateProgressBar = function () {
        directive.progressBarElement.width = progress.getProgress() + '%';
      };

      var playStop = function () {
        console.log('stopping sound', sound);
        sound.pause();
        sound.currentTime = 0;
        hideStop();
        showPlay();
        stopProgressBar();
      };

      var playStart = function () {
        console.log('playing sound', sound);
        playStart();
        sound.play();
        hidePlay();
        showStop();
        startProgressBar();
      };
      element.on('click', playStart);
    }
  };
});
