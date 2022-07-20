### Example and explain for basic nginx deployment file:
#### Ref:
- https://www.mirantis.com/blog/multi-container-pods-and-container-communication-in-kubernetes/


#### Note: k8s knows when to create or update deployment


```
apiVersion: apps/v1
kind: Deployment  # I want to create deployment so type `Deployment` is going to use here!
metadata: 
  labels: 
    app: nginx
  name: nginx-deployment  # Name of the deployment
spec:  # Spec for deployment
 replicas: 3  # How many replicas of the pods i want to create
 selector: 
   matchLabels:
     app: nginx
 template: 
   metadata: 
     labels:
       app: nginx
   spec: # Spec for pods
     containers:  # one conta
       - image: "nginx:1.7.9" # Image section
         name: nginx
         ports:
         - containerPort: 80 # We are gonna bind that on port 80

```


- Example for multiple container inside a pod:
``
apiVersion: v1
kind: Pod
metadata:
  name: mc1
spec:
  volumes:
  - name: html
    emptyDir: {}
  containers:
  - name: 1st
    image: nginx
    volumeMounts:
    - name: html
      mountPath: /usr/share/nginx/html
  - name: 2nd
    image: debian
    volumeMounts:
    - name: html
      mountPath: /html
    command: ["/bin/sh", "-c"]
    args:
      - while true; do
          date >> /html/index.html;
          sleep 1;
        done
```
