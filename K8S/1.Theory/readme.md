## Source && reference:
- https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/explore-intro/
- https://github.com/thangtq710/Kubernetes
- https://stackoverflow.com/questions/53888389/difference-between-daemonsets-and-deployments
- 
## no idea about title:
- K8S is the most popular container orchestration, docker is container runtime.
- It has 2 major component: master node and worker node.
- The important thing in k8s cluster is ETCD: it is DB storage for k8s cluster
- The common basic concept we need to know when working with in k8s is: pod, deployment, service. They are basic resource we need to learn for begin 

## Pod:
A Pod is a group of one or more application containers (such as Docker) and includes shared storage (volumes), IP address and information about how to run them. Containers of pod can run in same server only.

![image](https://user-images.githubusercontent.com/3434274/142842540-e15529f8-a83c-4ce8-8019-080d7ca8f98c.png)

### Deployment:
- When deploy service, we can use deployment or daemonset, but most common is deployment.
- More detail: Kubernetes deployments manage stateless services running on your cluster (as opposed to for example StatefulSets which manage stateful services). Their purpose is to keep a set of identical pods running and upgrade them in a controlled way. For example, you define how many replicas(pods) of your app you want to run in the deployment definition and kubernetes will make that many replicas of your application spread over nodes. If you say 5 replica's over 3 nodes, then some nodes will have more than one replica of your app running.

## DaemonSets:
- DaemonSets manage groups of replicated Pods. However, DaemonSets attempt to adhere to a one-Pod-per-node model, either across the entire cluster or a subset of nodes. A Daemonset will not run more than one replica per node. Another advantage of using a Daemonset is that, if you add a node to the cluster, then the Daemonset will automatically spawn a pod on that node, which a deployment will not do.
- DaemonSets are useful for deploying ongoing background tasks that you need to run on all or certain nodes, and which do not require user intervention. Examples of such tasks include storage daemons like ceph, log collection daemons like fluentd, and node monitoring daemons like collectd

Lets take the example you mentioned in your question: why is kube-dns a deployment and kube-proxy a daemonset?

The reason behind that is that kube-proxy is needed on every node in the cluster to run IP tables, so that every node can access every pod no matter on which node it resides. Hence, when we make kube-proxy a daemonset and another node is added to the cluster at a later time, kube-proxy is automatically spawned on that node.

Kube-dns responsibility is to discover a service IP using its name and only one replica of kube-dns is enough to resolve the service name to its IP. Hence we make kube-dns a deployment, because we don't need kube-dns on every node.




![image](https://user-images.githubusercontent.com/3434274/164888637-59d37cfc-5435-45c5-8eb3-9e344bad6025.png)

- When we declare deployment with replica set is 3. The component controller manager in master it will commands deploy 3 pods as replica is 3 and interact with worker via kubelet, after that kubelet will use to deploy pods, run pods in containers. For able to run it, it use container runtime, specific is Docker!. 

### Service: 
- Used to connect traffic betwen pods in k8s cluster or connect service/ application from outside to inside k8s cluster. 

![image](https://user-images.githubusercontent.com/3434274/164889073-2825c470-7fc7-41b3-bb51-d761efeb1db1.png)

- Default, when deploy some deployments it will create a service called Cluster IP ( it is default service in k8s, pods in there will interact with each other via service name of that cluster IP. Mainly use for internal interact!

![image](https://user-images.githubusercontent.com/3434274/164889028-114b124e-4b25-4758-837c-8e4f20540c06.png)

for picture above: It used to know as load balancer for pod, when traffic go in service 1 with label is nginx,then it will forward al traffic to pod that has label nginx. 

- Next is node port:
![image](https://user-images.githubusercontent.com/3434274/164889207-a272c20d-4e88-441f-b748-15e6eb78c58e.png)
It used to run when service from outside call / interact with pod inside k8s cluster. Specify of node port is we can call port 30001 in any node even that pod isn't running on that node. For achieved it, it will create a rule iptable, it will NAT and forward port 30001 to all node of that k8s cluster.


## Node:
![image](https://user-images.githubusercontent.com/3434274/142842596-a419ebe9-abfb-4749-b96c-e79ec470cf05.png)
