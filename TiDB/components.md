### Components of TiDB:
### Ref: https://docs.pingcap.com/tidb/stable/tidb-architecture
### Ref: https://docs.pingcap.com/tidb/stable/tidb-storage

Ti is short of Titanium!

### I. Overview
#### 1. PD Server (Placement Driver Server)
- The PD server is "the brain" of the entire TiDB cluster
- Store/ managing metadata of entire cluster
- Sends data scheduling command to specific TiKV nodes according to the data distribution state reported by TiKV nodes in real time
- the PD server consists of three nodes at least and has high availability. It is recommended to deploy an odd number of PD nodes.
- works as the manager in a TiDB cluster, schedules Regions in the cluster

#### 2. TiDB Server
- Is a Stateless SQL layer expose the connection endpoint of the Mysql Protocol
- Receive SQL requests, perform SQL parsing and optimization, generates a distributed execution plan
- Does not store data and is only for computing
- transmitting actual data read request to TiKV nodes or TiFlash Nodes

#### 3. TiKV ( Storage Servers )
- Responsible for storing Data ( Distributed transaction key-value storag engine )
- Region is the basic unit to store data. Each Region stores the data for a particular key range from StartKey to EndKey
- Multiple Regions exists in each TiKV node
- After processing SQL statement, TiDB server convert the SQL execution plan to an actual call to the TiKV API
- All data in TiKV is automatically maintained in multiple replicas ( 3 reps by default). For HA and Auto failover

#### 4. TiFlash ( Storage Servers )
- The TiFlash Server is a special type of storage server
- Unlike ordinary TiKV nodes, TiFlash stores data by column, mainly designed to accelerate analytical processing


### II. Storage
- Key-Value pairs: TiKV's choice is the Key-Value model

- Local storage (RocksDB)
+ For any persistent storage engine, data is eventually saved on disk, and TiKV is no exception
+ RocksDB is an excellent standalone storage engine open-sourced by Facebook

- Raft protocol
+ TiKV use Raft to perform data replication
+ Data is written through the interface of Raft instead of to RocksDB

- Region: TiKV chooses the second solution that divides the whole Key-Value space into a series of consecutive Key segments. Each segment is called a Region.
+ There is a size limit for each Region to store data (the default value is 96 MB and the size can be configured). Each Region can be described by [StartKey, EndKey), a left-closed and right-open interval.
+ Hash: Create Hash by Key and select the corresponding storage node according to the Hash value
+ Range: Divide ranges by Key, where a segment of serial Key is stored on a node
+ TiKV will try the best to make sure number of Regions of each node is roughly similiar

+ First, data is divided into many Regions according to Key, and the data for each Region is stored on only one node (ignoring multiple replicas). The TiDB system has a PD component that is responsible for spreading Regions as evenly as possible across all nodes in the cluster. In this way, on one hand, the storage capacity is scaled horizontally (Regions on the other nodes are automatically scheduled to the newly added node); on the other hand, load balancing is achieved (the situation where one node has a lot of data while the others have little will not occur).

+ For the second task, TiKV replicates data in Regions, which means that data in one Region will have multiple replicas with the name "Replica". Multiple Replicas of a Region are stored on different nodes to form a Raft Group, which is kept consistent through the Raft algorithm.

- MVCC ( multi-version concurrency control ): allow multiple client modify value of key at the same time!

- Distributed ACID transaction:  Transaction of TiKV adopts the model used by Google in BigTable