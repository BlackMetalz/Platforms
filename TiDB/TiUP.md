### Source: https://docs.pingcap.com/tidb/stable/production-deployment-using-tiup


1. Install TiUP and config
```
curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
```

- Install the TiUP cluster component:
```
tiup cluster
```
- If TiUP is already installed, update the TiUP cluster component to the latest version
```
tiup update --self && tiup update cluster
```

- If “Update successfully!” is displayed, the TiUP cluster is updated successfully.

- Verify the current version of your TiUP cluster
```
tiup --binary cluster
```

2. Initialize cluster topology file
```
tiup cluster template > topology.yaml
```

