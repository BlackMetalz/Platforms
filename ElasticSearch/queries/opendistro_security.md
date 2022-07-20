Source: https://opendistro.github.io/for-elasticsearch-docs/docs/security/access-control/api/#get-user

# 1. Get Section
- Get users
```
GET _opendistro/_security/api/internalusers
```

- Get single user
```
GET _opendistro/_security/api/internalusers/<username>
```

- Get roles:
```
GET _opendistro/_security/api/roles/
```

- Get singe role:
```
GET _opendistro/_security/api/roles/<role>
```

- Get role mappings
```
GET _opendistro/_security/api/rolesmapping
```

# 2. Delete Section
- Delete user:
```
DELETE _opendistro/_security/api/internalusers/<username>
```

- Delete role:
```
DELETE _opendistro/_security/api/roles/<role>
```

- Delete role mapping:
```
DELETE _opendistro/_security/api/rolesmapping/<role>
```
