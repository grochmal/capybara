#!/usr/bin/env python

from urllib import urlopen,urlretrieve
from bs4    import BeautifulSoup
from json   import dumps
import sys,os,time

VADSURL = 'http://www.vads.ac.uk/'

# medium: http://www.vads.ac.uk/images/NIRP/ABERDEEN/medium/ag004524.jpg
# large:  http://www.vads.ac.uk/images/NIRP/ABERDEEN/large/ag004524.jpg

def mksubdir(dir,artist=None):
    d = dir.rstrip('/')
    if artist: d = os.path.join(dir,artist)
    if not os.path.exists(d):
        os.makedirs(d)
    elif not os.path.isdir(d):
        print >> sys.stderr, d, 'is not a directory'
        return None
    return d

def get_img(dir, url):
    image = { u'image_id' : '' , u'url' : url }
    soup  = BeautifulSoup(urlopen(url).read().decode('iso-8859-1'))
    table = soup.find('table', id='arial')
    trs   = table('tr')[1:]
    for tr in trs:
        tds = tr('td')
        image[tds[0].b.text.lower()] = tds[1].text.encode('utf-8')
    idiv  = soup.find('div', class_='main2right')
    ilink = idiv.find('a')
    img   = idiv.find('img')
    src   = img['src']
    if 'images/default.jpg' != src:
        # images/NIRP/ABERDEEN/medium/ag004524.jpg
        i,n,place,size,file = src.split('/')
        if ilink: src = '/'.join([i,n,place,'large',file])
        print >> sys.stderr, 'fetch img:', VADSURL+src
        urlretrieve(VADSURL+src, dir+'/'+file.lower())
        image[u'image_id'] = file
    print dumps(image)

if '__main__' == __name__:
    if 3 != len(sys.argv):
        print 'Usage:', sys.argv[0], 'imgdir infile'
        sys.exit(1)
    dir = mksubdir(sys.argv[1])
    with open(sys.argv[2]) as f:
        try:
            for line in f:
                line = line.strip()
                try:
                    print >> sys.stderr, 'fetch:', line
                    get_img(dir, line)
                    time.sleep(6)
                except Exception as e:
                    print >> sys.stderr, 'BAD ENCODING:', line
                    print >> sys.stderr, str(e)
        except IOError as e:
            print >> sys.stderr, str(e)

