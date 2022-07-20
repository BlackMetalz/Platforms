### 1. View process history usage
- First get the log you want to check fisrt from  /var/log/atop/atop_20191023 ( something like this )
- Then use command:
```
atop -r /var/log/atop/atop_20191023
```

But for better check, use with -b paramter ( begin time )
```
atop -r /var/log/atop/atop_20191023 -b 18:00
```

command above will check history from 18:00 till the end of that day 

- When enter atop screen:
+ use "M" : Sort the current list in the order of resident memory consumption. The one-but-last column changes to ''MEM''.
+ use "C": Sort the current list in the order of cpu consumption (default). The one-but-last column changes to ''CPU''.
+ use "c" : Show the command line of the process.
Per process the following fields are shown: process-id, the occupation percentage for the choosen resource and the command line including arguments.

Reference: https://linux.die.net/man/1/atop
