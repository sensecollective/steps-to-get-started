#!/usr/bin/python3

import os
import urllib
import requests
from bs4 import BeautifulSoup

# todo: sanitize params and take inputs from config file / cmdline
URL = 'https://bugzilla.redhat.com/buglist.cgi?bug_status=NEW&bug_status=ASSIGNED&bug_status=POST&bug_status=MODIFIED&bug_status=ON_DEV&bug_status=ON_QA&bug_status=VERIFIED&bug_status=RELEASE_PENDING&bug_status=CLOSED&component=API&component=Appliance&component=Automate&component=C%26U%20Capacity%20and%20Utilization&component=Performance&component=Providers&component=Provisioning&component=Replication&component=Reporting&component=SmartState%20Analysis&limit=0&list_id=8239177&order=bug_status%2Cext_bz_list%20DESC%2Ccomponent%2Cbug_id%20DESC&product=Red%20Hat%20CloudForms%20Management%20Engine&query_format=advanced&short_desc=RFE&short_desc_type=notregexp&version=5.6.0&version=5.7.0&version=5.8.0&version=5.9.0&version=6.0.0&ctype=rss'

FPATH = './bugzilla_results_56_to_60.xml'

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
        # print("reading data from FPATH %s" % FPATH)
except:
    raise

for e in data.find_all('entry'):
    print(e.title.text)
