#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
FILTER=util/canny.py
IN=data/hsvl
OUT=data/canny-hsvl

cd "$DIR"
if [[ ! -d $OUT ]]; then
  echo mkdir -p $OUT
       mkdir -p $OUT
fi

for i in $IN/*.pgm; do
  j=$(basename $i)
  echo $FILTER $i $OUT/$j
       $FILTER $i $OUT/$j
done

