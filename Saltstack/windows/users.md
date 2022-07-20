-- Add user from salt-master

```
salt adt-sys-windows-test-1-236 user.add kienlt 'win:salt@123'
```

-- Add user to group from salt-master
```
salt adt-sys-windows-test-1-236 user.addgroup kienlt Administrators
```

-- Password never expire :v 
```
"wmic useraccount where name='user' set passwordexpires=false"
```
