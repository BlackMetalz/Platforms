- Configure Aerospike Database


```
service {
  user root # This service run on root user
  
  group root # This service run on root group
  
  paxos-single-replica-limit 1 # Number of nodes where the replica count is automatically reduced to 1.
  
  pidfile /data/softs/aerospike-server/var/run/aerospike.pid # Location storage pid of aerospike
  
  # The number of concurrent connections to the database is limited by
  # proto-fd-max, and by the system's maximum number of open file descriptors.
  # See "man limits.conf" for how to set the system's "nofile" limit.
  proto-fd-max 15000
  
  # Seem like this location of aerospike server works...
  work-directory /data/softs/aerospike-server/var 
  
  log-local-time true # use local time instead of default GMT
}

logging {
	# Log file must be an absolute path.
	file run/log/aerospike.log {
		context any info
	}
}
```

- Network with heartbeat multicast

```
network {
	service {
		address any
		port 3000
	}

	heartbeat {
		mode multicast
		multicast-group 239.1.99.222
		port 9918

		# To use unicast-mesh heartbeats, remove the 3 lines above, and see
		# aerospike_mesh.conf for alternative.

		interval 150
		timeout 10
	}

	fabric {
		port 3001
	}

	info {
		port 3003
	}
}

```

- Network with heartbeat mesh ( TCP / IP )
```
network {
  service {
    address any
    port 3000
  }
 heartbeat {
    address vlan1189 # interface name of network ( ifconfig )
    mode mesh
    port 3002
        mesh-seed-address-port 172.18.9.20 3002
        mesh-seed-address-port 172.18.9.22 3002
        mesh-seed-address-port 172.18.9.23 3002
        mesh-seed-address-port 172.18.9.24 3002
        mesh-seed-address-port 172.18.9.25 3002
    interval 150
    timeout 10
  }
  
  fabric {
    address vlan1189
    port 3001
  }

  info {
    port 3003
  }
}


- Namespace
```

# Example for mem storage
namespace mem_storage {
  replication-factor 2 # Best practice is 2. 1 Master and 1 replica
  memory-size 64G
  default-ttl 1 # 30 days, use 0 to never expire/evict.
  storage-engine memory
}

# Example for device storage
namespace hdd_storage {
        replication-factor 2 # Best practice is 2. 1 Master and 1 replica
        memory-size 32G
        default-ttl 1 # 30 days, use 0 to never expire/evict.
        storage-engine device {
                file /data/aerospike_data/aerospike_data.bat # Location storage aerospike data
                filesize 1024G
                data-in-memory false # Store data in memory in addition to file.
        }
}
```


-- Eviction :
Eviction is when records are removed before their expiration time. Only records where TTL is set to a positive integer will be affected by evictions. Eviction starts when a High Water Mark (either disk or memory) is breached. It is particularly important to understand the role of bucket width in eviction as this explain which data will be evicted first.

