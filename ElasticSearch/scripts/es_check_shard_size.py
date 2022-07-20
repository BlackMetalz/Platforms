#!/usr/bin/python3
# Author: kienlt
# For check mk plugin
# Usage: Monitor shard size. If pri.store.size > shard * pri.store.size. Send Critical state.
import argparse
import sys

import requests
from requests.auth import HTTPBasicAuth

shard_size_threshold = 50
threshold_unit = "gb"


class Check:
    def __init__(self, args):
        self.args = args

        if not self.args.host:
            print("Missing Host args")
            argparse.ArgumentParser().print_help()
            sys.exit(1)
        elif not self.args.user:
            print("Missing User args")
            argparse.ArgumentParser().print_help()
            sys.exit(1)
        elif not self.args.password:
            print("Missing Password args")
            argparse.ArgumentParser().print_help()
            sys.exit(1)

        response = requests.get(
            "http://%s:9200/_cat/indices?format=json&h=index,pri,pri.store.size" % self.args.host,
            auth=HTTPBasicAuth(self.args.user, self.args.password))

        data = response.json()

        crit_list = list()

        for k in data:
            if k['pri.store.size']:
                if threshold_unit in k['pri.store.size']:
                    shard_var = k['pri.store.size'].replace(threshold_unit, '')
                    shard_count = int(k['pri'])
                    shard_size = float(shard_var)
                    if shard_size > shard_size_threshold * shard_count:
                        crit_list.append("Index:%s|Shard:%s|Size:%s" % (k['index'], k['pri'], k['pri.store.size']))

        if crit_list:
            print("Index shard is in critical warning: %s" % crit_list)
            sys.exit(2)
        else:
            print("Shard usage for index: OK!")
            sys.exit(0)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-H", "--host", help="Elasticsearch Host", type=str)
    parser.add_argument("-u", "--user", help="Elasticsearch User", type=str)
    parser.add_argument("-p", "--password", help="Elasticsearch Pass", type=str)
    args = parser.parse_args()
    check = Check(args)
