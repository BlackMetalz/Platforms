- Create table with Key range: 000 -> 999
```
create 'hbase_tbl_dev', 'cf', {SPLITS => ['050','100','150','200','250','300','350','400','450','500','550','600','650','700','750','800','850','900','950']}
alter 'hbase_tbl_dev', { NAME => 'cf', COMPRESSION => 'SNAPPY' }
alter 'hbase_tbl_dev', {METADATA => {'SPLIT_POLICY' => 'org.apache.hadoop.hbase.regionserver.DisabledRegionSplitPolicy'}}
```

Explain: split those key range to 20 regions
1000 / 20 = 50, so 50 each jump
Bash command for calculate
```
for x in {1..20}; do echo $(( 50 * $x )); done | while read l; do echo -n "$l, "; done
```

Output:
```
50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000
```

Remove last one and we get 
```
{SPLITS => ['050','100','150','200','250','300','350','400','450','500','550','600','650','700','750','800','850','900','950']}
```


- Table with TTL: ttl is in second
```
alter 'hbase_tbl_dev', { NAME => 'cf', COMPRESSION => 'SNAPPY', TTL => '2592000'}
```

- Alter column families:
```
alter 'namespace:hbase_tbl_name', { NAME => 'cf', BLOOMFILTER => 'ROWCOL', TTL => 'FOREVER'}
alter 'namespace:hbase_tbl_name', { NAME => 'cf1', BLOOMFILTER => 'ROWCOL', TTL => 'FOREVER'}

```

Bloomfilter: https://www.linkedin.com/pulse/bloom-filters-hbase-kuldeep-deshpande/
