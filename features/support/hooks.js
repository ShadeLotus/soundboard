var myHooks = function () {
  this.Before(function (callback) {
    this.resetApi();

    // Don't forget to tell Cucumber when you're done:
    callback();
  });
};
