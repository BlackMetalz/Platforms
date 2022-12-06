#!/usr/bin/python
# Author: Luong Trung Kien
import os

users=[]

# ls /home > users.txt
with open("users.txt", "r") as f:
    for data in f:
        users.append(data)

# Remove new line in list
users= [x.strip() for x in users if x.strip()]


for user in users:
    cmd = "cat /home/%s/.ssh/authorized_keys > %s_id_rsa.pub"%(user,user)
    os.system(cmd)
