#!/bin/sh

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

read POST_DATA

get_param() {
    echo "$POST_DATA" | tr '&' '\n' | grep "^$1=" | cut -d= -f2-
}

decode() {
    printf '%b' "$(printf '%s' "$1" | sed 's/+/ /g; s/%/\\x/g')"
}

PASS1=$(decode "$(get_param pass1)")
PASS2=$(decode "$(get_param pass2)")

[ -n "$PASS1" ] && [ "${#PASS1}" -le 32 ] ||
    fail_request "400 Bad Request" "Invalid password"
[ "$PASS1" = "$PASS2" ] ||
    fail_request "400 Bad Request" "Password mismatch"
printf '%s' "$PASS1" | LC_ALL=C grep -Eq '^[[:print:]]+$' ||
    fail_request "400 Bad Request" "Invalid password"

HASH=$(openssl passwd -crypt "$PASS1") ||
    fail_request "500 Internal Server Error" "Save failed."

HTPASSWD="/script/web/www/.htpasswd"
NEW_HTPASSWD="${HTPASSWD}.new.$$"
trap 'rm -f "$NEW_HTPASSWD"' EXIT HUP INT TERM

printf 'admin:%s\n' "$HASH" > "$NEW_HTPASSWD" &&
    chmod 600 "$NEW_HTPASSWD" &&
    mv "$NEW_HTPASSWD" "$HTPASSWD" ||
    fail_request "500 Internal Server Error" "Save failed."

trap - EXIT HUP INT TERM
reply "200 OK" "Saved"
