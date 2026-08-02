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

info=$(urldecode "$(get_param info)")

[ "${#info}" -le 64 ] ||
    fail_request "400 Bad Request" "Invalid Manufacture Info"
printf '%s' "$info" | LC_ALL=C grep -Eq '^[[:print:]]*$' ||
    fail_request "400 Bad Request" "Invalid Manufacture Info"
case "$info" in
    *\"*) fail_request "400 Bad Request" "Invalid Manufacture Info" ;;
esac

escaped=$(printf '%s' "$info" | sed 's/[\\&/]/\\&/g')
if grep -q '^manu_info' "$CONFIG"; then
    sed -i "s/^manu_info.*/manu_info = \"${escaped}\";/" "$CONFIG" ||
        fail_request "500 Internal Server Error" "Save failed."
else
    printf 'manu_info = "%s";\n' "$info" >> "$CONFIG" ||
        fail_request "500 Internal Server Error" "Save failed."
fi

reply "200 OK" "Saved"
