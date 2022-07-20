## Resource: https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/HDFSHighAvailabilityWithQJM.html
### 1. Theory
- Question: What is Journal Node?
- Answer: 
```
In order for the Standby node to keep its state synchronized with the Active node, both nodes communicate with a group of separate daemons called 
“JournalNodes” (JNs). When any namespace modification is performed by the Active node, it durably logs a record of the modification to a majority 
of these JNs
```

### 2. Practice
- Require: 2 or 3 server running JournalNode for HA cluster ( HA ), mostly Journal Node running same host with NameNode
- Note: The minimum number of NameNodes for HA is two, but you can configure more. Its suggested to not exceed 5 - with a recommended 3 NameNodes - due to communication overheads.



- Start Journal Node and ZKFC
- Before start you want to format zkfc
```
hdfs zkfc -formatZK
hdfs --daemon start journalnode
hdfs --daemon start zkfc
```
- Check start it running or not:
```
jps
```
- Output demo:
```
hdfs@hadoop-10-3-48-82:/opt/hadoop/etc/hadoop$ jps
23636 JournalNode
17766 Jps
30091 DFSZKFailoverController
14110 NameNode
```

- Some property need to know:
+ `dfs.nameservices` - the logical name for this new nameservice
+ `dfs.ha.namenodes.[nameservice ID]` - unique identifiers for each NameNode in the nameservice
+ `dfs.namenode.rpc-address.[nameservice ID].[name node ID]` - the fully-qualified RPC address for each NameNode to listen on
+ hmm. They are all in resource, i'm lazy to copy and paste it to here 😹


### What happens when journal node data folder is gone?
- Simply: Copy that folder from other node then start journal node again
- Ref: https://stackoverflow.com/questions/29385067/how-to-recover-hdfs-journal-node
