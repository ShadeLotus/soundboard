module.exports = function () {
  this.World = require("../support/world.js").World; // overwrite default World constructor

  this.Given(/^the google email address for the user does not exist$/, function (callback) {
    return this.visit('');
  });

  this.When(/^the user successfully completes an oauth request$/, function (callback) {
    callback.pending();
  });

  this.Then(/^an accessToken should be saved for the user$/, function (title, callback) {
    var pageTitle = this.browser.text('title');
    if (title === pageTitle) {
      callback();
    } else {
      callback.fail(new Error("Expected to be on page with title " + title));
    }
  });
};
