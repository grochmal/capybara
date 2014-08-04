#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
SEG=./segmentation.py
BASE=img/hsvl
OUT=segmentation-examples

for i in $BASE/*.pgm; do
  j=$(basename $i .pgm)
  echo $SEG $i $OUT/$j.png
  $SEG $i $OUT/$j.png
done

