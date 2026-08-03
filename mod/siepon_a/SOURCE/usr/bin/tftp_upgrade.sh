#!/bin/bash

image_name=$1
server_ip=$2
num=$#

if [ ${num} -ne 2 ]
then
	echo "para error,correct format:sh /user/bin/tftp upgrade.sh image_name server_ip"
	exit
fi

ret=`tftp -gr ${image_name} ${server_ip}`

if [ $? -ne 0 ]
then
	echo "get image fail,please try again"	
	rm -rf ${image_name}
	exit
fi

echo "imge transmation ok,start upgrade"
usleep 10000
ca.upgrade -f ${image_name}
usleep 10000
if [ $? -eq 0 ]
then
	echo "upgrade success,start set img_active img_commit"
	commit=`fw_printenv img_commit`
	usleep 10000
	active=`fw_printenv img_active`
	usleep 10000
	if [ ${active} == "img_active=1" ]
	then
		`fw_setenv img_active 2`
		echo "set img_active 2"
	fi
	usleep 10000
	if [ ${commit} == "img_commit=1" ]
	then
		`fw_setenv img_commit 2`
		echo "set img_commit 2"		
	fi	
	usleep 10000
	if [ ${active} == "img_active=2" ]
	then
		`fw_setenv img_active 1`
		echo "set img_active 1"
	fi
	usleep 10000
	if [ ${commit} == "img_commit=2" ]
	then
		`fw_setenv img_commit 1`
		echo "set img_active 1"		
	fi
	usleep 10000
	rm -rf ${image_name}
	echo "start reboot"	
	usleep 100000
	reboot	
else 
	echo "upgrade fail"
	rm -rf ${image_name}
fi

