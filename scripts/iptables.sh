#!/bin/sh
set -eo pipefail
set -x

IF_DOCKER=eth0
IP_DOCKER=`hostname -i`
IF_OPENVPN=$1
IP_OPENVPN=$4
IP_SSH_SERVER=172.17.0.1
PORT_SSH_SERVER=22

iptables -t nat -F POSTROUTING
iptables -t nat -A POSTROUTING --proto tcp --dport $PORT_SSH_SERVER -o $IF_DOCKER -j SNAT --to-source $IP_DOCKER
iptables -t nat -F PREROUTING
iptables -t nat -A PREROUTING -i $IF_OPENVPN --proto tcp -d $IP_OPENVPN --dport $PORT_SSH_SERVER -j DNAT --to-destination $IP_SSH_SERVER