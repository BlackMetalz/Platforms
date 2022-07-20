
## Gen cert for Opensearch
https://opendistro.github.io/for-elasticsearch-docs/old/0.9.0/docs/security/generate-certificates/#generate-private-key
https://aws.amazon.com/blogs/opensource/add-ssl-certificates-open-distro-for-elasticsearch/
https://opensearch.org/docs/latest/security-plugin/configuration/generate-certificates/


### Root CA
openssl genrsa -out root-ca-key.pem 2048 
openssl req -new -x509 -sha256 -key root-ca-key.pem -out root-ca.pem -days 3650

### Admin cert
openssl genrsa -out admin-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out admin-key.pem
openssl req -new -key admin-key.pem -out admin.csr -days 3650
openssl x509 -req -in admin.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out admin.pem

### Node cert
openssl genrsa -out osnode-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in osnode-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out osnode-key.pem
openssl req -new -key osnode-key.pem -out osnode.csr -days 3650
openssl x509 -req -in osnode.csr -CA root-ca.pem -CAkey root-ca-key.pem -CAcreateserial -sha256 -out osnode.pem

### Cleanup
rm admin-key-temp.pem
rm admin.csr
rm osnode-key-temp.pem
rm osnode.csr

--> output:
```
subject=C = AD, ST = AD, L = AD, O = AD, OU = AD, CN = AD
```

```
subject=C = AD, ST = AD, L = AD, O = AD, OU = AD, CN = AD
``` 

Remember to set password and extra email to null.

Config Example:

```
plugins.security.authcz.admin_dn:
  - "EMAILADDRESS=AD,CN=AD,OU=AD,O=AD,L=AD,ST=AD,C=AD"
plugins.security.nodes_dn:
  - "EMAILADDRESS=AD,CN=AD,OU=AD,O=AD,L=AD,ST=AD,C=AD"
```


- root-ca.pem: This is the certificate of the root CA that signed all other TLS certificates
- esnode.pem: This is the certificate that this node uses when communicating with other nodes on the transport layer (inter-node traffic) 
- esnode-key.pem: The private key for the esnode.pem node certificate
- admin.pem: This is the admin TLS certificate used when making changes to the security configuration. This certificate gives you full access to the cluster
- admin-key.pem: The private key for the admin TLS certificate

```
cd /data/opensearch-1.3.0/plugins/opensearch-security/tools/ &&
./securityadmin.sh -cd ../securityconfig/ -icl -nhnv -cacert ../../../config/root-ca.pem -cert ../../../config/admin.pem -key ../../../config/admin-key.pem
```
