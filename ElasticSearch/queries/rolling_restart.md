## Rolling Restart

# Step 1: Disable Shard Allocation:
```
PUT _cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.enable": "none"
  }
}
```

# Step 2: Restart single node
```
service elasticsearch restart
```

# Step 3: Check if node joined
```
GET _cat/nodes
```

# Step 4: Reenable shard allocation
```
PUT _cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.enable": "all"
  }
}
```

# Step 5: Wait till cluster green
```
GET _cluster/health
```

# Step 6: Repeat from step 1
