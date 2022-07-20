-- Remove a data node from cluster:
```
PUT _cluster/settings
{
  "transient": {
    "cluster.routing.allocation.exclude._ip": "node_ip_here"
  }
}
```

Then check for health status


-- Set it to null if u want that node have data ( curl version ):
```
curl -XPUT “http://@host:9200/_cluster/settings” -d 
'{
  "transient" :{
      "cluster.routing.allocation.exclude._ip" : ""
   }
}'
```

-- Check progress tip:
You still can see relocating shard in cluster health status. 
And check how much shard left for allocating:
doing in curl command:
```
curl -s "eshost:esport/_cat/shards" | grep node_ip_here | wc -l
```

You can see total shard left for relocation. Once no shard in node you want to remove. It is done!
