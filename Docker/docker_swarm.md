-- Configure the Manager Node for Swarm Cluster Initialization

```
docker swarm init --advertise-addr 10.3.48.82
```

Output:
```
root@kienlt-lab-48:~# docker swarm init --advertise-addr 10.3.48.82
Swarm initialized: current node (otjf4bysr6x3m1akci1onftf5) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-189251y9tnhmdhy5bktzuae8m0vvw412jiybtjethff64uqqcj-a1d2k2h8xgaemyvwd3pdb4vhv 10.3.48.82:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

Run follow command to other node to join swarm as a worker

```
docker swarm join --token SWMTKN-1-189251y9tnhmdhy5bktzuae8m0vvw412jiybtjethff64uqqcj-a1d2k2h8xgaemyvwd3pdb4vhv 10.3.48.82:2377
```

-- Add a manager to this swarm, run following command: ( require not running join swarm as docker above. If you have runs it, leave docker swarm by: `docker swarm leave` )
```
docker swarm join-token manager
```

Ouput
```
root@kienlt-lab-48:~# docker swarm join-token manager
To add a manager to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-189251y9tnhmdhy5bktzuae8m0vvw412jiybtjethff64uqqcj-4s8gqs7z7v1qfdiecdjj2jl3c 10.3.48.82:2377
```

Credit: https://linuxconfig.org/how-to-configure-docker-swarm-with-multiple-docker-nodes-on-ubuntu-18-04


# Promote / demote node docker
```
$ docker node promote node-3 node-2
```
Node node-3 promoted to a manager in the swarm.
Node node-2 promoted to a manager in the swarm.
To demote a node or set of nodes, run docker node demote from a manager node:
```
$ docker node demote node-3 node-2
```
Manager node-3 demoted in the swarm.
Manager node-2 demoted in the swarm.
