#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
BASE=img

kolmogorov () {
  for p in CS_ H_ L_ SHSL_ SHSV_ V_; do
    i=$BASE/$1/$p$3.pgm
    j=$(basename $i .pgm)
    for n in 60 40 20; do
      k=$BASE/$2-$n/$j.jpg
      is=$(stat -c %s $i)
      ks=$(stat -c %s $k)
      klg=$(echo "scale=3; $is/$ks;" | bc)
      echo -n " $klg"
      #echo "$i => $k ($klg)"
    done
  done
}

echo -n img
echo -n " nofilter-cs60 nofilter-cs40 nofilter-cs20"
echo -n " nofilter-h60 nofilter-h40 nofilter-h20"
echo -n " nofilter-l60 nofilter-l40 nofilter-l20"
echo -n " nofilter-shsv60 nofilter-shsv40 nofilter-shsv20"
echo -n " nofilter-shsl60 nofilter-shsl40 nofilter-shsl20"
echo -n " nofilter-v60 nofilter-v40 nofilter-v20"
echo -n " sobel-cs60 sobel-cs40 sobel-cs20"
echo -n " sobel-h60 sobel-h40 sobel-h20"
echo -n " sobel-l60 sobel-l40 sobel-l20"
echo -n " sobel-shsv60 sobel-shsv40 sobel-shsv20"
echo -n " sobel-shsl60 sobel-shsl40 sobel-shsl20"
echo -n " sobel-v60 sobel-v40 sobel-v20"
echo -n " canny-cs60 canny-cs40 canny-cs20"
echo -n " canny-h60 canny-h40 canny-h20"
echo -n " canny-l60 canny-l40 canny-l20"
echo -n " canny-shsv60 canny-shsv40 canny-shsv20"
echo -n " canny-shsl60 canny-shsl40 canny-shsl20"
echo -n " canny-v60 canny-v40 canny-v20"
echo

echo -n rembrandt_eu_464
kolmogorov hsvl        hsvl-jpeg   rembrandt_eu_464
kolmogorov sobel-hsvl  sobel-jpeg  rembrandt_eu_464
kolmogorov canny-hsvl  canny-jpeg  rembrandt_eu_464
echo

echo -n caravaggio_1962_139_1
kolmogorov hsvl        hsvl-jpeg   caravaggio_1962_139_1
kolmogorov sobel-hsvl  sobel-jpeg  caravaggio_1962_139_1
kolmogorov canny-hsvl  canny-jpeg  caravaggio_1962_139_1
echo

