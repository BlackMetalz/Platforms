### Ref:
- https://www.projectpro.io/article/overview-of-hbase-architecture-and-its-components/295
- https://www.geeksforgeeks.org/architecture-of-hbase/
- 
### Comparision between HDFS and HBASE
#### HDFS
- cannot handle high velocity of random writes and reads 
- cannot change a file without completely rewriting it
- HDFS provides high latency operations
- HDFS supports Write once Read Many times
- HDFS is accessed through MapReduce jobs / YARN
#### HBASE
- built on top of HDFS
- allows fast random writes and reads in an optimized way
- HBase provides low latency access
- HBase supports random read and writes
- HBase is accessed through shell commands, Java API, REST, Avro or Thrift API

Note – HBase is extensively used for online analytical operations, like in banking applications such as real-time data updates in ATM machines, HBase can be used

### Components of HBbase
#### 1. HMaster:
HBase HMaster is a lightweight process that assigns regions to region servers in the Hadoop cluster for load balancing. Responsibilities of HMaster

##### - Manages and Monitors the Hadoop Cluster
##### - Performs Administration (Interface for creating, updating and deleting tables.)
##### - Controlling the failover
##### - DDL operations are handled by the HMaster
##### - Whenever a client wants to change the schema and change any of the metadata operations, HMaster is responsible for all these operations.

#### 2. Region Server: it run in data node of HDFS
These are the worker nodes which handle read, write, update, and delete requests from clients. Region Server process, runs on every node in the hadoop cluster. Region Server runs on HDFS DataNode and consists of the following components.

##### - Block Cache – This is the read cache. Most frequently read data is stored in the read cache and whenever the block cache is full, recently used data is evicted.
##### - MemStore- This is the write cache and stores new data that is not yet written to the disk. Every column family in a region has a MemStore.
##### - Write Ahead Log (WAL) is a file that stores new data that is not persisted to permanent storage.
##### - HFile is the actual storage file that stores the rows as sorted key values on a disk.

### 3. Zookeeper:

HBase uses ZooKeeper as a distributed coordination service for region assignments and to recover any region server crashes by loading them onto 
other region servers that are functioning. ZooKeeper is a centralized monitoring server that maintains configuration information and provides 
distributed synchronization. 
Whenever a client wants to communicate with regions, they have to approach Zookeeper first. 
HMaster and Region servers are registered with ZooKeeper service, client needs to access ZooKeeper quorum in order to connect with 
region servers and HMaster. In case of node failure within an HBase cluster, ZKquoram will trigger error messages and start repairing failed nodes.

ZooKeeper service keeps track of all the region servers that are there in an HBase cluster- tracking information about how many 
region servers are there and which region servers are holding which DataNode. HMaster contacts ZooKeeper to get the details of region servers. 
Various services that Zookeeper provides include

##### - Establishing client communication with region servers.
##### - Tracking server failure and network partitions.
##### - Maintain Configuration Information
##### - Provides ephemeral nodes, which represent different region servers.

