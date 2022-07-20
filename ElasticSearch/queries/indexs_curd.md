-- Read: https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html
- Create new index basic:
```
PUT your_index_name
{
  "settings": {
    "index": {
      "number_of_shards": 5,  
      "number_of_replicas": 1 
    }
  }
}
```


- Index setting for reindex
```
PUT /wtf_index_name/_settings
{
  "index" : {
    "number_of_replicas" : 0,
    "refresh_interval" : "60s"
  },
  "translog": {
    "flush_threshold_size": "2gb"
  }
}
```

- Other example:
```
PUT your_index_name
{
  "settings": {
    "index": {
      "number_of_shards": 5,
      "number_of_replicas": 1,
      "routing": {
        "allocation": {
          "require": {
            "temp": "wamp"
          }
        }
      }
    }
  }
}
```
