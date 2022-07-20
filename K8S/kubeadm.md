### 1. Basic
```
kubeadm init // Run in master
kubeadm join // Run in worker
kubeadm token // create|delete|list|generate
kubeadm version //Show version of kubeadm
kubeadm upgrade // 
```

kubelet : primary node agent run on each worker

- Install ref : https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
- Config:
```
# Setup required sysctl params, these persist across reboots.
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system # Apply...

```
- Docker config:
```
{
  "data-root": "/data/docker", 
  # "bip": "123.0.0.0/24", # You only need this in some special condition 
  "exec-opts": ["native.cgroupdriver=systemd"], # This is required, if not it will say error #1
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "3"
  }
}
```

### Errors
- #1 : kubelet fails with error "misconfiguration: kubelet cgroup driver: "cgroupfs" is different from docker cgroup driver: "systemd
















# Ref :
- https://kubernetes.io/docs/setup/production-environment/container-runtimes/
- - 
