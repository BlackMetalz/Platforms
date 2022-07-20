### Demo config
## - Other example: https://github.com/apache/ignite/blob/master/examples/config/example-default.xml
## - Basic config:
```
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="
       http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd">

    <bean id="grid.cfg" class="org.apache.ignite.configuration.IgniteConfiguration"/>

    <bean class="org.apache.ignite.spi.discovery.tcp.ipfinder.vm.TcpDiscoveryVmIpFinder">
    <property name="addresses">
         <list>
            <value>10.3.48.54</value>
            <value>10.3.48.56</value>
            <value>10.3.48.82</value>
         </list>
    </property>
    </bean>

</beans>
```

## - Good example:
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="
       http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd">
    <!--
        Alter configuration below as needed.
    -->

<bean class="org.apache.ignite.configuration.IgniteConfiguration">

    <property name="discoverySpi">
	    <bean class="org.apache.ignite.spi.discovery.tcp.TcpDiscoverySpi">
		<property name="ipFinder">
        		<bean class="org.apache.ignite.spi.discovery.tcp.ipfinder.vm.TcpDiscoveryVmIpFinder">
			    <property name="addresses">
			         <list>
			            <value>10.3.48.54</value>
			            <value>10.3.48.56</value>
			            <value>10.3.48.82</value>
			         </list>
			    </property>
		        </bean>
		</property>
	    </bean>
    </property>
    
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
</beans>
```


## - A little advance config
In this config. I did change port 47500 ( discovery ) --> 8100. Port 47100 ( communication ) -> 8101
```
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="
       http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd">

      <bean class="org.apache.ignite.configuration.IgniteConfiguration">
      <property name="discoverySpi">
            <bean class="org.apache.ignite.spi.discovery.tcp.TcpDiscoverySpi">
            <property name="localPort" value="8100"/>
            <property name="ipFinder">
                <bean class="org.apache.ignite.spi.discovery.tcp.ipfinder.vm.TcpDiscoveryVmIpFinder">
                    <property name="addresses">
                        <list>
                            <!--
                              Explicitly specifying address of a local node to let it start and
                              operate normally even if there is no more nodes in the cluster.
                              You can also optionally specify an individual port or port range.
                              -->
                            <!-- <value>1.2.3.4</value> -->
                            <!--
                              IP Address and optional port range of a remote node.
                              You can also optionally specify an individual port.
                              -->
                            <value>10.3.48.54:8100</value>
                            <value>10.3.48.56:8100</value>
                            <value>10.3.48.82:8100</value>
                        </list>
                    </property>
                </bean>
          </property>
          </bean>
          </property>


    <!--
    Explicitly configure TCP communication SPI changing local
    port number for the nodes from the first cluster.
    -->

    <property name="communicationSpi">
        <bean class="org.apache.ignite.spi.communication.tcp.TcpCommunicationSpi">
            <property name="localPort" value="8101"/>
        </bean>
    </property>
    
    </bean>
</beans>

```


