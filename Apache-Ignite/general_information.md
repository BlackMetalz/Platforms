# 1. Ports ( source: https://dzone.com/articles/a-simple-checklist-for-apache-ignite-beginners )
By default, Ignite uses the following local ports:


| TCP/UDP | Port Number | Description |
| ------- | ----------- | ----------- |
| TCP     | 10800       | Default port for thin client connection |
| TCP     | 11211       | Default JDBC port                       |
| TCP     | 47100       | Default local communication port        |
| UDP     | 47400       |                                         |
| TCP     | 47500       | Default local discovery port            |
| TCP     | 8080        | Default port for REST API               |
| TCP     | 49128       | Default port for JMX connection         |
| TCP     | 31100~31200 | Default time server port                |
| TCP     | 48100~48200 | Default shared memory port              |

# 2. Network
If you encountered strange network errors, for instance, if a network could not connect or could not send the message, 
most often you've unfortunately been hit by the IPv6 network problem. It can’t be said that Ignite doesn’t support the IPv6 protocol, 
but at this moment, there are a few specific problems. The easiest solution is to disable the IPv6 protocol. To disable the IPv6 protocol, 
you can pass a Java option or property to the JVM as follows:

```
-Djava.net.preferIPv4Stack=true
```
The above JVM option forces the Ignite to use IPv4 protocols and solves a significant part of the problems related to the network.
