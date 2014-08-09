#!/usr/bin/env python

import os,sys
from PIL import Image
import numpy as np

__doc__ = 'Usage: chops.py n file [file file ...]'

def chop(ar, p):
    yn, xn = ar.shape
    bits = [0 for i in range(p*p)]
    for i in range(p):
        for j in range(p):
            bits[i*p+j] = ar[yn*i/p:yn*(i+1)/p,xn*j/p:xn*(j+1)/p]
    return bits

def chop_img(img, n):
    im = np.array(Image.open(img))
    ps = chop(im, n)
    ch = ps[(n*n)/2]
    print '%.6f %.6f' % (ch.mean() , ch.std()),

if '__main__' == __name__:
    if 2 >= len(sys.argv):
        print __doc__
        exit(0)
    n = int(sys.argv[1])
    for a in sys.argv[2:]:
        if os.path.isfile(a) : chop_img(a, n)
        else                 : print >> sys.stderr, a, ': no such file'
    print

