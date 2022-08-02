## Kafdrop – Kafka Web UI 
- Basic config for kafdrop: https://github.com/obsidiandynamics/kafdrop

```
docker run -d --rm -p 9000:9000 \
    -e KAFKA_BROKERCONNECT=10.3.48.54:9092,10.3.48.56:9092,10.3.48.82:9092 \
    -e JVM_OPTS="-Xms32M -Xmx64M" \
    -e SERVER_SERVLET_CONTEXTPATH="/" \
    obsidiandynamics/kafdrop
```

Remember to grant full permission to host which hosted kafdrop:
```
bin/kafka-acls.sh --authorizer-properties zookeeper.connect=10.3.48.54:2181 --operation All --allow-principal User:*   --allow-host 10.99.99.99 --cluster --topic '*' --group '*' --add
```
