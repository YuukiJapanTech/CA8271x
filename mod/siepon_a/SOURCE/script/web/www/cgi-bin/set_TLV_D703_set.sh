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

BootVer=$(urldecode "$(get_param BootVer)")
BootCRC=$(urldecode "$(get_param BootCRC)")
FirmVer=$(urldecode "$(get_param FirmVer)")
FirmCRC=$(urldecode "$(get_param FirmCRC)")

echo "$BootVer" | grep -Eq '^[0-9A-Fa-f]{4}$' || { echo "Invalid BootVer"; exit 1; }
echo "$BootCRC" | grep -Eq '^[0-9A-Fa-f]{8}$' || { echo "Invalid BootCRC"; exit 1; }
echo "$FirmVer" | grep -Eq '^[0-9A-Fa-f]{4}$' || { echo "Invalid FirmVer"; exit 1; }
echo "$FirmCRC" | grep -Eq '^[0-9A-Fa-f]{8}$' || { echo "Invalid FirmCRC"; exit 1; }

BootVer=$(echo "$BootVer" | tr 'a-f' 'A-F')
BootCRC=$(echo "$BootCRC" | tr 'a-f' 'A-F')
FirmVer=$(echo "$FirmVer" | tr 'a-f' 'A-F')
FirmCRC=$(echo "$FirmCRC" | tr 'a-f' 'A-F')

fw_setenv CA8271_FW_BOOTVER "$BootVer"
fw_setenv CA8271_FW_BOOTCRC "$BootCRC"
fw_setenv CA8271_FW_FWVER "$FirmVer"
fw_setenv CA8271_FW_FWCRC "$FirmCRC"

echo "Saved"

