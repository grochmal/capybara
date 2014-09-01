#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
BASE=data/hsvl

# simplifications (as the style is similar):
# mannerism           ->  baroque
# dutch golden age    ->  baroque
# venetian school     ->  renaissance
# barbizon school     ->  romanticism
# symbolism           ->  romanticism
# realism             ->  romanticism
# post-impressionism  ->  impressionism
# neoimpressionism    ->  impressionism

cd "$DIR"
declare -A amt=( \
  ["bassano"]="bassano renaissance italy"        \
  ["botticelli"]="botticelli renaissance italy"  \
  ["raphael"]="raphael renaissance italy"        \
  ["titian"]="titian renaissance italy"          \
  ["veronese"]="veronese renaissance italy"      \
  \
  ["berchem"]="berchem baroque netherlands"          \
  ["caravaggio"]="caravaggio baroque italy"          \
  ["cuyp"]="cuyp baroque netherlands"                \
  ["dujardin"]="dujardin baroque netherlands"        \
  ["greco"]="greco baroque spain"                    \
  ["hondecoeter"]="hondecoeter baroque netherlands"  \
  ["miereveld"]="miereveld baroque netherlands"      \
  ["molenaer"]="molenaer baroque netherlands"        \
  ["monnoyer"]="monnoyer baroque france"             \
  ["murillo"]="murillo baroque spain"                \
  ["poussin"]="poussin baroque italy"                \
  ["rebecca"]="rebecca baroque italy"                \
  ["rembrandt"]="rembrandt baroque netherlands"      \
  ["ribera"]="ribera baroque italy"                  \
  ["ricci"]="ricci baroque italy"                    \
  ["rosa"]="rosa baroque italy"                      \
  ["rubens"]="rubens baroque netherlands"            \
  ["teniers"]="teniers baroque netherlands"          \
  ["velazquez"]="velazquez baroque spain"            \
  ["wouwerman"]="wouwerman baroque netherlands"      \
  \
  ["canaletto"]="canaletto neoclassicism italy"        \
  ["carlevariis"]="carlevariis neoclassicism italy"    \
  ["dughet"]="dughet neoclassicism italy"              \
  ["kauffmann"]="kauffmann neoclassicism switzerland"  \
  ["panini"]="panini neoclassicism italy"              \
  ["zoffany"]="zoffany neoclassicism britain"          \
  \
  ["boudin"]="boudin romanticism france"               \
  ["daubigny"]="daubigny romanticism france"           \
  ["delacroix"]="delacroix romanticism france"         \
  ["diaz"]="diaz romanticism france"                   \
  ["goya"]="goya romanticism spain"                    \
  ["latour"]="latour romanticism france"               \
  ["loutherbourg"]="loutherbourg romanticism britain"  \
  ["rousseau"]="rousseau romanticism france"           \
  \
  ["gauguin"]="gauguin impressionism france"        \
  ["monticelli"]="monticelli impressionism france"  \
  ["pissarro"]="pissarro impressionism france"      \
  \
  ["basawan"]="basawan mughal india"  \
  ["jagan"]="jagan mughal india"      \
  ["kesav"]="kesav mughal india"      \
  ["lal"]="lal mughal india"          \
  ["miskin"]="miskin mughal india"    \
  ["tulsi"]="tulsi mughal india"      \
  \
  ["carpenter"]="carpenter watercolour india"  \
  ["tagore"]="tagore watercolour india"        \
  \
  ["constable"]="constable romanticism britain"        \
  ["gainsborough"]="gainsborough romanticism britain"  \
  ["leslie"]="leslie romanticism britain"              \
  ["mulready"]="mulready romanticism britain"          \
  ["watts"]="watts romanticism britain"                \
  \
  ["devi"]="devi na india"  \
               )

img_meta () {
  a=$(echo $1 | cut -d '_' -f 2)
  echo "$1 ${amt["$a"]}"
}

echo "img artist school country"

for i in $BASE/H_*.pgm; do
  j=$(basename $i .pgm)
  img_meta ${j#H_}
done

