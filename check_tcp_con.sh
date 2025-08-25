#!/bin/bash

DEBUG=0
if [ $DEBUG -gt 0 ]
then
    exec 2>>/tmp/my.log
    set -x
fi

# Default path
SNMPWALKBIN=snmpwalk
WCBIN=wc

# Plugin defaults
COMMUNITY=public

print_usage() {
    echo ""
    echo "Usage: $(basename $0) <host_ip>,<port>"
    echo ""
}

IPADDRESS=$1
PORT=$2

SYSTEMNAME=$IPADDRESS

if [[ -z $SYSTEMNAME || -z $PORT || -z $IPADDRESS || -z $COMMUNITY ]]
then
    print_usage
    exit 3
fi

# Check status
CONNS=$($SNMPWALKBIN -On -c $COMMUNITY -v2c $IPADDRESS .1.3.6.1.2.1.6.13.1.3.$SYSTEMNAME.$PORT | $WCBIN -l)

echo "$CONNS"
exit
