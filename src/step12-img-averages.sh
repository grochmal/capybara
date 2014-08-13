#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
IMGAVG=util/imgavg.py
BASE=data/hsvl

cd "$DIR"
averages () {
  echo -n "$1 "
  echo $IMGAVG $BASE/CS_$1.pgm   $BASE/H_$1.pgm    $BASE/L_$1.pgm \
               $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm $BASE/V_$1.pgm \
               >&2
       $IMGAVG $BASE/CS_$1.pgm   $BASE/H_$1.pgm    $BASE/L_$1.pgm \
               $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm $BASE/V_$1.pgm
}

echo -n img

echo -n " cs-avg cs-std h-avg h-std"
echo -n " l-avg l-std shsl-avg shsl-std"
echo -n " shsv-avg shsv-std v-avg v-std"

echo

for i in $BASE/H_*.pgm; do
  j=$(basename $i .pgm)
  averages ${j#H_}
done

