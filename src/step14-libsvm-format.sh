#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
CLASS=cls
BASE=fe
ARTIST="util/mksvmf.pl artist enc"
SCHOOL="util/mksvmf.pl school enc"
DAT=$BASE/dataset.dat
OUTART=$CLASS/artist.libsvm
OUTSCH=$CLASS/school.libsvm

cd "$DIR"
if [[ ! -d $CLASS ]]; then
  echo mkdir -p $CLASS
  mkdir -p $CLASS
fi

echo "JOIN meta.dat kolmogorov.dat glcm.dat itten12.dat"  \
     "rule-of-3.dat itten-contrast.dat img-averages.dat INTO $DAT"

cat    $BASE/meta.dat           |
join - $BASE/kolmogorov.dat     |
join - $BASE/glcm.dat           |
join - $BASE/itten12.dat        |
join - $BASE/rule-of-3.dat      |
join - $BASE/itten-contrast.dat |
join - $BASE/img-averages.dat   > $DAT

# --complement is not POSIX, if it does not work for you
# type all the fields into the comma separated list for -f
echo -n "cut --complement -d ' ' -f 1,3,4 $DAT |"
echo    " $ARTIST | sort > $OUTART"
      cut --complement -d ' ' -f 1,3,4 $DAT |
        $ARTIST | sort > $OUTART

echo -n "cut --complement -d ' ' -f 1,2,4 $DAT |"
echo    " $SCHOOL | sort > $OUTSCH"
      cut --complement -d ' ' -f 1,2,4 $DAT |
        $SCHOOL | sort > $OUTSCH

