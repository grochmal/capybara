#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
COLOUR=../util/sv2cs.py
PREFIX=img/hsvl

c=caravaggio_1962_139_1.pgm
r=rembrandt_eu_464.pgm

cd "$DIR"
echo $COLOUR $PREFIX/V_$c $PREFIX/SHSV_$c $PREFIX/CS_$c
$COLOUR $PREFIX/V_$c $PREFIX/SHSV_$c $PREFIX/CS_$c
echo $COLOUR $PREFIX/V_$r $PREFIX/SHSV_$r $PREFIX/CS_$r
$COLOUR $PREFIX/V_$r $PREFIX/SHSV_$r $PREFIX/CS_$r

