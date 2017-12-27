#!/bin/bash

curl -XDELETE http://localhost:9601/pbench.sar*
# ES_PORT=`grep port /etc/pbench-index.cfg | awk -F' ' '{print $NF}'`
# ES_HOST=`grep host /etc/pbench-index.cfg | awk -F' ' '{print $NF}'`

# curl -XDELETE $ES_HOST:$ES_PORT/pbench.sar*
echo

# PROJECT_LOC='/home/arcolife/workspace/utils/RH/ARCO/Forked/pbench/server/pbench/'
#PYTHONPATH=${PROJECT_LOC%/}/lib/vos/analysis/:$PYTHONPATH
./test.py
