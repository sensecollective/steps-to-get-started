#!/bin/bash

cc -o my_prog my_prog.c
echo "..Running program with default strcmp()"
./my_prog 

cc -o mylibrary.so -shared library_strcmp.c -ldl

LD_LIBRARY_PATH=./:$LD_LIBRARY_PATH

# this doesn't work
# LD_PRELOAD=mylibrary.so ./my_prog

# output: 
# > ERROR: ld.so: object 'mylibrary.so' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored.
# > String are not matched


# ..this works. Reason: LD_PRELOAD needs full paths. Debug as follows:

# # LD_DEBUG=files LD_PRELOAD=./mylibrary.so ./my_prog
# v/s
# # LD_DEBUG=files LD_PRELOAD=$PWD/mylibrary.so ./my_prog

echo -e "\n..Running program with overridden strcmp() from mylibrary.so"
LD_PRELOAD=$PWD/mylibrary.so ./my_prog 

# output: 
# > Strings are matched
