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

BootVer=$(urldecode "$(get_param BootVer)")
BootCRC=$(urldecode "$(get_param BootCRC)")
FirmVer=$(urldecode "$(get_param FirmVer)")
FirmCRC=$(urldecode "$(get_param FirmCRC)")

echo "$BootVer" | grep -Eq '^[0-9A-Fa-f]{4}$' ||
    fail_request "400 Bad Request" "Invalid BootVer"
echo "$BootCRC" | grep -Eq '^[0-9A-Fa-f]{8}$' ||
    fail_request "400 Bad Request" "Invalid BootCRC"
echo "$FirmVer" | grep -Eq '^[0-9A-Fa-f]{4}$' ||
    fail_request "400 Bad Request" "Invalid FirmVer"
echo "$FirmCRC" | grep -Eq '^[0-9A-Fa-f]{8}$' ||
    fail_request "400 Bad Request" "Invalid FirmCRC"

BootVer=$(echo "$BootVer" | tr 'a-f' 'A-F')
BootCRC=$(echo "$BootCRC" | tr 'a-f' 'A-F')
FirmVer=$(echo "$FirmVer" | tr 'a-f' 'A-F')
FirmCRC=$(echo "$FirmCRC" | tr 'a-f' 'A-F')

if ! fw_setenv -s - <<EOF
CA8271_FW_BOOTVER $BootVer
CA8271_FW_BOOTCRC $BootCRC
CA8271_FW_FWVER $FirmVer
CA8271_FW_FWCRC $FirmCRC
EOF
then
    fail_request "500 Internal Server Error" "Save failed."
fi

reply "200 OK" "Saved"
