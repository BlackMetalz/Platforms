-- Source: https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-reindex.html

-- Good read: https://developers.soundcloud.com/blog/how-to-reindex-1-billion-documents-in-1-hour-at-soundcloud

-- Reindex: Copies documents from a source to a destination.

index: wtf_1 have 20k documents
index: test_data have 100k documents

```
POST _reindex?wait_for_completion=false
{
  "source": {
    "index": "wtf_1"
  },
  "dest": {
    "index": "test_data"
  }
}
```

after reindex
```
GET _refresh
GET _cat/count/test_data?
```

output:
```
epoch      timestamp count
1603168599 04:36:39  120000
```

So 120000 documents in total.


-- Reindex from remote cluster:
```
https://www.elastic.co/guide/en/elasticsearch/reference/current/reindex-upgrade-remote.html
```


-- Reindex from remote cluster. I used this for reindex from ES 5 to ES 7 or ES 7 to ES 7
No auth:
```
POST _reindex?wait_for_completion=false
{
  "source": {
    "remote": {
      "host": "http://10.0.0.222:9200"
    },
    "index": "index-name-2021.01.20"
  },
  "dest": {
    "index": "index-name-2021.01.20"
  }
}
```

-- Timeout?. Ref: https://github.com/elastic/elasticsearch/commit/d249529c82ee9a2815126f4f45d35a601e093d2a
POST _reindex?wait_for_completion=false
{
  "source": {
    "remote": {
      "host": "http://10.0.0.222:9200",
      "socket_timeout": "1m",
      "connect_timeout": "60s"
    },
    "index": "index-name-2021.01.20"
  },
  "dest": {
    "index": "index-name-2021.01.20"
  }
}
```



```
POST _reindex?wait_for_completion=false
{
  "source": {
    "remote": {
      "host": "http://oldhost:9200",
      "username": "user",
      "password": "pass"
    },
    "index": "index_name"
  },
  "dest": {
    "index": "index_name"
  }
}
```
Don't forget to add: 
```
reindex.remote.whitelist : oldhost:9200
```

into elasticsearch.yml ( master node only and restart )


- CURL command if you don't use kibana
```
curl -XPOST \
    http://127.0.0.1:9200/_reindex \
    -H 'Content-Type: application/json' \
    -d '{
    "source": {
        "index": "wtf"
    },
    "dest": {
        "index": "wtf_new"
    }
}' -u admin:adminwtf -k
```

Multiple reindex
```
for index in i1 i2 i3 i4 i5; do
  curl -HContent-Type:application/json -XPOST localhost:9200/_reindex?pretty -d'{
    "source": {
      "index": "'$index'"
    },
    "dest": {
      "index": "'$index'-reindexed"
    }
  }'
done
```

-- Increase reindex speed:
# https://aws.amazon.com/premiumsupport/knowledge-center/elasticsearch-indexing-performance/
# https://developers.soundcloud.com/blog/how-to-reindex-1-billion-documents-in-1-hour-at-soundcloud
```
Create an index with the appropriate mappings and settings. Set the refresh_interval to -1 and set number_of_replicas to 0 for faster reindexing.

PUT index_name/_settings
{
  "settings": {
    "index": {
      "number_of_replicas": 0,
      "refresh_interval": "-1"
    },
    "translog": {
      "flush_threshold_size": "2gb"
    }
  }
}

```

-- Reindex with auto slice: This doesn't work with reindex from remote
https://discuss.elastic.co/t/slow-reindex-operation-on-heavy-index/198320/3
From author:
```
This is the solution. Thanks! It helped indeed. I also merged the source index in a single segment as 
I don't expect any further writes to it anytime soon. 
Also disabled all type of shard allocation throughout the cluster and now my reindex is avg ~15,000 docs/sec 
which is the best historical indexing rate I've ever had in this cluster :slight_smile:
```
- Note  for slices number:
```
Picking the number of slices
If slicing automatically, setting slices to auto will choose a reasonable number for most indices. If slicing manually or 
otherwise tuning automatic slicing, use these guidelines.

Query performance is most efficient when the number of slices is equal to the number of shards in the index. If that number is large (e.g. 500),
choose a lower number as too many slices will hurt performance. Setting slices higher than the number of shards generally does not 
improve efficiency and adds overhead.

Indexing performance scales linearly across available resources with the number of slices.

Whether query or indexing performance dominates the runtime depends on the documents being reindexed and cluster resources.
```

So number of slice should be equal to number of shard ( primary and replica )

```
POST _reindex?wait_for_completion=false&slices=20&refresh
{
  "source": {
    "index": "puma.compilation.pipeline.96f19f5b-bc84-4d4b-8694-b80a293e78e4-latest",
    "size": 500,
    "query": {
"range": {
      "ibi_logtime": {
        "gte": "now-9M/M"
      }
    }
    }
  },
  "dest": {
    "index": "puma.compilation.pipeline.96f19f5b-bc84-4d4b-8694-b80a293e78e4-optimized"
  }
}
```

-- Or use slices=auto for easy xD
```
POST _reindex?wait_for_completion=false&slices=auto&refresh
{
  "source": {
    "index": "indexname-06*"
  },
  "dest": {
    "index": "indexname-06"
  }
}
```


-- Get reindex status and cancel the reindex: https://stackoverflow.com/questions/52410416/how-to-stop-reindexing-in-elasticsearch
```
GET _tasks?detailed=true&actions=*reindex
example output:
```
      "tasks" : {
        "56aFiZWgTca6isXCGwF8ew:10725" : {
        ```
So we used this for cancel specific task:
```
POST _tasks/56aFiZWgTca6isXCGwF8ew:10725/_cancel
```

-- More explain for reindex task
```
    "start_time_in_millis" : 1614934768470,
    "running_time_in_nanos" : 33417453267004,
```
- start_time_in_millis: Convert this to unix time. It is when you start reindex / task
- running_time_in_nanos: Convert this to minute / hour. You will see total time task spend for this
