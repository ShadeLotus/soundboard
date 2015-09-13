'use strict';
angular.module('main')
.directive('soundList', function ($compile, DEFAULT_PACKAGE_NAME) {
  return {
    templateUrl: 'main/templates/sound-list.html',
    priority: 1000,
    terminal: true,
    scope: {
      packages: '='
    },
    link: function postLink (scope, element) {
      scope.soundPackage = scope.packages[DEFAULT_PACKAGE_NAME];
      $compile(element.contents())(scope);
    }
  };
});
