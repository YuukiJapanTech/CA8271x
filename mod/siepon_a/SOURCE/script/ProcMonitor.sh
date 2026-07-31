#!/bin/sh

while true
do

PSList=$(ps ww)

THTTPD=$(echo "$PSList" | grep '/script/web/thttpd')
if [ -z "$THTTPD" ]; then
    echo "thttpd not detect. target start..."
    /lib230/ld.so.1 --library-path /lib230 /script/web/thttpd -C /script/web/thttpd.conf -p 80
fi

sleep 5

done

