#!/bin/sh

printf "Content-Type: application/json\r\n\r\n"

year=$(fw_printenv CA8271_MANU_YEAR 2>/dev/null | cut -d= -f2)
Date=$(fw_printenv CA8271_MANU_MON 2>/dev/null | cut -d= -f2)


[ -z "$year" ] && year="0000"
[ -z "$Date" ] && Date="00"

printf '{'
printf '"year":"%s",' "$year"
printf '"Date":"%s"' "$Date"
printf '}\n'

