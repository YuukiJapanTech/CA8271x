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

Name=$(urldecode "$(get_param Name)")

HEX=$(printf '%s' "$Name" | hexdump -v -e '/1 "%02X"')

LEN=${#HEX}

if [ "$LEN" -gt 28 ]; then
    HEX=$(printf '%s' "$HEX" | cut -c1-28)
else
    PAD=$(( (28 - LEN) / 2 ))
    while [ $PAD -gt 0 ]; do
        HEX="${HEX}00"
        PAD=$((PAD - 1))
    done
fi

fw_setenv CA8271_VEN_NAME $HEX

echo "Saved"

