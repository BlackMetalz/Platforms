-- Create new template basic:

```
PUT _index_template/k8s_logs
{
  "index_patterns": ["k8s_logs_*"],
  "template": {
    "settings": {
      "number_of_shards": 5,
      "number_of_replicas": 1
    }
  }
}
```

-- Create basic template with setting.
```
PUT _template/k9s_logs_test
{
    "order" : 0,
    "index_patterns" : [
      "k9s_logs_test_*"
    ],
    "settings" : {
      "index" : {
        "number_of_shards" : "5",
        "number_of_replicas" : "1"
      }
    },
    "mappings" : {
      "_source" : {
        "enabled" : false
      },
      "properties" : {
        "created_at" : {
          "format" : "EEE MMM dd HH:mm:ss Z yyyy",
          "type" : "date"
        },
        "host_name" : {
          "type" : "keyword"
        }
      }
    },
    "aliases" : { }
}
```

-- Delete Template:
```
DELETE _template/template_name
```

-- Setup template default ( order: -1 mean lowest priority )
```
PUT _template/default
{
  "index_patterns": ["*"],
  "order": -1,
  "settings": {
    "number_of_shards": "5",
    "number_of_replicas": "1"
  }
}
```

-- Another example: 
```
PUT _template/security-auditlog
{
  "index_patterns": ["security-auditlog*"],
  "order": -1,
  "settings": {
    "number_of_shards": "1",
    "number_of_replicas": "1"
  }
}
```

-- template with policy
```
PUT _template/k8s_logs
{
  "index_patterns": [
    "k8s_logs_*"
  ],
  "settings": {
    "number_of_shards": 2,
    "number_of_replicas": 1,
    "opendistro.index_state_management.policy_id": "delete_index_older_than_10_days"
  }
}

```
