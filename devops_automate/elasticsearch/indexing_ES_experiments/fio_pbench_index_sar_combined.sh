#!/bin/bash

#ES_HOST="localhost:9200"

ES_URL=`egrep '^host\s?=.*' /etc/pbench-index.cfg | awk -F' ' '{print $NF}'`
ES_PORT=`egrep '^port\s?=.*' /etc/pbench-index.cfg | awk -F' ' '{print $NF}'`
ES_HOST=$ES_URL:$ES_PORT
echo $ES_HOST


echo -e "\n....removing last ES indexed results to avoid bug."
curl -XDELETE $ES_HOST/pbench*

#./run_pbench_test_es_index.sh /var/lib/pbench-agent/fio_analyzer_iodepth\:32_type\:native_io\:aio_run\:2-IOPS\:write-debugger\:perf_kvm_record__2016-02-05_09\:37\:22/

./run_pbench_test_es_index.sh /var/lib/pbench-agent/sysbench_MariaDB_MultiVM_AIO_native_OLTP_6000_2016-05-19_19\:45\:59/
# pbench indexes sar data as well.
#./sar_test_pbench_es.sh
