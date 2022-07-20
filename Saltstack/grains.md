- List all items of grains in salt minion:
```
salt minion-id grains.items
```

- Then get information for that items. Example ip4_interfaces
```
salt minion-id grains.get ip4_interfaces
```
Demo output:
```
    ----------
    docker0:
        - 172.17.0.1
    enp2s0f0:
        - 192.168.23.29
    enp2s0f1:
    flannel.1:
        - 10.233.91.0
    lo:
        - 127.0.0.1

```
