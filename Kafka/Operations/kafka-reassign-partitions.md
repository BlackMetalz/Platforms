# Source: https://docs.confluent.io/platform/current/kafka/post-deployment.html
- Partition 1. Rep 3
```
Topic: wtf  PartitionCount: 3  ReplicationFactor: 1  Configs: 
  Topic: wtf  Partition: 0  Leader: 1  Replicas: 1  Isr: 1
  Topic: wtf  Partition: 1  Leader: 0  Replicas: 0  Isr: 0
  Topic: wtf  Partition: 2  Leader: 2  Replicas: 2  Isr: 2
```

- increase Replication factor json. (increase-replication-factor.json)
```
{
  "version": 1,
  "partitions" :
  [
    {
      "topic": "wtf",
      "partition": 0,
      "replicas": [0,1,2]
    },
    {
      "topic": "wtf",
      "partition": 1,
      "replicas": [0,1,2]
    },
  {
      "topic": "wtf",
      "partition": 2,
      "replicas": [0,1,2]
    }
  ]
}
```

- Command:
```
bin/kafka-reassign-partitions.sh --bootstrap-server 10.3.48.54:9092 --reassignment-json-file increase-replication-factor.json --execute
```

- After Run:
```
Topic: wtf  PartitionCount: 3  ReplicationFactor: 3  Configs: 
  Topic: wtf  Partition: 0  Leader: 0  Replicas: 0,1,2  Isr: 1,0,2
  Topic: wtf  Partition: 1  Leader: 0  Replicas: 0,1,2  Isr: 0,2,1
  Topic: wtf  Partition: 2  Leader: 2  Replicas: 0,1,2  Isr: 2,1,0
```

- Verify
```
bin/kafka-reassign-partitions.sh --bootstrap-server 10.3.48.54:9092 --reassignment-json-file increase-replication-factor.json --verify
```
