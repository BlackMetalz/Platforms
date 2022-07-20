#!/usr/bin/python3
# Author: kienlt
# Description: Check heap size all nodes in cluster Elasticsearch
import argparse
import sys

import requests
from requests.auth import HTTPBasicAuth


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
        elif not self.args.threshold:
            print("Missing threshold args")

        response = requests.get('http://%s:9200/_nodes/stats/jvm' % self.args.host,
                                auth=HTTPBasicAuth(self.args.user, self.args.password))

        data = response.json()

        ok_data = list()

        crit_data = list()

        for k, v in data['nodes'].items():
            for _k1, _v1 in v['jvm'].items():
                if _k1 == 'mem':
                    for _k2, _v2 in _v1.items():
                        if _k2 == 'heap_used_percent':
                            ok_data.append("%s heap used: %s" % (v['name'], _v2))
                            if _v2 >= self.args.threshold:
                                crit_data.append("%s heap used: %s" % (v['name'], _v2))

        # print(check_list)
        # check list is not empty - alert
        if not crit_data:
            print("The heap usage cluster is ok! %s" % ok_data)
            sys.exit(0)
        else:
            print("The heap usage of cluster is in crit! %s " % crit_data)
            sys.exit(2)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-H", "--host", help="Elasticsearch Host", type=str)
    parser.add_argument("-u", "--user", help="Elasticsearch User", type=str)
    parser.add_argument("-p", "--password", help="Elasticsearch Pass", type=str)
    parser.add_argument("-c", "--threshold", help="Threshold for alert", type=int)
    args = parser.parse_args()

    check = Check(args)
