### 1. Hbase Regions:

![image](https://user-images.githubusercontent.com/3434274/166670955-f42c10d5-2b1c-4ce5-9286-24b6298e719a.png)

- Client connect with zookeeper endpoint, retrieve list of region servers
- Regions are assigned to Region Servers
- Table are horizontally partitioned into key ranges ( regions )

### 2. Hbase Hmaster:

![image](https://user-images.githubusercontent.com/3434274/166671256-ebf83cfa-560a-4673-aba7-8c3e599da89d.png)

- Coordinating the region servers
- Master monitors all RegionServer instances in the HBase Cluster
- It acts as an interface for creating, deleting and updating tables in HBase

### 3. Zookeeper:

![image](https://user-images.githubusercontent.com/3434274/166671544-4443f3d3-ba56-4e8f-8e74-b15d17d39d10.png)


### Ref:
- https://data-flair.training/blogs/hbase-architecture/
