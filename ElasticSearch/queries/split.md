-- source: https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-split-index.html

Shrinks an existing index into a new index with fewer primary shards.

- Split index to new index with larger shard (wtf_1 have 1 shard )
```
POST /wtf_1/_split/wtf_1_2s
{
  "settings": {
    "index.number_of_shards": 2
    }
}
```

result
```
health status index    uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   wtf_1    8UFYzdPHTii-ZgcTf31YJw   1   1      20000            0      3.7mb          1.8mb
green  open   wtf_1_2s izCnOCyfSuCT6Wi8ANX_PA   2   1      20000            0      9.2mb          5.5mb
```

