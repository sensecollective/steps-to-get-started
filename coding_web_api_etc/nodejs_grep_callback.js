#!/usr/bin/env node
// install: $ npm install simple-grep

var grep = require('simple-grep');
var test_var = "archit";
var test_var_2 = "fullmetal";
var xyz_endpoint = '';

function callback(ff){
  grep('UUID', '/etc/fstab', function(list, callback){
    var _tmp = list[0].results[0];
    var line = _tmp.line_number + ":" + _tmp.line;
    xyz_endpoint = line.split('UUID=')[1];
    console.log('inside: ' + xyz_endpoint + " -- " + test_var + " -- " + test_var_2);
    ff();
  });
};

callback(function(){
  console.log('outside: ' + xyz_endpoint + " -- " + test_var + " -- " + test_var_2);
  console.log('super: ' + xyz_endpoint + " -- " + test_var + " -- " + test_var_2);
});
