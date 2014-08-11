#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
NORM=../util/norm-size.pl
PIXELS=300000
OUT=img/rgb

CAR=../../nirp-dataset/caravaggio_rgb/caravaggio_1962_139_1.jpg
REM=../../nirp-dataset/rembrandt_rgb/rembrandt_eu_464.jpg

cd "$DIR"
car_size=$(identify $CAR | cut -d ' ' -f 3)
rem_size=$(identify $REM | cut -d ' ' -f 3)
echo "ORIGINAL: caravaggio [$car_size] rembrandt [$rem_size]"
car_conv=$($NORM $car_size $PIXELS)
rem_conv=$($NORM $rem_size $PIXELS)
echo "CONVERT: caravaggio [$car_conv] rembrandt [$rem_conv]"
car_new=$(basename $CAR .jpg)
rem_new=$(basename $REM .jpg)
echo convert $CAR -resize $car_conv -normalize $OUT/$car_new.png
convert $CAR -resize $car_conv -normalize $OUT/$car_new.png
echo convert $REM -resize $rem_conv -normalize $OUT/$rem_new.png
convert $REM -resize $rem_conv -normalize $OUT/$rem_new.png

