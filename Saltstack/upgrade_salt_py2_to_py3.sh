#!/bin/bash
# Author kienlt
## Fully remove salt master
rm /etc/apt/sources.list.d/saltstack.list
# Get key of saltstack
GPG_KEY=$(apt-key list 2> /dev/null | grep -B 1  saltstack | head -1 | awk '{print $9 $10}')
# Remove GPG Key
apt-key del $GPG_KEY
apt update
apt autoremove salt-master
echo "deb [arch=amd64] http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main" > /etc/apt/sources.list.d/saltstack.list
apt-get update
apt-get install -y --assume-no salt-master
salt-master -V
