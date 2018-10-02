#!/bin/sh

makesrc=`dirname $0`/makesrc.pl

for file in input/*; do
	name=`basename ${file} | tr A-Z a-z`
	${makesrc} $file > src/${name}.s
done
