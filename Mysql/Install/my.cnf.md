innodb-buffer-pool-size = 80% Server RAM

Require for datadir changes since if in Ubuntu: Appamor fucked:

```
ln -s /etc/apparmor.d/usr.sbin.mysqld /etc/apparmor.d/disable/
apparmor_parser -R /etc/apparmor.d/usr.sbin.mysqld
# Check if /usr/sbin/mysqld is gone
apparmor_status
```

-- Create folder for change data dir mysql
```
mkdir -p /data/var/lib/mysql
mkdir -p /data/var/log/mysql/mysql-bin/
mkdir -p /data/temp
chown -R mysql: /data/var/lib/mysql /data/var/log/mysql /data/temp
```

# Config file default
- /etc/mysql/conf.d/mysql.cnf  or /etc/mysql/mysql.conf.d/mysqld.cnf  ( mysql community server 5.7 )
- /etc/mysql/percona-server.conf.d/mysqld.cnf ( percona server 5.7 )

```
[client]
socket                         = /data/var/lib/mysql/mysql.sock
default-character-set          = utf8

[mysql]

# CLIENT #
port                           = 3306
socket                         = /data/var/lib/mysql/mysql.sock
default-character-set          = utf8

[mysqld]

# GENERAL #
user                           = mysql
default-storage-engine         = InnoDB
socket                         = /data/var/lib/mysql/mysql.sock
pid-file                       = /data/var/lib/mysql/mysql.pid
bind-address                   = 0.0.0.0


# MyISAM #
key-buffer-size                = 32M
myisam-recover-options         = FORCE,BACKUP

# SAFETY #
max-allowed-packet             = 16M
max-connect-errors             = 1000000
skip-name-resolve

# DATA STORAGE #
datadir                        = /data/var/lib/mysql/

# BINARY LOGGING #
log-bin                        = /data/var/log/mysql/mysql-bin/mysql-bin
expire-logs-days               = 3
log-bin
log_slave_updates
server-id                      = 3336

# CACHES AND LIMITS #
tmpdir                         = /data/temp
tmp-table-size                 = 32M
max-heap-table-size            = 32M
#query-cache-type              = 0
#query-cache-size              = 0
max-connections                = 15000
thread-cache-size              = 50
open-files-limit               = 65535
table-definition-cache         = 1024
table-open-cache               = 2048
query-cache-size               = 0
query-cache-type               = 0

# INNODB #
innodb-flush-method            = O_DIRECT
innodb-log-files-in-group      = 2
innodb-log-file-size           = 256M
innodb-flush-log-at-trx-commit = 2
innodb-file-per-table          = 1
innodb-buffer-pool-size        = 3G
innodb-doublewrite             = 0
innodb-io-capacity             = 2000
innodb-io-capacity-max         = 10000

# LOGGING #
log-error                      = /data/var/log/mysql/mysql-error.log
log-queries-not-using-indexes  = 1
slow-query-log                 = 1
slow-query-log-file            = /data/var/log/mysql/mysql-slow.log
#general_log_file               = /data/var/log/mysql/query.log
#general_log                    = 1


# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links                 = 0

```
