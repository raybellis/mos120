#!/bin/sh

/bin/rm -rf lst
mkdir -p lst

for file in src/*.s; do
	name=`basename $file .s`
	ca65 -U $file -o objs/${name}.o -l lst/${name}.lst
done

for file in inc/*.s; do
	name=`basename $file .s`
	ca65 -U $file -o objs/${name}.o
done

ld65 -t bbc -o rom/mos120.rom objs/*.o
