# 1. Install package API: apt install satl-api

# 2. /etc/salt/master.d/salt-api.conf
```
external_auth:
  pam:
    saltuser:
      -.*

rest_cherrypy:
  port: 8000
  disable_ssl: True
  debug: True
```
while saltuser is system user

# 3. Login and save the cookie
```
curl -si http://127.0.0.1:8000/login \
        -H "Accept: application/json" \
        -d username='saltuser' \
        -d password='123123' \
        -d eauth='pam' > /tmp/cookies.txt
```

# 4. Query:
```
curl -b /tmp/cookies.txt -sS 127.0.0.1:8000 -H "Accept:application/x-yaml" -d client='local' -d tgt='*' -d fun='test.ping'
```

Output:
```
return:
- wtf-sys-centos7-dev-93-134: true
  wtf-sys-kienlt-48-54: true
  wtf-sys-kienlt-48-56: true
  wtf-sys-kienlt-48-82: true
```
