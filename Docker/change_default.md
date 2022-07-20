### Change Default data location of docker

- Stop service first:
```
service docker stop
```

- Edit or create new file `/etc/docker/daemon.json` with content:
```
{
"data-root": "/data/docker"
}
```

- Create new folder location for docker and rsync old data of docker to new location of docker

```
mkdir /data/docker
rsync -aqxP /var/lib/docker/ /data/docker
```
- Start service and Done


### Change default subnet of docker to avoid conflict with real network. Example i have real ip with subnet 172.17.0.0.
- Show current route:

```
route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         gateway         0.0.0.0         UG    0      0        0 bond0
link-local      0.0.0.0         255.255.0.0     U     1004   0        0 bond0
169.254.169.250 0.0.0.0         255.255.255.255 UH    0      0        0 docker0
172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0
192.168.23.0    0.0.0.0         255.255.255.0   U     0      0        0 bond0
```

- Stop the service
```
service docker stop
```

- delete that route

```
route del -net 172.17.0.0/16 gw 0.0.0.0 docker0
```

- Update or create new file with content: `/etc/docker/daemon.json`

```
{
"bip": "172.29.0.1/24"
}
```

- Start docker service and check new route have been updated for docker

```

route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         gateway         0.0.0.0         UG    0      0        0 bond0
link-local      0.0.0.0         255.255.0.0     U     1004   0        0 bond0
169.254.169.250 0.0.0.0         255.255.255.255 UH    0      0        0 docker0
172.29.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0
192.168.23.0    0.0.0.0         255.255.255.0   U     0      0        0 bond0

```

-- Complete with limit log driver
```
	"data-root": "/data/docker", 
	"bip": "172.18.0.1/24",
	"log-driver": "json-file",
  		"log-opts": {
    			"max-size": "100m",
    			"max-file": "3"
 		 }
```
