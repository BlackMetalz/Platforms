
# Backup
- Backup command, require astools installed

```
asbackup --host localhost --namespace ns_aes_test --directory /data/asbackup/ns_aes_test_today
```

- Best practice for backup:

```
asbackup -h 127.0.0.1 -p 3000 -n test -d backup_2015_08_24
```
- With gzip
```
asbackup -h  1.2.3.4 -p 3000 -n test -o - | gzip > asbackup/location/test_3000_$(date -I).asb.gz
```

# Restore
- Basic
```
asrestore --host localhost --directory ns_aes_test_today/ -n oldnamespace,newnamespace
```

- With single file

```
asrestore -h 127.0.0.1 -p 3000 -i backupfile.asb
```

- Increaase thread ( speed for restore )
```
-t <threads> or --threads <threads>     # 20 is the default
```
- Restore single Set
```
asrestore -p 3000 -d backup_folder -s yourset
```
- Restore set to another set ( same with namespace )
```
asrestore -p 3000 -d backup_folder -s oldset,newset
```

