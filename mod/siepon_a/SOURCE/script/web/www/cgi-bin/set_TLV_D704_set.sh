#!/bin/sh

CONFIG="/config/scfg.txt"

echo "Content-Type: text/html"
echo ""

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

echo "$JDECID" | grep -Eq '^[0-9A-Fa-f]{4}$' || { echo "Invalid JDECID"; exit 1; }
echo "$Model" | grep -Eq '^[0-9A-Fa-f]{4}$' || { echo "Invalid Model"; exit 1; }
echo "$Version" | grep -Eq '^[0-9A-Fa-f]{8}$' || { echo "Invalid Version"; exit 1; }

JDECID=$(echo "$JDECID" | tr 'a-f' 'A-F')
Model=$(echo "$Model" | tr 'a-f' 'A-F')
Version=$(echo "$Version" | tr 'a-f' 'A-F')

fw_setenv CA8271_CHIP_ID "$JDECID"
fw_setenv CA8271_CHIP_MODEL "$Model"

hex_array=$(echo "$Version" | sed 's/../0x&, /g' | sed 's/, $//')
formatted="{${hex_array}}"
if grep -q '^CHAR-ARRAY CFG_ID_HW_VERSION' "$CONFIG"; then
    sed -i "s/^CHAR-ARRAY CFG_ID_HW_VERSION.*/CHAR-ARRAY CFG_ID_HW_VERSION = ${formatted};/" "$CONFIG"
else
    echo "CHAR-ARRAY CFG_ID_HW_VERSION = ${formatted};" >> "$CONFIG"
fi

echo "Saved"

