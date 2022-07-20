### Note 1:

![image](https://user-images.githubusercontent.com/3434274/131527959-b1ab08f7-5d67-47bc-be1b-5f4e5c08e24d.png)

- Document size: about 2.5kb 
- Max Peak: ~100k index document/s
- Total Node: 3 master, 20 data. Each data node has 3 disks, 2Tb/disk
- resource consume: disk busy about 50%, cpu used 30-40%


### Note 2: https://discuss.elastic.co/t/one-master-node-removes-and-adds-cluster-nodes-on-regular-base/156700/3
```
ES 2.1.0 When you say it removed and re-adds, does it mean it drops the node and re-adds the node, making many shards go unassigned and have to be assigned again? This is exactly what is happening. I see cluster goes into yellow every hour and many shards become unassigned.
```

```
 # Reduce keep alive values to increase frequency of keep alive packets sent across network in order to prevent ElasticSearch nodes losing connection between each other
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_keepalive_intvl = 60
net.ipv4.tcp_keepalive_probes = 20
```

### Note 3: Node get removed from cluster, caused by 
[PersistedClusterStateService] writing cluster state took [12623ms] which is above the warn threshold of [10s];

https://discuss.elastic.co/t/elasticsearch-a-scale-problem-master-timeout/232973/4

```
[2020-05-17T07:32:19,357][WARN ][o.e.g.IncrementalClusterStateWriter] [CUSTER-DATA-025] writing cluster state took [11841ms] which is above the warn threshold of [10s]; wrote metadata for [0] indices and skipped [2] unchanged indices
```

```
Writing the cluster state to disk should take a handful of milliseconds, but is actually taking over 10 seconds. This suggests your disks are overloaded or otherwise too slow, and if they're slow enough then nodes will be considered unhealthy and may be removed from the cluster.
```

Reason: High Disk IO ( Source: https://discuss.elastic.co/t/nodes-constantly-losing-connection/262331 )

### Note 4: replicas are increasing search latency...why?
- Ref: https://www.reddit.com/r/elasticsearch/comments/q7fe3t/replicas_are_increasing_search_latencywhy/
```
[I work at Elastic]

Replicas can help search concurrency. They CAN increase latency in that if you are searching for something and search for it again, you have cache coherency for that targeted information.

Now, your next search hits the replica... and whoops, there's no cache hit. It has to go to disk, because that information wasn't already in memory.

So, if you have lots of transactions going on at once over different data, then replicas can help. If you are going against the same data over and over, you're more likely to be better with fewer replicas.

However, I would say that having only 2 data nodes puts you in a position where we're not really optimizing. You could lose a node and have major issues, that way and would likely be served better by having more nodes, as well, and eventually see better performance due to other limiting factors being removed.

```

### Note 5: ```absolute clock went backwards by [300ms/300ms] while timer thread was sleeping ```
- Check the ntp service
- Ref: https://discuss.elastic.co/t/warn-o-e-t-threadpool-absolute-clock-went-backwards/296320


### Note 6: ```Change GC log thresholds```
Log:

```
[2018-11-02T08:00:12,056][INFO ][o.e.m.j.JvmGcMonitorService] [vie01a-clog-pesd-pe05] [gc][24] overhead, spent [277ms] collecting in the last [1s]
[2018-11-02T08:00:25,212][INFO ][o.e.m.j.JvmGcMonitorService] [vie01a-clog-pesd-pe05] [gc][37] overhead, spent [355ms] collecting in the last [1.1s]
[2018-11-02T08:01:12,534][INFO ][o.e.m.j.JvmGcMonitorService] [vie01a-clog-pesd-pe05] [gc][84] overhead, spent [374ms] collecting in the last [1.2s]
[2018-11-02T08:01:42,570][INFO ][o.e.m.j.JvmGcMonitorService] [vie01a-clog-pesd-pe05] [gc][114] overhead, spent [432ms] collecting in the last [1s]
[2018-11-02T08:01:58,697][INFO ][o.e.m.j.JvmGcMonitorService] [vie01a-clog-pesd-pe05] [gc][130] overhead, spent [304ms] collecting in the last [1.1s]
[2018-11-02T08:02:15,709][INFO ][o.e.m.j.JvmGcMonitorService] [vie01a-clog-pesd-pe05] [gc][147] overhead, spent [337ms] collecting in the last [1s]
[2018-11-02T08:02:28,096][INFO ][o.e.m.j.JvmGcMonitorService] [vie01a-clog-pesd-pe05] [gc][159] overhead, spent [431ms] collecting in the last [1.3s]
[2018-11-02T08:03:21,184][INFO ][o.e.m.j.JvmGcMonitorService] [vie01a-clog-pesd-pe05] [gc][212] overhead, spent [426ms] collecting in the last [1s]
```

Solution: https://discuss.elastic.co/t/change-gc-log-thresholds/155132
```
# Add this into elasticsearch.yml
monitor.jvm.gc.overhead.warn: 90
```

### Note 7 :Disable GeoIP - Elasticsearch
```
PUT _cluster/settings
{
  "persistent" : {
    "ingest.geoip.downloader.enabled" : false
  }
}
```
