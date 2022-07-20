- Enable table replication:
```
enable_table_replication 'tbl_name'
```

- Disable table replication:
```
disable_table_replication 'tbl_name'
```


For change column family, please disable table replication first, start alter table in both main and replicated cluster, after done Enable table replication
