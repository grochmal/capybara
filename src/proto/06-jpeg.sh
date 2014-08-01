#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
BASE=img

compress () {
  for i in $BASE/$1/*.pgm; do
    j=$(basename $i .pgm)
    echo convert $i -quality $3 $BASE/$2-$3/$j.jpg
    convert $i -quality $3 $BASE/$2-$3/$j.jpg
  done
}

compress hsvl       hsvl-jpeg  60
compress hsvl       hsvl-jpeg  40
compress hsvl       hsvl-jpeg  20
compress sobel-hsvl sobel-jpeg 60
compress sobel-hsvl sobel-jpeg 40
compress sobel-hsvl sobel-jpeg 20
compress canny-hsvl canny-jpeg 60
compress canny-hsvl canny-jpeg 40
compress canny-hsvl canny-jpeg 20

