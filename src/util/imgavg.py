#!/usr/bin/env python

import os,sys
from PIL import Image
import numpy as np

__doc__ = 'Usage: imgavg.py file [file file ...]'

def imgavg(img):
    im = np.array(Image.open(img))
    print '%.6f %.6f' % (im.mean() , im.std()),

if '__main__' == __name__:
    if 1 >= len(sys.argv):
        print __doc__
        exit(0)
    for a in sys.argv[1:]:
        if os.path.isfile(a) : imgavg(a)
        else                 : print >> sys.stderr, a, ': no such file'
    print

