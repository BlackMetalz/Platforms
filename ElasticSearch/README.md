# Introduce Elasticsearch ( ES )
### Credit: https://facinating.tech/2020/02/22/in-depth-guide-to-running-elasticsearch-in-production/

### I. Good read for optimize : https://octoperf.com/blog/2018/09/21/optimizing-elasticsearch/
1. Number of Replicas is a trade-off between indexing speed and data durability.
2. Leave Ram more ram -> more performance for ES ( used by filesystem cache )
-- If mostly used read,write -> leave more ram for filesystem cache
-- If mostly used for AAG query -> 40-50% Ram ( no more 32G )

### II. Related to field
+ More indexed fields = more data structures.
+ More data structures = more random disk seeks.
+ More random disk seeks = more time.

### III. Related to Delete index:
I was deleting big index. About 10Tb index size per request.
```
DELETE index-name-currentmonth-*
```

I don't know why cluster turn red, it takes about 30 minutes to complete recovery. My daily index is large. About ~3Tb/ Index ( 60 Shards )
Therefore I guess i have to delete one by one and slowly.
Also cluster cpu is peaked at that time so i guess it is also a part of reason cluster go red!

### IV. This isn't correct but i will update in feature in case i know
-- index F7Azbob3S4mAWXNkx2MydQ is no longer part of any snapshots in the repository, but failed to clean up their index folders:
Solution: `POST /_snapshot/my_repository/_cleanup`
Source: https://www.elastic.co/guide/en/elasticsearch/reference/current/clean-up-snapshot-repo-api.html

### V. About client node explain: https://stackoverflow.com/questions/33789479/how-to-setup-elasticsearch-client-nodes
Yes, you can send queries via http to any node that has port 9200 open.

With node.data: false and node.master: false, you get a "client node". These are useful for offloading indexing and search traffic from your data nodes. If you have 10 of them, you would want to put a load balancer in front of them.

Closing the data node's http port (http.enabled: false) would keep them from serving client requests (probably good), though it would also prevent you from curl'ing them directly for stats, etc.

Client nodes are useful (see #2), so I wouldn't route traffic directly to your data nodes. Whether you run both a client and data node on the same piece of hardware would be dependent on the config of that machine (do you have sufficient RAM, etc).

Client node are also useful for indexing, because they know which data node should receive the data for storage. If you sent an indexing request to a random data node instead, the odds would be high that it would have to redirect that request to another node. That's a waste of time and resources, if you can create client nodes.

Having your clients join the cluster might give them access to more information about the cluster, but using http gives them a more generic "black box" interface. With http, you also don't have to keep your clients at the same version as your ES nodes.

Hope that helps.

### VI. Number of total tasks
```
GET _cat/tasks?s=running_time:desc
```

Becareful with large number like 20-30k tasks running at the moment because it can lead to cluster timeout. That is the reason caused in ###III i already mentioned before

So the reason caused by client fluentbit. Which my friend setup push log from K8S to ES.

Before
```
 	[INPUT]
Name tail
Tag kube.*
Path /var/log/containers/*.log
Parser docker
DB /var/log/flb_kube.db
Mem_Buf_Limit 128MB
Skip_Long_Lines On
Refresh_Interval 10
```

After change `Refresh_Interval` to 30, the number of task reduced a lot from 30k ++ to 4-5k.
Cluster no longer suffer from timeout sometime xD

### VII. Suffering from JvmGcMonitorService run too frequent
- Too many shards given the total data volume, which will be affecting performance!
### VIII. Scroll:
```
Fortunately, it is easy to find this sweet spot: Try indexing typical documents in batches of increasing size. When performance starts to drop off, your batch size is too big. A good place to start is with batches of 1,000 to 5,000 documents or, if your documents are very large, with even smaller batches.

It is often useful to keep an eye on the physical size of your bulk requests. One thousand 1KB documents is very different from one thousand 1MB documents. A good bulk size to start playing with is around 5-15MB in size.

```
