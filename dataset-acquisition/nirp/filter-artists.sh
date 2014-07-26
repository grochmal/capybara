#!/bin/sh

# e.g.
# mkdir gauguin
#
# jgrep artist 'Gauguin, P' f~available-images-stripped |
# jcut -f artist,image_id |
# sort |
# sed -e 's/^{"image_id": "/cp e-images\//;s/".*/.jpg gauguin/' |
# sh
#
# jgrep artist 'Gauguin, P' f~available-images-stripped > gauguin.jso

DT=nirp-dataset
if [[ ! -d $DT ]]; then
  echo mkdir $DT
  mkdir $DT
fi
FILE=f~available-images-stripped
IDIR=e-images

ga() {
  if [[ ! -d $DT/$1 ]]; then
    echo mkdir $DT/$1
    mkdir $DT/$1
  fi
  if [[ $# != 5 ]]; then
     echo "Failed on $0: $1 $2 $3 $4 $#"
  fi
  jgrep artist "$2" "$FILE" |
  jcut -f artist,image_id |
  sort |
  sed -e "s/^{\"image_id\": \"/cp e-images\//;s/\".*/ $DT\\/$1/" |
  #cat
  sh
  jgrep artist "$2" "$FILE" |
  jsed -e '/artist/org_artist/' |
  jecho -f "artist:$5" -f "artist_country:$3" -f "artist_lifetime:$4" |
  #jcut -f artist,image_id
  cat > $DT/$1.jso
}

ga gauguin    'Gauguin, P'    france '1848-1903' 'Gauguin, Paul'
ga greco      'El Greco'      spain  '1541-1614' 'El Greco'
ga botticelli 'Botticelli, S' italy  '1444-1510' 'Botticelli, Sandro'
ga caravaggio 'Caravaggio, M' italy  '1571-1610' \
              'Caravaggio, Michelangelo Merisi da'

ga delacroix  'Delacroix, E'   france '1798-1863' 'Delacroix, Eugene'
ga goya       'Goya y|Goya, F' spain  '1746-1828' \
              'Goya y Lucientes, Francisco Jose de'

# Camille's son, Lucien, has an almost identical style
ga pissarro    'Pissarro, [CL]' france '1831-1903' 'Pissarro, Camille'
# Melchior's grandfather, Gillis Claesz, had a similar style
ga hondecoeter 'Hondecoeter, [MG]' netherlands '1636-1695' \
                       'Hondecoeter, Melchior de'
# The brothers Nicolaes (Klaes) and Jan Miense Molenaer had a similar style
ga molenaer  'Molenaer, [JK]' netherlands '1630-1676' 'Molenaer, Klaes'
# Father Jacopo Bassano and two sons: Francesco and Leandro
ga bassano   'Bassano, [JFL]' italy       '1510-1592' 'Bassano, Jacopo'
# Sebastiano Ricci taught his nephew Marco
ga ricci     'Ricci, [SM]'    italy       '1659-1734' 'Ricci, Sebastiano'
# Teniers family of painters followed a similar style
ga teniers   'Teniers, [AD]|Tieners family' netherlands '1582-1690' 'Teniers'

ga dujardin  'Dujardin, K'    netherlands '1626-1678' 'Dujardin, Karel'
ga miereveld 'Miereveld, M'   netherlands '1567-1641' \
             'Miereveld, Michiel Jansz van'
ga daubigny  'Daubigny, C'    france      '1817-1878' \
             'Daubigny, Charles Francois'

ga loutherbourg 'Loutherbourg, P' britain '1740-1812' \
                'Loutherbourg, Philip James de'
ga rousseau   'Rousseau, T'     france  '1812-1867' 'Rousseau, Theodore'
ga monticelli 'Monticelli, A'   france  '1824-1886' \
              'Monticelli, Adolphe Joseph Thomas'
ga zoffany    'Zoffany, [JR]'   britain '1733-1810' 'Zoffany, Johann'
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

