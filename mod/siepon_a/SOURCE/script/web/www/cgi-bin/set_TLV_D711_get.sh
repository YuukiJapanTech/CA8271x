#!/bin/sh

printf "Content-Type: application/json\r\n\r\n"

HEX=$(fw_printenv CA8271_VEN_NAME 2>/dev/null | cut -d= -f2)

[ -z "$HEX" ] && HEX="0000000000000000000000000000"

HEX=$(echo "$HEX" | tr 'a-f' 'A-F')

ASCII=""

i=1
while [ $i -le ${#HEX} ]; do
    BYTE=$(printf '%s' "$HEX" | cut -c$i-$((i+1)))

    if [ "$BYTE" != "00" ]; then
        ASCII="${ASCII}$(printf "\\x$BYTE")"
    fi

    i=$((i+2))
done

ASCII_ESC=$(printf '%s' "$ASCII" | sed 's/\\/\\\\/g; s/"/\\"/g')

printf '{'
printf '"Name":"%s"' "$ASCII_ESC"
printf '}\n'

