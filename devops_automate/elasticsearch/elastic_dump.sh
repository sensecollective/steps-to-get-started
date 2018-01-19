#!/bin/bash

index_name="$1"

# Copy an index from production to staging with mappings:
# elasticdump \
#     --input=http://172.17.0.2:9200/$index_name \
#     --output=http://localhost:9200/$index_name \
#     --type=mapping

elasticdump \
    --input=http://172.17.0.2:9200/$index_name \
    --output=http://localhost:9200/satjitsu.sar \
    --type=data
