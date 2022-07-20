- `bootstrapStandby`:  use in case where name node lost data of namenode, namenode will not start and error is namenode is not formated. 
This will pull data from active namenode.  After this you are able to start name node
```
hdfs namenode -bootstrapStandby
```

- start name node:
```
hdfs --daemon start namenode
```

- format name node: mostly run for the first time only after install hadoop
```
hdfs namenode -format
```

- format ZKFC: After the configuration keys have been added, the next step is to initialize required state in ZooKeeper. 
You can do so by running the following command from one of the NameNode hosts.
```
hdfs zkfc -formatZK
```

- After format ZK, you can start daemon:
```
hdfs --daemon start zkfc
```
