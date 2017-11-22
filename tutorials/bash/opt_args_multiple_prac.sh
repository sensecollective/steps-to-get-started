#!/usr/bin/env bash
set -o errexit -o noclobber -o nounset -o pipefail
params="$(getopt -o ab:c -l alpha,bravo:,charlie --name "$0" -- "$@")"
eval set -- "$params"

while true
do
    case "$1" in
	-a|--alpha)
	    echo alpha
	    shift
	    ;;
	-b|--bravo)
	    echo "bravo=$2"
	    shift 2
	    ;;
	-c|--charlie)
	    echo charlie
	    shift
	    ;;
	--)
	    shift
	    break
	    ;;
	*)
	    echo "Not implemented: $1" >&2
	    exit 1
	    ;;
    esac
done
