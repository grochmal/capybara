#!/usr/bin/env python

import os,sys
import numpy  as np
import pandas as pd

__doc__ = '''
    Usage: table-predict.py <dataset> <index column> <out artist> <out school>
'''

def predict(dat, idx, outa, outs):
    data   = pd.read_table( dat, delim_whitespace=True
                          , skipinitialspace=True, index_col=idx )
    artist = data[data.index == 'artist-predict']
    sorta  = artist.sort(columns='class')
    col1   = sorta[0:19].values
    col2   = sorta[19:38].values
    col3   = sorta[38:56].values
    art    = ''
    sch    = ''
    for i in range(18):
        row = [ '%-12s' % col1[i,0], '%6.2f' % col1[i,2]
              , '%-12s' % col2[i,0], '%6.2f' % col2[i,2]
              , '%-12s' % col3[i,0], '%6.2f' % col3[i,2]
              ]
        art += ' & '.join(row) + ' \\\\\n'
    row = [ '%-12s' % col1[18,0], '%6.2f' % col1[18,2]
          , '%-12s' % col2[18,0], '%6.2f' % col2[18,2]
          , ' '*12              , ' '*6
          ]
    art += ' & '.join(row) + ' \\\\\n'
    school = data[data.index == 'school-predict'].values
    row    = [ '%-13s' % 'renaissance' , '%6.2f' % school[0,2]
             , '%-13s' % 'romanticism' , '%6.2f' % school[3,2]
             ]
    sch += ' & '.join(row) + ' \\\\\n'
    row    = [ '%-13s' % 'baroque'       , '%6.2f' % school[1,2]
             , '%-13s' % 'impressionism' , '%6.2f' % school[4,2]
             ]
    sch += ' & '.join(row) + ' \\\\\n'
    row    = [ '%-13s' % 'neoclassicism' , '%6.2f\n' % school[2,2]]
    sch += ' & '.join(row)
    mughal = data[data.index == 'mughal'].values
    sch += '  & \cellcolor[gray]{0.9} mughal & \cellcolor[gray]{0.9} '
    sch += str(mughal[0,2]) + ' \\\\\n'
    with open(outa, 'wb') as a:
        a.write(art)
    with open(outs, 'wb') as s:
        s.write(sch)

if '__main__' == __name__:
    if 5 != len(sys.argv):
        print __doc__
        exit(0)
    if not os.path.isfile(sys.argv[1]):
        print sys.argv[1], ': no such file'
        exit(1)
    predict(*sys.argv[1:])

