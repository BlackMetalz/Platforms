# 1. Auto Restart World Server

```bash
#!/bin/bash

while :; do
sudo ./worldserver
sleep 0
done
```

# 2. Running Server
```
# Now to start the auth and restarter without having PuTTy open, we going to use screen
# Run the following commands to get screen running with name and in detach mode =. S: sessioname, md: start screen in detached mde
screen -mdS auth ./authserver
screen -mdS world ./restarter.sh

```

# 3. Debug script with relwithdebinfo build 

```
#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo $DIR
cd $DIR

echo "run\n" > gdbcommands
echo "shell echo -e \"SERVERCRASHEVENT\"        " >> gdbcommands
echo "shell echo -e \"\nCRASH ON\" `date`       " >> gdbcommands
echo "info program                              " >> gdbcommands
echo "shell echo -e \"\nBACKTRACE\n\"           " >> gdbcommands
echo "bt                                        " >> gdbcommands
echo "shell echo -e \"\nBACKTRACE FULL\n\"      " >> gdbcommands
echo "bt full                                   " >> gdbcommands
echo "shell echo -e \"\nTHREADS\n\"             " >> gdbcommands
echo "info threads                              " >> gdbcommands
echo "shell echo -e \"\nTHREADS BACKTRACE\n\"   " >> gdbcommands
echo "thread apply all bt full                  " >> gdbcommands

chmod +x gdbcommands

while :
do
    echo "starting worldserver";

    #./worldserver
    mkdir -p crashes
    gdb worldserver --batch -x gdbcommands | tee crashes/current
    FILE=$(date +%s)
    sed -i '1,/SERVERCRASHEVENT/d' crashes/current
    mv crashes/current crashes/$FILE".crash"
    find crashes/ -name '*.crash' -and -size -10k -delete # Remove small files (not crashes)

    echo "worldserver stopped";
    sleep 1
done

```
