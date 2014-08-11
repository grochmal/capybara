#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
FILTER=../util/sobel.py
IN=img/hsvl
OUT=img/sobel-hsvl

cd "$DIR"
for i in $IN/*.pgm; do
  j=$(basename $i)
  echo $FILTER $i $OUT/$j
  $FILTER $i $OUT/$j
done

