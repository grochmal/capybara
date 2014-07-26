#!/usr/bin/env python

from urllib import urlopen
from bs4    import BeautifulSoup
import sys,re,time

VADSURL = 'http://www.vads.ac.uk/'

# VADS website mixes UTF-8 with latin-1, WTF!
# Thanks to that neither URL quoting or page encoding
# conversion  works, we need to know which parts are
# encoded in utf-8 and which in latin-1.
def urlquote(url):
    out = []
    for s in url:
        if ord(s) < 128: out.append(s)
        else:
            out.append('%'+hex(ord(s))[2:].upper())
    return ''.join(out)

def one_artist(url):
    print >> sys.stderr, 'fetch', url
    soup   = BeautifulSoup(urlopen(url).read().decode('latin-1'))
    div    = soup.find('div', class_='results-content')
    linktr = div.table('tr')[1]
    next   = linktr.find('a',text='[Next]')
    timgs  = div('table')[1]
    tds    = timgs.tr.td.table('td')
    for td in tds:
        detail = re.sub(r'&sos=\d+$', '', td.a['href'])
        print VADSURL + detail
    if next:
        print >> sys.stderr, 'next page', urlquote(VADSURL+next['href'])
        time.sleep(6)
        one_artist(urlquote(VADSURL+next['href']))

if '__main__' == __name__:
    if 2 != len(sys.argv):
        print 'Usage:', sys.argv[0], 'url'
        sys.exit(1)
    one_artist(sys.argv[1])

