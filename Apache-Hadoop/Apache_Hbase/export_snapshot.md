### Ref:
- https://stackoverflow.com/questions/16649940/how-can-i-export-hbase-table-using-starttime-endtime


- Create snapshot command:
```
snapshot 'hbase_table_name','hbase_table_snapshot_name'
```

- Export Command: require run in node have yarn / mapreduce

```
hbase org.apache.hadoop.hbase.snapshot.ExportSnapshot -snapshot hbase_table_snapshot_name -copy-to hdfs://10.0.0.1:8020//apps/hbase/data -mappers 16 -copy-from hdfs://10.0.0.2:8020//apps/hbase/data
```

- List Snapshot:
```
list_snapshots
```

- Restore Command:
```
restore_snapshot 'hbase_table_snapshot_name'
```

- Export with start time and end time
```
hbase org.apache.hadoop.hbase.mapreduce.Export <tablename> <outputdir> [<versions> [<starttime> [<endtime>]]]
```

- Delete single snapshot:
```
delete_snapshot 'snapshotName'
```

- Delete all snapshot with pattern:
```
delete_all_snapshot 'table-pattern.*'
```
