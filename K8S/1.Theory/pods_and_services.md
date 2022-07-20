-- Resource from here: https://www.youtube.com/watch?v=wHQRJZL0FnI

### 1. Pod
- Smallest unit of K8s
- Abstraction over container
- Usually 1 application per Pod
- Each Pod gets its own IP address
- New IP address on re-creation ( that is why we have to use service )

### 2. Service
- permanent IP address




Good explain xD ( from youtube ):

![image](https://user-images.githubusercontent.com/3434274/133860070-015ac18f-9810-4d59-b178-c322f73d3ced.png)


Container <-> Pod <-> My App <-> Service <-> Ingress <-> External
