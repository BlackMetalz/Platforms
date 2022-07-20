### Ref:
- https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.0.0/administration/content/hbase-ports.html
- https://stackoverflow.com/questions/20230942/what-is-hbase-compaction-queue-size-at-all


| Service | services | Port Default | Protocol | Description | Need End User Access | Configuration Parameters |
| ------- | ------- | ------- | ------- |------- |------- |------- |
| HMaster | Master Nodes (HBase Master Node and any back-up HBase Master node)| 16000 | TCP | The port used by HBase client to connect to the HBase Master | Yes | hbase.master.port |
| HMaster Info Web UI | Master Nodes (HBase master Node and back up HBase Master node if any)	 | 16010 | HTTP | The port for the HBase­Master web UI. Set to -1 if you do not want the info server to run.	| Yes | hbase.master.info.port |
| RegionServer | All Slave Nodes | 16020 | TCP | The port used by HBase client to connect to the HBase RegionServer | Yes (Typically admins, dev/support teams) | hbase.regionserver.port |
| RegionServer | All Slave Nodes | 16030 | TCP | The port used by HBase client to connect to the HBase RegionServer | Yes (Typically admins, dev/support teams) | hbase.regionserver.info.port |
| HBase REST Server (optional) | All REST Servers | 8080 | HTTP | The port used by HBase Rest Servers. REST servers are optional, and not installed by default | Yes |  hbase.rest.port |
| HBase REST Server Web UI (optional) | All REST Servers | 8085 | HTTP | The port used by HBase Rest Servers web UI. REST servers are optional, and not installed by default	| Yes | hbase.rest.info.port |
| HBase Thrift Server (optional) | All Thrift Servers | 9090 | TCP | The port used by HBase Thrift Servers. Thrift servers are optional, and not installed by default | Yes | N/A |
| HBase Thrift Server Web UI (optional)	 | All Thrift Servers | 9095 | TCP | The port used by HBase Thrift Servers web UI. Thrift servers are optional, and not installed by default	 | Yes | hbase.thrift.info.port |



```
Table       (HBase table)
  Region      (Regions for the table)
    Store       (Store per ColumnFamily for each Region for the table)
      MemStore    (MemStore for each Store for each Region for the table)
      StoreFile   (StoreFiles for each Store for each Region for the table)
        Block       (Blocks within a StoreFile within a Store for each Region for the table)
```
