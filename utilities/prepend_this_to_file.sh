#!/bin/bash


if [[ $# = 0 ]]; then
	echo '# example usage: ./prepend_this_to_file.sh "\#\!\/bin\/bash" opt_args_prac.sh'
	exit -1
fi

# sed -i '1s/^/\#\!\/usr\/bin\/env python2\n/' *.py
sed -i '1s/^/'$1'\n/' $2
