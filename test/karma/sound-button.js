'use strict';

describe('Directive: soundButton', function() {
  var element,
    scope;

  var audioMock = {
    play: function () { return true; },
    pause: function () { return true; }
  };

  beforeEach(module('main'));
  beforeEach(inject(function($rootScope, $compile) {
    window.Audio = function(src) {
      audioMock.src = src;
      return audioMock;
    };

    element = angular.element('<div class="well span6">' +
      '<h3>Sounds:</h3>' +
      '<sound-button sound="{{sound}}">' +
      '</sound-button></div>');

    scope = $rootScope;
    scope.sound = 'nobell.mp3';

    $compile(element)(scope);
    scope.$digest();
  }));

  it("should play and pause on click", function() {
    spyOn(audioMock, 'play');
    spyOn(audioMock, 'pause');

    angular.forEach(element.find('sound-button'), function(e) {
      expect(audioMock.src).toBe(e.getAttribute('sound'));

      var ngElement = angular.element(e);
      ngElement.triggerHandler('click');
      expect(audioMock.play).toHaveBeenCalled();
      ngElement.triggerHandler('click');
      expect(audioMock.pause).toHaveBeenCalled();
      expect(audioMock.currentTime).toBe(0);
    });
  });
});
