## Source: https://www.aerospike.com/docs/reference/configuration/

-- Get detail information about specific namespace:
```
asinfo -v 'namespace/your_namespace' -l
```

-- Get detail for specific set:
```
asinfo -p 3000 -h 192.168.1.111 -v 'sets' | grep set_name
```

-- Increase memory-size of namespace instant

```
asinfo -h 192.168.1.100 -p 5000 -v 'set-config:context=namespace;id=wtf_ns;memory-size=32G'
```
-- Change high water mark disk pct
```
asinfo -p 7000 -h 172.26.49.72 -v "set-config:context=namespace;id=ssd_storage;high-water-disk-pct=60"
```

-- Change batch-max-requests
```
asinfo -v "set-config:context=service;batch-max-requests=6000"
```

after done, change in config file too in case of aerospike restart. Config won't be reverted!

-- Truncate set from namespace

```
root@kienlt-lab-48:~# asinfo -v 'truncate:namespace=ns_aes_test;set=user_info;'
ok
```

Before truncate

```
aql> select * from ns_aes_test.testset
+-------+-----+
| a     | b   |
+-------+-----+
| "abc" | 140 |
| "abc" | 129 |
+-------+-----+
```

After truncate:
```
aql> select * from ns_aes_test.user_info
0 rows in set (0.099 secs)

OK
```

-- Truncate Namespace
```
asinfo -v "truncate-namespace:namespace=ns_aes_test"
ok
```

-- Change default ttl
```
	asinfo -v "set-config:context=namespace;id=ip2location;default-ttl=0" -h 10.3.51.160 -p 8000
  ```

