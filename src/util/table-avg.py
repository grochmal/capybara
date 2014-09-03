#!/usr/bin/env python

import os,sys
import numpy  as np
import pandas as pd
from itertools import chain

__doc__ = '''
    Usage: table-avg.py <dataset> <index column> <out top> <out bottom>
'''

def pfl(f):
    if 100 < f:
        return '%.1e' % f
    return '%.2f' % f

def avgs(dat, idx, topout, botout):
    schools = [ 'renaissance'
              , 'baroque'
              , 'neoclassicism'
              , 'romanticism'
              , 'impressionism'
              , 'mughal'
              ]
    lsf   = '_mean'
    rsf   = '_std'
    data  = pd.read_table( dat, delim_whitespace=True
                         , skipinitialspace=True, index_col=idx )
    grp   = data.groupby('school')
    means = grp.mean().transpose()[schools]
    stds  = grp.std().transpose()[schools]
    mcols = map(lambda x: x+lsf, means.columns)
    scols = map(lambda x: x+rsf, stds.columns)
    order = list(chain(*zip(mcols, scols)))
    table = means.join(stds, lsuffix=lsf, rsuffix=rsf)[order]
    kolix = map(lambda x: 'kol-'+x,table.index[0:54])
    table.index = kolix + table.index[54:192].tolist()
    with open(topout, 'wb') as t:
        t.write(table[order[0:6]].to_latex(header=False, float_format=pfl))
    with open(botout, 'wb') as b:
        b.write(table[order[6:12]].to_latex(header=False, float_format=pfl))

if '__main__' == __name__:
    if 5 != len(sys.argv):
        print __doc__
        exit(0)
    if not os.path.isfile(sys.argv[1]):
        print sys.argv[1], ': no such file'
        exit(1)
    avgs(*sys.argv[1:])

