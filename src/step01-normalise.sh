#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
NORM=util/norm-size.pl
PIXELS=300000
OUT=data/images_rgb

from_set () {
  for input in $(find $1 -name '*.jpg'); do
    j=$(basename $input .jpg)
    output=$OUT/${2}_$j.png
    cur_size=$(identify $input | cut -d ' ' -f 3)
    new_size=$($NORM $cur_size $PIXELS)
    echo convert $input -resize $new_size -normalize $output
    convert $input -resize $new_size -normalize $output
  done
}

cd "$DIR"
if [[ ! -d $OUT ]]; then
  echo mkdir -p $OUT
  mkdir -p $OUT
fi
from_set ../vam-dataset  vam
from_set ../nirp-dataset nirp

