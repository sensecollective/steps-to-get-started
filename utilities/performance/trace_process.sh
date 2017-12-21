#!/bin/bash

strace -f bash -c 'df -hT'
# found out that my keybase.mount service was causing the
# delay in output of df -hT.. 
# this was because there was a statfs('/keybase') pending,
# for NFS (network) based mount point
