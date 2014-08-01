#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
FILTER=../util/canny.py
IN=img/hsvl
OUT=img/canny-hsvl

for i in $IN/*.pgm; do
  j=$(basename $i)
  echo $FILTER $i $OUT/$j
  $FILTER $i $OUT/$j
done

