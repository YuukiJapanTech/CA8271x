#!/bin/sh

printf "Content-Type: application/json\r\n\r\n"

VAL=$(fw_printenv CA8271_FORCE_BRIDGE 2>/dev/null | cut -d= -f2)
MACADDR=$(fw_printenv -n CA8271_FORCE_BRIDGE_MAC 2>/dev/null | cut -d= -f2)

# fallback
[ "$VAL" != "1" ] && VAL=0
[ -z "$MACADDR" ] && MACADDR="00:00:00:00:00:00"

printf '{'
printf '"CA8271_FORCE_BRIDGE":"%s",' "$VAL"
printf '"MacAddr":"%s"' "$MACADDR"
printf '}\n'

