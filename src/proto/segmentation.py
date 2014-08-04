#!/usr/bin/env python

import sys,os
from PIL import Image
import numpy as np
from scipy import ndimage
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from skimage import morphology as morph
from skimage.filter import rank

__doc__ = 'Usage: segmentation.py file [output]'

def big_regions(lb, tot):
    l = []
    for i in range(1, tot+1):
        l.append((sum(sum(i == lb)), i))
    l.sort()
    l.reverse()
    return l

def segment(img, outimg):
    img = np.array(Image.open(img))
    den = rank.median(img, morph.disk(3))
    # continuous regions (low gradient)
    markers  = rank.gradient(den, morph.disk(5)) < 10
    mrk, tot = ndimage.label(markers)
    grad     = rank.gradient(den, morph.disk(2))
    labels   = morph.watershed(grad, mrk)
    print 'Total regions:', tot
    regs = big_regions(labels, tot)

    plt.subplot(3,6,1)
    plt.imshow(img,    cmap=cm.gray,     interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('image')
    plt.subplot(3,6,2)
    plt.imshow(den,    cmap=cm.gray,     interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('denoised')
    plt.subplot(3,6,3)
    plt.imshow(grad,   cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('gradient')
    plt.subplot(3,6,4)
    plt.imshow(mrk,    cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('markers')
    plt.subplot(3,6,5)
    plt.imshow(labels, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('regions\n(%i)' % tot)
    plt.subplot(3,6,6)
    plt.imshow(img,    cmap=cm.spectral, interpolation='nearest')
    plt.imshow(labels, cmap=cm.spectral, interpolation='nearest', alpha=0.7)
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('composite')

    plt.subplot(3,6,7)
    masked = np.ma.masked_array(labels, ~(labels == regs[0][1]))
    plt.imshow(masked, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('main region')
    plt.subplot(3,6,8)
    masked = np.ma.masked_array(labels, ~(labels == regs[1][1]))
    plt.imshow(masked, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('2nd region')
    plt.subplot(3,6,9)
    masked = np.ma.masked_array(labels, ~(labels == regs[2][1]))
    plt.imshow(masked, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('3rd region')
    plt.subplot(3,6,10)
    masked = np.ma.masked_array(labels, ~(labels == regs[3][1]))
    plt.imshow(masked, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('4th region')
    plt.subplot(3,6,11)
    masked = np.ma.masked_array(labels, ~(labels == regs[4][1]))
    plt.imshow(masked, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('5th region')
    plt.subplot(3,6,12)
    masked = np.ma.masked_array(labels, ~(labels == regs[5][1]))
    plt.imshow(masked, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('6th region')

    plt.subplot(3,6,13)
    masked = np.ma.masked_array(labels, ~(labels == regs[0][1]))
    crop   = masked[~np.all(masked == 0, axis=1), :]
    crop   = crop[:, ~np.all(crop == 0, axis=0)]
    plt.imshow(crop, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('main region')
    plt.subplot(3,6,14)
    masked = np.ma.masked_array(labels, ~(labels == regs[1][1]))
    crop   = masked[~np.all(masked == 0, axis=1), :]
    crop   = crop[:, ~np.all(crop == 0, axis=0)]
    plt.imshow(crop, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('2nd region')
    plt.subplot(3,6,15)
    masked = np.ma.masked_array(labels, ~(labels == regs[2][1]))
    crop   = masked[~np.all(masked == 0, axis=1), :]
    crop   = crop[:, ~np.all(crop == 0, axis=0)]
    plt.imshow(crop, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('3rd region')
    plt.subplot(3,6,16)
    masked = np.ma.masked_array(labels, ~(labels == regs[3][1]))
    crop   = masked[~np.all(masked == 0, axis=1), :]
    crop   = crop[:, ~np.all(crop == 0, axis=0)]
    plt.imshow(crop, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('4th region')
    plt.subplot(3,6,17)
    masked = np.ma.masked_array(labels, ~(labels == regs[4][1]))
    crop   = masked[~np.all(masked == 0, axis=1), :]
    crop   = crop[:, ~np.all(crop == 0, axis=0)]
    plt.imshow(crop, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('5th region')
    plt.subplot(3,6,18)
    masked = np.ma.masked_array(labels, ~(labels == regs[5][1]))
    crop   = masked[~np.all(masked == 0, axis=1), :]
    crop   = crop[:, ~np.all(crop == 0, axis=0)]
    plt.imshow(crop, cmap=cm.spectral, interpolation='nearest')
    plt.yticks([])
    plt.xticks([])
    plt.xlabel('6th region')

    #plt.savefig('test.eps', dpi=300)
    plt.savefig(outimg, dpi=300)
    #plt.show()

if '__main__' == __name__:
    if 3 != len(sys.argv):
        print __doc__
        exit(0)
    if os.path.isfile(sys.argv[1]) : segment(sys.argv[1], sys.argv[2])
    else                           : print sys.argv[1], ': no such file'

