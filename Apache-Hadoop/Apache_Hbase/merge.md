### Merge region have no data 

Example Table: 'wtf:abc_xyz' 10 Regions, 2 regions (region_name_1, region_name_2) doesn't have any data:

start merge by command:
```
merge_region 'region_name_1','region_name_2'
```

After that, merge region_name_new to region_name_3. Done, do major compaction. Do it asap if table is small, if table is big, do it at the night:

```
major_compact 'wtf:abc_xyz'
```