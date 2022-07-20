### Database Hierarchy

| Term  	|   Definition	|   	Notes|  
|---	|---	|---	|
|  Cluster 	| An Aerospike cluster services a single database service  	|  While a company may deploy multiple clusters,applications will only connect to a single cluster.	|
|   Node	|   A single instance of an Aerospike database. 	|  For production deployments, a host should only have a single node. For development, you may place more than one node on a host. 	| 
|  Namespace 	|   An area of storage related to the media. Can be either RAM or SSD based.	|  Similar to a “database” or “tablespaces” in relational databases. 	| 
| Set  	|  An unstructured grouping of data that have some commonality. 	|  Similar to “tables” in a relational database, but do not require a schema. 	| 
|   Record	|  A key and all data related to that key. 	|   Similar to a “row” in a relational database	| 
| Bin  	|  One part of data related to a key 	|   Bins in Aerospike are typed, but the same bin in different records can have different types. Bins are not required. Single bin optimizations are allowed.	| 
|   (Large Data Type) LDT	|  LDTs provide functions for storing arbitrarily large amounts of data without requiring the database to read the entire record. 	|  Most commonly the data stored in LDTs will be time series data, but this is not a requirement. This feature is still in development. 	| 



Reference: Aerospike 2013 documents


Cluster
```
➤ Will be distributed on different nodes.
➤ Management of cluster is automated, so
no manual rebalancing or reconfiguration
is necessary.
➤ Will contain one or more namespaces.
Adding/removing namespaces requires a
cluster-wide restart.
```

Nodes
```
➤ Each node is assumed to be identical.
➤ Data (and their associated traffic) will be
evenly balanced across the nodes.
➤ Big differences between nodes imply a
problem.
➤ Node capacity should take into account
node failure patterns. 
```

Namespaces
```
➤ Are associated with the storage media:
- Hybrid (ram for index and SSD for data)
- RAM + disk for persistence only
- RAM only
➤ Each can be configured with their own:
- replication factor (change requires a cluster-wide restart)
- RAM and disk configuration
- settings for high-watermark
- default TTL (if you have data that must never be
automatically deleted, you must set this to “0”)
```

Sets
```
➤ Similar to “tables” in relational
databases.
➤ Sets are optional.
➤ Schema does not have to be pre-defined.
➤ In order to request a record, you must
know its set.
➤ Scans can be done across a set 
```

Records
```
➤ Similar to a row in a relational database.
➤ All data for a record will be stored on the
same node. This is true even for LDTs.
➤ Any change to a record will result in a
complete write of the entire record,
unless using LDTs.
```

Bins
```
➤ Values Are typed. Current types are:
- Simple (integer, string, blob [language specific])
- Complex (list, map)
- Large Data Types (LDTs)
➤ A single bin may be updated by the client.
- Increment
- Replacement
- User Defined Function (UDF)
```
