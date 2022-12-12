- List all broker ID available in cluster:
```
./zookeeper-shell.sh zookeeperhost:port ls /brokers/ids
or
zkCli.sh ls /brokers/ids
```
- See detail about specific broker ID
```
zkCli.sh get /brokers/ids/9 # 9 is the broker id
```
