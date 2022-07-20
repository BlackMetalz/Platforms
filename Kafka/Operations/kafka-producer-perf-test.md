Command to run test:

```
kafka-producer-perf-test  --num-records 50000 --record-size 100 --throughput 100000 --producer-props acks=1 --topic topic-name-2-1-test-rep3-par3 --producer.config producer-perf.properties
```

producer-perf.properties content:
```
bootstrap.servers=1.2.3.4:9092
```


## Read more : https://titanwolf.org/Network/Articles/Article?AID=d367966a-68b3-49e1-96b2-a22f7b74bbbb 
## Or even search google with keyword: `kafka-producer-perf-test`
