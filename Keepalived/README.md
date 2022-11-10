### Basic setup for keepalived service

#### Master:

##### File Location: /etc/keepalived/keepalived.conf

```
global_defs {
   router_id master_name
   vrrp _mcast_group4 234.10.10.10
}

vrrp_instance VIP_IP_123_321 {
    state MASTER
    interface eth0
    virtual_router_id 79
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass PASSWORD_GO_HERE
    }
    virtual_ipaddress {
       10.0.0.1/32  # VIP is 10.0.0.1
    }
}
```