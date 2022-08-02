```
kafka-consumer-perf-test.sh --bootstrap-server boot-strapserver.com:9094 --consumer.confg config/api_wtf.properties --topic zzz-5-1-wut --messages 100
```

Content of api_wtf.properties
```
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="zzz-5-1-wutwut" password="passwordgohere";
security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-512
```
