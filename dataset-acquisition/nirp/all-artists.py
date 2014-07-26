#!/usr/bin/env python

from urllib import urlopen,urlretrieve
from bs4    import BeautifulSoup
import re,sys,time,string

NIRPURL = 'http://www.vads.ac.uk/collections/NIRP/artist.php'

def artist_alpha(acc,letter,page=1):
    time.sleep(6)
    url  = NIRPURL + '?letter=' + letter + '&page=' + str(page)
    print >> sys.stderr, 'fetch from', url
    alpha = urlopen(url)
    soup  = BeautifulSoup(alpha.read())
    anchs = [a['href'] for a in soup('a','linktext')
                       if not a['href'].startswith('artist.php')]
    for a in anchs: print a
    next = soup('a','linktext',text=re.compile('Next.30'))
    if next : return artist_alpha(acc+anchs,letter,page+1)
    else    : return acc+anchs

def all_artists():
    acc = []
    for l in string.ascii_lowercase:
        acc += artist_alpha([],l)
    return acc

if '__main__' == __name__:
    artists = all_artists()
    print >> sys.stderr, len(artists)

