## Source: https://github.com/confluentinc/examples/tree/6.2.0-post/clients/cloud/go

- Create new `producer.conf` file with content for produce
```
# Kafka producer
bootstrap.servers=10.3.48.54:9093,10.3.48.56:9093,10.3.48.82:9093
security.protocol=SASL_PLAINTEXT
sasl.mechanisms=SCRAM-SHA-256
sasl.username=test1
sasl.password=test1
```

`consumer.conf` for consume:
```
# Kafka consumer
bootstrap.servers=10.3.48.54:9093,10.3.48.56:9093,10.3.48.82:9093
security.protocol=SASL_PLAINTEXT
sasl.mechanisms=SCRAM-SHA-256
sasl.username=test1
sasl.password=test1
group.id=test_1_group
```

2 files config for more clear i guess, but you can take them all in one file only xD

### - Producer
```
./producer -f producer.conf -t test_1
```
### - Consumer. In this time i did test, there is a little trouble related to group. 

You have to update in source code that group.id is read from config file!
```
        // Create Consumer instance
        c, err := kafka.NewConsumer(&kafka.ConfigMap{
                "bootstrap.servers": conf["bootstrap.servers"],
                "sasl.mechanisms": conf["sasl.mechanisms"],
                "security.protocol": conf["security.protocol"],
                "sasl.username":     conf["sasl.username"],
                "sasl.password":     conf["sasl.password"],
                "group.id":          conf["group.id"],
                "auto.offset.reset": "earliest",
        })
```

```
./consumer -f consumer.conf -t test_1
```


