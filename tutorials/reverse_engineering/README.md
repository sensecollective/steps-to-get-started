## How-to

Run this for compiling a program and seeing effects of overriding a library call

```
$ ./compile_libs.sh
```

It does the following:

1. compiles a sample C program called `my_prog`
2. compiles a custom C library made by us, called `library_strcmp.c`, into `mylibrary.so`
3. sets `LD_LIBRARY_PATH` to current working dir
4. sets `LD_PRELOAD` to `$PWD/mylibrary.so` and runs `./my_prog`
5. Above steps give different outputs before and after we override `strcmp` library call, included in step 4.

The output is as follows:

```sh
..Running program with default strcmp()
String are not matched

..Running program with overridden strcmp() from mylibrary.so
Strings are matched
```

### deducing library calls and symbols from an ELF (binary file) 

```
$ ./reverse_engineer_deduct_symbols.sh
```

shows output from `nm` command, for the compiled binary `my_prog`
..before and after running `strip` command included
inside the script `reverse_engineer_deduct_symbols.sh`

Output as follows:

```sh
Compiling binary...
my_prog.c: In function ‘main’:
my_prog.c:5:6: warning: implicit declaration of function ‘strcmp’ [-Wimplicit-function-declaration]
   if(strcmp(str1,str2)) {
      ^~~~~~
extracting symbols from a non-stripped binary file (size is greater than a stripped one)
Symbols saved to ./my_prog_symbols
Extracting strings from non-stripped binary file, into ./my_prog_strings
Size of binary right now:-
 -> 8536
Stripping binary file
Size of binary after stripping symbols from ELF :-
 -> 6224
Attempting to extract symbols from *stripped* binary file
nm: my_prog: no symbols
Compiling again and overwriting my_prog
my_prog.c: In function ‘main’:
my_prog.c:5:6: warning: implicit declaration of function ‘strcmp’ [-Wimplicit-function-declaration]
   if(strcmp(str1,str2)) {
      ^~~~~~
reading from readelf with -s instead of nm
info stored in ./my_prog_readelf_info
stripping with -s
..and reading symbols from readelf again
info stored in ./my_prog_readelf_info_stripped
storing addresses of .bss, .text, .data for my_prog
stored in ./addresses_of_memory_regions 
   text	   data	    bss	    dec	    hex	filename
   1319	    548	      4	   1871	    74f	my_prog
```

## References

For usage of strace, ltrace etc.. with `my_prog`, refer to these links:

- http://www.thegeekstuff.com/2012/09/strip-command-examples/
- http://www.thegeekstuff.com/2012/03/reverse-engineering-tools/
