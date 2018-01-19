#!/usr/bin/env python3

import json


data = json.loads(open('sar_doc.json','r').read())
new = ''
for item in data:
    t = item.pop('_timestamp')
    s = item.pop('_source')
    item.pop('_op_type'); item['_index'] = 'test-vos'
    new += "\n" + json.dumps({'index' : item })
    s['_timestamp'] = t
    for i in s['power-management']['cpu-frequency']:
        i['number'] = str(i['number'])
    for i in s['cpu-load-all']:
        i['cpu'] = str(i['cpu'])
    new += "\n" + json.dumps(s)

open('requests_combined','w').write(new)
