1. Zookeeper: /etc/systemd/system/zookeeper.service
```
[Unit]
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
User=kafka
ExecStart=/data/kafka/kafka_2.13-2.7.0/bin/zookeeper-server-start.sh /data/kafka/kafka_2.13-2.7.0/config/zookeeper.properties
ExecStop=//data/kafka/kafka_2.13-2.7.0/bin/zookeeper-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
```

2. Kafka: /etc/systemd/system/kafka.service
```
[Unit]
Requires=zookeeper.service
After=zookeeper.service

[Service]
Type=simple
User=kafka
ExecStart=/bin/sh -c '/data/kafka/kafka_2.13-2.7.0/bin/kafka-server-start.sh /data/kafka/kafka_2.13-2.7.0/config/server.properties > /data/kafka/kafka_2.13-2.7.0/logs/kafka.log 2>&1'
ExecStop=/data/kafka/kafka_2.13-2.7.0/bin/kafka-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
```
