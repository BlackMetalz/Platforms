# note: update roles and update role mapping equal to create. So you just need re-run create role/mapping query with new data. Run security will flush those users >.>
# Permissions: https://opendistro.github.io/for-elasticsearch-docs/docs/security/access-control/permissions/

# 1. Create user
```
PUT _opendistro/_security/api/internalusers/username
{
  "password": "wtfpassword",
  "backend_roles": ["userrole"]
}
```

# 2. Create Roles with permission
This example is full access to index pattern defined.
```
PUT _opendistro/_security/api/roles/userrole
{
  "cluster_permissions": [
    "cluster_composite_ops",
    "cluster:monitor/main",
    "cluster:monitor/health",
    "cluster:monitor/state"
  ],
  "index_permissions": [{
    "index_patterns": [
      "wtf_index*"
    ],
    "dls": "",
    "fls": [],
    "masked_fields": [],
    "allowed_actions": [
       "indices_all"
    ]
  }]
}
```

# 3. Map role to user
```
PUT _opendistro/_security/api/rolesmapping/userrole
{
  "backend_roles" : [ "userrole" ],
  "hosts" : [ "" ],
  "users" : [ "username" ]
}
```
