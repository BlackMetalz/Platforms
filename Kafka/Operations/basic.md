### Source: 
- https://www.tutorialspoint.com/apache_kafka/apache_kafka_basic_operations.htm
- https://kafka.apache.org/quickstart
- https://medium.com/@TimvanBaarsen/apache-kafka-cli-commands-cheat-sheet-a6f06eac01b

- Start kafka broker:
```
bin/kafka-server-start.sh config/server.properties
```


- Start Producer to Send Messages:
```
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic topic-name
```

Then type something like:
```
hello
first
second messages
abc
wtf
uuu.kimochi
```

- Start Consumer to Receive Messages
```
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topic-name --from-beginning
```



