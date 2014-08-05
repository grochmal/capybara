#!/usr/bin/env python

import os,sys
from PIL import Image
import numpy as np

__doc__ = '''
    Usage: colour.py hue-file [hue-file hue-file]
'''

# Scale 0-255 into 0-360 and add 15 degrees to account for red being centered
# at zero.  After this we have the following 12 bins:
#   0 -  29 : red           (r)
#  30 -  59 : orange red    (or)
#  60 -  89 : orange        (o)
#  90 - 119 : orange yellow (oy)
# 120 - 149 : yellow        (y)
# 150 - 179 : green yellow  (gy)
# 180 - 209 : green         (g)
# 210 - 239 : green blue    (gb)
# 240 - 269 : blue          (b)
# 270 - 299 : purple blue   (pb)
# 300 - 329 : purple        (p)
# 330 - 360 : purple red    (pr)

def itten12(f):
    hue_img = np.array(Image.open(f), 'uint32')
    v, bins = np.histogram(((hue_img*360/255)+15)%360, bins=12)
    stdev   = int(np.ceil(v.std()))
    colours = v - stdev
    colours[colours < 0] = 0
    for c in colours: print c,

if '__main__' == __name__:
    if 1 >= len(sys.argv):
        print __doc__
        exit(0)
    for a in sys.argv[1:]:
        if os.path.isfile(a) : itten12(a)
        else                 : print >> sys.stderr, a, ': no such file'
    print

