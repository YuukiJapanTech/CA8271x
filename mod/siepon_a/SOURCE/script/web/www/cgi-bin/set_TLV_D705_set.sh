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

year=$(urldecode "$(get_param year)")
Date=$(urldecode "$(get_param Date)")

echo "$year" | grep -Eq '^[0-9A-Fa-f]{4}$' || { echo "Invalid year"; exit 1; }
echo "$Date" | grep -Eq '^[0-9A-Fa-f]{2}$' || { echo "Invalid Date"; exit 1; }

year=$(echo "$year" | tr 'a-f' 'A-F')
Date=$(echo "$Date" | tr 'a-f' 'A-F')

fw_setenv CA8271_MANU_YEAR "$year"
fw_setenv CA8271_MANU_MON "$Date"

echo "Saved"

