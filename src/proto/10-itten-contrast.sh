#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
CONTR=../util/itten.py
BASE=img/hsvl

itten_cont () {
  echo -n "$1 "
#  echo $CONTR $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm  \
#              $BASE/L_$1.pgm    $BASE/V_$1.pgm     \
#              $BASE/H_$1.pgm    $BASE/CS_$1.pgm    \
#              >&2
       $CONTR $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm  \
              $BASE/L_$1.pgm    $BASE/V_$1.pgm     \
              $BASE/H_$1.pgm    $BASE/CS_$1.pgm
}

echo -n img

#   0 -  29 : red           (r)  --\
#  30 -  59 : orange red    (or)   |  warm
#  60 -  89 : orange        (o)    | colours
#  90 - 119 : orange yellow (oy) --/
# 120 - 149 : yellow        (y)
# 150 - 179 : green yellow  (gy)
# 180 - 209 : green         (g)  --\
# 210 - 239 : green blue    (gb)   |  cold
# 240 - 269 : blue          (b)    | colours
# 270 - 299 : purple blue   (pb) --/
# 300 - 329 : purple        (p)
# 330 - 360 : purple red    (pr)

echo -n " itct-sat-sl itct-sat-sv"
echo -n " itct-lightdark-l itct-lightdark-v"
echo -n " itct-hue-h itct-hue-cs"
echo -n " itct-warmcold-h itct-warmcold-cs"
echo -n " itct-comp-h itct-comp-cs"

echo

#itten_cont rembrandt_eu_464
itten_cont caravaggio_1962_139_1

