#!/bin/bash
# Script by kienlt
# Usage: ./aerospike_backup_v2.sh 127.0.0.1 3000
# Edit 3000 to which port you want to use aswell as 127.0.0.1


# Init Var
date=$(date -I)
backup_path=/data/backup/$2/
host=$1
port=$2

namespaces=$(aql -h $host -p $port -o raw -c "show namespaces"  | sort -u | grep -oE "\"(.*)\"" | tr -d "\"")

if [ -d "${backup_path}" ]
then
  for ns in $namespaces
    do asbackup -h $host -p $port --namespace $ns --directory ${backup_path}${ns}_${date}
  done
else
  mkdir -p $backup_path
  for ns in $namespaces
    do asbackup -h $host -p $port --namespace $ns --directory ${backup_path}${ns}_${date}
  done
fi

# Remove backup older than 7 day
find $backup_path -type d -ctime +7 -exec rm -rf {} \;
