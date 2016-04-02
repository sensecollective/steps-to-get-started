#!/bin/bash

# while getopts "h?vf:" opt; do
#     case "$opt" in
# 	h|\?)
# 	    echo "Usage: $0 [-v] [-f seplist] file ..."
# 	    exit 0
# 	    # exit 1;;
# 	    ;;
# 	v)  echo "hi"
# 	    ;;
# 	f)  echo "${types[$OPTARG]}"
# 	    ;;
#     esac
# done

declare -A skim_types=([0]="skim_native" [1]="skim_threads")

while getopts "h?t:p:" opt; do
    case "$opt" in
	h|\?)
	    echo "Usage: $0 [-t skim for native/threads] [0|1] ..."
	    exit 0
	    ;;
	t)  skim_type=${skim_types[$OPTARG]}
	    ;;
	p)  DUMP_PATH=$OPTARG
		;;
    esac
done

echo $DUMP_PATH
grep "^$skim_type" /etc/delta_processor.conf
