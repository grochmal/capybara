#!/bin/sh

# e.g.
# mkdir tulsi
#
# jgrep artist 'Tulsi' c~paintings-with-images |
# jcut -f artist,primary_image_id |
# sort |
# sed -e 's/^{"primary_image_id": "/cp c-images\//;s/".*/.jpg tulsi/' |
# sh
#
# jgrep artist 'Tulsi' c~paintings-with-images > tulsi.jso

DT=vam-dataset
if [[ ! -d $DT ]]; then
  echo mkdir $DT
  mkdir $DT
fi
FILE=c~paintings-with-images
IDIR=c-images

get_artist() {
  if [[ ! -d $DT/$1 ]]; then
    echo mkdir $DT/$1
    mkdir $DT/$1
  fi
  jgrep artist "$2" "$FILE" |
  jcut -f artist,primary_image_id |
  sort |
  sed -e "s/^{\"primary_image_id\": \"/cp c-images\//;s/\".*/.jpg $DT\\/$1/" |
  #cat
  sh
  jgrep artist "$2" "$FILE" |
  jsed -e "/artist/.*/$3/" |
  #jcut -f artist,primary_image_id
  cat > $DT/$1.jso
}

get_artist 'basawan' 'Basawan' 'Basawan'  # 11
get_artist 'tulsi'   'Tulsi'   'Tulsi'    # 10
get_artist 'jagan'   'Jagan'   'Jagan'    # 9
get_artist 'kesav'   'Kesav'   'Kesav'    # 15
get_artist 'lal'     "^La'?l"  'Lal'      # 19
get_artist 'miskin'  'Miskin'  'Miskin'   # 15

get_artist 'tagore'  'Tagore'       'Tagore, Abanindranath'  # 8
get_artist 'devi'    'Devi,|Devi$'  'Devi'                   # 19

get_artist 'carpenter'    'Carpenter, W'    'Carpenter, William'       # 9
get_artist 'constable'    'Constable, J'    'Constable, John'          # 41
get_artist 'gainsborough' 'Gainsborough, T' 'Gainsborough, Thomas'     # 13
get_artist 'leslie'       'Leslie,|Leslie$' 'Leslie, Charles Robert'   # 11
get_artist 'mulready'     'Mulready, W'     'Mulready, William'        # 11
get_artist 'watts'        'Watts, G'        'Watts, George Frederick'  # 10

