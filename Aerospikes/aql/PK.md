PK is an internal designation used by AQL for the user specified primary key. For example, in AQL if 
you insert a record as follows: (Default KEY_SEND is false)

aql> INSERT INTO test.demo (PK, foo, bar) VALUES ('key1', 123, 'abc')
OK, 1 record affected.
aql> select * from test.demo
+-----+-------+
| foo | bar   |
+-----+-------+
| 123 | "abc" |
+-----+-------+
1 row in set (0.588 secs)


https://discuss.aerospike.com/t/aql-select-with-pk/3314/4
