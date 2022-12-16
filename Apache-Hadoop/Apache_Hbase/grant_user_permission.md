#### Grant permission to user
```
For example:

    hbase> grant 'bobsmith', 'RWXCA'
    hbase> grant '@admins', 'RWXCA'
    hbase> grant 'bobsmith', 'RWXCA', '@ns1'
    hbase> grant 'bobsmith', 'RW', 't1', 'f1', 'col1'
    hbase> grant 'bobsmith', 'RW', 'ns1:t1', 'f1', 'col1'
```


#### Check permission of user via table:
```
user_permission # or
user_permission 'namespace:table_name'
```
 
### Other way, Ref: https://community.cloudera.com/t5/Support-Questions/How-to-check-user-permissions-in-HBase/td-p/192905

```
hbase> user_permission
hbase> user_permission '@ns1'
hbase> user_permission '.*' # This is show all user with permission
hbase> user_permission '@^[a-c].*'
hbase> user_permission 'table1'
hbase> user_permission 'namespace1:table1'
hbase> user_permission '.*'
hbase> user_permission '^[A-C].*'
```
