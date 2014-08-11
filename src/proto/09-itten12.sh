#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
COLOURS=../util/colour.py
BASE=img/hsvl

cd "$DIR"
itten12 () {
  echo -n "$1 "
#  echo $COLOURS $BASE/H_$1.pgm >&2
       $COLOURS $BASE/H_$1.pgm
}

echo -n img

#   0 -  29 : red           (r)
#  30 -  59 : orange red    (or)
#  60 -  89 : orange        (o)
#  90 - 119 : orange yellow (oy)
# 120 - 149 : yellow        (y)
# 150 - 179 : green yellow  (gy)
# 180 - 209 : green         (g)
# 210 - 239 : green blue    (gb)
# 240 - 269 : blue          (b)
# 270 - 299 : purple blue   (pb)
# 300 - 329 : purple        (p)
# 330 - 360 : purple red    (pr)

echo -n " it12-r it12-or it12-o it12-oy"
echo -n " it12-y it12-gy it12-g it12-gb"
echo -n " it12-b it12-pb it12-p it12-pr"

echo

itten12 rembrandt_eu_464
itten12 caravaggio_1962_139_1

