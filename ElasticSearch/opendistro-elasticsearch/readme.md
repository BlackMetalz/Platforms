# Some notes
Change password default: https://aws.amazon.com/blogs/opensource/change-passwords-open-distro-for-elasticsearch/

- Gen hashed pass: 
```
sh /usr/share/elasticsearch/plugins/opendistro_security/tools/hash.sh -p 8qhlASrXHsR4bk73dzjH
```

- Active Security for first time, in 1 master node
```
cd /usr/share/elasticsearch/plugins/opendistro_security/tools/ && bash securityadmin.sh -cd ../securityconfig -icl -nhnv -cacert /etc/elasticsearch/root-ca.pem -cert /etc/elasticsearch/kirk.pem -key /etc/elasticsearch/kirk-key.pem 
```

- Security debug in case of cluster is red 
```
	Contacting elasticsearch cluster 'elasticsearch' and wait for YELLOW clusterstate ...
ERR: Timed out while waiting for a green or yellow cluster state.
   * Try running securityadmin.sh with -icl (but no -cl) and -nhnv (If that works you need to check your clustername as well as hostnames in your TLS certificates)
   * Make also sure that your keystore or PEM certificate is a client certificate (not a node certificate) and configured properly in elasticsearch.yml
   * If this is not working, try running securityadmin.sh with --diagnose and see diagnose trace log file)
   * Add --accept-red-cluster to allow securityadmin to operate on a red cluster.
   ```
Diagnose
```
bash securityadmin.sh -cd ../securityconfig -icl -nhnv -cacert /etc/elasticsearch/root-ca.pem -cert /etc/elasticsearch/kirk.pem -key /etc/elasticsearch/kirk-key.pem  --diagnose
```
