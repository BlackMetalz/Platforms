### 1. Note for setup Kafka with both Lan / Wan IP in server.properties

```
listeners=PLAINTEXT://10.0.0.1:9092,SASL_PLAINTEXT://10.0.0.1:9093,SASL_PLAINTEXT_WAN://12.12.12.12:9094
advertised.listeners=PLAINTEXT://10.0.0.1:9092,SASL_PLAINTEXT://10.0.0.1:9093,SASL_PLAINTEXT_WAN://12.12.12.12:9094


listener.security.protocol.map=PLAINTEXT:PLAINTEXT,SSL:SSL,SASL_PLAINTEXT:SASL_PLAINTEXT,SASL_SSL:SASL_SSL,SASL_PLAINTEXT_WAN:SASL_PLAINTEXT
```

important is map Custom with sasl: `SASL_PLAINTEXT_WAN:SASL_PLAINTEXT`