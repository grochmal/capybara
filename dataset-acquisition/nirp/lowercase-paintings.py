#!/usr/bin/env python

import json
import fileinput

for line in fileinput.input():
    js = json.loads(line)
    js['image_id'] = js['image_id'].lower()
    print json.dumps(js)

