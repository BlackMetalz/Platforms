- MirrorMaker2 Architecture: https://github.com/apache/kafka/tree/trunk/connect/mirror
- Config: https://cwiki.apache.org/confluence/display/KAFKA/KIP-382%3A+MirrorMaker+2.0
![image](https://user-images.githubusercontent.com/3434274/125752406-358d94e0-c03c-4934-99d1-59f0cba812b4.png)


MM2 is based on the Kafka Connect framework and can be viewed at its core as a combination of a Kafka source and sink connector. 
In a typical Connect configuration, the source-connector writes data into a Kafka cluster from an external source and the sink-connector reads 
data from a Kafka cluster and writes to an external repository. As with MM1, the pattern of remote-consume and local-produce is recommended, thus in the simplest 
source-target replication pair, the MM2 Connect cluster is paired with the target Kafka cluster. Connect internally always needs a Kafka cluster to store 
its state and this is called the “primary” cluster which in this case would be the target cluster. In settings where there are multiple clusters across multiple 
data centers in active-active settings, it would be prohibitive to have an MM2 cluster for each target cluster. In MM2 only one connect cluster is needed for 
all the cross-cluster replications between a pair of datacenters. Now if we simply take a Kafka source and sink connector and deploy them in tandem to do 
replication, the data would need to hop through an intermediate Kafka cluster. MM2 avoids this unnecessary data copying by a direct passthrough from source to sink.  


Read more at: https://blog.cloudera.com/a-look-inside-kafka-mirrormaker-2/ 😹 

- Weak Point from my personal opinion:
+ Have to restart mm2 service whenever new topic is created for sync data ( replica topic is created but doesn't sync data )
+ Deleted topic isn't geting delete in replica cluster ( have to delete two time )
