#!/bin/sh

echo "Content-Type: text/html"
echo ""

read POST_DATA

IP=$(echo "$POST_DATA" | sed -n 's/.*IPAddr=\([^&]*\).*/\1/p')

IP=$(echo "$IP" | sed 's/+/ /g')
IP=$(printf '%b' "${IP//%/\\x}")

echo "$IP" | grep -Eq '^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})$'
if [ $? -ne 0 ]; then
    echo "Invalid IP"
    exit 1
fi

FILE="/etc/network/interfaces"

if grep -q "iface eth0" "$FILE"; then
    sed -i "/iface eth0/,/iface / s/^\s*address .*/    address $IP/" "$FILE"
else
    echo "eth0 not found"
    exit 1
fi

echo "saved. IP updated to $IP, Please reboot."

