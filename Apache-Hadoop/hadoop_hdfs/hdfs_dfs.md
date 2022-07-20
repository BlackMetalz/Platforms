## Ref: 
- https://sparkbyexamples.com/apache-hadoop/hadoop-hdfs-dfs-commands-and-starting-hdfs-dfs-services/
- https://www.edureka.co/community/49603/how-setrep-command-is-used-and-what-is-the-description-to-this
- 
Note: user in hdfs map with user in linux, same for group


### - setrep command:
This HDFS command is used to change the replication factor of a file. If the entered path is a directory, then this command changes the replication factor of all the files present in the directory tree rooted at the path provided by user recursively.

HDFS setrep Command usage:
```
setrep [-R] [-w] rep <path>
```
HDFS setrep Command Example
```
hdfs dfs -setrep -w 3 /user/dataflair/dir1
```
Here, the -w flag requests that the command waits for the replication process to get completed. This may likely take a very long time to get completed.

The -R flag is accepted for backward compatibility. It does not make any changes.

Note: There is a case setrep will stuck with message
```
WARNING: the waiting time may be long for DECREASING the number of replications.
```

Because output of command `hdfs fsck /`:

```
 Total size:	1073744974 B
 Total files:	5
 Total blocks (validated):	12 (avg. block size 89478747 B)
 Minimally replicated blocks:	12 (100.0 %)
 Over-replicated blocks:	0 (0.0 %)
 Under-replicated blocks:	0 (0.0 %)
 Mis-replicated blocks:		0 (0.0 %)
 Default replication factor:	2
 Average block replication:	2.5
 Missing blocks:		0
 Corrupt blocks:		0
 Missing replicas:		0 (0.0 %)
 DecommissionedReplicas:	6
```

There is decommissioned node. Turn it back then setrep will ok!

