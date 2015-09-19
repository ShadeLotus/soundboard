'use strict';
angular.module('Soundboard', [
  'ngMockE2E',
  'main'
])
.run(function ($httpBackend, API_SERVER) {
  $httpBackend
    .whenGET(API_SERVER + '/packages')
    .respond({
      default: {
        sounds: [
          {loop: true, src: 'default/bell.mp3'},
          {loop: true, src: 'default/bell.mp3'},
          {loop: false, src: 'default/bell.mp3'},
          {loop: false, src: 'default/bell.mp3'}
        ]
      },
      christmas: {
        sounds: [
          {loop: false, src: 'default/bell.mp3'},
          {loop: false, src: 'default/bell.mp3'},
          {loop: true, src: 'default/bell.mp3'},
          {loop: true, src: 'default/bell.mp3'}
        ]
      }
    });

  $httpBackend.whenGET(/templates/).passThrough();
});
