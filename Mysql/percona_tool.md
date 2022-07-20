-  Add Column: 

```--dry-run``` : for test
```--execute``` : for real

```
pt-online-schema-change --alter="add column your_column_name bigint(20)" D=ur_db_name,t=ur_tbl_name  --dry-run
```

- Add indexes:

```
pt-online-schema-change --alter="add index idx_user_group_version (user_id,group_id,version_crc)" D=db_name,t=table_name  --dry-run
```

- Alter column
```
pt-online-schema-change --alter="modify your_column_name bigint(20) default 1" D=ur_db_name,t=ur_tbl_name  --dry-run
```

- Drop column
```
pt-online-schema-change --alter="drop column question_crc" D=wtf,t=tbl --dry-run
```

- Rename primary key
```
pt-online-schema-change --alter="change id question_id int(11) NOT NULL AUTO_INCREMENT" D=test,t=wtf_tbl --execute --no-check-alter
```

- by pass max threads running
```
pt-online-schema-change --alter="add column device_id varchar(200) default '-1'" --max-load Threads_running=50 D=xxx,t=yyy --execute
```

if error appear:
```
2020-07-03T22:53:12 Error copying rows from `xxx`.`yyy` to `xxx`.`_yyy`: Threads_running=51 exceeds its critical threshold 50
```
Increase it to higher value like 70 xD

or use this option instead of max-load
```
--critical-load Threads_running=100
```
