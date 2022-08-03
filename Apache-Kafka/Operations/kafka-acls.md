### Source: https://docs.confluent.io/platform/current/kafka/authorization.html

#### - Show list permission: 
```
bin/kafka-acls.sh --authorizer-properties zookeeper.connect=10.3.48.54:2181 --list
```

Output:
```
Current ACLs for resource `ResourcePattern(resourceType=TOPIC, name=test, patternType=LITERAL)`:
        (principal=User:test1, host=bin, operation=ALL, permissionType=ALLOW)

Current ACLs for resource `ResourcePattern(resourceType=CLUSTER, name=kafka-cluster, patternType=LITERAL)`:
        (principal=User:*, host=10.3.48.54, operation=ALL, permissionType=ALLOW)
        (principal=User:*, host=10.3.48.56, operation=ALL, permissionType=ALLOW)
        (principal=User:*, host=10.3.48.82, operation=ALL, permissionType=ALLOW)

Current ACLs for resource `ResourcePattern(resourceType=TOPIC, name=*, patternType=LITERAL)`:
        (principal=User:*, host=10.3.48.54, operation=ALL, permissionType=ALLOW)
        (principal=User:*, host=10.3.48.56, operation=ALL, permissionType=ALLOW)
        (principal=User:*, host=10.3.48.82, operation=ALL, permissionType=ALLOW)

Current ACLs for resource `ResourcePattern(resourceType=GROUP, name=*, patternType=LITERAL)`:
        (principal=User:*, host=10.3.48.54, operation=ALL, permissionType=ALLOW)
        (principal=User:*, host=10.3.48.56, operation=ALL, permissionType=ALLOW)
        (principal=User:*, host=10.3.48.82, operation=ALL, permissionType=ALLOW)
```

User in host 10.3.48.54 / 10.3.48.56 / 10.3.48.82 has full permission

#### Command grant all permission for specific host
```
kafka-acls --authorizer-properties zookeeper.connect=10.3.48.54:2181,10.3.48.56:2181,10.3.48.82:2181 --operation All --allow-principal User:*   --allow-host 10.1.2.123  --cluster --topic '*' --group '*' --add

```

#### - Add: Allow user test1 have all access to group/topic with prefix `test_`
```
bin/kafka-acls.sh --authorizer-properties zookeeper.connect=10.3.48.54:2181,10.3.48.56:2181,10.3.48.82:2181 --add --allow-principal User:test1 --allow-host '*' --operation ALL --topic 'test_' --group 'test_' --resource-pattern-type prefixed
```

Explain: https://kafka.apache.org/20/javadoc/org/apache/kafka/common/resource/PatternType.html
```
A Literal pattern with the same type and name, e.g. ResourcePattern(TOPIC, "payments.received", LITERAL)
A Wildcard pattern with the same type, e.g. ResourcePattern(TOPIC, "*", LITERAL)
A Prefixed pattern with the same type and where the name is a matching prefix, e.g. ResourcePattern(TOPIC, "payments.", PREFIXED)
```

Other useful: https://cwiki.apache.org/confluence/display/KAFKA/KIP-290%3A+Support+for+Prefixed+ACLs
```
Motivation
Kafka authorizes access to resources like topics, consumer groups etc. by way of ACLs. The current supported semantic of resource name in ACL definition is either full resource name or special wildcard '*', which matches everything.

Kafka should support a way of defining bulk ACLs instead of specifying individual ACLs.
Example use cases:

Principal “user2” has access to all topics that start with “com.company.product1.”.
Principal “user1” has access to all consumer groups that start with “com.company.client1.”.
Support for adding ACLs to such 'prefixed resource patterns' will greatly simplify ACL operational story in a multi-tenant environment.
```

What happens when i grant full permission to one host. In this example it is 10.5.94.94
```
Current ACLs for resource `ResourcePattern(resourceType=CLUSTER, name=kafka-cluster, patternType=LITERAL)`:
        (principal=User:*, host=10.5.94.94, operation=ALL, permissionType=ALLOW)

Current ACLs for resource `ResourcePattern(resourceType=TOPIC, name=*, patternType=LITERAL)`:
        (principal=User:*, host=10.5.94.94, operation=ALL, permissionType=ALLOW)

Current ACLs for resource `ResourcePattern(resourceType=GROUP, name=*, patternType=LITERAL)`:
        (principal=User:*, host=10.5.94.94, operation=ALL, permissionType=ALLOW)
```

