- Information: This is optimize for ~900 Hosts, ~21000 Services in production
- Find this config in omd. Know how many core you have, then set max_concurrent_checks = x2 core of your CPU ( If you don't know, run nproc command. It will return a number of your core )
For an example.  I have 16 cores, so i can set this to 32.

```
# MAXIMUM CONCURRENT SERVICE CHECKS
# This option allows you to specify the maximum number of
# service checks that can be run in parallel at any given time.
# Specifying a value of 1 for this variable essentially prevents
# any service checks from being parallelized.  A value of 0
# will not restrict the number of concurrent checks that are
# being executed.

max_concurrent_checks=32
```

Then your omd service won't be overload :D
