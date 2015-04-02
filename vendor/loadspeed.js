var page    = require('webpage').create();
var system  = require('system');
var address = system.args[1];
var t = Date.now();

page.open(address, function(status) {
  if (status !== 'success') {
    console.log('not_found');
  } else {
    t = Date.now() - t;
    console.log(t);
  }
  phantom.exit();
});