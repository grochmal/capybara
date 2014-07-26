#!/usr/bin/env python

import urllib as l
import json   as j
import sys
from time import sleep

# e.g. search?objectnamesearch=painting&limit=10&offset=120
#
# { "meta" : { "clusters"       : []
#            , "cluster_counts" : {}
#            , "group_deatils"  : []
#            , "result_count"   : 2000
#            }
# , "records" : [ { "pk"     : 123456
#                 , "model"  : "collection.museumobject"
#                 , "fields" : { "primary_image_id" : "2006AH4555"
#                              , "object"           : "Some painting"
#                              , "year_start"       : 1574
#                              , "artist"           : "Laurent, Jean"
#                              , "object_number"    : "O1065417"
#                              , "title"            : "Painting of someone"
#                              , "place"            : "Madrid"
#                              , ...
#                              }
#                 }
#               , { "pk"     : 654321
#                 , "model"  : "collection.museumobject"
#                 , "fields" : { ...
#                              }
#               , ...
#             ]
# }

VAMURL = 'http://www.vam.ac.uk/api/json/museumobject/search?'
LIMIT  = 10

def fetch_vam(object, limit, offset):
    url = VAMURL + 'objectnamesearch=' + object \
                 + '&limit=' + str(limit) + '&offset=' + str(offset)
    print >> sys.stderr, 'fetch', url
    return j.loads(l.urlopen(url).read())

def get_all(object):
    offset = 0
    count_recs = fetch_vam(object,1,offset)
    count = count_recs['meta']['result_count']
    if 1 > count:
        print 'No records to fetch,', count, 'records'
        return None
    print >> sys.stderr, 'Will fetch', count, 'records'
    while offset < count:
        this_limit = LIMIT
        if LIMIT > count - offset: this_limit = count - offset
        offset += LIMIT
        sleep(1)
        recs = fetch_vam(object,this_limit,offset)['records']
        for r in recs: print j.dumps(r['fields'])

if '__main__' == __name__:
    get_all('painting')

