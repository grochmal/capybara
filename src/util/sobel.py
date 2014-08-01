#!/usr/bin/env python

import os,sys
from PIL import Image
import numpy as np
from skimage import filter

__doc__ = '''
    Usage: sobel.py <raw gray image> <filtered image>
'''

def img_sobel(raw=None, filtered=None):
    raw_ar = np.array(Image.open(raw), 'uint8')
    sb = filter.sobel(raw_ar)
    im = Image.fromarray(np.array(255*(sb/sb.max()), 'uint8'))
    im.save(filtered)

if '__main__' == __name__:
    if 3 != len(sys.argv):
        print __doc__
        exit(0)
    if not os.path.isfile(sys.argv[1]):
        print sys.argv[1], ': no such file'
        exit(1)
    img_sobel(*sys.argv[1:])

