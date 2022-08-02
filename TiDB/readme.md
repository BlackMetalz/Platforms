### Complete document: https://docs.pingcap.com/tidb/

### Bootstrap simple cluster in single machine. Ref: https://docs.pingcap.com/tidb/stable/quick-start-with-tidb



1. Download and install TiUP:
```
curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
```

2. Active enviroment:
```
source ~/.bashrc
```

3. Install the cluster component of TiUP:
```
tiup cluster
```

4. Update:
```
tiup update --self && tiup update cluster
```

5. Create and start the cluster
Edit the configuration file according to the following template, and name it as topo.yaml:

```
# # Global variables are applied to all deployments and used as the default value of
# # the deployments if a specific deployment value is missing.
global:
 user: "tidb"
 ssh_port: 22
 deploy_dir: "/tidb-deploy"
 data_dir: "/tidb-data"

# # Monitored variables are applied to all the machines.
monitored:
 node_exporter_port: 9100
 blackbox_exporter_port: 9115

server_configs:
 tidb:
   log.slow-threshold: 300
 tikv:
   readpool.storage.use-unified-pool: false
   readpool.coprocessor.use-unified-pool: true
 pd:
   replication.enable-placement-rules: true
   replication.location-labels: ["host"]
 tiflash:
   logger.level: "info"

pd_servers:
 - host: 10.0.1.1

tidb_servers:
 - host: 10.0.1.1

tikv_servers:
 - host: 10.0.1.1
   port: 20160
   status_port: 20180
   config:
     server.labels: { host: "logic-host-1" }

 - host: 10.0.1.1
   port: 20161
   status_port: 20181
   config:
     server.labels: { host: "logic-host-2" }

 - host: 10.0.1.1
   port: 20162
   status_port: 20182
   config:
     server.labels: { host: "logic-host-3" }

tiflash_servers:
 - host: 10.0.1.1

monitoring_servers:
 - host: 10.0.1.1

grafana_servers:
 - host: 10.0.1.1

 ```

 6. Execute the cluster deployment commannd:

 ```
 tiup cluster deploy <cluster-name> <tidb-version> ./topo.yaml --user root
<cluster-name>: Set the cluster name

<tidb-version>: Set the TiDB cluster version. You can see all the supported TiDB versions by running the tiup list tidb command

```

I use SSH key, so skip the password part

7. Access to cluster ( required mysql client installed):

Create new file `.my.cnf`
```
[client]
host=127.0.0.1
user=root
port=4000
password=it_showed_after_bootstrap_cluster_or_init_xDD
```

After that you can access to TiDB console simply by type `mysql`

- To view the currently deployed cluster list:
```
tiup cluster list
```
- To view the cluster topology and status:
```
tiup cluster display <cluster-name>
```