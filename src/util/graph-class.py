#!/usr/bin/env python

import os,sys
import numpy  as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt

__doc__ = '''
    Usage: graph-class.py <dataset> <index column> <output>
'''

def plotclass(dat, idx, out):
    data   = pd.read_table( dat, delim_whitespace=True
                          , skipinitialspace=True, index_col=idx )
    artist = data[data.index == 'artist-predict']
    school = data[data.index == 'school-predict']
    sorta  = artist.sort(columns='sample')
    sorts  = school.sort(columns='sample')
    plt.plot(sorta['sample']*7, sorta['accuracy'], '-r', label='artists')
    plt.plot(sorts['sample'],   sorts['accuracy'], '-c', label='schools')
    plt.yticks(range(0,100,20))
    plt.legend(loc='lower right')
    plt.xlabel('number of paintings (scaled)')
    plt.ylabel('classification accuracy')
    plt.savefig(out, dpi=150)

if '__main__' == __name__:
    if 4 != len(sys.argv):
        print __doc__
        exit(0)
    if not os.path.isfile(sys.argv[1]):
        print sys.argv[1], ': no such file'
        exit(1)
    plotclass(*sys.argv[1:])

