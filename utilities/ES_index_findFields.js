#!/usr/bin/env node

if (!process.argv[2]) {
	console.log("you're supposed to supply path to an ES mapping json file");
	process.exit(-1);
}
console.log("processing file: " + process.argv[2]);

var fields = {},
		fs = require('fs'),
		obj = JSON.parse(fs.readFileSync(process.argv[2], 'utf8')),
		query = {type: 'number'},
		typeMap = {
			'float': 'number',
			'double': 'number',
			'integer': 'number',
			'long': 'number',
			'date': 'date',
			'string': 'string',
			'nested': 'nested'
		};

function AutocompleteSearchFields(doc, pre) {
	for (var field in doc) {
		var prop = doc[field];
		if (!prop.hasOwnProperty('type') && prop.hasOwnProperty('properties')) {
			// eg: hugepages
			for (var subfield in prop.properties) {
				var subfield_prop = prop.properties[subfield];
				if (pre) {
					new_pre = pre + '.' + field + '.' + subfield;
				} else {
					new_pre = field + '.' + subfield;
				}
				if (query.type && typeMap[subfield_prop.type] !== query.type) {
					// if (subfield_prop.type == 'nested') {
					AutocompleteSearchFields(subfield_prop.properties, new_pre);
					// } else {
					//     console.log("invalid subfield: " + subfield + '--' + subfield_prop.type);
					//     continue;
					// }
				}
				if (subfield_prop.type && subfield[0] !== '_') {
					if (query.type && typeMap[subfield_prop.type] == query.type) {
						fields[new_pre] = {text: new_pre, type: subfield_prop.type};
					}
				}
			}
		} else if (prop.hasOwnProperty('type') && prop.hasOwnProperty('properties')) {
			// eg: disk / nested docs || TODO: handle later
			if (pre) {
				new_pre = pre + '.' + field;
			} else {
				new_pre = field;
			}
			AutocompleteSearchFields(prop.properties, new_pre);
		} else if (prop.hasOwnProperty('type') && !prop.hasOwnProperty('properties')) {
			// eg: default grafana case handle (just type present. no subfields)
			if (query.type && typeMap[prop.type] !== query.type) {
				continue;
			}
			if (prop.type && field[0] !== '_') {
				if (pre) {
					new_pre = pre + '.' + field;
				} else {
					new_pre = field;
				}
				fields[new_pre] = {text: new_pre, type: prop.type};
			}
		}
	}
}


for (var indexName in obj) {
	var index = obj[indexName];
	var mappings = index.mappings;
	if (!mappings) { continue; }
	for (var typeName in mappings) {
		var properties = mappings[typeName].properties;
		AutocompleteSearchFields(properties, '');
	}
}

console.log(fields);
console.log("\ntotal field paths found: " + Object.keys(fields).length);
