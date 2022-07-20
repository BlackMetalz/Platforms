-- Use case for shrink split reindex api:

credit: https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-aliases.html :v 

after reindex / shrink / split: we can safely delete old index and still can access (original_index) it's by alias.

-- Add alias:
```
POST _aliases
{
  "actions": [
    {
      "add": {
        "index": "your_index",
        "alias": "your_alias"
      }
    }
  ]
}
```

-- Remove Alias:
```
POST /_aliases
{
  "actions" : [
    { "remove" : { "index" : "test1", "alias" : "alias1" } }
  ]
}
```
