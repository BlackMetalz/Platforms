### Download plugin from home page then extract 

```
cd /tmp
wget https://www.percona.com/downloads/percona-monitoring-plugins/1.1.5/percona-monitoring-plugins-1.1.5.tar.gz
tar -xzf percona-monitoring-plugins-1.1.5.tar.gz
cd percona-monitoring-plugins-1.1.5/nagios/bin
cp * /opt
```

- after that define them in mrpe.cfg 

For security reasons, it is recommended to not pass MySQL access credentials in the arguments. You can create /etc/nagios/mysql.cnf and the plugins will use it like the default .my.cnf file. For example:

```
[root@centos6 ~]# cat /etc/nagios/mysql.cnf
[client]
user = root
password = s3cret
[root@centos6 ~]# chown root:nagios /etc/nagios/mysql.cnf
[root@centos6 ~]# chmod 640 /etc/nagios/mysql.cnf
```
