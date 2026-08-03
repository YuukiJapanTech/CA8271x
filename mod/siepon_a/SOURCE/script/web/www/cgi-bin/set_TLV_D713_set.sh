#!/bin/sh

echo "Content-Type: text/html"
echo ""

read POSTDATA

urldecode() {
  echo "$1" | sed 's/+/ /g; s/%3[Aa]/:/g; s/%2[Ff]/\//g'
}

get_param() {
  echo "$POSTDATA" | tr '&' '\n' | grep "^$1=" | cut -d= -f2
}

HWVer=$(urldecode "$(get_param HWVer)")

HEX=$(printf '%s' "$HWVer" | hexdump -v -e '/1 "%02X"')

LEN=${#HEX}

if [ "$LEN" -gt 8 ]; then
    HEX=$(printf '%s' "$HEX" | cut -c1-8)
else
    PAD=$(( (8 - LEN) / 2 ))
    while [ $PAD -gt 0 ]; do
        HEX="${HEX}00"
        PAD=$((PAD - 1))
    done
fi

fw_setenv CA8271_HW_VER $HEX

echo "Saved"

