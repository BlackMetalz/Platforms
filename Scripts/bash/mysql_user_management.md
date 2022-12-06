```
#!/bin/bash

IPS="172.26.33.65 172.26.33.66 172.26.33.68 172.26.33.69 172.26.33.86 172.26.33.123 172.26.33.124 172.26.33.125"
TABLES="post_group_hidden post_group_hidden_dev"
PRIVS="select,update,insert"
DB="zzz"
USER="zzz-post-group"
PASS="Mt2KjTjHdW0lyE1GcE3P"

for ip in $IPS
do
	for t in $TABLES
	do
		if [ -z $PASS ]
		then
			echo -e "grant $PRIVS on \`$DB\`.\`$t\` to '$USER'@'$ip';"
		else
			echo -e "grant usage on *.* to '$USER'@'$ip' identified by '$PASS' with max_user_connections 20;"
		fi
		echo -e "grant $PRIVS on \`$DB\`.\`$t\` to '$USER'@'$ip';"
	done
	# echo -
done
```
