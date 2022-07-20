-- Count total shards of cluster
```
GET _cluster/stats?filter_path=indices.shards.total
```

-- Check active recovery status
```
curl -XGET "localhost:9200/_recovery?pretty&active_only"
```

-- Count Total Documents
```
GET _cluster/stats?filter_path=indices.docs.count
```

-- Count total indices
```
GET _cluster/stats?filter_path=indices.count
```


-- Unassigned Shard check:
```
GET /_cluster/allocation/explain?pretty
```

Fix Solution:
```
POST /_cluster/reroute?retry_failed
```

-- Read shard detail of index
```
GET /_cat/shards/index-name?h=index,shard,pr,state,docs,store,ip,node
```

-- read index stats
```
GET /index-name/_stats
```

-- Return document from an index
```
GET /security-auditlog-2020.09.21/_search
{
  "query": {
    "match_all": {}
  }
}
```

-- DELETE index with wildcard
```
DELETE /security-auditlog-2020.08*
```

-- Node Info API
```
GET /_nodes

GET /_nodes/<node_id>

GET /_nodes/<metric>

GET /_nodes/<node_id>/<metric>

-- indices stats
GET /_nodes/stats/indices/search
````

-- Get Cluster API

```
-- GEt cluster stats
GET /_cluster/stats
```

-- Get indices cache request stats
```
GET /_nodes/stats/indices/request_cache?human
```

-- Enable cache for index
```
PUT /my-index-000001/_settings
{ "index.requests.cache.enable": true }
```

-- Cluster setting with default
```
GET _cluster/settings?include_defaults=true
```
