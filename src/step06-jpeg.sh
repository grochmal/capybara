#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
BASE=data

cd "$DIR"
compress () {
  for i in $BASE/$1/*.pgm; do
    j=$(basename $i .pgm)
    echo convert $i -quality $3 $BASE/$2-$3/$j.jpg
         convert $i -quality $3 $BASE/$2-$3/$j.jpg
  done
}

declare -A todir=(["hsvl"]="hsvl-jpeg"         \
                  ["sobel-hsvl"]="sobel-jpeg"  \
                  ["canny-hsvl"]="canny-jpeg"  \
                 )
for d in hsvl sobel-hsvl canny-hsvl; do
  for c in 60 40 20; do
    if [[ ! -d $BASE/${todir[$d]}-$c ]]; then
      echo mkdir -p $BASE/${todir[$d]}-$c
           mkdir -p $BASE/${todir[$d]}-$c
    fi
    compress $d ${todir[$d]} $c
  done
done

