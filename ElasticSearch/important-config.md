- Change virtual memory
```
sysctl -w vm.max_map_count=262144
```

Remember to change in /etc/sysctl.conf for permanent
```
echo 'vm.max_map_count = 262144' >> /etc/sysctl.conf
```

- Tuning write queue size:
```
GET _nodes/thread_pool 
```
search write in output above.I recommend to increase write queue size to 2000 if you have seen output like this:
```
Running, pool size = 16, active threads = 16, queued tasks = 201, completed tasks = 111090581
```
