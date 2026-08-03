#!/bin/sh

echo "Content-Type: text/html"
echo ""

# POST data get
read POSTDATA

urldecode() {
  echo "$1" | sed 's/+/ /g; s/%3[Aa]/:/g; s/%2[Ff]/\//g'
}

get_param() {
  echo "$POSTDATA" | tr '&' '\n' | grep "^$1=" | cut -d= -f2
}

VALUE=$(urldecode "$(get_param ForceBridge)")
MACADDR=$(urldecode "$(get_param MacAddr)")

# MAC check
echo "$MACADDR" | grep -Eq '^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$'
if [ $? -ne 0 ]; then
    echo "Invalid MAC address"
    exit 1
fi

if [ "$VALUE" = "Enable" ]; then
    fw_setenv CA8271_FORCE_BRIDGE 1
elif [ "$VALUE" = "Disable" ]; then
    fw_setenv CA8271_FORCE_BRIDGE 0
else
    echo "Invalid value"
    exit 1
fi

fw_setenv CA8271_FORCE_BRIDGE_MAC $MACADDR

echo "Saved"

