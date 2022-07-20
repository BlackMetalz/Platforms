-- Actice - Active

1. Remote_Dc_1 conf:
```
# Aerospike database configuration file for use with systemd.

service {
        paxos-single-replica-limit 1 # Number of nodes where the replica count is automatically reduced to 1.
#        service-threads 16
#       migrate-threads 16
        proto-fd-max 50000
        log-local-time true
}

logging {
        file /var/log/aerospike/aerospike.log {
                context any info
        }
}

network {
        service {
                address eth0
                port 3000
        }

        heartbeat {
                address eth0
                mode mesh
                port 3002

                mesh-seed-address-port 10.8.6.178 3002
                mesh-seed-address-port 10.8.6.42 3002
                mesh-seed-address-port 10.3.48.54 3002

                interval 150
                timeout 10
        }

        fabric {
                address eth0
                port 3001
        }

        info {
                port 3003
        }
}

xdr {
        enable-xdr true # Globally enable/disable XDR on local node.
        xdr-digestlog-path /opt/aerospike/digestlog 20G # Track digests to be shipped.
        xdr-compression-threshold 1000
        forward-xdr-writes true
        datacenter REMOTE_DC_2 {
               dc-node-address-port 10.8.7.83 3000
               dc-node-address-port 10.8.7.101 3000
               dc-node-address-port 10.3.48.56 3000
        }
}


namespace mem_storage {
        enable-xdr true
        migrate-sleep 0
        xdr-remote-datacenter REMOTE_DC_2
        replication-factor 2
        memory-size 1G
        default-ttl 30d # 30 days, use 0 to never expire/evict.
        storage-engine memory
}

```

2. Remote_Dc_2:

```
# Aerospike database configuration file for use with systemd.

service {
        paxos-single-replica-limit 1 # Number of nodes where the replica count is automatically reduced to 1.
#        service-threads 16
#        migrate-threads 16
        proto-fd-max 50000
        log-local-time true
}

logging {
        file /var/log/aerospike/aerospike.log {
                context any info
        }
}

network {
        service {
                address eth0
                port 3000
        }

        heartbeat {
                address eth0
                mode mesh
                port 3002

                mesh-seed-address-port 10.8.7.83 3002
                mesh-seed-address-port 10.8.7.101 3002
                mesh-seed-address-port 10.3.48.56 3002

                interval 150
                timeout 10
        }

        fabric {
                address eth0
                port 3001
        }

        info {
                port 3003
        }
}

xdr {
        enable-xdr true # Globally enable/disable XDR on local node.
        xdr-digestlog-path /opt/aerospike/digestlog 20G # Track digests to be shipped.
        xdr-compression-threshold 1000
        forward-xdr-writes true
        datacenter REMOTE_DC_1 {
                dc-node-address-port 10.8.6.42 3000
                dc-node-address-port 10.8.6.178 3000
                dc-node-address-port 10.3.48.54 3000
        }

}


namespace mem_storage {
        enable-xdr true
        migrate-sleep 0
        xdr-remote-datacenter REMOTE_DC_1
        replication-factor 2
        memory-size 1G
        default-ttl 30d # 30 days, use 0 to never expire/evict.
        storage-engine memory
}
```
