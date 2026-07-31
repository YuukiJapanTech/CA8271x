#!/bin/sh

printf "Content-Type: application/json\r\n\r\n"

model=$(grep model /etc/onu_manu_modle.ini 2>/dev/null | cut -d'"' -f2)

# default
[ -z "$model" ] && model=""

printf '{ "model": "%s" }\n' "$model"

