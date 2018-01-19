#!/bin/bash

# awk -f count.awk /var/log/httpd/access_log
awk -f count.awk ./access_log
