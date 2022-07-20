## Used example from this: https://github.com/confluentinc/confluent-kafka-python/tree/master/examples

### -- Producer with sasl_plaintext:
```
(venv_examples) root@94-94:/data/confluent-kafka-python/examples# ./sasl_producer.py
usage: sasl_producer.py [-h] -b BOOTSTRAP_SERVERS [-t TOPIC] [-d DELIMITER] [-m {GSSAPI,PLAIN,SCRAM-SHA-512,SCRAM-SHA-256}] [--tls ENAB_TLS] -u USER_PRINCIPAL -s USER_SECRET
sasl_producer.py: error: the following arguments are required: -b, -u, -s
(venv_examples) root@94-94:/data/confluent-kafka-python/examples# ./sasl_producer.py -b 10.3.48.54:9093 -t test_1 -m SCRAM-SHA-256 -u test1 -s test1
Producing records to topic test_1. ^C to exit.
>1
>2
User record None successfully produced to test_1 [1] at offset 1
>3
User record None successfully produced to test_1 [0] at offset 0
>4
User record None successfully produced to test_1 [5] at offset 3
>5
User record None successfully produced to test_1 [4] at offset 0
>6
User record None successfully produced to test_1 [2] at offset 0
>7
>8
```

### -- Consumer: You have update conf in consumer.py to
```
    conf = {'bootstrap.servers': broker, 'group.id': group, 'session.timeout.ms': 6000, 'sasl.mechanisms': 'SCRAM-SHA-256',
            'auto.offset.reset': 'earliest', 'security.protocol': 'sasl_plaintext', 'sasl.username': 'test1', 'sasl.password': 'test1'}
```
If you want to use sasl_plaintext xD.  `'sasl.mechanisms': 'SCRAM-SHA-256' `: This is the part where you create user with!

Command in action:
```
./consumer.py 10.3.48.54:9093 test_1_consumer test_1
```
