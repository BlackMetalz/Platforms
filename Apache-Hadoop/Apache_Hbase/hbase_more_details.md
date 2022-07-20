#### Ref:
- https://www.onlineinterviewquestions.com/
- https://viblo.asia/p/hbase-overview-architecture-va-data-flow-63vKj6J6K2R

Question: what is DDL?
- Answer:
```
Data Definition Language. DDL statements are used to create database, schema, constraints, users, tables etc.	
Example command: CREATE, DROP, RENAME and ALTER.	
```

Question: What is NameSpace in Hbase?
- Answer: 
```
The namespace is used for logical table grouping into a database system.
It helped to resource management, Security, isolation. The syntax of NameSpace is below.
<table namespace>:<table qualifier> .
TL-DR: logical grouping of tables
```

Question: what is HBase table?
- Answer:
```
An HBase table is a multi-dimensional map comprised of one or more columns and rows of data. 
You specify the complete set of column families when you create an HBase table
TL-DR: collection of all rows
```

Question: what is Hbase row?
- Answer:
```
Row—a collection of column families. Column Family—a collection of columns. 
HBase stores data by column family and not row. This makes for faster retrieval of columns since they are located near each other
TL-DR: collection of all column family ( cf )
```

Question: what is Hbase Column Family?
- Answer:
```
Collection of all columns (col)
```

Question: what is Hbase Column?
- Answer:
```
Collection of row-key pairs
```

Question: what is Hbase Cell?
- Answer:
```
row, column, version determine 1 cell in Hbase
```

Question: what is Hbase Region?
- Answer:
```
a region consists of all the rows between the start key and the end key which are assigned to that Region
```

Question: what is Hbase Region Servers?
- Answer:
```
those Regions which we assign to the nodes in the HBase Cluster, is what we call “Region Servers”
```

Question: what is Hbase meta table?
- Answer:
```
META Table is a special HBase Catalog Table. Basically, it holds the location of the regions in the HBase Cluster.

- It keeps a list of all Regions in the system.
- Structure of the .META. table is as follows:
1. Key: region start key, region id
2. Values: RegionServer

It is like a binary tree
```
