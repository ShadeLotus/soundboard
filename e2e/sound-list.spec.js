// spec.js
describe('Protractor Demo App', function () {
  it('should have a title', function () {
    browser.get('http://localhost:9000');

    expect(browser.getTitle()).toEqual('Soundboard');
  });

  it('should change buttons and sounds with new option', function () {
    element
      .all(by.tagName('option'))
      .then(function (options) {
        options[0].click();
        element
          .all(by.tagName('sound-button'))
          .then(function (soundButtons) {
            var buttonsBefore = [];
            var soundsBefore = [];
            for (buttonIndex in soundButtons) {
              var button, sound;
              button = buttonsBefore[buttonIndex] = soundButtons[buttonIndex];
              sound = soundsBefore[buttonIndex] = button.evaluate('sound');
              console.log('sound: ', button);
              expect(sound.src).toBeDefined();
              expect(sound.loop).toBeDefined();
            }
            options[1].click();
            element
              .all(by.tagName('sound-button'))
              .then(function (soundButtons) {
                expect(soundButtons[0].getText()).toEqual('Play');
                expect(soundButtons[1].getText()).toEqual('Play');
                expect(soundButtons[2].getText()).toEqual('Loop');
                expect(soundButtons[3].getText()).toEqual('Loop');

                expect(buttonsAfter === buttonsBefore).toBeFalsey();
                expect(soundsAfter === soundsBefore).toBeFalsey();
              });
          });
      });
  });
});
