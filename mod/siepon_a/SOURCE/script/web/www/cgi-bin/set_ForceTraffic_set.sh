#!/bin/sh

echo "Content-Type: text/html"
echo ""

# POST data get
read POSTDATA

# val collect
VALUE=$(echo "$POSTDATA" | sed -n 's/^ForceTraffic=\(.*\)$/\1/p')

if [ "$VALUE" = "Enable" ]; then
    fw_setenv CA8271_FORCE_TRAFFIC 1
elif [ "$VALUE" = "Disable" ]; then
    fw_setenv CA8271_FORCE_TRAFFIC 0
else
    echo "Invalid value"
    exit 1
fi

echo "Saved"


