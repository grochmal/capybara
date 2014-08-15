#!/bin/sh

DIR=$(dirname $(readlink -e "$0"))
BASE=data/hsvl

cd "$DIR"
declare -A amt=( \
  ["rembrandt"]="rembrandt baroque netherlands"        \
  ["caravaggio"]="caravaggio baroque italy"            \
  ["gauguin"]="gauguin post-impressionism france"      \ ### impressionism
  ["greco"]="greco mannerism spain"                    \ ### baroque
  ["botticelli"]="botticelli renaissance italy"        \
  ["delacroix"]="delacroix romanticism france"         \
  ["goya"]="goya romanticism spain"                    \
  ["pissarro"]="pissarro post-impressionism france"    \ ### impressionism
  ["hondecoeter"]="hondecoeter baroque netherlands"    \
  ["molenaer"]="molenaer baroque netherlands"          \
  ["bassano"]="bassano venetian italy"                 \ ### renaissance
  ["ricci"]="ricci baroque italy"                      \
  ["teniers"]="teniers baroque netherlands"            \
  ["dujardin"]="dujardin baroque netherlands"          \
  ["miereveld"]="miereveld baroque netherlands"        \
  ["daubigny"]="daubigny realism france"               \ ### romanticism
  ["loutherbourg"]="loutherbourg romanticism britain"  \
  ["rousseau"]="rousseau realism france"               \ ### romanticism
  ["monticelli"]="monticelli impressionism france"     \
  ["zoffany"]="zoffany neoclassicism britain"          \
               )

ga veronese   'Veronese, P'     italy   '1528-1588' 'Veronese, Paolo'
ga monnoyer   'Monnoyer, J'     france  '1636-1699' 'Monnoyer, Jean-Baptiste'
ga diaz       'Diaz de la Pe.a' france  '1808-1876' \
              'Diaz de la Pena, Narcisse Virgile'

ga poussin 'Poussin, N'              italy       '1594-1665' 'Poussin, Nicolas'
ga boudin  'Boudin, E|Eug.ne Boudin' france      '1824-1898' \
           'Boudin, Eugene Louis'

ga cuyp      'Cuyp, A'          netherlands '1620-1691' 'Cuyp, Aelbert'
ga kauffmann 'Kauffmann, A'     switzerland '1741-1807' 'Kauffmann, Angelica'
ga ribera    'Ribera, J'        italy       '1591-1652' 'Ribera, Jusepe de'
ga velazquez 'Vel.zquez, D'     spain       '1599-1660' 'Velazquez, Diego'
ga latour    'Fantin-Latour, H' france      '1836-1904' 'Fantin-Latour, Henri'
ga dughet    'Dughet, G'        italy       '1615-1675' 'Dughet, Gaspard'
ga wouwerman 'Wouwerman, P'     netherlands '1619-1668' 'Wouwerman, Philips'
ga titian    'Titian'           italy       '1488-1576' 'Titian'
ga canaletto 'Canaletto'        italy       '1697-1768' 'Canaletto'
ga panini    'Panini, G'        italy       '1692-1765' \
             'Panini, Giovanni Paolo'
ga rebecca   'Rebecca, B'       italy       '1735-1808' 'Rebecca, Biagio'
ga murillo   'Murillo, B'       spain       '1618-1682' \
             'Murillo, Bartolome Esteban'
ga rosa      'Rosa, S'          italy       '1615-1673' 'Rosa, Salvator'
ga berchem   'Berchem, N'       netherlands '1620-1683' 'Berchem, Nicolaes'
ga rubens    'Rubens, P'        netherlands '1577-1640' 'Rubens, Peter Paul'


ga carlevariis 'Carlevariis, L'    italy '1663-1729' 'Carlevariis, Luca'
ga raphael     'Raphael \(Italian' italy '1483-1520' 'Raphael'

ga rembrandt    \
   'Rembrandt van Rijn|van Rijn, Rembrandt|Rembrandt, Harmensz van Rijn' \
   netherlands  \
   '1606-1669'  \
   'Rijn, Rembrandt Harmenszoon van'

img_meta () {
  a=$(echo $1 | cut -d '_' -f 1)
  echo "$1 ${amt["$a"]}"
}

echo "img artist school country"

for i in $BASE/H_*.pgm; do
  j=$(basename $i .pgm)
  img_meta ${j#H_}
done

