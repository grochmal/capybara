#!/usr/bin/env python

import os,sys
import numpy  as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt

__doc__ = '''
    Usage: graph-corr.py <dataset> <index column> <output>
'''

def plotcorrs(dat, idx, out):
    data = pd.read_table( dat, delim_whitespace=True
                         , skipinitialspace=True, index_col=idx )
    corr = abs(np.corrcoef(data.transpose()[3:]))
    x    = range(corr.shape[0])
    plt.plot(x, corr[0],   'vr', label='kol-nofilter-cs60')
    plt.plot(x, corr[36],  '^g', label='kol-canny-cs60')
    plt.plot(x, corr[72],  'ob', label='glcm-h-hm1')
    plt.plot(x, corr[108], 'sc', label='glcm-shsv-hm1')
    plt.plot(x, corr[144], 'pm', label='r3-shsl-avg')
    plt.plot(x, corr[180], 'Dy', label='cs-avg')
    plt.legend(loc='upper left', numpoints=1)
    plt.xlabel('feature')
    plt.ylabel('correlation coefficient (absolute value)')
    plt.savefig(out, dpi=150)

if '__main__' == __name__:
    if 4 != len(sys.argv):
        print __doc__
        exit(0)
    if not os.path.isfile(sys.argv[1]):
        print sys.argv[1], ': no such file'
        exit(1)
    plotcorrs(*sys.argv[1:])

