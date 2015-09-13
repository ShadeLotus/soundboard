// spec.js
describe('Protractor Demo App', function () {
  it('should have a title', function () {
    browser.get('http://localhost:9000');

    expect(browser.getTitle()).toEqual('Soundboard');
  });

  it('should change buttons and sounds with new option', function () {
    console.log('asdfasdf: ', element(by.model('soundPackage')));
    element(by.model('soundPackage'))
      .findElements(by.tagName('option'))
      .then(function (options) {
        options[0].click();
        element
          .findElements(by.tagName('sound-button'))
          .then(function (soundButtons) {
            var buttonsBefore = [];
            var soundsBefore = [];
            for (buttonIndex in soundButtons) {
              var button, sound;
              button = buttonsBefore[buttonIndex] = soundButtons[buttonIndex];
              sound = soundsBefore[buttonIndex] = button.evaluate('sound');
              expect(sound.src).toBeDefined();
              expect(sound.loop).toBeDefined();
            }
            options[1].click();
            element
              .findElements(by.tagName('sound-button'))
              .then(function (soundButtons) {
                var buttonsAfter = [];
                var soundsAfter = [];
                for (buttonIndex in soundButtons) {
                  var button, sound;
                  button = buttonsAfter[buttonIndex] = soundButtons[buttonIndex];
                  sound = soundsAfter[buttonIndex] = button.evaluate('sound');
                  expect(sound.src).toBeDefined();
                  expect(sound.loop).toBeDefined();
                }

                expect(buttonsAfter === buttonsBefore).toBeFalsey();
                expect(soundsAfter === soundsBefore).toBeFalsey();
              });
          });
      });
  });
});
