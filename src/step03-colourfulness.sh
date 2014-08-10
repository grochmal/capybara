#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
COLOUR=util/sv2cs.py
PREFIX=data/hsvl

cd "$DIR"
colour () {
  for i in $PREFIX/V_*.pgm; do
    j=$(basename $i .pgm)
    echo $COLOUR $i $PREFIX/SHSV_${j#V_}.pgm $PREFIX/CS_${j#V_}.pgm
         $COLOUR $i $PREFIX/SHSV_${j#V_}.pgm $PREFIX/CS_${j#V_}.pgm
  done
}

if [[ ! -d $PREFIX ]]; then
  echo $PREFIX directory do not exist, run previous stps first
  exit 1
fi

colour

