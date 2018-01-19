#!/usr/bin/env node

if (!process.argv[2]) {
    console.log("you're supposed to supply path to an ES mapping json file");
    process.exit(-1);
}
console.log("processing file: " + process.argv[2]);

var fields = {},
    fs = require('fs'),
    _ = require('underscore'),
    obj = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'));

//console.log(obj.aggregations[4]['buckets']);
//console.log(_.where(obj.aggregations[4]['buckets'], {doc_count: 6}));
//console.log(_.findWhere(, {doc_count: 6}));

processBuckets = function(aggs) {
    for (aggId in aggs) {
	aggDef = _.findWhere(aggs, {id: aggId});
	esAgg = aggs[aggId];
	console.log(aggDef);
	if (!aggDef) {
	    continue;
	}
	processBuckets(esAgg);
    }
};

processBuckets(obj.aggregations[4]['buckets'])
