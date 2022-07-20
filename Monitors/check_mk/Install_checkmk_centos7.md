### 1. Add EPEL Repository to the System

We have to install EPEL repository because some of the check_mk packages are not available in default repositories.

`
yum install epel-release -y
`

### 2. Install Check_MK
Get link download in https://checkmk.com/download.php?
Checkmk Raw Edition ( Stable ). 

Example:

`
wget https://checkmk.com/download_version.php?&version=1.5.0p19&edition=cre
`

Install Check_MK and all the dependencies required for Check_MK.

`
yum install check-mk-raw-1.5.0*
`

Now modify Firewall rules for HTTP.

`
firewall-cmd --add-service=http --zone=public --permanent
firewall-cmd --reload
`

Verify install:

`
omd version
`

### 3. Config Check MK

Create new site. Recommend create one site only for monitor:

`
omd create kienlt_monitor
`

Output:

```
root@2f0576fbb167:/# omd create kienlt_monitor
Adding /opt/omd/sites/kienlt_monitor/tmp to /etc/fstab.
Creating temporary filesystem /omd/sites/kienlt_monitor/tmp...mount: permission denied
WARNING: Could not mount tmpfs. You may either start the container in privileged mode or use the "docker run" option "--tmpfs" to make docker do the tmpfs mount for the site.
WARNING: You may continue without tmpfs, but the performance of Check_MK may be degraded.
OK
Created new site kienlt_monitor with version 1.5.0p19.cre.

  The site can be started with omd start kienlt_monitor.
  The default web UI is available at http://hostname/kienlt_monitor/

  The admin user for the web applications is cmkadmin with password: 9p0XN5JG
  (It can be changed with 'htpasswd -m ~/etc/htpasswd cmkadmin' as site user.
)
  Please do a su - kienlt_monitor for administration of this site.
  ```
  
  
  Start it:
```  
root@2f0576fbb167:/# omd start kienlt_monitor
Creating temporary filesystem /omd/sites/kienlt_monitor/tmp...mount: permission denied
WARNING: Could not mount tmpfs. You may either start the container in privileged mode or use the "docker run" option "--tmpfs" to make docker do the tmpfs mount for the site.
WARNING: You may continue without tmpfs, but the performance of Check_MK may be degraded.
OK
Starting mkeventd...OK
Starting rrdcached...OK
Starting npcd...OK
Starting nagios...2019-07-15 16:45:00 [6] updating log file index
2019-07-15 16:45:00 [6] updating log file index
OK
Starting apache...OK
Initializing Crontab...OK
```

4. Config and install checkmk agent:
- Install check mk agent package on client
- Install xinetd on client
- Open port 6556 on client
  

