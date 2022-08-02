## Source: 
- https://developer.ibm.com/tutorials/kafka-authn-authz/
- https://codeforgeek.com/how-to-set-up-authentication-in-kafka-cluster/
- 

I. Authentication mechanism Kafka provides

- Authentication using SSL.
- Authentication using SASL.

 will use Authentication using SASL. In SASL, we can use the following mechanism.
```
GSSAPI (Kerberos)
PLAIN
SCRAM-SHA-256
SCRAM-SHA-512
OAUTHBEARER
```

II. Operation vs Resource:

![image](https://user-images.githubusercontent.com/3434274/131313763-6257f98c-65b9-43f6-a97b-a6acbfb1adb8.png)




III. Step by step for setup a cluster with auth: zk, kafka and mm2

1. Setup zookeeper binary with config from here: 
- We have to create a user and group named: zookeeper
zoo.cfg: https://github.com/BlackMetalz/kafka/blob/main/security/zoo.cfg
zookeeper.yaml: https://github.com/BlackMetalz/kafka/blob/main/security/zookeeper.yaml
jmx_prometheus_javaagent-0.15.0.jar: Download it from internet xD
- Create service for it in  `/etc/systemd/system/zookeeper-2181.service`. Content:
```
[Unit]
Description=Zookeeper Daemon for port 2181
Documentation=http://zookeeper.apache.org
Requires=network.target
After=network.target

[Service]
Type=forking
WorkingDirectory=/data/zookeeper-3.5.8-2181
User=zookeeper
Group=zookeeper
Environment="ZOO_LOG_DIR=/data/zookeeper-data/zookeeper-3.5.8-2181/logs"
Environment=SERVER_JVMFLAGS="-Xms1024m -Xmx2048m -Djava.security.auth.login.config=/data/zookeeper-3.5.8-2181/conf/zookeeper_jaas.conf -Dzookeeper.requireClientAuthScheme=sasl -Dzookeeper.authProvider.1=org.apache.zookeeper.server.auth.SASLAuthenticationProvider -javaagent:/opt/jmx_prometheus_javaagent-0.15.0.jar=7070:/opt/zookeeper.yaml"
ExecStart=/data/zookeeper-3.5.8-2181/bin/zkServer.sh start /data/zookeeper-3.5.8-2181/conf/zoo.cfg
ExecStop=/data/zookeeper-3.5.8-2181/bin/zkServer.sh stop /data/zookeeper-3.5.8-2181/conf/zoo.cfg
ExecReload=/data/zookeeper-3.5.8-2181/bin/zkServer.sh restart /data/zookeeper-3.5.8-2181/conf/zoo.cfg
TimeoutSec=30
Restart=on-failure

[Install]
WantedBy=default.target
```

Start service, that's all for ZK

2. Setup kafka cluster with auth: I'm using kafka_2.13-2.7.0 in this step
- We have to create user and group named: kafka
server.properties: https://github.com/BlackMetalz/kafka/blob/main/security/server.properties
log4j.properties: already include in binary source xD
kafka-2_0_0.yml:  https://github.com/BlackMetalz/kafka/blob/main/security/kafka-2_0_0.yml
jmx_prometheus_javaagent-0.15.0.jar: Download it from internet xD

- Create service for kafka: ` /etc/systemd/system/kafka.service`. Content:
```
[Unit]
Description=Apache Kafka server (broker)
Requires=zookeeper-2181.service
After=zookeeper-2181.service
Documentation=http://kafka.apache.org/documentation.html
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
User=kafka
Group=kafka
WorkingDirectory=/data/kafka/kafka_2.13-2.7.0
Environment="KAFKA_LOG4J_OPTS=-Dlog4j.configuration=file:/data/kafka/kafka_2.13-2.7.0/config/log4j.properties -Dkafka.logs.dir=/data/kafka/kafka_2.13-2.7.0/logs"
Environment="KAFKA_JMX_OPTS=-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=10001 -Djava.rmi.server.hostname=10.3.48.54"
Environment="KAFKA_OPTS=-Djava.security.auth.login.config=/data/kafka/kafka_2.13-2.7.0/kafka_server_jaas.conf -javaagent:/opt/jmx_prometheus_javaagent-0.15.0.jar=9090:/opt/kafka-2_0_0.yml"
Environment="KAFKA_HEAP_OPTS=-Xms4g -Xmx4g -XX:MetaspaceSize=96m -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:G1HeapRegionSize=16M -XX:MinMetaspaceFreeRatio=50 -XX:MaxMetaspaceFreeRatio=80"
ExecStart=/data/kafka/kafka_2.13-2.7.0/bin/kafka-server-start.sh /data/kafka/kafka_2.13-2.7.0/config/server.properties
ExecStop=/data/kafka/kafka_2.13-2.7.0/bin/kafka-server-stop.sh
Restart=on-failure
SyslogIdentifier=kafka
SuccessExitStatus=143
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
```

- Start kafka by service. Create 2 user with following command, we already define them in jaas files
```
bin/kafka-configs.sh --zookeeper 10.3.48.54:2181,10.3.48.56:2181,10.3.48.82:2181 -add-config 'SCRAM-SHA-256=[iterations=8192,password=admin]' --alter --entity-type users --entity-name admin
bin/kafka-configs.sh --zookeeper 10.3.48.54:2181,10.3.48.56:2181,10.3.48.82:2181 -add-config 'SCRAM-SHA-256=[iterations=8192,password=kienlt_pwd]' --alter --entity-type users --entity-name kienlt
```

- Allow access from hosts which is kafka broker. If you want more detail you have to read about kafka acls. This will take sometimes for you i guess ( it takes shit load of time for me :( )
```
# I have to allow 3 host as they are broker in this.
# Allow all
kafka-acls.sh --authorizer-properties zookeeper.connect=10.3.48.54:2181,10.3.48.56:2181,10.3.48.82:2181 --operation All --allow-principal User:*  --allow-host 10.3.48.54  --allow-host 10.3.48.56 --allow-host 10.3.48.82 --cluster --topic '*' --group '*' --add
```

- After this in my case i don't have any error lefts in log :D

3. Setup Mirror Maker 2 ( mm2 ) service:

- Put config in ` /data/kafka/kafka_2.13-2.7.0/config/mm2.properties` : with content from https://github.com/BlackMetalz/kafka/blob/main/security/mm2.properties

- Create folder for mm2 logs in all brokers: ( via salt `salt \* cmd.run 'mkdir -p /data/kafka/mm2/logs'` )
```
mkdir /data/kafka/mm2/logs
```
- Setup Service for mm2:  `/etc/systemd/system/mm2.service`
```
[Unit]
Description=Mirror Make 2 Service
After=netowrk.target
[Service]
Type=simple
Restart=always
LimitNOFILE=65535
RestartSec=1
User=root
Environment="KAFKA_HEAP_OPTS=-Xmx4G -Xms4G"
Environment="KAFKA_LOG4J_OPTS=-Dlog4j.configuration=file:/data/kafka/kafka_2.13-2.7.0/config/connect-log4j.properties -Dkafka.logs.dir=/data/kafka/mm2/logs"
Environment="KAFKA_OPTS=-javaagent:/data/kafka/kafka_2.13-2.7.0/jmx_prometheus_javaagent-0.15.0.jar=3600:/data/kafka/kafka_2.13-2.7.0/config/kafka-connect.yml"
ExecStart=/data/kafka/kafka_2.13-2.7.0/bin/connect-mirror-maker.sh /data/kafka/kafka_2.13-2.7.0/config/mm2.properties
[Install]
WantedBy=multi-user.target
```

- Start service, that's all.
Note for mm2:
At this time it doesn't auto sync data for topic, you have to restart mm2 process. With saltstack be like: `salt -b 1 kafka-cluster-* service.restart mm2`
For delete topic, you have to delete it in both cluster.
