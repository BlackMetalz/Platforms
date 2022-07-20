1. throttled
```
"allocate_explanation" : "allocation temporarily throttled"
"explanation" : "reached the limit of incoming shard recoveries [2], cluster setting [cluster.routing.allocation.node_concurrent_incoming_recoveries=2] (can also be set via [cluster.routing.allocation.node_concurrent_recoveries])"
```

Solution: change index.allocation.max_retries to higher value than [2] 
```
PUT /index-name-with-wildcard*/_settings 
{
  "index.allocation.max_retries": 3
}
```

2. cannot allocate because all found copies of the shard are either stale or corrupt
Source: https://stackoverflow.com/questions/49005638/healthy-elasticsearch-cluster-turns-red-after-opening-a-closed-index

```
This occurs when the master-node is brought down abruptly.

Here are the steps I took to resolve the same issue, that I had encountered ,

Step 1: Check the allocation

curl -XGET http://localhost:9200/_cat/allocation?v
Step 2: Check the shard stores

curl -XGET http://localhost:9200/_shard_stores?pretty Look out for "index", "shard" and "node" that has the error that you displayed. The ERROR should be --> "no segments* file found in SimpleFSDirectory@/...."
Step 3: Now reroute that index as shown below

curl -XPOST 'http://localhost:9200/_cluster/reroute?master_timeout=5m' \ -d '{ "commands": [ { "allocate_empty_primary": { "index": "IndexFromStep2", "shard": ShardFromStep2 , "node": "NodeFromStep2", "accept_data_loss" : true } } ] }'
Step 4: Repeat Step2 and Step3 until you see this output.

curl -XGET 'http://localhost:9200/_shard_stores?pretty'
{ "indices" : { } }

Your cluster should go green soon.
```
