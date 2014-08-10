#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
BASE=img/hsvl

declare -A amt=( \
  ["rembrandt"]="rembrandt baroque netherlands"  \
  ["caravaggio"]="caravaggio baroque italy"      \
               )

img_meta () {
  a=$(echo $1 | cut -d '_' -f 2)
  echo "$1 ${amt["$a"]}"
}

echo "img artist school country"

for i in $BASE/H_*.pgm; do
  j=$(basename $i .pgm)
  img_meta $j
done

