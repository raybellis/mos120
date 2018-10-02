#!/bin/sh

/bin/rm -rf lst objs
mkdir -p objs lst rom

file=mos120.s
name=`basename $file .s`

cat src/*.s > ${file}
ca65 -U $file -o objs/${name}.o -l lst/${name}.lst

ld65 -t bbc -o rom/mos120.rom objs/*.o
