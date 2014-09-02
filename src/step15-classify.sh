#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
CLASS=cls
UTILART="util/mksvmf.pl artist dec"
UTILSCH="util/mksvmf.pl school dec"
ARTIST=$CLASS/artist.libsvm
ARTSCL=$CLASS/artist-scale.libsvm
ARTMOD=$CLASS/artist.model
SCHOOL=$CLASS/school.libsvm
SCHSCL=$CLASS/school-scale.libsvm
SCHMOD=$CLASS/school.model
MUGHAL=$CLASS/mughal.libsvm
MUGSCH=$CLASS/mughal-school.libsvm
MUGSCL=$CLASS/mughal-scale.libsvm

OUTPUT=$CLASS/output.dat
KFOLDSCH=36
KFOLDART=12
GRID="svm-grid.py -out null -gnuplot null -v 6"
SCALE="svm-scale -l 0"

model () {
         echo "$GRID $1 | tail -n 1"
  local grid=$($GRID $1 | tail -n 1)
  local argd=($grid)
  echo "cost [${argd[0]}] gamma [${argd[1]}]"
  echo "svm-train -q -c ${argd[0]} -g ${argd[1]} $1 $2"
        svm-train -q -c ${argd[0]} -g ${argd[1]} $1 $2
}

school_scale () {
  local name=$(echo $1 | $UTILSCH)
  echo "filter scaled school $name ($1)"
  echo "egrep \"^$1\" $SCHSCL > $CLASS/$name-scale.libsvm"
        egrep  "^$1"  $SCHSCL > $CLASS/$name-scale.libsvm
}

artist_scale () {
  local name=$(echo $1 | $UTILART)
  echo "filter scaled artist $name ($1)"
  echo "egrep \"^$1 \" $ARTSCL > $CLASS/$name-scale.libsvm"
        egrep  "^$1 "  $ARTSCL > $CLASS/$name-scale.libsvm
}

model_school () {
  local name=$(echo $1 | $UTILSCH)
  echo "general classification of school $name ($1)"
  local scfile="$CLASS/$name-scale.libsvm"
  local outpfl="$CLASS/$name-scale.svmout"
  local lineno=$(wc -l $scfile | cut -d ' ' -f 1)
        echo "svm-predict $scfile $SCHMOD $outpfl"
  local val=$(svm-predict $scfile $SCHMOD $outpfl)
  local per=${val%\%*}
  echo "school-predict $name $lineno ${per#*= }  >> $OUTPUT"
  echo "school-predict $name $lineno ${per#*= }" >> $OUTPUT
}

model_artist () {
  local name=$(echo $1 | $UTILART)
  echo "general classification of artist $name ($1)"
  local arfile="$CLASS/$name-scale.libsvm"
  local outpfl="$CLASS/$name-scale.svmout"
  local lineno=$(wc -l $arfile | cut -d ' ' -f 1)
        echo "svm-predict $arfile $ARTMOD $outpfl"
  local val=$(svm-predict $arfile $ARTMOD $outpfl)
  local per=${val%\%*}
  echo "artist-predict $name $lineno ${per#*= }  >> $OUTPUT"
  echo "artist-predict $name $lineno ${per#*= }" >> $OUTPUT
}

school_class () {
  local name=$(echo $1 | $UTILSCH)
  echo "generate school $name ($1)"
  echo "egrep \"^$1\" $SCHOOL > $CLASS/$name.libsvm"
        egrep  "^$1"  $SCHOOL > $CLASS/$name.libsvm
}

school_diff () {
  local l=$(echo $1 | $UTILSCH)
  local r=$(echo $2 | $UTILSCH)
  local comp="$CLASS/$l-$r.libsvm"
  local compscl="$CLASS/$l-$r-scale.libsvm"
  echo "cat $CLASS/$l.libsvm $CLASS/$r.libsvm > $comp"
        cat $CLASS/$l.libsvm $CLASS/$r.libsvm > $comp
  local lineno=$(wc -l $comp | cut -d ' ' -f 1)
  echo "$SCALE $comp > $compscl"
        $SCALE $comp > $compscl
         echo "$GRID $compscl | tail -n 1"
  local grid=$($GRID $compscl | tail -n 1)
  local argd=($grid)
  echo "cost [${argd[0]}] gamma [${argd[1]}]"
        echo "svm-train -q -c ${argd[0]} -g ${argd[1]} -v $KFOLDSCH $compscl"
  local val=$(svm-train -q -c ${argd[0]} -g ${argd[1]} -v $KFOLDSCH $compscl)
  local per=${val%\%}
  echo "school-diff $l-$r $lineno ${per#*= }  >> $OUTPUT"
  echo "school-diff $l-$r $lineno ${per#*= }" >> $OUTPUT
}

