1. HAADMIN
- Get all service state ( for namenode check which node is active / standby )
```
hdfs haadmin -getAllServiceState
```

- Force promote standby to active, use in case all name node is standby. This command is dangerous, use it with caution
```
hdfs haadmin -transitionToActive --forceactive --forcemanual Namenode_ID # Namenode ID get from web UI
```

- Failover: transfer active namenode to other node
```
bin/hdfs haadmin -failover namenodeID_is_active namenodeID_is_standby
```

2. DFSADMIN
- DFS Report: Report list live data node, capacity, number of block:
```
bin/hdfs dfsadmin -report
```

- Decomission data node. First add record to file of property `dfs.hosts.exclude` into all of namenode. After that run command below into all of namenode
```
hdfs dfsadmin -refreshNodes
```
After that you will see it is state of Decomissioning. And next when it complete, it will show as below

![image](https://user-images.githubusercontent.com/3434274/164442943-15db472d-9289-4a46-b1fd-e54e75c9ef36.png)

You can safety remove this node by remove it's entry in file of property `dfs.hosts`


- Leave safe mode:
```
Security is off.

Safe mode is ON. Resources are low on NN. Please add or free up more resourcesthen turn off safe mode manually. NOTE: If you turn off safe mode before adding resources, the NN will immediately return to safe mode. Use "hdfs dfsadmin -safemode leave" to turn safe mode off.
```

If this notice appear: run as it said!
