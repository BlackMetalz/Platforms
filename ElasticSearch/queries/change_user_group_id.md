# Here is the guide for change elasticsearch and guid. In case of snapshot permission between node.
- For an example. You have different user and group ID in elasticsearch cluster. You want to change them to make all user/group id is the same for snapshot restore permission

1. Stop ES Service and change user/group ID:
```
usermod -u 114 elasticsearch
groupmod -g 121 elasticsearch
```

2. Change owner of elasticsearch folder:
```
chown -R elasticsearch: /data/odfe/ # this is include log and data dir of es
chown -R elasticsearch:  /etc/default/elasticsearch
chown -R elasticsearch:  /etc/elasticsearch
chown -R elasticsearch: /var/log/elasticsearch
```
