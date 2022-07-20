- View log of container inside pod
```
kubectl logs nginx-pod
```

- View log of specific container inside pod has multiple container
```
kubectl logs nginx-pod -c nginx-container
```

- Also you can use tail with kubectl log
```
kubectl logs -f nginx-pod
```

- Get log of last hour , get 10 record with timestamp
```
kubectl logs --since=1h --tail=10 --timestamps=true nginx-pod
```
