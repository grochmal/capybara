#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
MKSTAT=../util/glcm.py
BASE=img/hsvl

cd "$DIR"
glcm () {
  echo -n "$1 "
#  echo $MKSTAT $BASE/CS_$1.pgm   $BASE/H_$1.pgm    $BASE/L_$1.pgm \
#               $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm $BASE/V_$1.pgm \
#               2\>\/dev\/null >&2
  $MKSTAT $BASE/CS_$1.pgm   $BASE/H_$1.pgm    $BASE/L_$1.pgm \
          $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm $BASE/V_$1.pgm 2>/dev/null
}

echo -n img

echo -n " glcm-cs-ct1 glcm-cs-ct6 glcm-cs-ct20"
echo -n " glcm-cs-en1 glcm-cs-en6 glcm-cs-en20"
echo -n " glcm-cs-hm1 glcm-cs-hm6 glcm-cs-hm20"
echo -n " glcm-cs-cr1 glcm-cs-cr6 glcm-cs-cr20"

echo -n " glcm-h-ct1 glcm-h-ct6 glcm-h-ct20"
echo -n " glcm-h-en1 glcm-h-en6 glcm-h-en20"
echo -n " glcm-h-hm1 glcm-h-hm6 glcm-h-hm20"
echo -n " glcm-h-cr1 glcm-h-cr6 glcm-h-cr20"

echo -n " glcm-l-ct1 glcm-l-ct6 glcm-l-ct20"
echo -n " glcm-l-en1 glcm-l-en6 glcm-l-en20"
echo -n " glcm-l-hm1 glcm-l-hm6 glcm-l-hm20"
echo -n " glcm-l-cr1 glcm-l-cr6 glcm-l-cr20"

echo -n " glcm-shsl-ct1 glcm-shsl-ct6 glcm-shsl-ct20"
echo -n " glcm-shsl-en1 glcm-shsl-en6 glcm-shsl-en20"
echo -n " glcm-shsl-hm1 glcm-shsl-hm6 glcm-shsl-hm20"
echo -n " glcm-shsl-cr1 glcm-shsl-cr6 glcm-shsl-cr20"

echo -n " glcm-shsv-ct1 glcm-shsv-ct6 glcm-shsv-ct20"
echo -n " glcm-shsv-en1 glcm-shsv-en6 glcm-shsv-en20"
echo -n " glcm-shsv-hm1 glcm-shsv-hm6 glcm-shsv-hm20"
echo -n " glcm-shsv-cr1 glcm-shsv-cr6 glcm-shsv-cr20"

echo -n " glcm-v-ct1 glcm-v-ct6 glcm-v-ct20"
echo -n " glcm-v-en1 glcm-v-en6 glcm-v-en20"
echo -n " glcm-v-hm1 glcm-v-hm6 glcm-v-hm20"
echo -n " glcm-v-cr1 glcm-v-cr6 glcm-v-cr20"

echo

glcm rembrandt_eu_464
glcm caravaggio_1962_139_1

