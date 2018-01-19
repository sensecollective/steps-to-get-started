#!/bin/bash

cp local_configs/{hosts.local,ssh-config.local} cfme-performance-01/cfme-performance/ansible/
cp local_configs/{hosts.local,ssh-config.local} cfme-performance-02/cfme-performance/ansible/
cp local_configs/{hosts.local,ssh-config.local} cfme-performance-03/cfme-performance/ansible/

cp local_configs/{all.local.yml,create_appliances.local.yml} cfme-performance-01/cfme-performance/ansible/group_vars/
cp local_configs/{all.local.yml,create_appliances.local.yml} cfme-performance-02/cfme-performance/ansible/group_vars/
cp local_configs/{all.local.yml,create_appliances.local.yml} cfme-performance-03/cfme-performance/ansible/group_vars/

cp local_configs/cfme_performance.local.yml cfme-performance-01/cfme-performance/cfme-performance/conf/
cp local_configs/cfme_performance.local.yml cfme-performance-02/cfme-performance/cfme-performance/conf/
cp local_configs/cfme_performance.local.yml cfme-performance-03/cfme-performance/cfme-performance/conf/
