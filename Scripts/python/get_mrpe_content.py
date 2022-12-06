#!/usr/bin/python
# Get mrpe in all server
# Author: Luong Trung Kien
import salt.client
import os
import sys

path="/srv/saltstack/salt/check-mk-agent/files/mrpe"

client = salt.client.LocalClient()
print("Loading data")
minions = client.cmd('*','cmd.run', ['cat /etc/check_mk/mrpe.cfg'], full_return=True)
print "Load data done"
# Load minino items
for k,v in minions.items():
    #print k,v
    # create folder first
    create_folder_path = "mkdir -p %s/%s" % (path,k)
    os.system(create_folder_path)
    # Check minion is dict ( in case of minion don't return )
    if isinstance(v,dict):
        if v['retcode'] == 1:
            print "%s: do not have mrpe file" % k
        elif v['retcode'] == 0:
            #print "%s: have mrpe file" % (k)
            cmd = "echo \"%s\" > %s/%s/mrpe.cfg" % (v['ret'],path,k)
            os.system(cmd)
            print "Get mrpe data done for host: %s" % k
    else:
        print "Host error: %s" % k
