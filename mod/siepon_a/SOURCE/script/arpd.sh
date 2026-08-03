#!/bin/sh

IP=$(grep -A2 "iface eth0" /etc/network/interfaces | grep address | awk '{print $2}')

echo "Sending Gratuitous ARP : $IP"

busybox.full arping -U -I eth0 -w 30 $IP >/dev/null 2>&1
busybox.full arping -A -I eth0 -c 5 $IP >/dev/null 2>&1

echo "ARP send done."

