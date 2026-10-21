#!/bin/sh

CONFIG="/config/scfg.txt"

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

read POSTDATA

MACADDR=$(echo "$POSTDATA" | sed -n 's/^MacAddr=\(.*\)$/\1/p' | sed 's/%3[Aa]/:/g')

echo "$MACADDR" | grep -Eq '^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$' ||
    fail_request "400 Bad Request" "Invalid MAC address"

if grep -q '^MAC CFG_ID_MAC_ADDRESS' "$CONFIG"; then
    sed -i "s/^MAC CFG_ID_MAC_ADDRESS.*/MAC CFG_ID_MAC_ADDRESS = $MACADDR;/" "$CONFIG" ||
        fail_request "500 Internal Server Error" "Save failed."
else
    printf 'MAC CFG_ID_MAC_ADDRESS = %s;\n' "$MACADDR" >> "$CONFIG" ||
        fail_request "500 Internal Server Error" "Save failed."
fi

reply "200 OK" "Saved"
