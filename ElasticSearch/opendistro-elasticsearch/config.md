### elasticsearch.yml

- This is an example with 3 nodes: 

Node 1:
```
cluster.name: odfe-test
node.name: "node-4854"
node.master: true
node.data: true
node.ingest: true
path.data: /data/odfe/data
path.logs: /data/odfe/log
bootstrap.memory_lock: false
network.host: 10.3.48.54
http.port: 9200
discovery.seed_hosts: ["10.3.48.54", "10.3.48.56", "10.3.48.82"]
cluster.initial_master_nodes: ["node-4854"]
discovery.zen.minimum_master_nodes: 1

######## Start OpenDistro for Elasticsearch Security Demo Configuration ########
# WARNING: revise all the lines below before you go into production
opendistro_security.ssl.transport.pemcert_filepath: esnode.pem
opendistro_security.ssl.transport.pemkey_filepath: esnode-key.pem
opendistro_security.ssl.transport.pemtrustedcas_filepath: root-ca.pem
opendistro_security.ssl.transport.enforce_hostname_verification: false
opendistro_security.ssl.http.enabled: true
opendistro_security.ssl.http.pemcert_filepath: esnode.pem
opendistro_security.ssl.http.pemkey_filepath: esnode-key.pem
opendistro_security.ssl.http.pemtrustedcas_filepath: root-ca.pem
opendistro_security.allow_unsafe_democertificates: true
opendistro_security.allow_default_init_securityindex: true
opendistro_security.authcz.admin_dn:
  - CN=kirk,OU=client,O=client,L=test, C=de

opendistro_security.audit.type: internal_elasticsearch
opendistro_security.enable_snapshot_restore_privilege: true
opendistro_security.check_snapshot_restore_write_privileges: true
opendistro_security.restapi.roles_enabled: ["all_access", "security_rest_api_access"]
cluster.routing.allocation.disk.threshold_enabled: false
node.max_local_storage_nodes: 3######## End OpenDistro for Elasticsearch Security Demo Configuration ########
```


Node 2:
```
cluster.name: odfe-test
node.name: "node-4856"
node.master: false
node.data: true
node.ingest: true
path.data: /data/odfe/data
path.logs: /data/odfe/log
bootstrap.memory_lock: false
network.host: 10.3.48.56
http.port: 9200
discovery.seed_hosts: ["10.3.48.54", "10.3.48.56", "10.3.48.82"]
#cluster.initial_master_nodes: ["node-4854","node-4856","node-4882"]
#discovery.zen.minimum_master_nodes: 1

######## Start OpenDistro for Elasticsearch Security Demo Configuration ########
# WARNING: revise all the lines below before you go into production
opendistro_security.ssl.transport.pemcert_filepath: esnode.pem
opendistro_security.ssl.transport.pemkey_filepath: esnode-key.pem
opendistro_security.ssl.transport.pemtrustedcas_filepath: root-ca.pem
opendistro_security.ssl.transport.enforce_hostname_verification: false
opendistro_security.ssl.http.enabled: true
opendistro_security.ssl.http.pemcert_filepath: esnode.pem
opendistro_security.ssl.http.pemkey_filepath: esnode-key.pem
opendistro_security.ssl.http.pemtrustedcas_filepath: root-ca.pem
opendistro_security.allow_unsafe_democertificates: true
opendistro_security.allow_default_init_securityindex: true
opendistro_security.authcz.admin_dn:
  - CN=kirk,OU=client,O=client,L=test, C=de

opendistro_security.audit.type: internal_elasticsearch
opendistro_security.enable_snapshot_restore_privilege: true
opendistro_security.check_snapshot_restore_write_privileges: true
opendistro_security.restapi.roles_enabled: ["all_access", "security_rest_api_access"]
cluster.routing.allocation.disk.threshold_enabled: false
node.max_local_storage_nodes: 3
```

Node 3:
```
cluster.name: odfe-test
node.name: "node-4882"
node.master: false
node.data: true
node.ingest: true
path.data: /data/odfe/data
path.logs: /data/odfe/log
bootstrap.memory_lock: false
network.host: 10.3.48.82
http.port: 9200
discovery.seed_hosts: ["10.3.48.54", "10.3.48.56", "10.3.48.82"]
#cluster.initial_master_nodes: ["node-4854","node-4856","node-4882"]
#discovery.zen.minimum_master_nodes: 3

######## Start OpenDistro for Elasticsearch Security Demo Configuration ########
# WARNING: revise all the lines below before you go into production
opendistro_security.ssl.transport.pemcert_filepath: esnode.pem
opendistro_security.ssl.transport.pemkey_filepath: esnode-key.pem
opendistro_security.ssl.transport.pemtrustedcas_filepath: root-ca.pem
opendistro_security.ssl.transport.enforce_hostname_verification: false
opendistro_security.ssl.http.enabled: true
opendistro_security.ssl.http.pemcert_filepath: esnode.pem
opendistro_security.ssl.http.pemkey_filepath: esnode-key.pem
opendistro_security.ssl.http.pemtrustedcas_filepath: root-ca.pem
opendistro_security.allow_unsafe_democertificates: true
opendistro_security.allow_default_init_securityindex: true
opendistro_security.authcz.admin_dn:
  - CN=kirk,OU=client,O=client,L=test, C=de

opendistro_security.audit.type: internal_elasticsearch
opendistro_security.enable_snapshot_restore_privilege: true
opendistro_security.check_snapshot_restore_write_privileges: true
opendistro_security.restapi.roles_enabled: ["all_access", "security_rest_api_access"]
cluster.routing.allocation.disk.threshold_enabled: false
node.max_local_storage_nodes: 3
######## End OpenDistro for Elasticsearch Security Demo Configuration ########
```

Remember to empty data folder before it's start
