#!/usr/bin/env python

import os,sys
from PIL import Image
import numpy as np

__doc__ = '''
    Usage: sv2cs.py <value channel> <saturation channel> <colourfullness>
'''

# calculates the "colourfulness": a pixel by pixel multiplication between
# S and V channels (from the HSV colour space) is performed and then scaled
# back to greyscale units (0-255).
def sv2cs(value=None, saturation=None, colourfulness=None):
    v = np.array(Image.open(value), 'uint16')
    s = np.array(Image.open(saturation), 'uint16')
    c = np.array(s*v/255, 'uint8')
    im = Image.fromarray(c)
    im.save(colourfulness)

if '__main__' == __name__:
    if 4 != len(sys.argv):
        print __doc__
        exit(0)
    if not os.path.isfile(sys.argv[1]):
        print sys.argv[1], ': no such file'
        exit(1)
    if not os.path.isfile(sys.argv[2]):
        print sys.argv[2], ': no such file'
        exit(1)
    sv2cs(*sys.argv[1:])

