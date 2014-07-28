#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
EDGE=768
SET=vam-dataset

cd "$DIR"
if [[ ! -z $1 ]]; then
  SET=$1
fi
if [[ ! -z $2 ]]; then
  EDGE=$2
fi
for d in $SET/*.jsons; do
  e=$(basename $d .jsons)
  if [[ ! -d $SET/${e}_rgb ]]; then
    echo mkdir $SET/${e}_rgb
    mkdir $SET/${e}_rgb
  fi
  for j in $SET/$e/*.jpg; do
    i=$(basename $j)
    size=$(identify $SET/$e/$i | cut -d ' ' -f 3)
    if [[ ${size#*x} > ${size%x*} ]]; then
      param=x$EDGE
    else
      param=$EDGE
    fi
    echo convert $SET/$e/$i -colorspace RGB -quality 90 \
                 -resize $param $SET/${e}_rgb/${e}_$i
    convert $SET/$e/$i -colorspace RGB -quality 90 \
            -resize $param $SET/${e}_rgb/${e}_$i
  done
done

