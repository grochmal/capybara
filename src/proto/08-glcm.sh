#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
MKSTAT=../util/glcm.py
BASE=img/hsvl

glcm () {
  echo -n "$1 "
  echo $MKSTAT $BASE/CS_$1.pgm   $BASE/H_$1.pgm    $BASE/L_$1.pgm \
               $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm $BASE/V_$1.pgm \
               2\>\/dev\/null >&2
#  $MKSTAT $BASE/CS_$1.pgm   $BASE/H_$1.pgm    $BASE/L_$1.pgm \
#          $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm $BASE/V_$1.pgm 2>/dev/null
}

#    glcm = feature.greycomatrix(grey,[1,6,20],[np.pi])
#    cont = feature.greycoprops(glcm, 'contrast')
#    enrg = feature.greycoprops(glcm, 'energy')
#    hmgn = feature.greycoprops(glcm, 'homogeneity')
#    corr = feature.greycoprops(glcm, 'correlation')

echo -n img
echo -n " cs-glcm-ct cs-glcm-cr cs-glcm-en cs-glcm-hm"
echo -n " h-glcm-ct h-glcm-cr h-glcm-en h-glcm-hm"
echo -n " l-glcm-ct l-glcm-cr l-glcm-en l-glcm-hm"
echo -n " shsv-glcm-ct shsv-glcm-cr shsv-glcm-en shsv-glcm-hm"
echo -n " shsl-glcm-ct shsl-glcm-cr shsl-glcm-en shsl-glcm-hm"
echo -n " v-glcm-ct v-glcm-cr v-glcm-en v-glcm-hm"
echo

glcm rembrandt_eu_464
glcm caravaggio_1962_139_1

