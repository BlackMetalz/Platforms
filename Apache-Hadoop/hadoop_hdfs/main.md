### Source: https://www.edureka.co/blog/apache-hadoop-hdfs-architecture/

### HDFS Architecture

![image](https://user-images.githubusercontent.com/3434274/160559181-0142908b-b07d-4e06-8b9d-986df15d7801.png)

Apache HDFS or Hadoop Distributed File System is a block-structured file system where each file is divided into blocks of a pre-determined size. 
These blocks are stored across a cluster of one or several machines. Apache Hadoop HDFS Architecture follows a Master/Slave Architecture, 
where a cluster comprises of a single NameNode (Master node) and all the other nodes are DataNodes (Slave nodes). 
HDFS can be deployed on a broad spectrum of machines that support Java. Though one can run several DataNodes on a single machine, 
but in the practical world, these DataNodes are spread across various machines.

### NameNode

![image](https://user-images.githubusercontent.com/3434274/160559354-50e5ce35-a1cf-4323-8b09-1280ad427797.png)

NameNode is the master node in the Apache Hadoop HDFS Architecture that maintains and manages the blocks present on the DataNodes (slave nodes). 
NameNode is a very highly available server that manages the File System Namespace and controls access to files by clients. 
I will be discussing this High Availability feature of Apache Hadoop HDFS in my next blog. 
The HDFS architecture is built in such a way that the user data never resides on the NameNode. The data resides on DataNodes only.  

Functions of NameNode:
  - It is the master daemon that maintains and manages the DataNodes (slave nodes)
  - It records the metadata of all the files stored in the cluster, e.g. The location of blocks stored, the size of the files, permissions, hierarchy, etc. 
  There are two files associated with the metadata:
    + FsImage: It contains the complete state of the file system namespace since the start of the NameNode.
    + EditLogs: It contains all the recent modifications made to the file system with respect to the most recent FsImage.
  - It records each change that takes place to the file system metadata. For example, if a file is deleted in HDFS, the NameNode will immediately record this in the EditLog.
  - It regularly receives a Heartbeat and a block report from all the DataNodes in the cluster to ensure that the DataNodes are live.
  - It keeps a record of all the blocks in HDFS and in which nodes these blocks are located.
  - The NameNode is also responsible to take care of the replication factor of all the blocks which we will discuss in detail later in this HDFS tutorial blog.
  - In case of the DataNode failure, the NameNode chooses new DataNodes for new replicas, balance disk usage and manages the communication traffic to the DataNodes.
