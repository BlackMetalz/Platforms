- show statistic namespace like object

-- Credit: https://www.aerospike.com/docs/tools/asadm/user_guide

-- Show sets with static and grep GB ( for most set memory usage )
```
asadm -p 18000 -e "info set" |grep GB
```
