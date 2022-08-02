# Source: https://developer.ibm.com/components/kafka/tutorials/kafka-authn-authz/

- Terminology: 
Kafka provides authentication and authorization using Kafka Access Control Lists (ACLs) and through several interfaces (command line, API, etc.) 
Each Kafka ACL is a statement in this format:

```
Principal P is [Allowed/Denied] Operation O From Host H On Resource R.
```

+ Principal is a Kafka user.
+ Operation is one of Read, Write, Create, Describe, Alter, Delete, DescribeConfigs, AlterConfigs, ClusterAction, IdempotentWrite, All.
+ Host is a network address (IP) from which a Kafka client connects to the broker.
+ Resource is one of these Kafka resources: Topic, Group, Cluster, TransactionalId. These can be matched using wildcards.

Not all operations apply to every resource. The current list of operations per resource are in the table below. All associations can be found in the:
https://kafka.apache.org/documentation/#operations_resources_and_protocols

![image](https://user-images.githubusercontent.com/3434274/125758322-d764e618-eae5-4406-adb8-ddbf0248d723.png)

- Background:
This article aims at demonstrating authentication and authorizations capabilities of Kafka. 
It is not a guide how to configure Kafka for production environments.

In particular, it does not cover encryption which is usually a requirement in secured environments. 
We’ll demonstrate how to perform authentication using the SASL_PLAINTEXT security protocol which transmits all data, 
including passwords, as plain text. SASL_SSL enables encrypting data over the wire and should be used for production use cases. 
All information included here also apply to environments using SASL_SSL.

- Flow:

![image](https://user-images.githubusercontent.com/3434274/125758660-d645d843-7137-45c5-a324-50cbc60f0552.png)
