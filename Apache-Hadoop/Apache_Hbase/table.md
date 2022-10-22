### REF: https://sparkbyexamples.com/hbase/hbase-shell-commands-cheat-sheet/

# Show info of hbase table:
```
describe 'hbase_tblname'
```

# Drop table in hbase, have to disable table first
```
Start disable of named table:
hbase> disable 't1'
hbase> disable 'ns1:t1'
```

```
Drop the named table. Table must first be disabled:

hbase> drop 't1'
hbase> drop 'ns1:t1'

```


# For alter table with replicated cluster by @hoangdh:
```
- Disable replicate table
- Alter table on both cluster
- Enable replicate table
- Run major compaction this table
```
