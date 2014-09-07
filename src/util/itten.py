#!/usr/bin/env python

import os,sys
from PIL import Image
import numpy as np
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
            l.append( [ (0 <= crop).sum() , crop ] )
    l.sort(key=lambda x: x[0])
    l.reverse()
    return l

def chopimg(ar, p):
    yn, xn = ar.shape
    size   = (yn*xn)/(p*p)
    bits   = [0 for i in range(p*p)]
    for i in range(p):
        for j in range(p):
            bits[i*p+j] = [ size , ar[yn*i/p:yn*(i+1)/p,xn*j/p:xn*(j+1)/p] ]
    return bits

def segm(img):
    den      = rank.median(img, morph.disk(3))
    # continuous regions (low gradient)
    markers  = rank.gradient(den, morph.disk(5)) < 10
    mrk, tot = ndimage.label(markers)
    grad     = rank.gradient(den, morph.disk(2))
    labels   = morph.watershed(grad, mrk)
    return seg_regions(img, labels, tot)

def contrast_hsl(regs, d):
    avgs  = []
    for reg in regs:
        size  = (reg[1] >= 0).sum()
        avg   = (reg[1].sum()) / size
        avgs += [avg] * reg[0]
    print '%.6f' % np.array(avgs).std(),

def scale_hue(regs):
    for reg in regs: reg[1] = ((np.ma.array(reg[1], np.uint32)*360/255)+15)%360

# contrast only regions bigger than 548 pixels (square root of 300 000)
def filter_small_regions(regs): return filter(lambda x: x[0] >= 548, regs)

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

def contrast_wc(regs):
    nonzero = lambda x: x if abs(x) > 0.1 else 0.1  # damping
    def contr(w1,w2,c1,c2):
        n1 = nonzero(1 - w1 - c1)
        n2 = nonzero(1 - w2 - c2)
        return max(abs(w1/w2-c1/c2),abs(w2/w1-c2/c1))/((n1+0.5)*(n2+0.5))
    wcvals = []
    bigs   = filter_small_regions(regs)
    for reg in bigs:
        size    = (reg[1] >= 0).sum()
        v, bins = np.histogram(reg[1][~reg[1].mask], bins=12)
        warm    = float(v[[0,1,2,3]].sum())/size  # red to orange yellow
        cold    = float(v[[6,7,8,9]].sum())/size  # green to purple blue
        wcvals.append(map(nonzero, [warm, cold]))
    contrasts = [contr(i[0],j[0],i[1],j[1]) for j in wcvals for i in wcvals]
    contrasts.sort()
    print '%.6f' % contrasts[-1],

def contrast_comp(dregs, divs, threshold):
    for d in divs:
        bigs      = filter_small_regions(dregs[d])
        means     = map(lambda x: x[1].mean(), bigs)
        contrasts = [min(abs(i-j),360-abs(i-j)) for i in means for j in means]
        if 'sg' == d:
            print len(filter(lambda x: x >= threshold, contrasts)) / 2,
        else:
            contrasts.sort()
            print '%.6f' % contrasts[-1],

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
            contrast_hsl(i[d], d)
    # scale to 0-360 and make all hue arrays into masked arrays
    map(scale_hue, [hi[x] for x in divs] + [csi[x] for x in divs])
    for i in [hi, csi]:
        for d in divs:
            contrast_hsl(i[d], d)
            contrast_wc(i[d])
    contrast_comp(hi,  divs, 160)
    contrast_comp(csi, divs, 125)  # 160*200/255 (scaled by saturation)

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

