#!/usr/bin/python3
# Check state snapshot of multi cluster
# Tested with Opendistro for Elasticsearch  ( 7.8 -> 7.10 )
# Author: Kienlt

import sys
import requests
from requests.auth import HTTPBasicAuth

_information = {
    "c1":       {"host": "10.0.0.1",  "user": "admin", "pass": "wtf", "repo": "backup"},
    "c2":             {"host": "10.0.0.2", "user": "admin", "pass": "wtf", "repo": "backup-repo"},
}

# Init empty list
snapshot_fail = list()
snapshot_success = list()

def get_value_by_key(val, my_dict):
    for key, value in my_dict.items():
        if val == key:
            return value
    return "key doesn't exist"


def Check_Snapshot_Status(_cluster, _host, _repo, _user, _pass):
    # start auth for get json data
    _res = requests.get('http://%s:9200/_snapshot/%s/*' % (_host, _repo), auth=HTTPBasicAuth(_user, _pass))
    data = _res.json()

    # Access data of snapshots
    for _data in data['snapshots']:
        snapshot_name = get_value_by_key('snapshot', _data)
        state = get_value_by_key('state', _data)
        # If state is not success, append to snapshot_fail list
        if state == 'FAILED' or state == 'PARTIAL':
            snapshot_fail.append("Cluster: %s. State of %s: %s " % (_cluster, snapshot_name, state))
        if state == 'SUCCESS':
            snapshot_success.append("Cluster: %s. State of %s: %s " % (_cluster, snapshot_name, state))

def report_snapshot_status():
    if not snapshot_fail:
        print("Snapshot is in success state: %s" % snapshot_success)
        sys.exit(0) # OK
    # check list is not empty - alert
    else:
        print("Snapshot is not in success state: %s " % snapshot_fail)
        sys.exit(2) # CRIT

# Start check, gather result
for k, v in _information.items():
    _cluster = k
    _user = get_value_by_key('user', v)
    _repo = get_value_by_key('repo', v)
    _pass = get_value_by_key('pass', v)
    _host = get_value_by_key('host', v)
    Check_Snapshot_Status(_cluster, _host, _repo, _user, _pass)

# Final. Report
report_snapshot_status()
