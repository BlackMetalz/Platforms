### Ref:
- https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.0.0/administration/content/hdfs-ports.html



| Service | services | Port Default | Protocol | Description | Need End User Access | Configuration Parameters |
| ------- | ------- | ------- | ------- |------- |------- |------- |
| NameNode WebUI | Master Nodes (NameNode and any back-up NameNodes)	 | 50070 | http | Web UI to look at current status of HDFS, explore file system	 | yes | dfs.http.address |
| NameNode WebUI | Master Nodes (NameNode and any back-up NameNodes)	 | 50470 | https | Secure http service	 | yes | dfs.http.address |
| NameNode metadata service |  |  8020/ 9000	 | IPC | File system metadata operations | Yes (All clients who directly need to interact with the HDFS) | Embedded in URI specified by fs.defaultFS |
| DataNode | All slave nodes | 50075 | http | DataNode WebUI to access the status, logs, etc, and file data operations when using webhdfs or hftp | Yes |  dfs.datanode.http.address |
| DataNode | All slave nodes | 50475 | https | Secure http service | Yes |  dfs.datanode.https.address |
| DataNode | All slave nodes | 50010 | http | Data transfer | Yes |  dfs.datanode.address |
| DataNode | All slave nodes | 1019 | https | Secure data transfer | Yes |  dfs.datanode.address |
| DataNode | All slave nodes | 50020 | IPC | Metadata operations | No |  dfs.datanode.ipc.address |
| Secondary NameNode | Secondary NameNode and any backup Secondanry NameNode | 50090 | http | Checkpoint for NameNode metadata | No |  dfs.secondary.http.address |
