#!/bin/bash

echo Enter tha name of the blast file you want to clean.
read var
echo The file $var will be cleaned

perl -p -i -e's/Query[:]*.+//' $var
perl -p -i -e 's/^\s*[A-Z]*\s*\n//' $var
perl -p -i -e's/Sbjct[:]*\s*\d*\s*//' $var
perl -p -i -e's/\d*\n/\n/' $var
perl -p -i -e's/\s*//' $var

echo You have finished your work

