- Create user and add to group admin with some policy

```
net user /add youruser yourpass
net localgroup administrators youruser /add
net localgroup "Remote Desktop Users" youruser /add
wmic useraccount where "name='youruser'" set passwordexpires=false
```


- Quick create firewall rules. Here is example for allow specific port from single remote IP
```
netsh advfirewall firewall add rule name="Allow Rule from 192.168.1.254" dir=in action=allow protocol=ANY remoteip=192.168.1.254
```
