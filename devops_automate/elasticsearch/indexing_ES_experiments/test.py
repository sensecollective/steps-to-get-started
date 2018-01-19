#!/usr/bin/env python3

import sys

PROJECT_LOC='/home/arcolife/workspace/utils/RH/ARCO/Forked/pbench/server/pbench/'
sys.path.append("%s/lib/vos/analysis/" % PROJECT_LOC)

from lib.index_sar import  *

# call_indexer(file_path='/home/arcolife/Desktop/sar_samples/sar.xml',
#             _nodename='perf14', cfg_name='/etc/pbench-index.cfg')


# call_indexer(file_path='/tmp/fio_analyzer_iodepth:32_type:native_io:aio_run:2-IOPS:write-debugger:perf_kvm_record__2016-02-05_09:37:22/1-write-4KiB/sample1/tools-default/localhost/sar/sar.data.xml',
#             _nodename='localhost.localdomain', cfg_name='/etc/pbench-index.cfg')


call_indexer(file_path='/home/arcolife/sar.xml',
            _nodename='localhost.localdomain', cfg_name='/etc/pbench-index.cfg',
            #_nodename='perf14', cfg_name='/etc/pbench-index.cfg',
            run_md5='2e2e8933451409eeda920ab6c35f7cde',
            run_unique_id='ARCO_TEST_UNIQ')
