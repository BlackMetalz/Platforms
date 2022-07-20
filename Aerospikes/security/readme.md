1. Enable security by change in aerospike config:

```
    security {
        enable-security true

        # Other security-related configuration...
    }

```

ref: https://www.aerospike.com/docs/operations/configure/security/access-control/

2. AQL
- login with password default "admin"
```
aql -Uadmin
```

```
# 
aql> # Change admin password
aql> set passwrd "QWERTY@QWERTY" for admin
OK
aql> show roles
+------------------+------------------+-----------+
| role             | privileges       | whitelist |
+------------------+------------------+-----------+
| "data-admin"     | "data-admin"     | ""        |
| "read"           | "read"           | ""        |
| "read-write"     | "read-write"     | ""        |
| "read-write-udf" | "read-write-udf" | ""        |
| "sys-admin"      | "sys-admin"      | ""        |
| "user-admin"     | "user-admin"     | ""        |
| "write"          | "write"          | ""        |
+------------------+------------------+-----------+
7 rows in set (0.002 secs)
aql> create user superadmin password "QWE@QWE@123" role user-admin
OK
aql> show users
+--------------+--------------+
| user         | roles        |
+--------------+--------------+
| "admin"      | "user-admin" |
| "superadmin" | "user-admin" |
+--------------+--------------+
2 rows in set (0.003 secs)
aql> # create a role with read-write-udf privileges on set "setA" in namespace "test"
aql> create role setA-user privileges read-write-udf.test.setA
OK
aql> show role setA-user
+-------------+----------------------------+
| role        | privileges                 |
+-------------+----------------------------+
| "setA-user" | "read-write-udf.test.setA" |
+-------------+----------------------------+
1 row in set (0.000 secs)
OK
aql> # add a whitelist to this role so that it must connect from a 127.xx.xx.xx address
aql> # (Aerospike server 4.6 or later)
aql> set whitelist "127.0.0.0/8" for setA-user
OK
aql> show role setA-user
+-------------+----------------------------+----------------+
| role        | privileges                 | whitelist      |
+-------------+----------------------------+----------------+
| "setA-user" | "read-write-udf.test.setA" | "127.0.0.0/8" |
+-------------+----------------------------+----------------+
1 row in set (0.001 secs)
OK

aql> # create a role with read-write-udf privileges on set "setB" in namespace "test"
aql> create role setB-user privileges read-write-udf.test.setB
OK
aql> # create a role with read-write-udf privileges on set "setC" in namespace "test"
aql> # that is only allowed to connect from a specific IP address (Aerospike server 4.6 or later)
aql> create role setC-user privileges read-write-udf.test.setB whitelist "127.23.45.67"
OK
aql> # remove the whitelist from this role (Aerospike server 4.6 or later)
aql> set whitelist "" for setC-user
OK
aql> # create a user with several roles
aql> create user fred password fredspwd roles user-admin,setA-user,setB-user
OK
aql> show user fred
+--------+------------------------------------+
| user   | roles                              |
+--------+------------------------------------+
| "fred" | "setA-user, setB-user, user-admin" |
+--------+------------------------------------+
1 row in set (0.001 secs)
OK
aql> # create a user without a role
aql> create user sally password foo
OK
aql> show user sally
+-------+-------+
| user  | roles |
+-------+-------+
| sally | ""    |
+-------+-------+
aql> # remove a role from a user
aql> revoke role setB-user from fred
OK
aql> show user fred
+--------+-------------------------+
| user   | roles                   |
+--------+-------------------------+
| "fred" | "setA-user, user-admin" |
+--------+-------------------------+
1 row in set (0.000 secs)
OK
aql> # create a role with read-write privileges on namespaces "test" and "bar"
aql> create role new-role privileges read-write.test, read-write.bar
OK
aql> show role new-role
+------------+-----------------------------------+
| role       | privileges                        |
+------------+-----------------------------------+
| "new-role" | "read-write.bar, read-write.test" |
+------------+-----------------------------------+
1 row in set (0.000 secs)
OK
aql> # add a role to a user
aql> grant role new-role to fred
OK
aql> show user fred
+--------+-----------------------------------+
| user   | roles                             |
+--------+-----------------------------------+
| "fred" | "new-role, setA-user, user-admin" |
+--------+-----------------------------------+
1 row in set (0.000 secs)
OK
aql> # remove a privilege from a role (Affects any                mesh-seed-address-port 10.3.48.56 3002
                mesh-seed-address-port 10.3.48.82 3002
 users who have the role)
aql> revoke privilege read-write.bar from new-role
OK
aql> show role new-role
+------------+-------------------+
| role       | privileges        |
+------------+-------------------+
| "new-role" | "read-write.test" |
+------------+-------------------+
1 row in set (0.000 secs)
OK
aql> # eliminate a role (Affects any users having the role)
aql> drop role new-role
OK
aql> show user fred
+--------+-------------------------+
| user   | roles                   |
+--------+-------------------------+
| "fred" | "setA-user, user-admin" |
+--------+-------------------------+
1 row in set (0.000 secs)
OK

```

3. General:
create an user in 1 node, it auto sync data to another node. 
It means that you can can login to every node in cluster by only one user that you created.

security information logged in /opt/aerospike/smd/security.smd
