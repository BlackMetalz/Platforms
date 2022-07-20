### Should read:
- http://blog.odoobiz.com/2021/09/elasticsearch-explained-trying-to.html
- https://stackoverflow.com/questions/60108662/scroll-contexts-are-left-open-and-they-never-get-deleted-or-expired-in-elasticse

Error: 
```
Trying to create too many scroll contexts. Must be less than or equal to: [500]. This limit can be set by changing the [search.max_open_scroll_context] setting.
```
- Increase scroll: Default is 500
```
PUT _cluster/settings
{
  "persistent": {
    "search.max_open_scroll_context": 1000
  }
}
```


- Check current max_open_scroll_context value:
```
GET _cluster/settings?include_defaults
```

- Check max_open_scroll_context in each node:
```
GET _nodes/stats
```
then see `max_open_scroll_context` value

- Check open context:
```
GET _nodes/stats/indices?filter_path=**.open_contexts
```
