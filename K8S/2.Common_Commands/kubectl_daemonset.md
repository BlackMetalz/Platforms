### Ref: https://www.bluematador.com/learn/kubectl-cheatsheet

- Get all Daemonset from all Namespace

```
kubectl get daemonset -A
kubectl get ds -A # Shorter
```

- Edit and update the definition of one or more daemonset
```
kubectl edit daemonset <daemonset_name> -n namespace_of_daemonset
```

- Delete a daemonset
```
kubectl delete daemonset <daemonset_name> -n namespace_of_daemonset
```

- Create a new daemonset
```
kubectl create daemonset <daemonset_name>
```

- Manage the rollout of a daemonset
```
kubectl rollout daemonset
```

- Display the detailed state of daemonsets within a namespace
```
kubectl describe daemonset <daemonset_name> -n namespace_of_daemonset
```

