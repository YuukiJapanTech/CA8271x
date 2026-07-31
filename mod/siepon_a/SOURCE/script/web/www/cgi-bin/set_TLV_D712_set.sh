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

model=$(urldecode "$(get_param model)")


if grep -q '^model' "$CONFIG"; then
    sed -i "s/^model.*/model = \"$model\";/" "$CONFIG"
else
    echo "model = \"$model\";" >> "$CONFIG"
fi

echo "Saved"

