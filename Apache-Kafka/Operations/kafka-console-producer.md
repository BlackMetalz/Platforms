- Consumer with auth
```
kafka-console-producer.sh --broker-list 10.3.48.54:9093 --topic test_topic --producer.config ~/kafka_2.13-2.7.0/config/producer.properties
```

producer.properties content for auth:
```
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="kienlt" password="password_go_here";
security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-256
```
