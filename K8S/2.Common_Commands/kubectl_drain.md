- Usage: this command used for graceful maintain k8s node.

1. Evict pod / cordon node

```
kubectl drain --ignore-daemonsets 10.5.5.5
```

2. After maintain complete. Un-cordon node
```
kubectl uncordon 10.5.5.5
```
