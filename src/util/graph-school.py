#!/usr/bin/env python

import os,sys
import numpy  as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt

__doc__ = '''
    Usage: graph-school.py <dataset> <index column> <output>
'''

def avgs(dat, idx, out):
    schools     = [ 'renaissance'
                  , 'baroque'
                  , 'neoclassicism'
                  , 'romanticism'
                  , 'impressionism'
                  , 'mughal'
                  ]
    data        = pd.read_table( dat, delim_whitespace=True
                               , skipinitialspace=True, index_col=idx )
    df          = data[data.columns[3:]]
    df.index    = data.school
    d           = (df - df.min()) / (df.max() - df.min())
    d['school'] = d.index
    grp         = d.groupby('school')
    means       = grp.mean().transpose()[schools]
    fe          = range(192)
    plt.plot(fe, means['renaissance'].tolist(),   '-r', label='renaissance')
    plt.plot(fe, means['baroque'].tolist(),       '-g', label='baroque')
    plt.plot(fe, means['neoclassicism'].tolist(), '-b', label='neoclassicism')
    plt.plot(fe, means['romanticism'].tolist(),   '-c', label='romanticism')
    plt.plot(fe, means['impressionism'].tolist(), '-m', label='impressionism')
    plt.plot(fe, means['mughal'].tolist(),        '-y', label='mughal')
    plt.legend(loc='upper left')
    plt.xlabel('feature')
    plt.ylabel('mean value')
    plt.savefig(out, dpi=150)

if '__main__' == __name__:
    if 4 != len(sys.argv):
        print __doc__
        exit(0)
    if not os.path.isfile(sys.argv[1]):
        print sys.argv[1], ': no such file'
        exit(1)
    avgs(*sys.argv[1:])

