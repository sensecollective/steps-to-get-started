#!/bin/bash

while [ "$1" != "" ]; do
    case $1 in
	-t | --tripleo_ip_address )
            shift
            tripleo_ip_address=$1
            ;;
	-h | --help )
	    usage
	    exit
	    ;;
	* )
	    echo "no args supplied"    
            usage
            exit 1
    esac
    shift
done

# while getopts "h?t:" opt;
# do
#     case "$opt" in
#         h|\?) usage
#               exit
#               ;;
#         t) shift
# 	   tripleo_ip_address=$1		  
# 	   ;;
#     esac
# done

echo "IP: $tripleo_ip_address"
if [ -z "$tripleo_ip_address" ]; then
    usage
    exit 1
fi
