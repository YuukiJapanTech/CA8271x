#!/bin/bash

ifconfig eth0 0.0.0.0
vconfig add eth0 100
ifconfig eth0.100 192.168.0.1
arp -s 192.168.0.100 00:00:00:00:00:64
