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

# val collect
VALUE=$(echo "$POSTDATA" | sed -n 's/^ForceTraffic=\(.*\)$/\1/p')

if [ "$VALUE" = "Enable" ]; then
    TRAFFIC=1
elif [ "$VALUE" = "Disable" ]; then
    TRAFFIC=0
else
    fail_request "400 Bad Request" "Invalid value"
fi

fw_setenv CA8271_FORCE_TRAFFIC "$TRAFFIC" ||
    fail_request "500 Internal Server Error" "Save failed."

reply "200 OK" "Saved"
