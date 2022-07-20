### Ref:
- https://www.simplilearn.com/tutorials/kubernetes-tutorial/kubernetes-interview-questions
- https://www.edureka.co/blog/interview-questions/kubernetes-interview-questions/

1. What need to do when pod crash / loop back?
Answer: 
- Check CPU / RAM Usage:
+ For Ram, if you did limit memory and your pod use more than memory limit, k8s will force kill your pod with out of memory event
+ For CPU, there is something called health check, if you use CPU more than you provided for your pod, health check will not response, hence leading to kill
pod duo health check problem!
- Check log of pod ( you can check from any node if that node can run kubectl )
- Check describe of pod


2. What need to do when node un-available?
Answer: kubectl describe node
