#!/bin/sh

reply() {
    if [ "$1" != "200 OK" ]; then
        echo "Status: $1"
    fi
    echo "Content-Type: text/plain; charset=utf-8"
    echo "Cache-Control: no-store"
    echo ""
    echo "$2"
}

fail_request() {
    reply "$1" "$2"
    exit 1
}

read POST_DATA

IP=$(echo "$POST_DATA" | sed -n 's/.*IPAddr=\([^&]*\).*/\1/p' | sed 's/+/ /g')

echo "$IP" | grep -Eq '^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})$' ||
    fail_request "400 Bad Request" "Invalid IP"

FILE="/etc/network/interfaces"

awk '
    $1 == "iface" { in_eth0 = ($2 == "eth0") }
    in_eth0 && $1 == "address" { found = 1 }
    END { exit !found }
' "$FILE" || fail_request "500 Internal Server Error" "eth0 address not found"

sed -i '/^iface eth0 /,/^iface / s/^[[:space:]]*address .*/    address '"$IP"'/' "$FILE" ||
    fail_request "500 Internal Server Error" "Save failed."

reply "200 OK" "Saved"
