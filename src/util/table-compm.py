#!/usr/bin/env python

import os,sys
import numpy  as np
import pandas as pd

__doc__ = '''
    Usage: table-compm.py <dataset> <index column> <out artist> <out school>
'''

def compm(dat, idx, outa, outs):
    arts   = [ 'titian'    , 'murillo'   , 'rembrandt'
             , 'canaletto' , 'constable' , 'monticelli' ]
    schs   = [ 'renaissance' , 'baroque'       , 'neoclassicism'
             , 'romanticism' , 'impressionism' , 'mughal'        ]
    schdot = [ 'renaiss.'  , 'baroque'     , 'neoclass.'
             , 'romantic.' , 'impression.' , 'mughal'    ]
    data   = pd.read_table( dat, delim_whitespace=True
                          , skipinitialspace=True, index_col=idx )
    school = data[data.index == 'school-diff']
    stab   = 'school & '
    stab  += ' & '.join(schdot[:-1]) + ' \\\\\n\\midrule\n'
    for i in range(1, len(schs)):
        stab += ('%-13s' % schs[i]) + ' & '
        row   = []
        for j in range(len(schs) - 1):
            if j >= i:
                row.append(' '*6)
                continue
            val   = school[school['class'] == schs[j]+'-'+schs[i]].values[0,2]
            row.append('%6.2f' % val)
        stab += ' & '.join(row) + ' \\\\\n'
    artist = data[data.index == 'artist-diff']
    atab   = 'artist & '
    atab  += ' & '.join(arts[:-1]) + ' \\\\\n\\midrule\n'
    for i in range(1, len(arts)):
        atab += ('%-13s' % arts[i]) + ' & '
        row   = []
        for j in range(len(arts) - 1):
            if j >= i:
                row.append(' '*6)
                continue
            val   = artist[artist['class'] == arts[j]+'-'+arts[i]].values[0,2]
            row.append('%6.2f' % val)
        atab += ' & '.join(row) + ' \\\\\n'
    with open(outa, 'wb') as a:
        a.write(atab)
    with open(outs, 'wb') as s:
        s.write(stab)

if '__main__' == __name__:
    if 5 != len(sys.argv):
        print __doc__
        exit(0)
    if not os.path.isfile(sys.argv[1]):
        print sys.argv[1], ': no such file'
        exit(1)
    compm(*sys.argv[1:])

