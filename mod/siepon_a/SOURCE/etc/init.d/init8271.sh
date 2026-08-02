#!/bin/sh -e

case "$1" in
start)
        echo "Start CA8271 SYSTEM init ... "

        /script/liboam_patch.sh

        echo "done."
        ;;

stop)
        echo -n "Stop CA8271 ... "
        killall Background_API.sh
        killall liboam_patch.sh
        rm /tmp/lib/libca-oam.so.1.0.0
        echo "done."
        ;;
*)
        echo "Usage: /etc/init.d/8271init.sh {start|stop}"
        exit 1
        ;;
esac

exit 0


