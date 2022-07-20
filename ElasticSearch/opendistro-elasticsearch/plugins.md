# Credit: https://www.elastic.co/guide/en/elasticsearch/plugins/6.8/listing-removing-updating.html#_listing_plugins
- CD To ES Folder: `cd /usr/share/elasticsearch`

- Listing Plugin

```
bin/elasticsearch-plugin list
```

- Install new plugin:
+ From Zip File:
```
bin/elasticsearch-plugin install --batch file:///usr/share/elasticsearch/elasticsearch-analysis-vietnamese-7.6.1.zip
```
+ From ...
```
bin/elasticsearch-plugin install --batch analysis-icu
```

--batch for ignore some permission of java i guess

- Remove plugin
```
bin/elasticsearch-plugin remove [pluginname]
```