It turn about resourceType: cluster, group, topic like above!

When restart mm2, if `sync.topic.acls.enabled = true`. It will sync permission to cluster left with resourceType=TOPIC
If you want sync resouceType=CLUSTER or GROUP. You have to enable them as well xD




#### - Remove
Current i have following ACLs
```
Current ACLs for resource `ResourcePattern(resourceType=GROUP, name=test_, patternType=PREFIXED)`:
        (principal=User:test1, host=bin, operation=ALL, permissionType=ALLOW)
        (principal=User:test1, host=*, operation=ALL, permissionType=ALLOW)

Current ACLs for resource `ResourcePattern(resourceType=TOPIC, name=test_, patternType=PREFIXED)`:
        (principal=User:test1, host=bin, operation=ALL, permissionType=ALLOW)
        (principal=User:test1, host=*, operation=ALL, permissionType=ALLOW)

```

I want remove part host = bin. Command:
```
bin/kafka-acls.sh --authorizer-properties zookeeper.connect=10.3.48.54:2181,10.3.48.56:2181,10.3.48.82:2181 --remove --allow-principal User:test1  --allow-host
 'bin'  --operation ALL --topic 'test_' --group 'test_' --resource-pattern-type prefixed
```

Output:
```
Are you sure you want to remove ACLs:
        (principal=User:test1, host=bin, operation=ALL, permissionType=ALLOW)
 from resource filter `ResourcePattern(resourceType=TOPIC, name=test_, patternType=PREFIXED)`? (y/n)
y
Are you sure you want to remove ACLs:
        (principal=User:test1, host=bin, operation=ALL, permissionType=ALLOW)
 from resource filter `ResourcePattern(resourceType=GROUP, name=test_, patternType=PREFIXED)`? (y/n)
y
Current ACLs for resource `ResourcePattern(resourceType=TOPIC, name=test_, patternType=PREFIXED)`:
        (principal=User:test1, host=*, operation=ALL, permissionType=ALLOW)

Current ACLs for resource `ResourcePattern(resourceType=GROUP, name=test_, patternType=PREFIXED)`:
        (principal=User:test1, host=*, operation=ALL, permissionType=ALLOW)
```

Another example with delete
```
Current ACLs for resource `ResourcePattern(resourceType=TOPIC, name=cluster_10_3_cluster_10_5_*, patternType=LITERAL)`:
        (principal=User:*, host=10.5.92.67, operation=READ, permissionType=ALLOW)
        (principal=User:*, host=10.5.93.70, operation=READ, permissionType=ALLOW)
        (principal=User:*, host=10.3.48.54, operation=READ, permissionType=ALLOW)
        (principal=User:*, host=10.3.48.56, operation=READ, permissionType=ALLOW)
        (principal=User:*, host=10.5.93.192, operation=READ, permissionType=ALLOW)
        (principal=User:*, host=10.3.48.82, operation=READ, permissionType=ALLOW)
```
Use: `bin/kafka-acls.sh --authorizer-properties zookeeper.connect=10.5.92.67:2181 --remove --topic 'cluster_10_3_cluster_10_5_*'`


Don't care for user and complete want to remove any permission related to that topic?
```
bin/kafka-acls.sh --authorizer-properties zookeeper.connect=10.5.92.67:2181 --remove --topic 'CLUSTER-10-3_test*'
```

Remove wildcard permission like this:

```
Current ACLs for resource `ResourcePattern(resourceType=TOPIC, name=*, patternType=LITERAL)`: 
  (principal=User:*, host=*, operation=ALL, permissionType=ALLOW)
  
Current ACLs for resource `ResourcePattern(resourceType=GROUP, name=*, patternType=LITERAL)`: 
  (principal=User:*, host=*, operation=ALL, permissionType=ALLOW)
```

Command:
```
kafka-acls.sh --authorizer-properties zookeeper.connect=10.3.48.74:2181 -operation All --allow-principal User:*   --allow-host '*'  --cluster --topic '*' --group '*' --remove
```
