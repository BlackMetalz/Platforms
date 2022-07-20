- Config kibana to odfe nodes with auth: kibana.yml
```
server.host: 0.0.0.0
elasticsearch.hosts:
  - http://10.9.8.7:9200
elasticsearch.ssl.verificationMode: none
elasticsearch.username: admin
elasticsearch.password: adminpassword
elasticsearch.requestHeadersWhitelist: ["securitytenant","Authorization"]

opendistro_security.multitenancy.enabled: true
opendistro_security.multitenancy.tenants.preferred: ["Private", "Global"]
opendistro_security.readonly_mode.roles: ["kibana_read_only"]

newsfeed.enabled: false
telemetry.optIn: false
telemetry.enabled: false

```
