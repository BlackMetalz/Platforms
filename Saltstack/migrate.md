- Copy pki from current master to another master
```
salt-cp -C salt-master-123.123 /etc/salt/pki/master/* /etc/salt/pki/master
```

- Copy file to salt minion through salt-cp
```
salt aaa-xxx-jaeger-logstash-* cp.get_file salt://softwares_dev/disk.sh /root/
```
