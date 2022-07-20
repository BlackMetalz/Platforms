# Ref: https://opendistro.github.io/for-elasticsearch-docs/docs/troubleshoot/security-admin/

-- Some how your cluster is fucked by you and become in red status:
```
cd /usr/share/elasticsearch/plugins/opendistro_security/tools/ && bash securityadmin.sh -cd ../securityconfig -nhnv -cacert /etc/elasticsearch/root-ca.pem -cert /etc/elasticsearch/kirk.pem -key /etc/elasticsearch/kirk-key.pem -icl --accept-red-cluster
```

# Source: https://discuss.opendistrocommunity.dev/t/users-gone-after-using-securityadmin-sh/1781/4

```
Question: So i will lose configuration from kibana when i use securityadmin.sh?

Answer: No, if you only load the config.yml instead of the entire /securityconfig/ dir you will retain your configured Kibana roles
```

``` 
Question: Can i export the settings i did to the .yml files?

Answer: 
https://opendistro.github.io/for-elasticsearch-docs/docs/security/configuration/security-admin/#backup-restore-and-migrate
```

- Here is the script I use when I reboot my cluster that does not erase any of the users and roles
```
./securityadmin.sh -h YOUR-HOST -cn YOUR-CLUSTER-NAME -f ../securityconfig/config.yml -nhnv -cacert ../../../config/root-ca.pem -cert ../../../config/admin.pem -key ../../../config/admin-key.pem
```


## What i learned
- Change admin password by run only internal_users.yml file ( ofc, have to change hash pass in there xD )
```
./securityadmin.sh -h HOST_IP -cn CLUSTER_NAME -f ../securityconfig/internal_users.yml -nhnv -cacert /etc/elasticsearch/root-ca.pem -cert /etc/elasticsearch/kirk.pem -key /etc/elasticsearch/kirk-key.pem
```

- Export setting in cluster:
```
./securityadmin.sh -backup /root/odfe/ -h HOST_IP -icl -nhnv -cacert /etc/elasticsearch/root-ca.pem -cert /etc/elasticsearch/kirk.pem -key /etc/elasticsearch/kirk-key.pem
```

## Restore snapshot include security
```
But if you do need to restore the security index, you would need to do so with a curl command that includes the admin cert as per below:

curl -XPOST "https://localhost:9200/_snapshot/my_repo/snapshot_1/_restore" --key "/usr/share/elasticsearch/config/kirk-key.pem" --cert "/usr/share/elasticsearch/config/kirk.pem" --cacert "/usr/share/elasticsearch/config/root-ca.pem"
```
Source: https://discuss.opendistrocommunity.dev/t/restore-snapshot-from-s3-different-cluster-s-snapshot/6521/6?u=blackmetalz


## Block account after failed attemp:
-- Source: https://discuss.opendistrocommunity.dev/t/locking-accounts-after-failed-attempts/6867
```
auth_failure_listeners:
      ip_rate_limiting:
        type: ip
        allowed_tries: 3
        time_window_seconds: 3600
        block_expiry_seconds: 600
        max_blocked_clients: 100000
        max_tracked_clients: 100000
      internal_authentication_backend_limiting:
        type: username
        authentication_backend: internal        
        allowed_tries: 3
        time_window_seconds: 3600
        block_expiry_seconds: 600
        max_blocked_clients: 100000
        max_tracked_clients: 100000
```

