'use strict';
angular.module('main')
.service('Api', function (API_SERVER) {

  console.log('Hello from your Service: Api in module main');
  // TODO: do your service thing
  var ctrl = this;

  ctrl.getPackages = function () {
    return $http.get(API_SERVER + '/packages');
  };
});
