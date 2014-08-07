#!/usr/bin/env python

#   0 -  29 : red           (r)  --\
#  30 -  59 : orange red    (or)   |  warm
#  60 -  89 : orange        (o)    | colours
#  90 - 119 : orange yellow (oy) --/
# 120 - 149 : yellow        (y)
# 150 - 179 : green yellow  (gy)
# 180 - 209 : green         (g)  --\
# 210 - 239 : green blue    (gb)   |  cold
# 240 - 269 : blue          (b)    | colours
# 270 - 299 : purple blue   (pb) --/
# 300 - 329 : purple        (p)
# 330 - 360 : purple red    (pr)

import os,sys
from PIL import Image
import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt
from matplotlib import cm
from scipy import ndimage
from skimage import morphology as morph
from skimage.filter import rank

__doc__ = '''
Usage: itten.py hsl_saturation hsv_saturation value lightness hue cs
'''

def seg_regions(img, lb, tot):
    l = []
    for i in range(1, tot+1):
        masked = np.ma.masked_array(img, ~(lb == i))
        crop   = masked[~np.all(masked == 0, axis=1), :]
        crop   = crop[:, ~np.all(crop == 0, axis=0)]
        if (0,0) != crop.shape:
            # ignore empty crops (it might happen as we use uint8)
            l.append(((i == lb).sum(), crop))
    l.sort(key=lambda x: x[0])
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

def chopimg(ar, p):
    yn, xn = ar.shape
    size   = (yn*xn)/(p*p)
    bits   = [0 for i in range(p*p)]
    for i in range(p):
        for j in range(p):
            bits[i*p+j] = (size,ar[yn*i/p:yn*(i+1)/p,xn*j/p:xn*(j+1)/p])
    return bits

def plotchops(img, ps, p):
    plt.subplot(p+1,p,p/2+1)
    plt.imshow(img, cmap=cm.gray)
    plt.xticks([])
    plt.yticks([])
    for i in range(p*p):
        plt.subplot(p+1,p,p+1+i)
        plt.imshow(ps[i][1], cmap=cm.gray)
        plt.xticks([])
        plt.yticks([])
        plt.xlabel('%i px' % ps[i][0])

def segm(img):
    den      = rank.median(img, morph.disk(3))
    markers  = rank.gradient(den, morph.disk(5)) < 10
    mrk, tot = ndimage.label(markers)
    grad     = rank.gradient(den, morph.disk(2))
    labels   = morph.watershed(grad, mrk)
    return seg_regions(img, labels, tot)

def contrast_sl(regs, pixels):
    #ratio = 1/float(pixels)
    avgs  = []
    for reg in regs:
        avg = (reg[1].sum()) / ((reg[1] > 0).sum())
        #avgs.append(reg[0] * ratio * avg)
        avgs += [avg] * reg[0]
    #print ratio, regs[0][0], avgs, np.array(avgs).std()
    print '%.6f' % np.array(avgs).std(),

def contrast_hue(regs, pixels):
    #ratio = 1/float(pixels)
    avgs  = []
    #print regs[-1]
    for reg in regs:
        hue = ((np.ma.array(reg[1], np.uint32)*360/255)+15)%360
        # this only happens with reg for hues (why?)
        # OK, found it: sometimes empty crops are produced
#        if hue.shape == (0,0): print reg[0], reg[1].shape, hue
#        print reg[0], reg[1].shape  #, hue
#        print hue.dtype
        avg = (reg[1].sum()) / ((reg[1] > 0).sum())
#        avgs.append(reg[0] * ratio * avg)
#        avgs.append(avg)
        avgs += [avg] * reg[0]
    print '%.6f' % np.array(avgs).std(),

def itten_contrasts(shsl, shsv, l, v, h, cs):
    divs  = ['r3', 'r7', 'sg']
    shsli = { 'img' : np.array(Image.open(shsl) , np.uint8) }
    shsvi = { 'img' : np.array(Image.open(shsv) , np.uint8) }
    li    = { 'img' : np.array(Image.open(l)    , np.uint8) }
    vi    = { 'img' : np.array(Image.open(v)    , np.uint8) }
    hi    = { 'img' : np.array(Image.open(h)    , np.uint8) }
    csi   = { 'img' : np.array(Image.open(cs)   , np.uint8) }
    for i in [shsli, shsvi, li, vi, hi, csi]:
        i['r3'] = chopimg(i['img'], 3)
        i['r7'] = chopimg(i['img'], 7)
        i['sg'] = segm(i['img'])
    for i in [shsli, shsvi, li, vi]:
        for d in divs:
            contrast_sl(i[d], np.multiply(*i['img'].shape))
    for i in [hi, csi]:
        for d in divs:
            contrast_hue(i[d], np.multiply(*i['img'].shape))
    #contrast_sl(shsli['r3'], np.multiply(*shsli['img'].shape))
    #contrast_sl(shsli['r7'], np.multiply(*shsli['img'].shape))
    #contrast_sl(shsli['sg'], np.multiply(*shsli['img'].shape))
    #contrast_sl(shsvi['r3'])
    #contrast_sl(shsvi['r7'])
    #contrast_sl(shsvi['sg'])
    #spr = 3
    #spc = 6
    #plot_seg(spr,spc, 1, li['sg'][ 0][1], cm.gray, 1, '%i px'% li['sg'][ 0][0])
    #plot_seg(spr,spc, 2, li['sg'][ 1][1], cm.gray, 1, '%i px'% li['sg'][ 1][0])
    #plot_seg(spr,spc, 3, li['sg'][ 2][1], cm.gray, 1, '%i px'% li['sg'][ 2][0])
    #plot_seg(spr,spc, 4, li['sg'][ 3][1], cm.gray, 1, '%i px'% li['sg'][ 3][0])
    #plot_seg(spr,spc, 5, li['sg'][ 4][1], cm.gray, 1, '%i px'% li['sg'][ 4][0])
    #plot_seg(spr,spc, 6, li['sg'][ 5][1], cm.gray, 1, '%i px'% li['sg'][ 5][0])
    #plotchops(shsli['img'], shsli['r7'], 7)
    #plt.show()

if '__main__' == __name__:
    if 7 != len(sys.argv):
        print __doc__
        exit(0)
    for a in sys.argv[1:]:
        if not os.path.isfile(a) :
            print >> sys.stderr, a, ': no such file'
            exit(1)
    itten_contrasts(*sys.argv[1:])
    print

