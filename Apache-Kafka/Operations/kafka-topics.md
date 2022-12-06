### Creating a Kafka Topic − Kafka provides a command line utility named kafka-topics.sh to create topics on the server. 
Note: Don't use `.` ( dot ) or `_` ( underscore ) for topic names
Open new terminal and type the below example.
```
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1  --partitions 1 --topic topic-name
```
Output: 
```
root@sys-test-48-54:/data/kafka/kafka_2.13-2.7.0# bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic hello-kafka
Created topic hello-kafka.
```
More example:
```
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 2  --partitions 6 --config retention.ms=43200000 --topic topic-name
```


### Delete topic:
```
./bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic topic-name
```

- Delete topic with pattern / regex:
```
./bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic 'topic_name-.*'
```

### List kafka topics:
```
bin/kafka-topics.sh --list --zookeeper localhost:2181
```

- check which broker is listening on the current created topic as shown below
```
bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic topicname
```
Output:
```
bin/kafka-topics.sh --describe --zookeeper localhost:2181 
--topic Multibrokerappli-cation

Topic:Multibrokerapplication    PartitionCount:1 
ReplicationFactor:3 Configs:
   
Topic:Multibrokerapplication Partition:0 Leader:0 
Replicas:0,2,1 Isr:0,2,1

```
From the above output, we can conclude that first line gives a summary of all the partitions, showing topic name, 
partition count and the replication factor that we have chosen already. In the second line, each node will be the leader for 
a randomly selected portion of the partitions.

In our case, we see that our first broker (with broker.id 0) is the leader. Then Replicas:0,2,1 means that all the brokers replicate the 
topic finally Isr is the set of in-sync replicas. Well, this is the subset of replicas that are currently alive and caught up by the leader.

### Miscellaneous
Find all the partitions where one or more of the replicas for the partition are not in-sync with the leader.
```
$KAFKA_HOME/bin/kafka-topics.sh --zookeeper localhost:2181 --describe --under-replicated-partitions
```

Increase partiton of topic or by regex:

```
kafka-topics --alter --zookeeper localhost:2181 --topic my-topic-name --partitions 3
kafka-topics --alter --zookeeper localhost:2181 --topic 'item_s.*' --partitions 3
```
