#!/bin/bash

x="vmcapsule100.abc.com vmcapsule99.abc.com vmcapsule2.abc.com"; y=($x); 

# Method 1 
# (doesn't work in ansible 1.9.6). Refer:
# https://github.com/ansible/ansible/issues/16968
echo -e "\nMethod 1: Using \${#y[@]} we can get both count of elements and access an element by index"
echo ${#y[@]}; echo ${y[@]}; 
echo ${#y[0]} ${#y[1]} ${#y[2]}

# Method 2
echo -e "\nMethod 2: Using \${!y[@]} we can get the total count of elements in array using expr"
g=(${!y[@]});  res=`expr ${g[-1]} + 1`; echo $res
