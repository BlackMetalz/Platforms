- Create nginx deployment with the latest nginx:
```
kubectl create deployment nginx-deployment --image=nginx
```

- Also you can create deployment to specific namespace ( example is namespace: `kienlt` )
```
kubectl create deployment nginx-deployment --image=nginx -n kienlt
```

- Edit deployment without manifest file:
```
kubectl edit deployment nginx-deploy -n kienlt
```

Output demo: 
```
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2022-05-07T07:52:59Z"
  generation: 1
  labels:
    app: nginx-deploy
  name: nginx-deploy
  namespace: kienlt
  resourceVersion: "138424256"
  selfLink: /apis/apps/v1/namespaces/kienlt/deployments/nginx-deploy
  uid: a66e0de4-dbcb-4eef-9b6a-e2b19e98fcfe
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx-deploy
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-deploy
    spec:
      containers:
      - image: nginx-img-url-xDD
        imagePullPolicy: Always
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2022-05-07T07:53:04Z"
    lastUpdateTime: "2022-05-07T07:53:04Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2022-05-07T07:52:59Z"
    lastUpdateTime: "2022-05-07T07:53:04Z"
    message: ReplicaSet "nginx-deploy-674546dc8b" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1
```
