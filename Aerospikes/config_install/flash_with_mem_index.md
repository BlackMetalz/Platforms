Aerospike config:

```
namespace wtf {
  replication-factor 2
  memory-size 1G
  default-ttl 30d # 5 days, use 0 to never expire/evict.
 
  storage-engine device {
    file /opt/aerospike/data/wtf.dat
    filesize 5G
    data-in-memory false # Store data in memory in addition to file.
    #write-block-size 128K   # adjust block size to make it efficient for SSDs. Only for device /dev/<device>

  }
}


```

Docker config:

```
version: '3.3'

services:
    aerospikedb:
        image: aerospike/aerospike-server:4.4.0.8
        networks:
        - aerospikenetwork
        deploy:
            mode: global
        labels:
            com.aerospike.description: "This label is for all containers for the Aerospike service"
        command: ["--config-file","/run/secrets/aerospike.conf"]
        secrets:
        - source: conffile
          target: aerospike.conf
          mode: 0440
        volumes:
        - aerospikedata:/opt/aerospike/data
        - aerospikelog:/var/log/aerospike

networks:
    aerospikenetwork:
        external:
            name: "host"

secrets:
    conffile:
        file: ./aerospike.conf

configs:
    amc_config:
        file: ./amc.conf

volumes:
    aerospikedata:
        driver_opts:
            type: none
            device: /data1/aerospike/data
            o: bind
    aerospikelog:
        driver_opts:
            type: none
            device: /data1/aerospike/log
            o: bind
```
