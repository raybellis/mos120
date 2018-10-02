#!/bin/sh

/bin/rm -rf lst objs
mkdir -p objs lst rom

for file in src/*.s inc/*.s; do
	name=`basename $file .s`
	ca65 -U $file -o objs/${name}.o -l lst/${name}.lst
done

ld65 -t bbc -o rom/mos120.rom objs/*.o
