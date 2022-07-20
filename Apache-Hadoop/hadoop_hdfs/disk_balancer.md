### Ref: 
- https://data-flair.training/blogs/hadoop-hdfs-disk-balancer/#:~:text=HDFS%20Disk%20Balancer-,Disk%20Balancer%20is%20a%20command%2Dline%20tool%20introduced%20in%20Hadoop,distributes%20data%20within%20the%20DataNode.
- https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.4/data-storage/content/diskbalancer_commands.html

## Before: 

![image](https://user-images.githubusercontent.com/3434274/165490404-16e2b670-041b-4544-81c9-0a53b9c76f40.png)

## Step for disk balancer ( This should run for data node only! )

1. Plan: The plan command generates the plan for the specified DataNode
``` 
hdfs diskbalancer -plan data-node-name
```

Advance: default bandwidth is 10MB/s, you may want to change it higher for faster balancer

```
hdfs diskbalancer -plan data-node-name -bandwidth 104857600 # 10 Mb = 104857600 bytes
```

Output example:
```
2022-04-27 16:41:04,175 INFO balancer.NameNodeConnector: getBlocks calls for hdfs://kienlt-dev will be rate-limited to 20 per second
2022-04-27 16:41:09,716 INFO planner.GreedyPlanner: Starting plan for Node : hadoop.data-1.node:9867
2022-04-27 16:41:09,720 INFO planner.GreedyPlanner: Disk Volume set 49496e84-6dad-4606-85a1-35b1bc54b6e6 Type : DISK plan completed.
2022-04-27 16:41:09,720 INFO planner.GreedyPlanner: Compute Plan for Node : hadoop.data-1.node:9867 took 51 ms 
2022-04-27 16:41:09,734 INFO command.Command: Writing plan to:
2022-04-27 16:41:09,735 INFO command.Command: /system/diskbalancer/2022-Apr-27-16-41-08/hadoop.data-1.node.plan.json
Writing plan to:
/system/diskbalancer/2022-Apr-27-16-41-08/hadoop.data-1.node.plan.json
```

2. Execute: The execute command executes the plan against the DataNode for which the plan was generated
```
hdfs diskbalancer --execute /system/diskbalancer/2022-Apr-27-16-41-08/hadoop.data-1.node.plan.json
```

Output example:
```
2022-04-27 16:45:24,145 INFO command.Command: Executing "execute plan" command
```

3. Query: The query command gets the current status of the  HDFS disk balancer from a DataNode for which the plan is running
```
hdfs diskbalancer -query <datanode>
```

Output Example:
```
2022-04-27 16:46:07,575 INFO command.Command: Executing "query plan" command.
Plan File: /system/diskbalancer/2022-Apr-27-16-41-08/hadoop.data-1.node.plan.json
Plan ID: 2d55fea85cc8dd8355b61849906cd745fb305e09
Result: PLAN_UNDER_PROGRESS
```

4. Cancel: Read Reference 😹

```
hdfs diskbalancer -cancel plan_ID
```

6. Report: The report command gives a detailed report of the specified DataNodes or top DataNodes that require a disk balancer

```
hdfs diskbalancer -report -top topnum # Run in active namenode
```

Output Example:
```
2022-04-27 16:54:43,173 INFO command.Command: Processing report command
2022-04-27 16:54:43,205 INFO balancer.NameNodeConnector: getBlocks calls for hdfs://kienlt-dev will be rate-limited to 20 per second
2022-04-27 16:54:44,766 INFO command.Command: Top limit input is not numeric, using default top value 100.
2022-04-27 16:54:44,766 INFO command.Command: Reporting top 3 DataNode(s) benefiting from running DiskBalancer.
Processing report command
Top limit input is not numeric, using default top value 100.
Reporting top 3 DataNode(s) benefiting from running DiskBalancer.
1/3 hadoop-3 <89d9b3ba-0b22-4aff-abcd-badcbc59a3e4>: 3 volumes with node data density 1.79.
2/3 hadoop-2 - <c09cb5d8-89f6-4bfc-a37f-9b5fef90813d>: 3 volumes with node data density 1.79.
3/3 hadoop-1 - <e3bcb444-7dfa-4b2b-b5ca-0746db7bcfcc>: 3 volumes with node data density 0.91.
```
