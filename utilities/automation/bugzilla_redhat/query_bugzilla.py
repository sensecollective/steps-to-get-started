#!/usr/bin/python3

import os
import urllib
import requests
from bs4 import BeautifulSoup

email_id = 'arcsharm@redhat.com'

EMAIL = urllib.parse.quote(email_id)

# todo: sanitize params and take inputs from config file / cmdline
URL = 'https://bugzilla.redhat.com/buglist.cgi?bug_status=NEW&bug_status=ASSIGNED&bug_status=POST&bug_status=MODIFIED&bug_status=ON_DEV&bug_status=ON_QA&bug_status=VERIFIED&bug_status=RELEASE_PENDING&bug_status=CLOSED&email1=%s&emailassigned_to1=1&emailcc1=1&emailreporter1=1&emailtype1=exact&query_format=advanced&ctype=rss' % EMAIL

FPATH = './bugzilla_results_%s.xml' % EMAIL

try:    
    if not os.path.exists(FPATH):
        print("querying URL because FPATH was not found..")
        res = requests.get(URL)
        with open(FPATH, 'w') as f:
            f.write(res.text)
        print("saving data to path: %s" % FPATH)
        data = BeautifulSoup(res.text, "lxml")
    else:
        with open(FPATH, 'r') as f:
            data = BeautifulSoup(f.read(), "lxml")
except:
    raise

for e in data.find_all('entry'):
    print(e.title.text)


# import json
# from pprint import pprint


# URL_EXAMPLE_ID = """https://bugzilla.redhat.com/jsonrpc.cgi?method=Bug.get&params=[{"ids":[1511897]}]"""

# print("\n\n...querying URL: %s" % URL_EXAMPLE_ID)

# pprint(json.loads(requests.get(URL_EXAMPLE_ID).text))

