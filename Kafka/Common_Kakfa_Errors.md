- GroupAuthorizationFailedError:
```
Have to create group with prefix pattern already grant in kafka auth :D
```

- About a java.lang.NoClassDefFoundError: Could not initialize class org.xerial.snappy.Snappy:
```
This error come from client side. Client using compression ( maybe disable compression in client? )
Source: https://stackoverflow.com/questions/41344968/about-a-java-lang-noclassdeffounderror-could-not-initialize-class-org-xerial-sn
```

- [2020-06-01 16:23:18,548] ERROR [ReplicaFetcherThread-0-4], Error for partition [1234_vlxx_topic,4] to broker 4:org.apache.kafka.common.errors.UnknownTopicOrPartitionException: This server does not host this topic-partition. (kafka.server.ReplicaFetcherThread)
```
Old data is discarded after log retention period or when the log reaches retention time.  In this case, you may need to increase retention period.  replication errors looks normal. Please reopen if you think the issue still exists
```

- [2020-06-21 11:13:14,919] FATAL [Replica Manager on Broker 1]: Halting due to unrecoverable I/O error while handling produce request:  (kafka.server.ReplicaManager)
kafka.common.KafkaStorageException: I/O exception in append to log 'vda-32' Caused by: java.io.IOException: Map failed

```
When this doesn't resolve the problem you could try to increase vm.max_map_count. The default value is 65536 (check this with sysctl vm.max_map_count)

With cat /proc/[kafka-pid]/maps | wc -l you can see how many maps are used.

Increase the setting with :

sysctl -w vm.max_map_count=262144
# Source: https://stackoverflow.com/questions/43042144/kafka-server-failed-to-start-java-io-ioexception-map-failed
```

-- This is not error but warning: producer use only one key for push data to kafka broker. It only send data to only one partition for ordering.
![image](https://user-images.githubusercontent.com/3434274/123737519-473ce300-d8cd-11eb-8f1c-65a828c542b0.png)
