#!/bin/bash
# Backup multiple namespace and delete older than 7 days
# Script by kienlt
# Required aerospike and aerospike tool installed in this machine
# namespace folder automatically created
# This script only support single port 3000 as default port
# Init Varriables
date=$(date -I)
backup_path=/data/backup/
namespaces=$(aql -o raw -c "show namespaces"  | sort -u | grep -oE "\"(.*)\"" | tr -d "\"")

# output example of command: echo $namespaces
# ``` foo bar ```

# Do backup 
for ns in $namespaces
  do asbackup --namespace $ns --directory ${backup_path}${ns}_${date}
done

# Remove backup older than 7 days
find $backup_path -type d -ctime +7 -exec rm -rf {} \;
