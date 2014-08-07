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
        l.append(((i == lb).sum(), i))
    l.sort()
    l.reverse()
    return l

def plot_seg(spr, spc, sps, img, cmap, alpha, xlabel):
    plt.subplot(spr, spc, sps)
    plt.imshow(img, cmap=cmap, interpolation='nearest', alpha=alpha)
    plt.yticks([])
    plt.xticks([])
    plt.xlabel(xlabel)

def plot_mask(spr, spc, sps, reg, lb, regs, cmap, xlabel):
    masked = np.ma.masked_array(lb, ~(lb == regs[reg][1]))
    plot_seg(spr, spc, sps, masked, cmap, 1, xlabel)

def plot_crop(spr, spc, sps, reg, img, lb, regs, cmap):
    masked = np.ma.masked_array(img, ~(lb == regs[reg][1]))
    crop   = masked[~np.all(masked == 0, axis=1), :]
    crop   = crop[:, ~np.all(crop == 0, axis=0)]
    plot_seg(spr, spc, sps, crop, cmap, 1, '%i px' % regs[reg][0])

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

    spr = 3
    spc = 6
    plot_seg(spr, spc, 1, img,    cm.gray,     1,   'image')
    plot_seg(spr, spc, 2, den,    cm.gray,     1,   'denoised')
    plot_seg(spr, spc, 3, grad,   cm.spectral, 1,   'gradient')
    plot_seg(spr, spc, 4, mrk,    cm.spectral, 1,   'markers')
    plot_seg(spr, spc, 5, labels, cm.spectral, 1,   'regions\n%i' % tot)
    plot_seg(spr, spc, 6, img,    cm.gray,     1,   'composite')
    plot_seg(spr, spc, 6, labels, cm.spectral, 0.7, 'composite')

    plot_mask(spr, spc, 7,  0, labels, regs, cm.spectral, 'main region')
    plot_mask(spr, spc, 8,  1, labels, regs, cm.spectral, '2nd region')
    plot_mask(spr, spc, 9,  2, labels, regs, cm.spectral, '3rd region')
    plot_mask(spr, spc, 10, 3, labels, regs, cm.spectral, '4th region')
    plot_mask(spr, spc, 11, 4, labels, regs, cm.spectral, '5th region')
    plot_mask(spr, spc, 12, 5, labels, regs, cm.spectral, '6th region')

    plot_crop(spr, spc, 13, 0, img, labels, regs, cm.gray)
    plot_crop(spr, spc, 14, 1, img, labels, regs, cm.gray)
    plot_crop(spr, spc, 15, 2, img, labels, regs, cm.gray)
    plot_crop(spr, spc, 16, 3, img, labels, regs, cm.gray)
    plot_crop(spr, spc, 17, 4, img, labels, regs, cm.gray)
    plot_crop(spr, spc, 18, 5, img, labels, regs, cm.gray)

    #plt.savefig('test.eps', dpi=300)
    plt.savefig(outimg, dpi=300)
    #plt.show()

if '__main__' == __name__:
    if 3 != len(sys.argv):
        print __doc__
        exit(0)
    if os.path.isfile(sys.argv[1]) : segment(sys.argv[1], sys.argv[2])
    else                           : print sys.argv[1], ': no such file'

