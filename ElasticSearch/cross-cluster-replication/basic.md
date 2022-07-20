# I just complete setup cross cluster via this handbook: https://github.com/opendistro-for-elasticsearch/cross-cluster-replication/blob/main/HANDBOOK.md
# Read More:
- https://discuss.opendistrocommunity.dev/t/unable-to-start-cross-cluster-replication/5863/2
- https://discuss.opendistrocommunity.dev/t/error-cant-start-cross-cluster-replication/6450/7


Add setting to all node ( elasticsearch.yml ):
```
opendistro_security.unsupported.inject_user.enabled: true
opendistro_security.nodes_dn_dynamic_config_enabled: true
node.remote_cluster_client: true
```

In this part, mostly master.
In this time it still has a lot of bug i mentioned in: https://discuss.opendistrocommunity.dev/t/error-cant-start-cross-cluster-replication/6450/7


Timeline:
## July - 15 - 2021:
replicate cluster unable to receive new data after start replication
