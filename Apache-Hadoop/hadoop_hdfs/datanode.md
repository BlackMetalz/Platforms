### Ref: 
- https://data-flair.training/blogs/hadoop-hdfs-disk-balancer/

#### - How much type for writing data when having multiple disks: 2 policies
+ Round-Robin policy
+ Available space policy

#### - Step for remove datanode :
1. Insert host into dfs.exclude
2. refreshNodes
3. Wait for decommission finish
4. Done, if you want to remove host in dashboard, remove in dfs.hosts
