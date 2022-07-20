### Ref:
- https://www.containiq.com/post/using-kubectl-to-restart-a-kubernetes-pod

- Delete pod: 
```
kubectl delete pod busybox-pod
```
Output example: `pod "busybox-pod" deleted`


- Get all pod from specific namespace:
```
root@k8s-stagging-1-61:~# kubectl get pods -n kienlt
NAME                           READY   STATUS             RESTARTS   AGE
nginx-deploy-d4789f999-wbkgk   0/1     ErrImagePull   0          14s
```

- See that error before, what is the reason for error? Go for describe:
```
kubectl describe pod nginx-deploy-d4789f999-wbkgk -n kienlt
```

output example:
![image](https://user-images.githubusercontent.com/3434274/167244179-b7ae85b7-4b55-4615-8ab0-0c80ccf655b6.png)

So for this error, simply login to docker hub and restart container port using following method:
Method 1: kubectl scale
```
kubectl scale deployment shop --replicas=0 -n service
```

Method 2: kubectl rollout restart
```
kubectl rollout restart deployment <deployment_name> -n <namespace>
```

Method 3: kubectl delete pod
```
kubectl delete replicaset <name> -n <namespace>
```

Method 4: kubectl get pod
```
kubectl get pod <pod_name> -n <namespace> -o yaml | kubectl replace --force -f -
```
