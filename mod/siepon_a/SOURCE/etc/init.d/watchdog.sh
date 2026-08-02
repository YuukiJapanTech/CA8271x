#! /bin/sh
#
# chkconfig: - 27 46
# description: A software watchdog
#
# rc file author: Marc Merlin <marcsoft@merlins.org>
#                 Henning P. Schmiedehausen <hps@tanstaafl.de>

# Source function library.
. /etc/init.d/functions

[ -x /usr/sbin/watchdog -a -e /etc/watchdog.conf ] || exit 0

VERBOSE="no"
if [ -f /etc/sysconfig/watchdog ]; then
    . /etc/sysconfig/watchdog
fi

RETVAL=0
prog=watchdog
pidfile=/var/run/watchdog.pid
lockfile=/var/lock/subsys/watchdog

start() {

	echo -n "Starting $prog: "
	if [ -n "$(pidofproc $prog)" ]; then
		echo -n "$prog: already running "
		failure
		echo
		return 1
	fi
	if [ "$VERBOSE" = "yes" ]; then
	    /usr/sbin/${prog} -v
	else
	    /usr/sbin/${prog}
        fi
	RETVAL=$?
	[ $RETVAL -eq 0 ] && touch $lockfile
	[ $RETVAL -eq 0 ] && success
	[ $RETVAL -ne 0 ] && failure
	echo
	return $RETVAL
}

stop() {
	echo -n "Stopping $prog: "
	# We are forcing it to _only_ use -TERM as killproc could use
	# -KILL which would result in BMC timer not being set properly 
	# and reboot the box.
	killproc $prog -TERM
	RETVAL=$?
	[ $RETVAL -eq 0 ] && rm -f $lockfile $pidfile
	[ $RETVAL -eq 0 ] && success
	[ $RETVAL -ne 0 ] && failure
	echo
	return $RETVAL
}

restart() {
  	stop
	sleep 6
	start
}	

case "$1" in
  start)
  	start
	;;
  stop)
  	stop
	;;
  reload|restart)
  	restart
	;;
  condrestart)
    if [ -f $lockfile ]; then
		restart
    fi
    ;;
  status)
	status $prog
	RETVAL=$?
	;;
  *)
	echo $"Usage: $0 {start|stop|restart|status|condrestart}"
	exit 1
esac
