#!/bin/sh

printf "Content-Type: application/json\r\n\r\n"

BootVer=$(fw_printenv CA8271_FW_BOOTVER 2>/dev/null | cut -d= -f2)
BootCRC=$(fw_printenv CA8271_FW_BOOTCRC 2>/dev/null | cut -d= -f2)
FirmVer=$(fw_printenv CA8271_FW_FWVER 2>/dev/null | cut -d= -f2)
FirmCRC=$(fw_printenv CA8271_FW_FWCRC 2>/dev/null | cut -d= -f2)

[ -z "$BootVer" ] && BootVer="0000"
[ -z "$BootCRC" ] && BootCRC="00000000"
[ -z "$FirmVer" ] && FirmVer="0000"
[ -z "$FirmCRC" ] && FirmCRC="00000000"

printf '{'
printf '"BootVer":"%s",' "$BootVer"
printf '"BootCRC":"%s",' "$BootCRC"
printf '"FirmVer":"%s",' "$FirmVer"
printf '"FirmCRC":"%s"' "$FirmCRC"
printf '}\n'

