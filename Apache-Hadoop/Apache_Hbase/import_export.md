- Export Command:
```
hbase-2.3.6/bin/hbase org.apache.hadoop.hbase.mapreduce.Export -Dhbase.client.zookeeper.quorum=10.0.0.1:2181 -Dzookeeper.znode.parent=/hbase-unsecure  table_name /tmp/path/export 1 1639282049162 1639282050000
```

param 1 in here stand for version which mean the latest version

Get milisecond:
-- Last 15 days:
```
date --date="15 days ago" +%s%N | cut -b1-13
==> 1651481316727
```

-- Current time:
```
date +%s%N | cut -b1-13
1652777349936
```

- Import Command:
```
hbase-2.3.6/bin/hbase org.apache.hadoop.hbase.mapreduce.Import -Dhbase.zookeeper.quorum=10.0.0.1:2181 -Dzookeeper.znode.parent=/hbase-unsecure table_name /tmp/path/export
```

2 command above need run on node which have YARN installed
