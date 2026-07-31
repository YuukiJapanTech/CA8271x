#!/bin/sh

echo "Content-Type: application/json"
echo ""

MACADDR=$(grep '^MAC CFG_ID_MAC_ADDRESS' /config/scfg.txt 2>/dev/null | cut -d= -f2 | tr -d ' ;')

# default
[ -z "$MACADDR" ] && MACADDR="00:00:00:00:00:00"

echo "{"
echo "  \"MacAddr\": \"$MACADDR\""
echo "}"

