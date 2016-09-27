#!/bin/bash

scp -F cfme-performance/ansible/ssh-config.local\
    cfme-performance/ansible/{hosts.local,ssh-config.local} \
    cfme-performance/ansible/group_vars/{all.local.yml,create_appliances.local.yml} \
    cfme-performance/cfme-performance/conf/cfme_performance.local.yml \
    root@HOSTNAME_WORKLOAD:/root/local_configs/

scp -F cfme-performance/ansible/ssh-config.local\
    cfme-performance/ansible/{hosts.local,ssh-config.local} \
    cfme-performance/ansible/group_vars/{all.local.yml,create_appliances.local.yml} \
    cfme-performance/cfme-performance/conf/cfme_performance.local.yml \
    archit@APACHE_HOST:~/cloudforms/
