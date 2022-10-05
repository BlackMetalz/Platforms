### Some basic command write for note while in redis cli

1. Check memory:
```
info memory
config get maxmemory
```

2. Increase memory for current port:
```
CONFIG SET maxmemory 16G
```