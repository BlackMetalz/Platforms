### Here is some tip trick for config file. I mainly use config file instead of Wato.

- Ignore service check and services: if u want to ignore some service. Add some line below into file main.mk or whatever file has extension is .mk
This will affect cmk -vII pernament.
```python
ignored_checks += [
  ('chrony', ALL_HOSTS),
  ('docker', ALL_HOSTS),
  ('postfix_mailq_status',ALL_HOSTS),
]
```

- Ignore services:
```python
ignored_services += [
  (ALL_HOSTS, ['MD Softraid','Resolve_mathias-kettner.de']),
  (ALL_HOSTS, ['Interface docker','Interface veth','Interface br-','Interface cali','Interface tunl0']), #Ignore specific service
  (['windows2k8'], ALL_HOSTS, ['Log Security','Log Application','Log System','Log ']), #Ignore with tag windows2k8
  (['asd-sqlserver-69.69','asd-sqlserver-99.99'],['Memory and pagefile']), #Ignore for specific hosts
]
```

- Check CPU Win level:
```python
# Check CPU_win Warning/crit level
winperf_cpu_default_levels = (90.0, 100.0)
```
- Check memory win:

```python
# Check memory_win Warning/crit
memory_win_default_levels = {
  "memory" : (99.0, 100.0),
  "pagefile" : (99.0, 100.0),
}
```

- Automatic inventory time: Determine for Check_MK Discovery. How many minutes to detect Check_MK Discovery has new unmonitored service!
```python
inventory_check_interval = 120
```

- Change default ntp threshold:
```
This check uses the output of ntpq -p as sent by the agent in order to check the quality of the NTP time synchronization of the client. If more than one peer is available, NTP chooses the "best" of them as "system peer". This check only measures the time difference to that system peer. 
The check is CRIT or WARN, if the time supplied by the system peer is not good enough (see below for parameters). It is UNKNOWN if no system peer is present or the system peer is unreachable. 
The check is CRIT, when there are NTP peers reachable but non of those is used by the NTP daemon. That is the case if the time provided by those peers is too bad. 
Note: If you want to check the health of the peers, you might want to use ntp, which creates one individual check per NTP peer. 
```

```python
ntp_default_levels = (20, 200.0, 500.0)
```

- change file system threshold
```python
filesystem_default_levels["levels"] = ( 90.0, 95.0 )
```

- Max attemps check: Re-check the service up to 3 times ( number in config ) in order to determine its final (hard) state. Simple explain: check up to 3 times, if fails 3 time then notify.
```python
# Set max check attempts for services
extra_service_conf['max_check_attempts'] = [
  ('10', ALL_HOSTS, ['Check_MK']),
  ('5', ALL_HOSTS, ['PING']),
  ('10', ALL_HOSTS, ['NTP Time']),
  ('2', ALL_HOSTS, ['NFS mount']),
]
# Set max check attempts for hosts
extra_host_conf['max_check_attempts'] = [
  ('3', ALL_HOSTS),
]
```
- Simply disable check type after reload. Example ignore NTP TIME
```
ignored_checktypes = [ "ntp.time" ]
```



