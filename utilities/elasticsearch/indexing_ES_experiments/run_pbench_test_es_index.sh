#! /bin/bash
# -*- mode: shell-script -*-

# Handy script to test pbench's ES based indexing functionality.
# Author: Archit Sharma <archit.py@gmail.com>

# Usage:
# ./es_test_index.sh <sample fio run maybe>.tar.xz

# NOTE: This script is meant to run under:
# <pbench project root>/server/pbench/bin
# ...also, be sure to copy the config file and make your own under:
# <pbench project root>/server/pbench/lib/config/pbench-index.cfg
# (i.e, supply ES instance url) and change the same below in ES_HOST

# ES_HOST="localhost:9200"

ES_URL=`egrep '^host\s?=.*' /etc/pbench-index.cfg | awk -F' ' '{print $NF}'`
ES_PORT=`egrep '^port\s?=.*' /etc/pbench-index.cfg | awk -F' ' '{print $NF}'`
ES_HOST=$ES_URL:$ES_PORT
echo $ES_HOST

PROJECT_LOC='/home/arcolife/workspace/utils/RH/ARCO/Forked/pbench/server/pbench/'
# PROJECT_LOC='/home/arcolife/workspace/utils/RH/PERF_DEPT/DSA/pbench/server/pbench/'
# ElasticSearch version must be less than 2.0

# echo -e "\n....removing last ES indexed results to avoid bug."
# curl -XDELETE $ES_HOST/pbench*

_HOSTNAME=`grep controller ${1%/}/metadata.log | awk -F' ' '{print $2}'`
echo -e "\n....compressing results for $_HOSTNAME"

tar cfJ /tmp/$(basename "$1").tar.xz --directory=$(dirname "$1") $(basename "$1")
echo -e "\n....generating md5"
md5sum /tmp/$(basename "$1").tar.xz | awk -F' ' '{print $1}' > \
                                                /tmp/$(basename "$1").tar.xz.md5

echo -e "\n....indexing"

PYTHONPATH=$PROJECT_LOC/lib/:$PYTHONPATH ${PROJECT_LOC%/}/bin/index-pbench \
    --config /etc/pbench-index.cfg /tmp/$(basename "$1").tar.xz

echo -e "\n....cleaning up"
rm /tmp/$(basename "$1").tar.xz /tmp/$(basename "$1").tar.xz.md5

echo -e "\nComplete!"

#
# LC_ALL=C ../lib/vos/analysis/bin/sadf-<verison for that sa file> -x <path to safile> --  -A  > sar.xml
