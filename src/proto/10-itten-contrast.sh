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

echo -n " itct-sat-sl-r3 itct-sat-sl-r7 itct-sat-sl-sg"
echo -n " itct-sat-sv-r3 itct-sat-sv-r7 itct-sat-sv-sg"

echo -n " itct-lightdark-l-r3 itct-lightdark-l-r7 itct-lightdark-l-sg"
echo -n " itct-lightdark-v-r3 itct-lightdark-v-r7 itct-lightdark-v-sg"

echo -n " itct-hue-h-r3 itct-hue-h-r7 itct-hue-h-sg"
echo -n " itct-hue-cs-r3 itct-hue-cs-r7 itct-hue-cs-sg"

echo -n " itct-warmcold-h-r3 itct-warmcold-h-r7 itct-warmcold-h-sg"
echo -n " itct-warmcold-cs-r3 itct-warmcold-cs-r7 itct-warmcold-cs-sg"

echo -n " itct-comp-h-r3 itct-comp-h-r7 itct-comp-h-sg"
echo -n " itct-comp-cs-r3 itct-comp-cs-r7 itct-comp-cs-sg"

echo

itten_cont rembrandt_eu_464
itten_cont caravaggio_1962_139_1

