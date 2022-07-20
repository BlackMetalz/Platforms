#!/bin/bash
# Author kienlt
HOST=$1
PORT=$2
PROTO_FD_MAX=$3
THRESHOLD_WARNING=$4
THRESHOLD_CRIT=$5


# Check asinfo is installed
if ! asinfo --version >/dev/null 2>&1; then
	echo "asinfo is not installed. Exit script now!"
	exit 2
fi

usage()
{	
	echo "Usage: ./aerospike_check_max_client host port proto_fd_max warning crit"
	echo "Example: ./aerospike_check_max_client 127.0.0.1 3000 10000 5000 9000"
}

# Check variables, if not set, exit
if [ -z "$1" ]; then
	echo "HOST is not set. Please enter Host"
	usage
	exit 1
elif [ -z "$2" ]; then
	echo "PORT is not set. Please enter Port"
	usage
	exit 1
elif [ -z "$3" ]; then
	echo "PROTO FD MAX is not set. Please check"
	usage
	exit 1
elif [ -z "$4" ]; then
	echo "Threshold for warning is not set. Please check"
	usage
	exit 1
elif [ -z "$5" ]; then
	echo "Threshold for crit is not set. Please check"
	usage
	exit 1
fi

# Check host and port connect able or not
if ! asinfo -p "$PORT" -h "$HOST" >/dev/null 2>&1; then
        echo "Not able to connect any cluster with $HOST:$PORT"
        exit 2
fi

# Get client connection number
CLIENT_CONNECTIONS=$(asinfo -p "$PORT" -h "$HOST" | grep -Eo 'client_connections=[0-9]+;' | grep -Eo '[0-9]+')

if [[ ( $CLIENT_CONNECTIONS -gt $THRESHOLD_WARNING && $THRESHOLD_CRIT -gt $CLIENT_CONNECTIONS) ]]; then
	echo "Too many client connections connect to node. Current client connections: $CLIENT_CONNECTIONS. Warning connections: $THRESHOLD_WARNING. Please take a look"
	exit 1
elif [[ $CLIENT_CONNECTIONS -gt $THRESHOLD_CRIT && $CLIENT_CONNECTIONS -gt $THRESHOLD_WARNING ]]; then
	echo "Client connection in critical state. Please check asap. Current client connections: $CLIENT_CONNECTIONS. Critical connections: $THRESHOLD_CRIT"
	exit 2
elif [[ ( $CLIENT_CONNECTIONS -gt $PROTO_FD_MAX ) ]]; then
	echo "Node Refused client connection. It is over $PROTO_FD_MAX. Current client connections: $CLIENT_CONNECTIONS"
	exit 2
else 
	echo "Client connection state is ok. Current client connections: $CLIENT_CONNECTIONS"
fi
