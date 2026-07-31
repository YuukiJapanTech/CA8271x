#!/bin/sh

CONFIG="/config/scfg.txt"

echo "Content-Type: text/html"
echo ""

# POST data get
read POSTDATA

# MacAddr get
MACADDR=$(echo "$POSTDATA" | sed -n 's/^MacAddr=\(.*\)$/\1/p')

# URL decode
MACADDR=$(echo "$MACADDR" | sed 's/%3A/:/g')

# MAC check
echo "$MACADDR" | grep -Eq '^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$'
if [ $? -ne 0 ]; then
    echo "Invalid MAC address"
    exit 1
fi

# write
if grep -q '^MAC CFG_ID_MAC_ADDRESS' "$CONFIG"; then
    sed -i "s/^MAC CFG_ID_MAC_ADDRESS.*/MAC CFG_ID_MAC_ADDRESS = $MACADDR;/" "$CONFIG"
else
    echo "MAC CFG_ID_MAC_ADDRESS = $MACADDR;" >> "$CONFIG"
fi

echo "Saved"

