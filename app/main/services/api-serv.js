'use strict';
angular.module('main')
.service('Api', function (API_SERVER, $http, $q) {

  console.log('Hello from your Service: Api in module main');
  // TODO: do your service thing
  var ctrl = this;

  ctrl.getPackages = function () {
    return $q(function (resolve, reject) {
      $http.get(API_SERVER + '/packages').then(
        function (responseSuccess) {
          resolve(responseSuccess.data);
        },
        function (responseFailure) {
          reject(responseFailure);
        });
    });
  };
});
