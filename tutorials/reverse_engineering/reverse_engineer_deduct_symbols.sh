#!/bin/bash

echo "Compiling binary..."
./compile_libs.sh 2>&1  >> /dev/null

echo "extracting symbols from a non-stripped binary file (size is greater than a stripped one)"
nm my_prog 2>&1 > my_prog_symbols

op=$(grep "no symbols" my_prog_symbols)
if [[ -z $op ]]; then
    echo "Symbols saved to ./my_prog_symbols"
else
    echo $op
fi

echo "Extracting strings from non-stripped binary file, into ./my_prog_strings"
strings my_prog > my_prog_strings

echo -e "Size of binary right now:-\n -> $(stat  my_prog -c %s)"

echo "Stripping binary file"
strip my_prog

echo -e "Size of binary after stripping symbols from ELF :-\n -> $(stat my_prog -c %s)"

echo "Attempting to extract symbols from *stripped* binary file"
nm my_prog
# echo "No symbols found!"
