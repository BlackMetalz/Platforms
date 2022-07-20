# Without this, you can't get call data from pillar with pillar.get
# pillar file for match list|compound : /srv/salt/pillar/users/server1.sls or /srv/salt/pillar/users/server1/init.sls
# 
base:
  '*':
    - softwares_dev
    - users
  'specific-minion-id,minion-id-exactly':
    - match: list
    - users.server1
  'server-regex0* or server-regex1*':
    - match: compound
    - users.server-regex