artist_class () {
  local name=$(echo $1 | $UTILART)
  echo "generate artist $name ($1)"
  echo "egrep \"^$1 \" $ARTIST > $CLASS/$name.libsvm"
        egrep  "^$1 "  $ARTIST > $CLASS/$name.libsvm
}

artist_diff () {
  local l=$(echo $1 | $UTILART)
  local r=$(echo $2 | $UTILART)
  local comp="$CLASS/$l-$r.libsvm"
  local compscl="$CLASS/$l-$r-scale.libsvm"
  echo "cat $CLASS/$l.libsvm $CLASS/$r.libsvm > $comp"
        cat $CLASS/$l.libsvm $CLASS/$r.libsvm > $comp
  local lineno=$(wc -l $comp | cut -d ' ' -f 1)
  echo "$SCALE $comp > $compscl"
        $SCALE $comp > $compscl
         echo "$GRID $compscl | tail -n 1"
  local grid=$($GRID $compscl | tail -n 1)
  local argd=($grid)
  echo "cost [${argd[0]}] gamma [${argd[1]}]"
        echo "svm-train -q -c ${argd[0]} -g ${argd[1]} -v $KFOLDART $compscl"
  local val=$(svm-train -q -c ${argd[0]} -g ${argd[1]} -v $KFOLDART $compscl)
  local per=${val%\%}
  echo "artist-diff $l-$r $lineno ${per#*= }  >> $OUTPUT"
  echo "artist-diff $l-$r $lineno ${per#*= }" >> $OUTPUT
}

generic_class () {
  local lineno=$(wc -l $1 | cut -d ' ' -f 1)
         echo "$GRID $1 | tail -n 1"
  local grid=$($GRID $1 | tail -n 1)
  local argd=($grid)
  echo "cost [${argd[0]}] gamma [${argd[1]}]"
        echo "svm-train -q -c ${argd[0]} -g ${argd[1]} -v $KFOLDART $1"
  local val=$(svm-train -q -c ${argd[0]} -g ${argd[1]} -v $KFOLDART $1)
  local per=${val%\%}
  echo "$2 $3 $lineno ${per#*= }  >> $OUTPUT"
  echo "$2 $3 $lineno ${per#*= }" >> $OUTPUT
}

cd "$DIR"

echo "scheme class sample accuracy  > $OUTPUT"
echo "scheme class sample accuracy" > $OUTPUT
echo "$SCALE $ARTIST > $ARTSCL"
      $SCALE $ARTIST > $ARTSCL
echo "$SCALE $SCHOOL > $SCHSCL"
      $SCALE $SCHOOL > $SCHSCL
echo "sed s/^./1/ $SCHOOL | cat $MUGHAL - > $MUGSCH"
      sed s/^./1/ $SCHOOL | cat $MUGHAL - > $MUGSCH
echo "$SCALE $MUGSCH > $MUGSCL"
      $SCALE $MUGSCH > $MUGSCL

model $ARTSCL $ARTMOD
model $SCHSCL $SCHMOD

for j in $(cut -d ' ' -f 1 $ARTSCL | uniq); do
  artist_scale $j
done

r=1  # renaissance
b=2  # baroque
n=3  # neoclassicism
o=4  # romanticism
i=5  # impressionism
m=6  # mughal

school_scale $r
school_scale $b
school_scale $n
school_scale $o
school_scale $i

model_school $r
model_school $b
model_school $n
model_school $o
model_school $i

for j in $(cut -d ' ' -f 1 $ARTSCL | uniq); do
  model_artist $j
done

school_class $r
school_class $b
school_class $n
school_class $o
school_class $i

school_diff $r $b
school_diff $r $n
school_diff $r $o
school_diff $r $i
school_diff $r $m
school_diff $b $n
school_diff $b $o
school_diff $b $i
school_diff $b $m
school_diff $n $o
school_diff $n $i
school_diff $n $m
school_diff $o $i
school_diff $o $m
school_diff $i $m

for j in $(cut -d ' ' -f 1 $ARTSCL | uniq); do
  artist_class $j
done

ati=4   # titian
amu=19  # murillo
are=22  # rembrant
aca=40  # canaletto
aco=51  # constable
amo=71  # moticelli

artist_diff $ati $amu
artist_diff $ati $are
artist_diff $ati $aca
artist_diff $ati $aco
artist_diff $ati $amo
artist_diff $amu $are
artist_diff $amu $aca
artist_diff $amu $aco
artist_diff $amu $amo
artist_diff $are $aca
artist_diff $are $aco
artist_diff $are $amo
artist_diff $aca $aco
artist_diff $aca $amo
artist_diff $aco $amo

# this gets 100% accuracy, it's likely too different from the rest
generic_class $MUGSCL mughal mughal

