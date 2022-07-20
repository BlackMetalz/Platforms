## Command get salt minion info

- Test ping if matched OS:
`
salt -G os_family:Redhat test.ping
`

- matched oscodename ( ubuntu 20 focal ) :
```
salt -G oscodename:focal cmd.run "date"
```

- Test ping if matched OS and name like:
`
salt -C 'G@os_family:RedHat and sysadmin*' test.ping
`

- Ping if it is centos 7:
```
salt -G osfinger:'CentOS Linux-7' test.ping
```

- Show document and how to use this:
`
salt server101 sys.doc test.ping
`

- see all document function test:
`
salt server101 sys.doc test
`

- see all module loaded in minion:
`
salt server101 sys.list_modules
`

- see which packets loaded on server101:
`
salt server101 pkg.list_pkgs
`

- install packet wget in all server
`
salt '*' pkg.install wget
`

- check packet grep has been installed or not
`
salt -L 'server101,server102' pkg.list_pkgs --out=txt | grep wget | cut -c -20 
`

- Run command on minion:
`
salt server101 cmd.run 'yum remove wget'
`

- show all users in minion
`
salt server101 user.list_users
`

- Get OS Family of minion: it probably will return Redhat or Debian
`
salt serverxxx grains.get os_family
`

- Get OS of all minions:
`
salt '*' grains.get os
`

