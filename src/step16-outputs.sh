#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
DATASET=fe/dataset.dat
DSINDEX=img
CLASSAC=cls/output.dat
CLINDEX=scheme
UTIL=util
OUT=out

rs () {
  extra=""
  if [[ "x$5" != "x" ]]; then
    extra=$OUT/$5
  fi
  echo $UTIL/$1 $2 $3 $OUT/$4 $extra
       $UTIL/$1 $2 $3 $OUT/$4 $extra
}

cd "$DIR"
if [[ ! -d $OUT ]]; then
  echo mkdir -p $OUT
  mkdir -p $OUT
fi

rs table-avg.py      $DATASET  $DSINDEX  means-stds-top.tex  means-stds-bot.tex
rs graph-corr.py     $DATASET  $DSINDEX  corr-graph.png
rs graph-class.py    $CLASSAC  $CLINDEX  class-graph.png
rs table-predict.py  $CLASSAC  $CLINDEX  art-predict.tex     sch-predict.tex

