-- Query with filter:
```
lq "GET services\nColumns: host_name description state plugin_output\nFilter: description ~~ Bonding Interface"  > bonding.csv
```

Output demo:
```
host1-48-28;Bonding Interface bond0;0
host2-48-29;Bonding Interface bond0;0
```

Usage: This is used for get report and write to csv for handle later
