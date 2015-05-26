#!/bin/bash

for FILE in *.faa
do
	NUMBER=`grep '>' $FILE |wc -l`
	echo "$FILE: $NUMBER"
done
	
