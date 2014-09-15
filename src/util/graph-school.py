#!/usr/bin/env python

import os,sys
import numpy  as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as plt

__doc__ = '''
    Usage: graph-school.py <dataset> <index column> <feature out> <sorted out>
'''

def avgs(dat, idx, fout, sout):
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
    ren = means['renaissance'].tolist()
    bar = means['baroque'].tolist()
    neo = means['neoclassicism'].tolist()
    rom = means['romanticism'].tolist()
    imp = means['impressionism'].tolist()
    mug = means['mughal'].tolist()
    plt.plot(fe, ren, '-r', label='renaissance')
    plt.plot(fe, bar, '-g', label='baroque')
    plt.plot(fe, neo, '-b', label='neoclassicism')
    plt.plot(fe, rom, '-c', label='romanticism')
    plt.plot(fe, imp, '-m', label='impressionism')
    plt.plot(fe, mug, '-y', label='mughal')
    plt.legend(loc='upper left')
    plt.xlabel('feature')
    plt.ylabel('mean value')
    #plt.show()
    plt.savefig(fout, dpi=150)
    plt.close()
    ren.sort()
    bar.sort()
    neo.sort()
    rom.sort()
    imp.sort()
    mug.sort()
    plt.plot(fe, ren, '-r', label='renaissance')
    plt.plot(fe, bar, '-g', label='baroque')
    plt.plot(fe, neo, '-b', label='neoclassicism')
    plt.plot(fe, rom, '-c', label='romanticism')
    plt.plot(fe, imp, '-m', label='impressionism')
    plt.plot(fe, mug, '-y', label='mughal')
    plt.legend(loc='upper left')
    plt.ylabel('feature mean value')
    #plt.show()
    plt.savefig(sout, dpi=150)

if '__main__' == __name__:
    if 5 != len(sys.argv):
        print __doc__
        exit(0)
    if not os.path.isfile(sys.argv[1]):
        print sys.argv[1], ': no such file'
        exit(1)
    avgs(*sys.argv[1:])

