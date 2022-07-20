- Target minion like:  ` *aerospike-9.* `

```bash
salt -C '*aerospike-9.*' cmd.run "cat /etc/os-release"
```

- Change Salt Master:
```bash
service salt-minion stop
# Remove minion master
rm -f /etc/salt/pki/minion/minion_master.pub 
# Edit salt master in /etc/salt/minion
# Then start salt-minion again
service salt-minion start
```

In salt master accept new key. Done

- Change Salt Minion ID:
Change in `/etc/salt/minion_id`
Restart salt-minion service
Then in Salt Master
- Delete Old salt-key of minion
- Accept new salt-key of minion


- Salt minion duplicate?: Possible double or more salt-minion services are running
grep them by:
```
ps -ef | grep salt-minion
```

then kill them all and start salt-minion service again. Then it will be ok ( From my experience while using saltstack )

- Can't see salt minion key in salt master?  : check firewall


- This trick is just awesome:

salt-key | grep -E "33\.(112|113|114)" | while read var; do salt $var network.ip_addrs; done;

- List all job running:
```
salt-run jobs.active
```

- Kill "SaltStack: The function “state.apply” is running as PID xxxx and was started at xxxx with jid xxxx"
```
# kill the job id
salt '*' saltutil.kill_job <job id>
# kill all jobs
salt '*' saltutil.kill_all_jobs
 ```
 
 - Escape $ character in salt cmd.run
 ```
 salt kienlt-lab-48.54 cmd.run "lsof | awk '{print \$1}'"
 ```
 - [ERROR   ] The Salt Master has cached the public key for this node, this salt minion will wait for 10 seconds before attempting to re-authenticate SOLUTION
 
 in salt-minion: 
 ```
 # salt-call test.ping
 [ERROR   ] The master key has changed, the salt master could have been subverted, verify salt master's public key
[CRITICAL] The Salt Master server's public key did not authenticate!
The master may need to be updated if it is a version of Salt lower than 3000.3, or
If you are confident that you are connecting to a valid Salt Master, then remove the master public key and restart the Salt Minion.
The master public key can be found at:
/etc/salt/pki/minion/minion_master.pub
Invalid master key
# remove salt-key in master before do step below 
root@rancher2-proxy-48:/etc/salt# rm /etc/salt/pki/minion/minion_master.pub 
root@rancher2-proxy-48:/etc/salt# service salt-minion restart
```

- Reset linux password with salt
Gen shadow pass:
```
salt minionid shadow.gen_password 'wtfboyz'
```

output:
```
$6$Kr4EWBMR$5s.TDUwSdar3CvFlH60xPufgrSLid6nuZUQJbwYD2Tafpobj1PbcuGrKo3PkhKnKS9X/7jDG/b2JmpwhV1Y7V1
```

Reset:
```
salt minionid shadow.set_password username '$6$Kr4EWBMR$5s.TDUwSdar3CvFlH60xPufgrSLid6nuZUQJbwYD2Tafpobj1PbcuGrKo3PkhKnKS9X/7jDG/b2JmpwhV1Y7V1'
```





