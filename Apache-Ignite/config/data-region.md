## Source: https://ignite.apache.org/docs/latest/memory-configuration/data-regions

### Overview
- Ignite uses the concept of data regions to control the amount of RAM available to a cache or a group of caches. 
- A data region is a logical extendable area in RAM in which cached data resides
- You can control the initial size of the region and the maximum size it can occupy.
- By default, there is one data region that can take up to 20% of RAM available to the node and all caches you create are placed in that region
- but you can add as many regions as you want. There are a couple of reasons why you may want to have multiple regions:
  + Regions allow you to configure the amount of RAM available to a cache or number of caches
  + Persistence parameters are configured per region. If you want to have both in-memory only caches and the caches that store their content to disk, you need to configure two (or more) 
    data regions with different persistence settings: one for in-memory caches and one for persistent caches
  + Some memory parameters, such as eviction policies, are configured per data region.


#### Configuring Default Data Region
By default, a new cache is added to the default data region. If you want to change the properties of the default data region, you can do so in the data storage configuration.

```
<bean class="org.apache.ignite.configuration.IgniteConfiguration" id="ignite.cfg">
    <property name="dataStorageConfiguration">
        <bean class="org.apache.ignite.configuration.DataStorageConfiguration">
            <!--
            Default memory region that grows endlessly. Any cache will be bound to this memory region
            unless another region is set in the cache's configuration.
            -->
            <property name="defaultDataRegionConfiguration">
                <bean class="org.apache.ignite.configuration.DataRegionConfiguration">
                    <property name="name" value="Default_Region"/>
                    <!-- 100 MB memory region with disabled eviction. -->
                    <property name="initialSize" value="#{100 * 1024 * 1024}"/>
                </bean>
            </property>
        </bean>
    </property>
    <!-- other properties -->
</bean>
```

####
In addition to the default data region, you can add more data regions with custom settings. In the following example, 
we configure a data region that can take up to 40 MB and uses the Random-2-LRU eviction policy. Note that further below in the configuration, 
we create a cache that resides in the new data region.

```

<bean class="org.apache.ignite.configuration.IgniteConfiguration" id="ignite.cfg">
    <property name="dataStorageConfiguration">
        <bean class="org.apache.ignite.configuration.DataStorageConfiguration">
            <!--
            Default memory region that grows endlessly. Any cache will be bound to this memory region
            unless another region is set in the cache's configuration.
            -->
            <property name="defaultDataRegionConfiguration">
                <bean class="org.apache.ignite.configuration.DataRegionConfiguration">
                    <property name="name" value="Default_Region"/>
                    <!-- 100 MB memory region with disabled eviction. -->
                    <property name="initialSize" value="#{100 * 1024 * 1024}"/>
                </bean>
            </property>
            <property name="dataRegionConfigurations">
                <list>
                    <!--
                    40MB memory region with eviction enabled.
                    -->
                    <bean class="org.apache.ignite.configuration.DataRegionConfiguration">
                        <property name="name" value="40MB_Region_Eviction"/>
                        <!-- Memory region of 20 MB initial size. -->
                        <property name="initialSize" value="#{20 * 1024 * 1024}"/>
                        <!-- Maximum size is 40 MB. -->
                        <property name="maxSize" value="#{40 * 1024 * 1024}"/>
                        <!-- Enabling eviction for this memory region. -->
                        <property name="pageEvictionMode" value="RANDOM_2_LRU"/>
                    </bean>
                </list>
            </property>
        </bean>
    </property>
    <property name="cacheConfiguration">
        <list>
            <!-- Cache that is mapped to a specific data region. -->
            <bean class="org.apache.ignite.configuration.CacheConfiguration">

                <property name="name" value="SampleCache"/>
                <!--
                Assigning the cache to the `40MB_Region_Eviction` region.
                -->
                <property name="dataRegionName" value="40MB_Region_Eviction"/>
            </bean>
        </list>
    </property>
    <!-- other properties -->
</bean>
```

#### Cache Warm-Up Strategy
Ignite does not require you to warm memory up from disk on restarts. As soon as a cluster is inter-connected, your application can query and compute on it. 
At the same time, the memory warm-up feature is designed for low-latency applications that prefer data being loaded in memory before it can be queried.

```
<bean class="org.apache.ignite.configuration.IgniteConfiguration">
    <property name="dataStorageConfiguration">
        <bean class="org.apache.ignite.configuration.DataStorageConfiguration">
            <property name="defaultWarmUpConfiguration">
                <bean class="org.apache.ignite.configuration.LoadAllWarmUpConfiguration"/>
            </property>
        </bean>
    </property>
</bean>
```

To warm up a specific data region, pass the configuration parameter LoadAllWarmUpStrategy to the DataStorageConfiguration#setWarmUpConfiguration as follows:

```
<bean class="org.apache.ignite.configuration.IgniteConfiguration">
<property name="dataStorageConfiguration">
    <property name="dataRegionConfigurations">
        <bean class="org.apache.ignite.configuration.DataRegionConfiguration">
            <property name="name" value="NewDataRegion"/>
            <property name="initialSize" value="#{100 * 1024 * 1024}"/>
            <property name="persistenceEnabled" value="true"/>
            <property name="warmUpConfiguration">
                <bean class="org.apache.ignite.configuration.LoadAllWarmUpConfiguration"/>
            </property>
        </bean>
    </property>
</property>
</bean>
```

To stop the warm-up for all data regions, pass the configuration parameter NoOpWarmUpConfiguration to the 
DataStorageConfiguration#setDefaultWarmUpConfiguration as follows:

```
<bean class="org.apache.ignite.configuration.IgniteConfiguration">
<property name="dataStorageConfiguration">
    <bean class="org.apache.ignite.configuration.DataStorageConfiguration">
        <property name="defaultWarmUpConfiguration">
            <bean class="org.apache.ignite.configuration.NoOpWarmUpConfiguration"/>
        </property>
    </bean>
</property>
</bean>
```

To stop the warm-up for a specific data region, pass the configuration parameter NoOpWarmUpStrategy to the 
DataStorageConfiguration#setWarmUpConfiguration as follows:
```
<bean class="org.apache.ignite.configuration.IgniteConfiguration">
<property name="dataStorageConfiguration">
    <property name="dataRegionConfigurations">
        <bean class="org.apache.ignite.configuration.DataRegionConfiguration">
            <property name="name" value="NewDataRegion"/>
            <property name="initialSize" value="#{100 * 1024 * 1024}"/>
            <property name="persistenceEnabled" value="true"/>
            <property name="warmUpConfiguration">
                <bean class="org.apache.ignite.configuration.NoOpWarmUpConfiguration"/>
            </property>
        </bean>
    </property>
</property>
</bean>
```

You can also stop the cache warm-up by using control.sh and JMX.

To stop the warm-up using control.sh:

```
control.sh --warm-up --stop --yes
```

To stop the warm-up using JMX, use the method:
```
org.apache.ignite.mxbean.WarmUpMXBean#stopWarmUp
```

