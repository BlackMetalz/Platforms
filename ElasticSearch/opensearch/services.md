### Service file for opensearch
#### Ref: https://discuss.opendistrocommunity.dev/t/install-opensearch-as-a-service-without-using-docker-or-kubernetes-like-elasticsearch/8321

path example: /etc/systemd/system/opensearch.service


Content of it:
```
[Unit]
Description=Opensearch
Documentation=https://opensearch.org/docs/latest
Requires=network.target remote-fs.target
After=network.target remote-fs.target
ConditionPathExists=/data/opensearch-1.2.3
ConditionPathExists=/data/opensearch/data
[Service]
User=opensearch
Group=opensearch
WorkingDirectory=/data/opensearch-1.2.3
ExecStart=/data/opensearch-1.2.3/bin/opensearch


# Specifies the maximum file descriptor number that can be opened by this process
LimitNOFILE=65535

# Specifies the maximum number of processes
LimitNPROC=4096

# Specifies the maximum size of virtual memory
LimitAS=infinity

# Specifies the maximum file size
LimitFSIZE=infinity

# Disable timeout logic and wait until process is stopped
TimeoutStopSec=0

# SIGTERM signal is used to stop the Java process
KillSignal=SIGTERM

# Send the signal only to the JVM rather than its control group
KillMode=process

# Java process is never killed
SendSIGKILL=no

# When a JVM receives a SIGTERM signal it exits with code 143
SuccessExitStatus=143

# Allow a slow startup before the systemd notifier module kicks in to extend the timeout
TimeoutStartSec=75

# with this you don't need to setup memlock in /etc/security/limits.conf 
LimitMEMLOCK=infinity

[Install]
WantedBy=multi-user.target
```

