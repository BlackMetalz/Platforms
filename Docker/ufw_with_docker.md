### Reference and credit: https://github.com/chaifeng/ufw-docker#tldr


For Ubuntu with Ufw want limit access on port in Docker:

- Modify the UFW configuration file /etc/ufw/after.rules and add the following rules at the end of the file:

```
# BEGIN UFW AND DOCKER
*filter
:ufw-user-forward - [0:0]
:DOCKER-USER - [0:0]

-A DOCKER-USER -j RETURN -s docker_inet

-A DOCKER-USER -p udp -m udp --sport 53 --dport 1024:65535 -j RETURN

-A DOCKER-USER -j ufw-user-forward

-A DOCKER-USER -j DROP -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -d docker_inet

-A DOCKER-USER -j DROP -p udp -m udp --dport 0:32767 -d docker_inet

-A DOCKER-USER -j RETURN
COMMIT
# END UFW AND DOCKER
```

- Detailed explain in reference.
- Quick explain: get docker_inet from command:  ` ip a  | grep docker `
Example output:

```
3: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
```

So replace docker_inet = 172.17.0.1/16. 


After that do this command:

```
ufw route allow proto tcp from Your_ip_want_to_allow_connect_to_port to any port 3306
# Dont forget to reload ufw. 
# Author said sometime it needed to reboot server, but when i try this, i dont need reboot server to get rule activated :D
```

- Ofc, Your_ip_want_to_allow_connect_to_port: is your ip address you want to allow to connect to port 3306. More secures for port 3306, right?



```
