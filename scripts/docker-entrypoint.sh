#!/bin/sh
set -eo pipefail

AUTH_FILE=/tmp/auth

SECRET=${SECRET:-"secret"}
CONFIG_URL=${CONFIG_URL:-"example.com/example.ovpn"}

echo $SECRET > $AUTH_FILE

wget -O /etc/ssl/certs/client.ovpn $CONFIG_URL

mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
     mknod /dev/net/tun c 10 200
fi

exec openvpn --config /etc/ssl/certs/client.ovpn --script-security 2 --up /usr/local/bin/iptables.sh