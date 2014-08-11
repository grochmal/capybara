#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
CHOPAVG=../util/chops.py
RULE=3
BASE=img/hsvl

cd "$DIR"
rule_of_thirds () {
  echo -n "$1 "
#  echo $CHOPAVG $RULE $BASE/CS_$1.pgm   $BASE/H_$1.pgm    $BASE/L_$1.pgm \
#                      $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm $BASE/V_$1.pgm
#                      >&2
       $CHOPAVG $RULE $BASE/CS_$1.pgm   $BASE/H_$1.pgm    $BASE/L_$1.pgm \
                      $BASE/SHSL_$1.pgm $BASE/SHSV_$1.pgm $BASE/V_$1.pgm
}

echo -n img

echo -n " r3-cs-avg r3-cs-std r3-h-avg r3-h-std"
echo -n " r3-l-avg r3-l-std r3-shsl-avg r3-shsl-std"
echo -n " r3-shsv-avg r3-shsv-std r3-v-avg r3-v-std"

echo

rule_of_thirds rembrandt_eu_464
rule_of_thirds caravaggio_1962_139_1

