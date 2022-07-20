# This is for opendistro version:
# Source: https://opendistro.github.io/for-elasticsearch-docs/docs/elasticsearch/cluster/

- Change index to node warm /hot
```
PUT index_name_lulz/_settings
{
  "index": {
    "routing.allocation.require.temp": "hot"
  }
}
```
- Change node warm / hot in elasticsearch.yml
```
node.attr.temp: hot
```

