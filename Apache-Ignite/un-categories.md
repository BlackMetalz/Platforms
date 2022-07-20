## Source: 
- https://www.gridgain.com/resources/videos/introducing-apache-ignitetm
- https://www.gridgain.com/resources/videos/introducing-apache-ignite-part--2
- https://www.gridgain.com/resources/webinars/moving-apacher-ignitetm-production-initial-checklist
- 

# 1. In-Memory Data Grid

![image](https://user-images.githubusercontent.com/3434274/138856074-36db231a-8aea-4941-92cc-e90af79da91c.png)

# 2. Off-heap Memory

![image](https://user-images.githubusercontent.com/3434274/138856133-19b802c4-f517-4193-87ed-9fb8d937b672.png)

- evicted / expire object can be be figured to push down into DBMS
- off-heap memory, this mean it doesn't affected by heap of JVM, store objects outside of the heap to avoid garbage collection cycles
- there is a configuration that allow push data from on heap into off heap after a certain threshold or we can decide. It is really is a simple configuration

# 3. Cache APIs & Queries
![image](https://user-images.githubusercontent.com/3434274/138856343-93ef65eb-5de1-4273-ab45-60a9373c93f2.png)


# 4. SQL Support ( ANSI 99 )
![image](https://user-images.githubusercontent.com/3434274/138856580-08960b94-bb2b-42b6-ac58-f58fb2de9a9d.png)

- Without Ignite: Have a lof of logic that need to run on client side, have to do a full scan to bring all objects and work on the results
- With Ignite: Map Reduced job? Execute the query in the background. Shipout the query that we want to execute the sql query to each of these nodes, the result set is then gathered and then shipped back to us and we have that if we need to do join again and we benefit of the collocation of the data. 

# 5. Transactions
![image](https://user-images.githubusercontent.com/3434274/138858681-498d29dd-b18c-429a-a202-f36bc9302acf.png)

# 6. Continuous Queries
![image](https://user-images.githubusercontent.com/3434274/138859044-76a1eacc-aa2b-4367-95ec-e4d4c6ef2c6d.png)

# 7. Messaging & Events
![image](https://user-images.githubusercontent.com/3434274/138859385-580cc137-10f3-4481-a280-3e968c9685fa.png)

# 8. Web Session Clustering
![image](https://user-images.githubuser content.com/3434274/138859520-fbb7a53b-4fe2-4f64-92b5-955c519b39fe.png)

# 9. In-Memory Compute Grid
![image](https://user-images.githubusercontent.com/3434274/138859730-980bf303-8979-4cb6-b217-b0c02926e6fb.png)
- You set a check point / multiple check point, if job go crash on specific, you can resume from a check point
![image](https://user-images.githubusercontent.com/3434274/138860107-7282ff68-15bd-48e7-b33c-fe8172623e98.png)

Use case:
![image](https://user-images.githubusercontent.com/3434274/138860290-cba66775-f0c3-486b-bf26-086a19769e87.png)

![image](https://user-images.githubusercontent.com/3434274/138860498-6ed079a7-6ccd-465c-ba9d-26a89199f6c3.png)

Note: Distributing data we use an affinity keys for hashing operation so once we've got this key, lets say based on the ID then we will decide where the data will reside and again if there's any rebalancing, this will actually happen automatically in the background 

# 10. In-Memory Service Grid
![image](https://user-images.githubusercontent.com/3434274/138861704-e5349d7d-2a6f-44ca-bf6e-c0b2aafde717.png)


Singleton : nhỏ?

![image](https://user-images.githubusercontent.com/3434274/139018816-fc0d71e0-5879-4933-a9a9-c86788d1d64b.png)

# 11. Hadoop Accelerator: Map Reduce
![image](https://user-images.githubusercontent.com/3434274/139018974-c858e28f-0ee1-47cd-9c06-e0fb84bdba60.png)

# 12. Spark Intergration: Shared RDDs & Improved SQL
![image](https://user-images.githubusercontent.com/3434274/139019323-5ef3fd98-6ca7-41b8-b883-c3d87e9e3f7e.png)

# 13. In-Memory Data Fabric: Security
![image](https://user-images.githubusercontent.com/3434274/139019781-d5175123-12ae-4e7b-916f-795c9cb64127.png)






