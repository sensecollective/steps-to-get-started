#!/bin/bash

strace -f bash -c 'df -hT'
# found out that my keybase.mount service was causing the
# delay in output of df -hT.. 
# this was because there was a statfs('/keybase') pending,
# for NFS (network) based mount point

# for PID 1234, trace write() syscalls which tells what the process is printing
# https://unix.stackexchange.com/questions/58550/how-to-view-the-output-of-a-running-process-in-another-bash-session
# find pid via `ps afx`. Would lie somewhere near the end
strace -p1234 -s9999 -e write

