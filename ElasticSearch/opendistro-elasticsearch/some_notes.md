-- Ports: https://discuss.elastic.co/t/elasticsearch-port-9200-or-9300/72080/2
```
9200 for Representational state transfer ( Rest )
9300 for node communication
For discover other node or master require port 9300 open.
For 9200. It depends if you want to send REST requests to that node.
```
-- or easy explain:
```
9200 is the HTTP port. The Java transport client needs to use port 9300 to
connect to the other nodes.
```

- Multi Cluster config: ( Credit: https://discuss.opendistrocommunity.dev/t/multi-node-cluster/963 )
First thing you have to know that two node elasticsearch cluster is not a good idea if you want to cover one node failure scenario. In this case you would have to configure:
```
minimum_master_nodes:1
```
and basically if you will have connection interruption between your 2 es nodes you will have split brain problem

With only 2 nodes you should configure
minimum_master_nodes:2
but then if one node will go down whole cluster will change it state to RED

So basically minimum multinode cluster should have 3 nodes with:
minimum_master_nodes:2
then one node can goes down.



-- DEPRECATION log in ODFE 1.12
How to resolve:
```
PUT _cluster/settings
{
  "persistent" : {
    "logger.org.elasticsearch.deprecation" : "ERROR"
  }
}
```

