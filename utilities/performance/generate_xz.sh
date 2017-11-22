#!/bin/bash

tar -cf - $1 | xz -9 -c - > ${1%/}.tar.xz

