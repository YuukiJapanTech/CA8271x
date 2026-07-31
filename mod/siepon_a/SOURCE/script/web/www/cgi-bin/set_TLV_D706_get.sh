#!/bin/sh

printf "Content-Type: application/json\r\n\r\n"

info=$(grep manu_info /etc/onu_manu_modle.ini 2>/dev/null | cut -d'"' -f2)

# default
[ -z "$info" ] && info=""

printf '{ "info": "%s" }\n' "$info"

