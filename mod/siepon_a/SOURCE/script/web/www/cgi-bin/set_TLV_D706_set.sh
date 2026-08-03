#!/bin/sh

CONFIG="/etc/onu_manu_modle.ini"

echo "Content-Type: text/html"
echo ""

read POSTDATA

urldecode() {
  echo "$1" | sed 's/+/ /g; s/%3[Aa]/:/g; s/%2[Ff]/\//g'
}

get_param() {
  echo "$POSTDATA" | tr '&' '\n' | grep "^$1=" | cut -d= -f2
}

info=$(urldecode "$(get_param info)")


if grep -q '^manu_info' "$CONFIG"; then
    sed -i "s/^manu_info.*/manu_info = \"$info\";/" "$CONFIG"
else
    echo "manu_info = \"$info\";" >> "$CONFIG"
fi

echo "Saved"

