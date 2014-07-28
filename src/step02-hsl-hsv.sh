#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
IN=data/images_rgb
OUTBASE=data/images

from_set () {
  out_dir=${OUTBASE}_${1,,}
  if [[ ! -d $out_dir ]]; then
    echo mkdir -p $out_dir
    mkdir -p $out_dir
  fi
  for i in $IN/*.png; do
    j=$(basename $i)
    echo convert $i -colorspace $1 $out_dir/$j
    convert $i -colorspace $1 $out_dir/$j
  done
}

cd "$DIR"
from_set HSB
from_set HSL

