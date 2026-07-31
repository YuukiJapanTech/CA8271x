#!/bin/sh

echo "Content-Type: text/html"
echo ""

read POST_DATA

PASS1=$(echo "$POST_DATA" | sed -n 's/.*pass1=\([^&]*\).*/\1/p')
PASS2=$(echo "$POST_DATA" | sed -n 's/.*pass2=\([^&]*\).*/\1/p')

decode() {
    local s="$1"
    s=$(echo "$s" | sed 's/+/ /g')
    printf '%b' "${s//%/\\x}"
}

PASS1=$(decode "$PASS1")
PASS2=$(decode "$PASS2")

if [ -z "$PASS1" ] || [ -z "$PASS2" ]; then
    echo "Password empty"
    exit 1
fi

if [ "$PASS1" != "$PASS2" ]; then
    echo "Password mismatch"
    exit 1
fi

HASH=$(openssl passwd -crypt "$PASS1")

HTPASSWD="/script/web/www/.htpasswd"

printf "admin:%s\n" "$HASH" > "$HTPASSWD"

chmod 600 "$HTPASSWD"

echo "Password updated"

