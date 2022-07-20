# Docker logging for Elasticsearch:
## https://fluentbit.io/articles/docker-logging-elasticsearch/
## https://docs.fluentbit.io/manual/installation/getting-started-with-fluent-bit


### 1. Install for Ubuntu 20.04
```
apt-get update && apt-get install ca-certificates
wget -qO - https://packages.fluentbit.io/fluentbit.key | sudo apt-key add -
```
Append `deb [arch=amd64] https://packages.fluentbit.io/ubuntu/focal focal main` to ` /etc/apt/sources.list`

```
apt-get update
apt-get install td-agent-bit
```

### 2. Config td-agent bit
`vim /etc/td-agent-bit/td-agent-bit.conf`
Content:
```
[SERVICE]
    Flush        30
    Daemon       Off
    Log_Level    debug

[INPUT]
    Name   forward
    Listen 0.0.0.0
    Port   24224

[OUTPUT]
    Name es
    Match *
    Host 10.3.104.30
    Port 9200
    HTTP_User fluent-bit-user
    HTTP_Passwd fluent-bit-password
    Index fluent-bit_${HOSTNAME}
```

### 3. Test 
```
docker run -t -i --log-driver=fluentd alpine echo "wtf"
```

Output demo in kibana:
![image](https://user-images.githubusercontent.com/3434274/141273086-cb4ce3df-dfac-4131-bb0a-5a4e7635722f.png)
