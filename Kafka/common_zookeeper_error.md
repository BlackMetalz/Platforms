- Log
```
2021-08-24 17:12:12,062 [myid:] - INFO  [main:QuorumPeerConfig@135] - Reading configuration from: /data/zookeeper-3.5.8-2181/conf/zoo.cfg
2021-08-24 17:12:12,070 [myid:] - INFO  [main:QuorumPeerConfig@387] - clientPortAddress is 0.0.0.0:2181
2021-08-24 17:12:12,071 [myid:] - INFO  [main:QuorumPeerConfig@391] - secureClientPort is not set
2021-08-24 17:12:12,076 [myid:] - ERROR [main:QuorumPeerMain@89] - Invalid config, exiting abnormally
org.apache.zookeeper.server.quorum.QuorumPeerConfig$ConfigException: Error processing /data/zookeeper-3.5.8-2181/conf/zoo.cfg
        at org.apache.zookeeper.server.quorum.QuorumPeerConfig.parse(QuorumPeerConfig.java:156)
        at org.apache.zookeeper.server.quorum.QuorumPeerMain.initializeAndRun(QuorumPeerMain.java:113)
        at org.apache.zookeeper.server.quorum.QuorumPeerMain.main(QuorumPeerMain.java:82)
Caused by: java.lang.IllegalArgumentException: myid file is missing
        at org.apache.zookeeper.server.quorum.QuorumPeerConfig.checkValidity(QuorumPeerConfig.java:736)
        at org.apache.zookeeper.server.quorum.QuorumPeerConfig.setupQuorumPeerConfig(QuorumPeerConfig.java:607)
        at org.apache.zookeeper.server.quorum.QuorumPeerConfig.parseProperties(QuorumPeerConfig.java:422)
        at org.apache.zookeeper.server.quorum.QuorumPeerConfig.parse(QuorumPeerConfig.java:152)
        ... 2 more
```

- Fix: Create a file named: `myid` in zookeeper data folder. And put number follow with this defined zoo.cfg
```
server.1=10.3.48.54:2888:3888
server.2=10.3.48.56:2888:3888
server.3=10.3.48.82:2888:3888
```

- Example:
![image](https://user-images.githubusercontent.com/3434274/130601198-553fa356-9eda-4836-ba65-deb4f74c2ecd.png)
