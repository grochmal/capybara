#!/usr/bin/env python

import os,sys
from PIL import Image
import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt
from matplotlib import cm

__doc__ = 'Usage: chopimg.py file n output'

def mark(ar, p):
    yn, xn = ar.shape
    xticks = [l*(xn/p) for l in range(1,p)]
    yticks = [l*(yn/p) for l in range(1,p)]
    for tic in xticks: ar[:,[tic-1,tic,tic+1]] = 255
    for tic in yticks: ar[[tic-1,tic,tic+1],:] = 255
    return ar

def chop(ar, p):
    yn, xn = ar.shape
    bits = [0 for i in range(p*p)]
    for i in range(p):
        for j in range(p):
            bits[i*p+j] = ar[yn*i/p:yn*(i+1)/p,xn*j/p:xn*(j+1)/p]
    return bits

def plot(img, ps, p):
    plt.subplot(p+1,p,p/2+1)
    plt.imshow(img, cmap=cm.gray)
    plt.xticks([])
    plt.yticks([])
    for i in range(p*p):
        plt.subplot(p+1,p,p+1+i)
        plt.imshow(ps[i], cmap=cm.gray)
        plt.xticks([])
        plt.yticks([])

def chop_img(img, n, out):
    im = np.array(Image.open(img))
    ps = chop(im, n)
    mk = mark(im.copy(), n)
    plot(mk, ps, n)
    #plt.show()
    plt.savefig(out, dpi=300)

if '__main__' == __name__:
    if 4 != len(sys.argv):
        print __doc__
        exit(0)
    if not os.path.isfile(sys.argv[1]):
        print sys.argv[1], ': no such file'
        exit(1)
    n = int(sys.argv[2])
    chop_img(sys.argv[1], n, sys.argv[3])

