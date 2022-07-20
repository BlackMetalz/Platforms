### Source: http://www.corejavaguru.com/bigdata/zookeeper/cli

- List:
```
[zk: localhost:2181(CONNECTED) 1] ls /
[zookeeper]
```

- create a new znode by running create /zk_test my_data. This creates a new znode and associates the string "my_data" with the node
```
[zk: localhost:2181(CONNECTED) 2] create /zk_test my_data
Created /zk_test
```


- get /zk_test:
```
[zk: localhost:2181(CONNECTED) 4] get /zk_test
my_data
```

- set /zk_test:
```
[zk: localhost:2181(CONNECTED) 5] set /zk_test junk
```

- delete /zk_test
```
[zk: localhost:2181(CONNECTED) 6] delete /zk_test
```


Explain:
```
my_data :This line of text is the data that we stored in the znode.
cZxid = 0x8 :The zxid (ZooKeeper Transaction Id) of the change that caused this znode to be created.
ctime = Mon Nov 30 18:41:06 IST 2015 :The time when this znode was created.
mZxid = 0x8 :The zxid of the change that last modified this znode.
mtime = Mon Nov 30 18:41:06 IST 2015 :The time when this znode was last modified.
pZxid = 0x8 :The zxid of the change that last modified children of this znode.
cversion = 0 :The number of changes to the children of this znode.
dataVersion = 0 :The number of changes to the data of this znode.
aclVersion = 0 :The number of changes to the ACL of this znode.
ephemeralOwner = 0x0: The session id of the owner of this znode if the znode is an ephemeral node. If it is not an ephemeral node, it will be zero.
dataLength = 7 :The length of the data field of this znode.
numChildren = 0 :The number of children of this znode.
```
