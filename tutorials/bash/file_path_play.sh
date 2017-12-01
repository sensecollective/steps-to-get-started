#!/bin/bash

if [ -z $1 ]; then
	file_path=/home/arcolife/a.txt 
else
	file_path=$1
fi

file_name=$(basename $file_path)
dir_name=$(dirname $file_path )
extension=${file_path#*.}
file_name_wo_ext="${file_name%.$extension}"

echo "Filepath=$file_path"
echo "File Name: $file_name"
echo "Dir name: $dir_name"
echo "Extension: $extension"
echo "File Name without extension: $file_name_wo_ext"

# $ ./file_ops.sh ~/a.txt 

# Filepath=/home/arcolife/a.txt
# File Name: a.txt
# Dir name: /home/arcolife
# Extension: txt
# File Name without extension: a

# ----------------------------------------------

# $ ./file_ops.sh ~/mlcc_tool.tar.xz 

# Filepath=/home/arcolife/tool.tar.xz
# File Name: tool.tar.xz
# Dir name: /home/arcolife
# Extension: tar.xz
# File Name without extension: tool
