-- cluster allocation filtering:
The most common use case for cluster-level shard allocation filtering is when you want to decommission a node. 
To move shards off of a node prior to shutting it down, you could create a filter that excludes the node by its IP address:

```
PUT _cluster/settings
{
  "transient" : {
    "cluster.routing.allocation.exclude._ip" : "10.0.0.1"
  }
}

```

-- Get cluster stats. This can see total shard, mem, heap size
```
GET /_cluster/stats
```

-- Get clused indices:
```
GET _cluster/state/blocks?pretty
```

-- Update cluster setting ( some setting doesn't need to restart service for set )
Source: https://www.elastic.co/guide/en/elasticsearch/reference/current/cluster-update-settings.html
Sadly update remote white list aren't updateable dynamically https://github.com/elastic/elasticsearch/issues/29153
```
PUT /_cluster/settings
{
  "persistent" : {
    "indices.recovery.max_bytes_per_sec" : "50mb"
  }
}

```

-- Tuning setting for rebalance. Tune setting for ur case!!
```
PUT _cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.cluster_concurrent_rebalance": "40",
    "cluster.routing.allocation.node_concurrent_recoveries": "40",
    "indices.recovery.max_concurrent_operations": "4",
    "indices.recovery.max_bytes_per_sec": "80mb"
  }
}
```

-- Turn back to normal
```
PUT _cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.cluster_concurrent_rebalance": "2",
    "cluster.routing.allocation.node_concurrent_recoveries": "2",
    "indices.recovery.max_concurrent_operations": "1",
    "indices.recovery.max_bytes_per_sec": "20mb"
  }
}
```
