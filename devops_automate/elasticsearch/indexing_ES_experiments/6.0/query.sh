#!/bin/bash

curl -s -H 'Content-Type: application/json' -XPOST http://localhost:9200/_search -d @context_switch.json  | json_pp
# ./query.sh  | egrep  '"value" : (?!n)'

curl -s -H 'Content-Type: application/json' -XPOST http://localhost:9200/_search -d @network.json  | json_reformat

