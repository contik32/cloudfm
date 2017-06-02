#!/bin/bash

maxdepth=0
pathname=music

if [ "$1" != "" ]; then
  maxdepth=$1
fi

if [ "$2" != "" ]; then
  pathname=$2
fi

IFS=$'\n'

#files=`find $pathname -maxdepth $maxdepth | grep -P -i "'"`
#for f in $files; do
#   mv -v -i "$f" "`echo $f | tr -d "'"`"
#done

for depth in `seq 0 $maxdepth`; do
    echo --- Depth $depth

    files=`find $pathname -maxdepth $depth | grep -P -i '[\[\]\+\#\@]'`
    for f in $files; do
       mv -v "$f" "`echo $f | tr '[]' '()' | tr '+@' '--' | tr -d '#'`"
    done

    files=`find $pathname -maxdepth $maxdepth | grep -P -i '  +'`
    for f in $files; do
      mv -v "$f" "`echo $f | sed 's/  \+/ /g'`"
    done
done
