- Bash script for backup folder and delete backup files older than 30 days

```
#!/bin/bash

# current date format ( Example 2019-08-10 )
current_date=`date +"%Y-%m-%d"` 

# compress
tar -czvf /data/checkmk_backup/omd_$current_date.tar.gz /omd/sites/example/etc

# Delete backup older than 30 days
find /data/checkmk_backup/ -type f -mtime +30 -exec rm -f {} \;

```
