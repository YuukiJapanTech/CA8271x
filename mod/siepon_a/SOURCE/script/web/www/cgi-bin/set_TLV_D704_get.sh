#!/bin/sh

printf "Content-Type: application/json\r\n\r\n"

JDECID=$(fw_printenv CA8271_CHIP_ID 2>/dev/null | cut -d= -f2)
Model=$(fw_printenv CA8271_CHIP_MODEL 2>/dev/null | cut -d= -f2)


[ -z "$JDECID" ] && JDECID="0000"
[ -z "$Model" ] && Model="0000"

Version=$(grep '^CHAR-ARRAY CFG_ID_HW_VERSION' /config/scfg.txt 2>/dev/null | sed -n 's/.*{\(.*\)}.*/\1/p' | sed 's/0x//g; s/,//g; s/ //g')

# default
[ -z "$Version" ] && Version="01000000"

printf '{'
printf '"JDECID":"%s",' "$JDECID"
printf '"Model":"%s",' "$Model"
printf '"Version":"%s"' "$Version"
printf '}\n'

