'use strict';
angular.module('main')
.controller('SoundButtonCtrl', function () {

  console.log('Hello from your Controller: SoundButtonCtrl in module main:. This is your controller:', this);

  // what are we doing?
  // we want to access the 'sound' object
  // we want our controller to provide sound object to our directive
  // sound objects seem to exist in the SoundCtrl
  // why and how do we get them into the soundButton controller?
  // we can get them in through controller inheritance maybe?
  // we can get them in via binding them onto the directive which is ideal
  // ng-repeat a container object.  Though, a container object is what I wanted to avoid.  Why?
  // can ng-repeat be used as an element?  Will it transclude and thus no need for a container?
  // let's find out. -- no we cannot use ng-repeat as an element
});
