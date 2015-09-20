module.exports = function() {
  this.Given(/^the user's email is "([^"]*)"$/, function (arg1, callback) {
    // Write code here that turns the phrase above into concrete actions
    callback.pending();
  });

  this.When(/^the user successfully completes an oauth request$/, function (callback) {
    // Write code here that turns the phrase above into concrete actions
    callback.pending();
  });

  this.Then(/^an accessToken should be saved for the user$/, function (callback) {
    // Write code here that turns the phrase above into concrete actions
    callback.pending();
  });
}
