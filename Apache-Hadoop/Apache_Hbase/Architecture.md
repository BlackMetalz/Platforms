### HBase Architecture is basically a column-oriented key-value data store and also it is the natural fit for deploying as a top layer on HDFS because it works extremely fine with the kind of data that Hadoop process.
Moreover, when it comes to both read and write operations it is extremely fast and even it does not lose this extremely important quality with humongous datasets.
There are 3 major components of HBase Architecture:

![image](https://user-images.githubusercontent.com/3434274/123074440-7ec90c80-d441-11eb-9bab-6ceb89113dd1.png)



1.  Master Server
- Assigns regions to the region servers with the help of Apache Zookeeper.
- Handles load balancing of the regions across region servers. It unloads the busy servers and shifts the regions to less occupied servers.
- Maintains the state of the cluster by negotiating the load balancing.
- Responsible for schema changes and other metadata operations such as the creation of tables and column families.

2. Region server
- Communicate with the client directly and handle data-related operations.
- Handle read and write requests for all the regions under it.
- Decide the size of the region by following the region size thresholds.
- A region server contains regions and stores.
- Regions are tables that are split up and spread across the region servers. The store contains Memstore and HFiles. Memstore is like a cache memory. Anything that is entered into the HBase is stored here initially. Later, the data is transferred and saved in Hfiles as blocks and the Memstore is flushed.

3. Zookeeper
- Zookeeper provides services like maintaining configuration information, naming, providing distributed synchronization, etc.
- Zookeeper has ephemeral nodes representing different region servers. Master servers use these nodes to discover available servers.
- In addition to availability, the nodes are also used to track server failures or network partitions.
- Clients communicate with region servers via zookeeper.




- Source: 
- https://yzhong-cs.medium.com/hbase-installation-step-by-step-guide-cb73381a7a4c
- https://data-flair.training/blogs/hbase-tutorial/
