#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
IN=img/rgb
OUT=img/hsvl

c=caravaggio_1962_139_1
r=rembrandt_eu_464

# channels R, G, B do not mean Red, Green, Blue they're only names for the 1st,
# 2nd and 3rd channel whatever the colorspace is.
# -channel must be passed before -separate otherwise all channles will be
# written to file regardless of the -separate option.

cd "$DIR"
echo convert $IN/$c.png -colorspace HSL -channel R -separate $OUT/H_$c.pgm
convert $IN/$c.png -colorspace HSL -channel R -separate $OUT/H_$c.pgm
echo convert $IN/$c.png -colorspace HSL -channel G -separate $OUT/SHSL_$c.pgm
convert $IN/$c.png -colorspace HSL -channel G -separate $OUT/SHSL_$c.pgm
echo convert $IN/$c.png -colorspace HSL -channel B -separate $OUT/L_$c.pgm
convert $IN/$c.png -colorspace HSL -channel B -separate $OUT/L_$c.pgm
echo convert $IN/$c.png -colorspace HSB -channel G -separate $OUT/SHSV_$c.pgm
convert $IN/$c.png -colorspace HSB -channel G -separate $OUT/SHSV_$c.pgm
echo convert $IN/$c.png -colorspace HSB -channel B -separate $OUT/V_$c.pgm
convert $IN/$c.png -colorspace HSB -channel B -separate $OUT/V_$c.pgm

echo convert $IN/$r.png -colorspace HSL -channel R -separate $OUT/H_$r.pgm
convert $IN/$r.png -colorspace HSL -channel R -separate $OUT/H_$r.pgm
echo convert $IN/$r.png -colorspace HSL -channel G -separate $OUT/SHSL_$r.pgm
convert $IN/$r.png -colorspace HSL -channel G -separate $OUT/SHSL_$r.pgm
echo convert $IN/$r.png -colorspace HSL -channel B -separate $OUT/L_$r.pgm
convert $IN/$r.png -colorspace HSL -channel B -separate $OUT/L_$r.pgm
echo convert $IN/$r.png -colorspace HSB -channel G $OUT/SHSV_$r.pgm
convert $IN/$r.png -colorspace HSB -channel G -separate $OUT/SHSV_$r.pgm
echo convert $IN/$r.png -colorspace HSB -channel B -separate $OUT/V_$r.pgm
convert $IN/$r.png -colorspace HSB -channel B -separate $OUT/V_$r.pgm

