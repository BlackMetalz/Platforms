-- Close Index
```
POST /my-index-000001/_close
```

-- Increase priority. For an example. Give it high priority to make its recovery faster
```
PUT some_index
{
  "settings": {
    "index.priority": 10
  }
}
```

