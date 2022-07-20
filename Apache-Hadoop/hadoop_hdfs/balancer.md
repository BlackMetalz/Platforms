### Ref:
- https://docs.cloudera.com/cdp-private-cloud-base/7.1.6/scaling-namespaces/topics/hdfs-balancer-commands.html
- https://docs.cloudera.com/HDPDocuments/HDP2/HDP-2.6.0/bk_hdfs-administration/content/configuring_balancer.html
- https://community.cloudera.com/t5/Support-Questions/Help-with-exception-from-HDFS-balancer/td-p/160081

### - Command example:
```
hdfs balancer -Ddfs.balancer.movedWinWidth=5400000 -Ddfs.balancer.moverThreads=1000 -Ddfs.balancer.dispatcherThreads=250 -Ddfs.datanode.balance.bandwidthPerSec=100000000 -Ddfs.balancer.max-size-to-move=10737418240 1>/tmp/balancer-out.log 2>/tmp/balancer-debug.log 
```



This runs the balancer with a default threshold of 10%, meaning that the script will ensure that disk usage on each DataNode differs from the overall 
usage in the cluster by no more than 10%. For example, if overall usage across all the DataNodes in the cluster is 40% of the cluster's total disk-storage capacity, 
the script ensures that each DataNode's disk usage is between 30% and 50% of that DataNode's disk-storage capacity.
You can run the script with a different threshold; for example:
```
sudo -u hdfs hdfs balancer -threshold 5
```

This specifies that each DataNode's disk usage must be (or will be adjusted to be) within 5% of the cluster's overall usage.
You can adjust the network bandwidth used by the balancer, by running the dfsadmin -setBalancerBandwidth command before you run the balancer; for example:
```
dfsadmin -setBalancerBandwidth  newbandwidth
```

where newbandwidth is the maximum amount of network bandwidth, in bytes per second, that each DataNode can use during the balancing operation. For more information about the setBalancerBandwidth and other HDFS command-line options, see the dfsadmin documentation.
The property dfs.datanode.balance.max.concurrent.moves sets the maximum number of threads used by the DataNode balancer for pending moves. It is a throttling mechanism to prevent the balancer from taking too many resources from the DataNode and interfering with normal cluster operations. Increasing the value allows the balancing process to complete more quickly, decreasing the value allows rebalancing to complete more slowly, but is less likely to compete for resources with other tasks on the DataNode. Adjust the value of this property in the /etc/hadoop/[service name]/hdfs-site.xml configuration file.
```
<property>
  <name>dfs.datanode.balance.max.concurrent.moves</name>
  <value>50</value>
</property>
```

The balancer can take a long time to run, especially if you are running it for the first time or do not run it regularly.

