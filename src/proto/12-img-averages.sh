#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
IMGAVG=../util/imgavg.py
RULE=3
BASE=img/hsvl

cd "$DIR"
averages () {
  echo -n "$1 "
#  echo $IMGAVG $BASE/CS_$1.pgm   $BASE/H_$1.pgm    $BASE/L_$1.pgm \
#               $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm $BASE/V_$1.pgm
#               >&2
       $IMGAVG $BASE/CS_$1.pgm   $BASE/H_$1.pgm    $BASE/L_$1.pgm \
               $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm $BASE/V_$1.pgm
}

echo -n img

echo -n " cs-avg cs-std h-avg h-std"
echo -n " l-avg l-std shsl-avg shsl-std"
echo -n " shsv-avg shsv-std v-avg v-std"

echo

averages rembrandt_eu_464
averages caravaggio_1962_139_1

