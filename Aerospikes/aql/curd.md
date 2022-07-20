-- Insert a Record
```
INSERT INTO <ns>[.<set>] (PK, <bins>) VALUES (<key>, <values>)
```

```
aql> INSERT INTO test.cats(PK, name, age) VALUES (100, 'Chester', 4)
OK, 1 record affected.
```
-- Select records
```
aql> SELECT * FROM test.cats WHERE PK = 100
+-----------+-----+
| name      | age |
+-----------+-----+
| "Chester" | 4   |
+-----------+-----+
1 row in set (0.002 secs)
```

 more example
 ```
 aql> INSERT INTO test.cats(PK, name, age) VALUES (100, 'Sir Chester', 5)
OK, 1 record affected.

aql> 
aql> SELECT * FROM test.cats WHERE PK = 100
+---------------+-----+
| name          | age |
+---------------+-----+
| "Sir Chester" | 5   |
+---------------+-----+
1 row in set (0.000 secs)
```

-- Delete a Record
```
DELETE FROM <ns>[.<set>] WHERE PK=<key>
```

```
aql> DELETE FROM test.cats WHERE PK = 100
OK, 1 record affected.

aql> 
aql> 

aql> 
aql> SELECT * FROM test.cats WHERE PK = 100
Error: (2) AEROSPIKE_ERR_RECORD_NOT_FOUND

```


