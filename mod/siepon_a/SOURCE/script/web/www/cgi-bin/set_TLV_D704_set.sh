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

urldecode() {
  echo "$1" | sed 's/+/ /g; s/%3[Aa]/:/g; s/%2[Ff]/\//g'
}

get_param() {
  echo "$POSTDATA" | tr '&' '\n' | grep "^$1=" | cut -d= -f2
}

JDECID=$(urldecode "$(get_param JDECID)")
Model=$(urldecode "$(get_param Model)")
Version=$(urldecode "$(get_param Version)")

echo "$JDECID" | grep -Eq '^[0-9A-Fa-f]{4}$' ||
    fail_request "400 Bad Request" "Invalid JDECID"
echo "$Model" | grep -Eq '^[0-9A-Fa-f]{4}$' ||
    fail_request "400 Bad Request" "Invalid Model"
echo "$Version" | grep -Eq '^[0-9A-Fa-f]{8}$' ||
    fail_request "400 Bad Request" "Invalid Version"

JDECID=$(echo "$JDECID" | tr 'a-f' 'A-F')
Model=$(echo "$Model" | tr 'a-f' 'A-F')
Version=$(echo "$Version" | tr 'a-f' 'A-F')

if ! fw_setenv -s - <<EOF
CA8271_CHIP_ID $JDECID
CA8271_CHIP_MODEL $Model
EOF
then
    fail_request "500 Internal Server Error" "Save failed."
fi

hex_array=$(echo "$Version" | sed 's/../0x&, /g' | sed 's/, $//')
formatted="{${hex_array}}"
if grep -q '^CHAR-ARRAY CFG_ID_HW_VERSION' "$CONFIG"; then
    sed -i "s/^CHAR-ARRAY CFG_ID_HW_VERSION.*/CHAR-ARRAY CFG_ID_HW_VERSION = ${formatted};/" "$CONFIG" ||
        fail_request "500 Internal Server Error" "Save failed."
else
    echo "CHAR-ARRAY CFG_ID_HW_VERSION = ${formatted};" >> "$CONFIG" ||
        fail_request "500 Internal Server Error" "Save failed."
fi

reply "200 OK" "Saved"
