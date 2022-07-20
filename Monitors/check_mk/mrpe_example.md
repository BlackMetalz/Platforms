-- MRPE example for aerospike monitor plugin
```
as_ml_48.31_p3000::cluster_size (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.31 -p 3000 -s cluster_size -w 6:6 -c 6:6
as_ml_48.35_p3000::cluster_size (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.35 -p 3000 -s cluster_size -w 6:6 -c 6:6
as_ml_48.31_p3000::total_objects (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.31 -p 3000 -s objects -w 0 -c 0
as_ml_48.35_p3000::total_objects (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.35 -p 3000 -s objects -w 0 -c 0
as_ml_48.31_p3000::memory_free (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.31 -p 3000 -s memory_free_pct -n mem_storage -w @25 -c @20
as_ml_48.35_p3000::memory_free (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.35 -p 3000 -s memory_free_pct -n mem_storage -w @25 -c @20
as_ml_48.31_p3000::disk_free (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.31 -p 3000 -s device_free_pct -n mem_storage -w @25 -c @20
as_ml_48.35_p3000::disk_free (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.35 -p 3000 -s device_free_pct -n mem_storage -w @25 -c @20
as_ml_48.31_p3000::memory_free (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.31 -p 3000 -s memory_free_pct -n ssd_storage -w @25 -c @20
as_ml_48.35_p3000::memory_free (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.35 -p 3000 -s memory_free_pct -n ssd_storage -w @25 -c @20
as_ml_48.31_p3000::disk_free (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.31 -p 3000 -s device_free_pct -n ssd_storage -w @25 -c @20
as_ml_48.35_p3000::disk_free (interval=120) /usr/bin/aerospike_nagios.py -h 123.456.48.35 -p 3000 -s device_free_pct -n ssd_storage -w @25 -c @20

```

Source: https://github.com/aerospike/aerospike-nagios
