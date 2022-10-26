-- Check data and shard allocation per node.
```
GET /_cat/allocation?v
```

-- Shard delayed allocation:
```
https://www.elastic.co/guide/en/elasticsearch/reference/current/delayed-allocation.html
```
```
PUT _all/_settings
{
  "settings": {
    "index.unassigned.node_left.delayed_timeout": "5m"
  }
}

```
