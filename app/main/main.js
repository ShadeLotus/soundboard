'use strict';
angular.module('main', [
  'ionic',
  'ngCordova',
  'ui.router',
  // TODO: load other modules selected during generation
])
.config(function ($stateProvider, $urlRouterProvider) {

  console.log('Allo! Allo from your module: ' + 'main');

  // ROUTING with ui.router
  $urlRouterProvider.otherwise('/main/sound');
  $stateProvider
    // this state is placed in the <ion-nav-view> in the index.html
    .state('main', {
      url: '/main',
      abstract: true,
      controller: '',
      templateUrl: 'main/templates/tabs.html'
    })
      .state('main.sound', {
        url: '/sound',
        views: {
          'tab-list': {
            templateUrl: 'main/templates/sound.html',
            controller: 'SoundCtrl as ctrl'
          }
        }
      })
      .state('main.moreSound', {
        url: '/more-sound',
        views: {
          'tab-debug': {
            templateUrl: 'main/templates/more-sound.html',
            controller: 'DebugCtrl as ctrl'
          }
        }
      });
});
