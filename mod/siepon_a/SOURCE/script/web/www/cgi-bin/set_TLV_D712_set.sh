#!/bin/sh

CONFIG="/etc/onu_manu_modle.ini"

reply() {
    if [ "$1" != "200 OK" ]; then
        echo "Status: $1"
    fi
    echo "Content-Type: text/plain; charset=utf-8"
    echo "Cache-Control: no-store"
    echo ""
    echo "$2"
}

fail_request() {
    reply "$1" "$2"
    exit 1
}

read POSTDATA

urldecode() {
    printf '%b' "$(printf '%s' "$1" | sed 's/+/ /g; s/%/\\x/g')"
}

get_param() {
    echo "$POSTDATA" | tr '&' '\n' | grep "^$1=" | cut -d= -f2-
}

model=$(urldecode "$(get_param model)")

[ "${#model}" -le 32 ] ||
    fail_request "400 Bad Request" "Invalid Model Number"
printf '%s' "$model" | LC_ALL=C grep -Eq '^[[:print:]]*$' ||
    fail_request "400 Bad Request" "Invalid Model Number"
case "$model" in
    *\"*) fail_request "400 Bad Request" "Invalid Model Number" ;;
esac

escaped=$(printf '%s' "$model" | sed 's/[\\&/]/\\&/g')
if grep -q '^model' "$CONFIG"; then
    sed -i "s/^model.*/model = \"${escaped}\";/" "$CONFIG" ||
        fail_request "500 Internal Server Error" "Save failed."
else
    printf 'model = "%s";\n' "$model" >> "$CONFIG" ||
        fail_request "500 Internal Server Error" "Save failed."
fi

reply "200 OK" "Saved"
