var page = require('webpage').create();
page.open('http://work.arcolife.in', function() {
  page.render('exammple.jpg');
  phantom.exit();
});

