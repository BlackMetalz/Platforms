#!/bin/bash
# Author: kienlt
# used for check mk
if grep -q "nameserver 192.168.23.63" /etc/resolv.conf; then
        echo "DNS Kafka OK"
        exit 0
else
        echo "DNS Kafka not found"
        exit 2
fi
