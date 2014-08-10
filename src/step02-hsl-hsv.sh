#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
IN=data/rgb
OUT=data/hsvl

cd "$DIR"
separate () {
  for i in $IN/*.png; do
    j=$(basename $i .png)
    echo convert $i -colorspace HSL -channel R -separate $OUT/H_$j.pgm
         convert $i -colorspace HSL -channel R -separate $OUT/H_$j.pgm
    echo convert $i -colorspace HSL -channel G -separate $OUT/SHSL_$j.pgm
         convert $i -colorspace HSL -channel G -separate $OUT/SHSL_$j.pgm
    echo convert $i -colorspace HSL -channel B -separate $OUT/L_$j.pgm
         convert $i -colorspace HSL -channel B -separate $OUT/L_$j.pgm
    echo convert $i -colorspace HSB -channel G -separate $OUT/SHSV_$j.pgm
         convert $i -colorspace HSB -channel G -separate $OUT/SHSV_$j.pgm
    echo convert $i -colorspace HSB -channel B -separate $OUT/V_$j.pgm
         convert $i -colorspace HSB -channel B -separate $OUT/V_$j.pgm
  done
}

if [[ ! -d $OUT ]]; then
  echo mkdir -p $OUT
       mkdir -p $OUT
fi

separate

