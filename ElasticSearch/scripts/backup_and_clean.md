1. Get snapshot Script:
```
#!/bin/bash
curl -XPUT 'http://10.3.48.54:9200/_snapshot/my-fs-repository/snapshot_'$(date +%Y%m%d-%H%M%S-%s)'?wait_for_completion=true&pretty' -u authuser:authpass -k
echo -e "Create -  Current time: `date`"
echo "Done!"
```

But have to Register repository before take snapshot:
```
curl -XPUT http://10.3.48.54:9200/_snapshot/my-fs-repository -u authuser:authpass -k -H 'Content-Type: application/json' \
-d '{
  "type": "fs",
  "settings": {
    "location": "/mnt/snapshots"
  }
}'
```
Important: /mnt/snapshots is folder inside container mounted with shared folder which all nodes of odfe can access ( NFS, Lizardfs, minio.... )

2. Clean snapshot script
```
#!/bin/bash
#
apt install jq -y

# The amount of snapshots we want to keep.
LIMIT=3
# Name of our snapshot repository
REPO=my-fs-repository
# Auth
USER=authuser:v
AUTH=authpass:v 

# Get a list of snapshots that we want to delete
SNAPSHOTS=`curl -s -XGET http://10.3.48.54:9200/_snapshot/$REPO/_all -u $USER:$AUTH -k  | jq -r ".snapshots[:-${LIMIT}][].snapshot"`

# Loop over the results and delete each snapshot
for SNAPSHOT in $SNAPSHOTS
do
 echo "Deleting snapshot: $SNAPSHOT"
        curl -s -XDELETE 10.3.48.54:9200/_snapshot/$REPO/$SNAPSHOT?pretty -u $USER:$AUTH -k
done
echo "Done!"
