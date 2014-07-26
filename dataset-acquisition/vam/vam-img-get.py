#!/usr/bin/env python

import sys,os,time,json,urllib

#http://media.vam.ac.uk/media/thira/collection_images/2006AH/2006AH4555.jpg
VAMURL = 'http://media.vam.ac.uk/media/thira/collection_images/'

def line2mobj(line):
    try:
        j = json.loads(line)
        return j['primary_image_id']
    except ValueError as e:
       print >> sys.stderr, 'Not a valid json, line ignored'

def fetch_all(inp, dir):
    try:
        with open(inp) as f:
            for line in f:
                line = line.strip()
                if '' == line: continue
                mobj = line2mobj(line)
                if mobj: dimg(mobj, dir)
    except IOError as e:
        print >> sys.stderr, str(e)

def dimg(mobj, dir):
    time.sleep(6)
    url  = VAMURL + mobj[:6] + '/' + mobj + '.jpg'
    file = os.path.join(dir, mobj+'.jpg')
    print 'fetch', url, 'as', file
    if os.path.exists(file): print >> sys.stderr, 'file',file,'already exists'
    else: urllib.urlretrieve(url, file)

if '__main__' == __name__:
    if 3 != len(sys.argv):
        print 'Usage:', sys.argv[0], '<input file> <directory>'
        sys.exit(1)
    dir = sys.argv.pop()
    inp = sys.argv.pop()
    if not os.path.exists(dir):
        os.makedirs(dir)
    elif not os.path.isdir(dir):
        print dir, 'is not a directory'
        sys.exit(1)
    fetch_all(inp, dir)

