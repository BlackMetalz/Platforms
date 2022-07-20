### Source: https://ignite.apache.org/docs/latest/tools/control-script

- Get cluster state:
```
control.sh --state
```
- Deactive cluster:
```
control.sh --set-state INACTIVE
```

- Getting Nodes Registered in Baseline Topology
```
control.sh --baseline
```

- Monitoring Cache State
```
# Displays a list of all caches
control.sh|bat --cache list .

# Displays a list of caches whose names start with "account-".
control.sh|bat --cache list account-.*

# Displays info about cache group distribution for all caches.
control.sh|bat --cache list . --groups

# Displays info about cache group distribution for the caches whose names start with "account-".
control.sh|bat --cache list account-.* --groups

# Displays info about all atomic sequences.
control.sh|bat --cache list . --seq

# Displays info about the atomic sequnces whose names start with "counter-".
control.sh|bat --cache list counter-.* --seq
```

- Verifying Partition Checksums
```
# Checks partitions of all caches that their partitions actually contain same data.
control.sh|bat --cache idle_verify

# Checks partitions of specific caches that their partitions actually contain same data.
control.sh|bat --cache idle_verify cache1,cache2,cache3
```


