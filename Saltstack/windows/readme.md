-- Credit: https://docs.saltstack.com/en/latest/topics/windows/windows-package-manager.html

Config in master: /etc/salt/master

```
# Disable winrepo for older minions
winrepo_remotes: []
winrepo_dir_ng: '/srv/salt/win/repo-ng'
winrepo_remotes_ng:
    - 'https://github.com/saltstack/salt-winrepo-ng.git'

```

- You have to run those command with in location /srv/salt/win  to init salt win repo
```
salt-run winrepo.update_git_repos # for update winrepo-ng
salt -G 'os:windows' pkg.refresh_db verbose=True # Apply news from repo to minions
```

You will see something like this appear:

```
        salt-winrepo-ng\winpcap.sls:
            - winpcap
        salt-winrepo-ng\winrar.sls:
            - winrar
        salt-winrepo-ng\winscp.sls:
            - winscp
        salt-winrepo-ng\wireshark.sls:
            - wireshark
        salt-winrepo-ng\wmi_provider\init.sls:
        salt-winrepo-ng\wscc.sls:
            - wscc
        salt-winrepo-ng\wufuc.sls:
            - wufuc
        salt-winrepo-ng\xampp.sls:
            - xampp
        salt-winrepo-ng\xming.sls:
            - xming
        salt-winrepo-ng\yubikey-manager.sls:
            - yubikey-manager
        salt-winrepo-ng\yubikey-personalization-tool.sls:
            - yubikey-personalization-tool
        salt-winrepo-ng\zabbix-agent.sls:
            - zabbix-agent
        salt-winrepo-ng\zipinstaller\init.sls:
            - zipinstaller
        salt-winrepo-ng\zoom.sls:
            - zoom
```


- After config you can run something like this:
```
salt minion_id pkg.install xampp
```

- List installed package in minion
```
salt minion_id pkg.list_pkgs
```

- Then remove with pkg_name from list_pkgs 
```
salt minion_id pkg.remove pkg_name
```

with package come from salt-winrepo-ng
