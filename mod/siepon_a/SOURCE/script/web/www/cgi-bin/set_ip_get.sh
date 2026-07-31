#!/bin/sh

echo "Content-Type: application/json"
echo ""

IP=$(grep -A2 "iface eth0" /etc/network/interfaces | grep address | awk '{print $2}')

printf '{ "IPAddr": "%s" }\n' "$IP"

