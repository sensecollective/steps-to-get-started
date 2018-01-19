#!/bin/bash

curl -XPOST http://172.17.0.2:9200/_all/_search?pretty=true -d @multi_type_pbench-run_and_sar.json

