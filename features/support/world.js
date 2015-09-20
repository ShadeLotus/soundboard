// features/support/world.js
require('dotenv').load();
var zombie = require('zombie');
var fork = require('child_process').fork;

function World(callback) {
  var child;

  // helper for init'ing the API with a fresh test database
  this.refreshApi = function() {
    if (child) {
      child.kill();
    }
    child = fork('SOUNDBOARD_DATASOURCE=testDb SOUNDBOARD_MIGRATE=drop node ' . process.env.API_APP_PATH);
  }

  this.browser = new zombie(); // this.browser will be available in step definitions

  this.visit = function (url, callback) {
    this.browser.visit(url, callback);
  };

  callback(); // tell Cucumber we're finished and to use 'this' as the world instance
}
module.exports.World = World;
