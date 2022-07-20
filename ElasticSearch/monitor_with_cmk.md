1. Add host
- Hostname: your hostname or cluster name
- IPv4 Address: 127.1.1.1
- Check_MK Agent: No Checkmk agent, all configured special agents

leave other default

2. Manual Check -> Applications, process & services -> Elasticsearch Cluster Health
Enter detail of what u need to check, this is easy step

3. Configuration of Host & Service Parameters -> Datasource programs -> Check state of Elasticsearch

- CHECK STATE OF ELASTICSEARCH -> Hostnames to query: Define multi master or leave single master
Other is easy step

4. Discover then reload.
Remember to disable ssh check aswell
