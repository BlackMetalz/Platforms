### Steps
1. Create user in local as normal: `useradd abcxyz`
2. create new folder in hdfs /user/abcxyz by: `hdfs dfs -mkdir -p /user/abcxyz`
3. Chown: `hdfs dfs -chown abcxyz:abcxyz /user/abcxyz`
4. Chmod: `hdfs dfs -chmod 755 /user/abcxyz`
