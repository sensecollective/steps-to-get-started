#!/usr/bin/env node

// this example is taken from http://github.com/arcolife/sarjitsu

var request = require('request'),
	// grep = require('simple-grep'),
// api_endpoint = "http://172.17.0.4:5000/db/create/",
	exec = require('child_process').exec,
	ts_begin = "2015-06-22T14:20:44",
	ts_end = "2015-06-22T14:40:34" ,
	hostname = "benchserver2",
	sar_params = ["io_transfer_rate_stats","paging_stats","block_device","fs_mount_stats"];

var grep = function(what, where, callback){
	var exec = require('child_process').exec;

	exec("grep " + what + " " + where + " -nr", function(err, stdin, stdout){
		var list = {}

		var results = stdin.split('\n');

	    // remove last element (it’s an empty line)
	    results.pop();
	    for (var i = 0; i < results.length; i++) {
	    	var eachPart = results[i].split(':') //file:linenum:line
	    	list[eachPart[0]] = []
	    }
	    for (var i = 0; i < results.length; i++) {
	    	var eachPart = results[i].split(':') //file:linenum:line
	    	var details = {}
	    	var filename = eachPart[0]
	    	details['line_number'] = eachPart[1]

	    	eachPart.shift()
	    	eachPart.shift()
	    	details['line'] = eachPart.join(':')

	    	list[filename].push(details)
	    }


	    var results = []
	    var files = Object.keys(list)
	    for(var i = 0; i < files.length; i++){
	    	results.push({'file' : files[i], 'results' : list[files[i]]})
	    }

	    callback(results)
	});
}

grep('api_url = ', '/etc/sar-index.cfg', function(list){
	var _tmp = list[0].results[0];
	var line = _tmp.line_number + ":" + _tmp.line;
	var api_endpoint = line.split('api_url = ');
	console.log(api_endpoint);

	request.post(api_endpoint,
		{ json: {
			ts_beg: ts_begin,
			ts_end: ts_end,
			nodename: hostname.replace(/\n/g, ''),
			modes: sar_params.join(',')
		}
	},
	function (error, response, body) {
		if (!error && response.statusCode == 200) {
			console.log(JSON.stringify(body));
		}
		else {
			console.log("status: " + response.statusCode);
			console.log("error: \n" + error);
			console.log("body: \n" + JSON.stringify(body));
		}
	});
});
