#!/bin/sh

printf "Content-Type: application/json\r\n\r\n"

VAL=$(fw_printenv CA8271_REBOOT_BLOCK 2>/dev/null | cut -d= -f2)

# fallback
[ "$VAL" != "1" ] && VAL=0

printf '{"CA8271_REBOOT_BLOCK":"%s"}\n' "$VAL"

