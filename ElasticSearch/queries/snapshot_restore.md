# Start backup
1. Add path.repo to elasearch.yml
```
path.repo: ["/mnt/snapshots"]
```
After that have to restart cluster. I'm using lizardfs in for shared file system in this case.

2. Register repo
```
PUT _snapshot/my-fs-repository
{
  "type": "fs",
  "settings": {
    "location": "/mnt/snapshots"
  }
}
```

3. Check register
```
GET /_snapshot/_all
```

4. Create snapshot:

```
PUT _snapshot/backup/snapshot_20201006?wait_for_completion=true&pretty
```
Advance: Remove some index and include some index when create snapshot
```
PUT _snapshot/backup/notify-cmt_snapshot_4?wait_for_completion=true&pretty
{
  "indices": "-security-auditlog*,-.opendistro*,-.kibana*,lala*,fafa*,live*",
  "ignore_unavailable": true,
  "include_global_state": false
}
```

- Check status: 
```
GET _snapshot/_status
```

# Restore step:
- See all snapshot available:
```
GET _snapshot/backup/*
```
- Delete index for testing purpose: 
```
DELETE index_name
```

- Then restore: Have to exclude opendistro_security and kibana. You can create snapshot for specific indices.
```
POST _snapshot/backup/snapshot_20201006/_restore 
{
  "indices": "-.opendistro_security,-.kibana",
  "include_global_state": false
}
```
2. Restore with different index name
Note: cannot restore index [yolo77] with [4] shards from a snapshot of index [wtf_200k_larger_shard] with [2] shards
```
POST yolo2/_close

POST _snapshot/backup/snapshot_20201221/_restore?wait_for_completion=false
{
  "indices": "wtf_200k_larger_shard",
  "ignore_unavailable": true,
  "include_global_state": false,        
  "include_aliases": false,
  "rename_pattern": "wtf_200k_larger_shard", 
  "rename_replacement": "yolo2"
}
```
3. Single index restore:
```
POST /_snapshot/backup/snapshot_20201222-040001/_restore
{
  "indices": "indexname",
  "ignore_unavailable": true,
  "include_global_state": false
}
```
4. Delete snapshot:
```
DELETE /_snapshot/my_repository/my_snapshot
```
5. Stop restore process: Simple delete index is going to restore
