// features/support/world.js
require('dotenv').load();
var zombie = require('zombie');
var fork = require('child_process').fork;

function World(callback) {
  //TODO: bootstrap api with test database
  var child = fork('SOUNDBOARD_DATASOURCE=testDb node ' . process.env.API_APP_PATH);

  // setup helper for wiping the database
  // hrm so what's the best way to make a global method for cucumber...
  // looks like it might be to attach it to 'this'
  //basically, we want to make a custom datasource and... wipe it... between tests
  //sails disk should be fine for this

  this.browser = new zombie(); // this.browser will be available in step definitions

  this.visit = function (url, callback) {
    this.browser.visit(url, callback);
  };

  callback(); // tell Cucumber we're finished and to use 'this' as the world instance
}
module.exports.World = World;
