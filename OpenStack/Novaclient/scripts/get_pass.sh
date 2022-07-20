#!/bin/bash
# Usage ./get_pass instance_name
key='private/key/for/nova/client/location'

nova get-password $1 $key
