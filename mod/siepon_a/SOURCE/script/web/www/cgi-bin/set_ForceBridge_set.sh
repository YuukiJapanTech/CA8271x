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
echo "$MACADDR" | grep -Eq '^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$' ||
    fail_request "400 Bad Request" "Invalid MAC address"

if [ "$VALUE" = "Enable" ]; then
    BRIDGE=1
elif [ "$VALUE" = "Disable" ]; then
    BRIDGE=0
else
    fail_request "400 Bad Request" "Invalid value"
fi

if ! fw_setenv -s - <<EOF
CA8271_FORCE_BRIDGE $BRIDGE
CA8271_FORCE_BRIDGE_MAC $MACADDR
EOF
then
    fail_request "500 Internal Server Error" "Save failed."
fi

reply "200 OK" "Saved"
