### Credit: https://github.com/opendistro-for-elasticsearch/community/issues/28#issuecomment-482866142
Here i what i was able to come up with. Feel free to change it up and fix grammatical mistakes (english is my second language)

When going for a complete production envirioment being able to scale up and restore backups to our implementations is key in order to have a reliable envirioment where people can store and explore real time data.
In order to archive this here is a step by step guide on building a cluster over docker swarm. For this example in particular i ll be using EC2 instances from AWS using the AMI of Ubuntu 16.04.
We ll strart by installing docker, docker-compose, setting the maximum virtual memory and download the opendistro images.

```
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce=18.06.3~ce~3-0~ubuntu containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo echo -e "[Service]\nLimitMEMLOCK=infinity" | SYSTEMD_EDITOR=tee systemctl edit docker.service
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo sysctl -w vm.max_map_count=262144 # Keep in mind this is not permanent. You should add the line "vm.max_map_count=262144" to the /etc/sysctl.conf file in order to avoid losing this configuration
sudo docker pull amazon/opendistro-for-elasticsearch:latest
sudo docker pull amazon/opendistro-for-elasticsearch-kibana:latest
```

Wow so many commands, but we can simplify most of this work if we just do it ones and then create an AMI so every machine (node) we use from now on is fully configured. But wait, before doing this we might want to create our own custom image in order to install plugins like s3-repository to be able to use S3 to store our backups and avoid using our local fs.
Now its time to create a Dockerfile using your favorite text processor to write (vi, nano, etc):

```
FROM amazon/opendistro-for-elasticsearch:latest
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch https://artifacts.elastic.co/downloads/elasticsearch-plugins/repository-s3/repository-s3-6.6.2.zip
RUN cat /file/containing/access_key | bin/elasticsearch-keystore add --force --stdin s3.client.default.access_key <<< "<YOUR AWS ACCESS KEY>"
RUN cat /file/containing/secret_key | bin/elasticsearch-keystore add --force --stdin s3.client.default.secret_key <<< "<YOUR AWS SECRET KEY>"
Keep in mind this credentials should have write access over the bucker where you want to backup your cluster. More info about S3repository and Elastic Snapshots.
```
Now we create a new image using:

```
docker build -t custom_opendistro .
```

Now we need to be able to replicate this image over the nodes. Here is where i would recommend using a docker repository like ECR but in order to avoid doing this post more extensive than it needs to we can just create an AMI here and move on.

Ones we have two machines up and running (the one we just configure and a new one we create from our recentlly created AMI).
Lets call them Instance1 and Instance2.

Now on the Instance1 we need to create the docker swarm:

```
docker swarm init --advertise-addr <Internal IP>
```

This command ll return something like

```
docker swarm join --token XXXXX InternalIP:2377
```

this you should run on the Instance2 node in order to join it to the swarm. At this point we have our swarm ready to deploy our app.
In order to do this we ll be using docker-compose. Here is an example file:

docker-compose.yml
```
version: '3'
services:
  elastic-node1:
    image: custom_opendistro
    environment:
      - cluster.name=elastic-cluster
      - bootstrap.memory_lock=false
      - "ES_JAVA_OPTS=-Xms64g -Xmx64g" 
      - opendistro_security.ssl.http.enabled=false
      - discovery.zen.minimum_master_nodes=1
    volumes:
      - elastic-data1:/mnt/data
    ports:
      - 9200:9200
      - 9600:9600
      - 2212:2212  
    ulimits:
      memlock:
        soft: -1
        hard: -1
    networks:
      - elastic-net
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints:
            - node.type == manager
  elastic-node2:
    image: custom_opendistro
    environment:
      - cluster.name=elastic-cluster
      - bootstrap.memory_lock=false
      - "ES_JAVA_OPTS=-Xms64g -Xmx64g"
      - discovery.zen.ping.unicast.hosts=elastic-node1
      - opendistro_security.ssl.http.enabled=false
      - discovery.zen.minimum_master_nodes=1
    volumes:
      - elastic-data2:/mnt/data
    networks:
      - elastic-net
    ulimits:
      memlock:
        soft: -1
        hard: -1
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints:
            - node.type != manager
  kibana:
    image: amazon/opendistro-for-elasticsearch-kibana:0.8.0
    ports:
      - 5601:5601
    expose:
      - "5601"
    environment:
      ELASTICSEARCH_URL: http://elastic-node1:9200
    networks:
      - elastic-net
    deploy:
      mode: replicated
      replicas: 1

volumes:
  elastic-data1:
  elastic-data2:

networks:
  elastic-net:
```

Feel free to change the "ES_JAVA_OPTS" variable in order to assign RAM memory to each node of the cluster. More info about elastic core configurations.

Ones your file is ready we can go on and deploy the cluster usign:

```
docker stack deploy --compose-file docker-compose.yml opendistrostack
```

GREAT !! Your first opendistro cluster should be running right now and you should be able to access it using the internal ip of the Instance1 on the port 5601. For example: http://127.0.0.1:5601

But now its time to fullfil the promises i made at the begining. Lets start with scaling up the cluster.
In order to do this we ll create a new machine from the same AMI, lets call it Instance3 and join it to the swarm just like we do with the Instance2.
And now we can just tell the swarm to increase the number of replicas we want for the elastic-node2 (keep in mind im using the elastic-node2 cause it has the configuration that allows a node to ping an elastic master node and join in - discovery.zen.ping.unicast.hosts)

```
docker service scale opendistrostack_elastic-node2=2
```

AWESOME!! You have a 3 node cluster up and running that is able to create and restore snapshots from S3 and you can keep adding nodes as much as you want.

Caveats:

In order to make the swarm fault tolerance the best way i found was promoting all nodes to leaders of the swarm and chaning from the docker-compose the constraints to labels. More info here.
The elastic cluster should be able to survive the lost of the Instance1 and i ll automatically assign another master but you ll lose your kibana. Im looking on deploying this on a more efficient way.
At some point the elastic cluster need to have more than one master and for this you ll need to run:

```
PUT /_cluster/settings {"persistent" : {"discovery.zen.minimum_master_nodes" : 2}}
```

and preferably add every master to the discovery.zen.ping.unicast.hosts variable. Updating the docker-compose file and running the update over the cluster.


Extras:

If you have problems creating the S3 repository for backups this request might help update the keystore values we setup on the Dockerfile:
```
POST _nodes/reload_secure_settings
```
In case you want to access the running container you might find that most commands fail cause of a memory issue. You need to overwrite the ES_JAVA_OPTS variable to be able to access the container.
```
docker exec -e ES_JAVA_OPTS= -it <Container ID> bash
```

I havent had the time to code a simple script to backup the whole cluster (it should be a simple http request) each day. Here is the request to create the repository:
```
PUT /_snapshot/s3_repository {"type": "s3","settings": {"bucket": "<Bucket name>","region": "us-east-1"}}
```
Create a snapshot
```
PUT /_snapshot/s3_repository/<Snapshot name>?wait_for_completion=false
```

