### - Check following thing before deploy in k8s cluster:
+ network plugin: calico-node-agent ( in Pods )
+ coredns: in pods
+ kube-proxy: check in docker ( it is daemonset )
+ etcd: in container
+ time: check time in 3 master sync or not
