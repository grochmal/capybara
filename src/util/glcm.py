#!/usr/bin/env python

import os,sys
from PIL import Image
import numpy as np
from skimage import feature

__doc__ = '''
    Usage: glcm.py file [file file ...]
'''

def glcm_fe(f):
    # 1 pixel, 6 pixesls, 20 pixels
    grey = np.array(Image.open(f), 'uint8')
    glcm = feature.greycomatrix(grey,[1,6,20],[np.pi])
    cont = feature.greycoprops(glcm, 'contrast')
    enrg = feature.greycoprops(glcm, 'energy')
    hmgn = feature.greycoprops(glcm, 'homogeneity')
    corr = feature.greycoprops(glcm, 'correlation')
    for i in cont[:,0]: print i,
    for i in enrg[:,0]: print "%.3f" % i,
    for i in hmgn[:,0]: print "%.3f" % i,
    for i in corr[:,0]:
        if np.isnan(i): i = 1
        print "%.3f" % i,

if '__main__' == __name__:
    if 1 >= len(sys.argv):
        print __doc__
        exit(0)
    for a in sys.argv[1:]:
        if os.path.isfile(a) : glcm_fe(a)
        else                 : print >> sys.stderr, a, ': no such file'
    print

