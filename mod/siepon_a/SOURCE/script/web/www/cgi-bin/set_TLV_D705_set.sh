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

read POSTDATA

urldecode() {
  echo "$1" | sed 's/+/ /g; s/%3[Aa]/:/g; s/%2[Ff]/\//g'
}

get_param() {
  echo "$POSTDATA" | tr '&' '\n' | grep "^$1=" | cut -d= -f2
}

year=$(urldecode "$(get_param year)")
Date=$(urldecode "$(get_param Date)")

echo "$year" | grep -Eq '^[0-9A-Fa-f]{4}$' ||
    fail_request "400 Bad Request" "Invalid year"
echo "$Date" | grep -Eq '^[0-9A-Fa-f]{2}$' ||
    fail_request "400 Bad Request" "Invalid Date"

year=$(echo "$year" | tr 'a-f' 'A-F')
Date=$(echo "$Date" | tr 'a-f' 'A-F')

if ! fw_setenv -s - <<EOF
CA8271_MANU_YEAR $year
CA8271_MANU_MON $Date
EOF
then
    fail_request "500 Internal Server Error" "Save failed."
fi

reply "200 OK" "Saved"
