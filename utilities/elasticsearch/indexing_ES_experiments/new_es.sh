#!/bin/bash

# delete all data
curl -XDELETE 'http://0.0.0.0:9200/_all'; curl -XDELETE 'http://0.0.0.0:9200/_ingest/pipeline/*'; curl -XDELETE 'http://0.0.0.0:9200/_template/*'

# ?filter_path=*.version

# add template
curl -s -H 'Content-Type: application/json' -XPUT 'http://0.0.0.0:9200/_template/sarjitsu.sar-02' -d @/home/arcolife/template.json | json_pp

# "properties": {
#   "date": {
#     "format": "yyyy-MM-dd",
#     "type": "date"
#   },
#   "time": {
#     "format": "HH:mm:ss",
#     "type": "date"
#   }
# }

# add pipeline set processor for timestamp on index ingestion
curl -s -H 'Content-Type: application/json' -XPUT 'http://0.0.0.0:9200/_ingest/pipeline/timestamp' -d '
{
  "description" : "Adds a timestamp field at the current time",
  "processors" : [ {
    "set" : {
      "field": "recorded_on",
      "value": "{{_ingest.timestamp}}"
    }
  } ]
}'

curl -s -XGET 'http://0.0.0.0:9200/_ingest/pipeline/timestamp?pretty=true'

# sample data
# template is not strictly followed here..
curl -s -H 'Content-Type: application/json' -XPUT 'http://0.0.0.0:9200/sarjitsu.sar-test/sar/1?pipeline=timestamp' -d '{ "_metadata": { "_metadata" : { "number-of-cpus": "cpu-2"}, "foo": "bar", "recorded_on": "2017-12-22T11:20:26.666Z" } }'

# # sample data without pipeline
# curl -s -H 'Content-Type: application/json' -XPUT 'http://0.0.0.0:9200/sarjitsu.sar-test/sar/1?pipeline=timestamp' -d '{ "_metadata": { "sysname" : "sdsd", "test": "bs" } }'

# grafana's search format
# https://www.elastic.co/guide/en/elasticsearch/reference/current/search-multi-search.html
curl -s -H 'Content-Type: application/x-ndjson' -XGET 'http://0.0.0.0:9200/_msearch?pretty=true' --data-binary "@/home/arcolife/msearch.json" | grep value | grep -v null

# get indices
curl http://0.0.0.0:9200/_cat/indices?v
