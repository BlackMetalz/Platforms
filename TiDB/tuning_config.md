### Source: https://docs.pingcap.com/tidb/stable/check-before-deployment

#### Checklist, requirements to deploy TiDB Cluster

1. For the Disk:
Require mount option: `nodelalloc,noatime`

2. Check NTP Service and check by `ntpstat` command

3. Firewall: Just allowed all from all TiDB node or network mask, for security reason, never ever disable firewall

4. System parameter:
- Dsiable THP:
check by `cat /sys/kernel/mm/transparent_hugepage/enabled`
if result is :
```
always [madvise] never
```
it means you need disable, by this way:  https://www.ibm.com/docs/en/db2-big-sql/5.0.4?topic=sql-disabling-transparent-hugepages
Details:
```
For each node in your cluster, run the following command:

echo never > /sys/kernel/mm/transparent_hugepage/enabled

This command disables hugepages only temporarily.
Add the following command to the /etc/rc.local file to run the command automatically when you reboot.

if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
    echo never > /sys/kernel/mm/transparent_hugepage/enabled
fi
```

- Set I/Oscheduler to storage media to noop: Hmm, i'm going to bypass this one duo use of cloud server :()

```
cat /sys/block/sd[bc]/queue/scheduler
noop [deadline] cfq
noop [deadline] cfq
```

