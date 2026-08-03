#!/bin/sh
### BEGIN INIT INFO
# Provides:          mountvirtfs
# Required-Start:
# Required-Stop:
# Default-Start:     S
# Default-Stop:
# Short-Description: Mount kernel virtual file systems.
# Description:       Mount initial set of virtual filesystems the kernel
#                    provides and that are required by everything.
### END INIT INFO

if [ -e /proc ] && ! [ -e /proc/mounts ]; then
  mount -t proc proc /proc
fi

if [ -e /sys ] && grep -q sysfs /proc/filesystems && ! [ -e /sys/class ]; then
  mount -t sysfs sysfs /sys
fi


check_dir()
{
	[ -d $1 ] && return 0
	mkdir -p $1
	[ -d $1 ] && return 0

	echo "check directory: $1 failed"
	return 2
}

mount_ubi_userdata()
{
	mtd_no=$1

	ubiattach -m ${mtd_no} || {
		echo "ubi attached failed: mtd=${mtd_no}"
		return 1
	}

	for ubidev in `find /sys/class/ubi -name "ubi*_*" -maxdepth 1`; do
		ubiname=`cat ${ubidev}/name`
		[ "${ubiname}" = "userdata" ] && break
		ubiname=""
	done

	[ -z "${ubiname}" ] && {
		echo 'no ubi volume named "userdata"'
		ubidetach -m ${mtd_no}
		return 1
	}

	ubidev=`echo ${ubidev} | sed 's#.*/##'`

	mount -n -t ubifs /dev/${ubidev} /overlay
}

mount_userdata()
{
	mtd_no=$1
	mount_already=`sed -n -e 's/#.*$//;/\/overlay/p' /etc/fstab`

	[ -z "$mount_already" ] && mount_ubi_userdata  ${mtd_no} || mount /overlay
}

detach_userdata()
{
	ubidetach -m $1
}

cleanup_dir()
{
	rm -rf $1/*
}

root_overlay()
{
	grep -q overlay /proc/filesystems || {
		echo 'Without overlayfs support'
		return 1
	}

	mtd_no=`sed -n -e '/user/s/mtd\([0-9]\)\{1,\}.*$/\1/p' /proc/mtd`
	[ -z "${mtd_no}" ] && {
		echo 'no mtd partition named "user"'
		return 1
	}

	check_dir /rom && check_dir /overlay || {
		echo 'rootfs overlay failed'
		return 1
	}

	mount_userdata ${mtd_no} && {
		check_dir "/overlay/upper" && check_dir "/overlay/work"  && cleanup_dir "/overlay/work" ||  {
			echo 'sanity check failed'
			umount /overlay
			false
		}
	} ||  {
		echo 'mount userdata failed'
		detach_userdata ${mtd_no}
		return  1
	}

	mount -n -t overlay overlay -o rw,noatime,lowerdir=/,upperdir=/overlay/upper,workdir=/overlay/work /mnt && {
		mount -n /proc -o noatime --move /mnt/proc && {
			pivot_root /mnt /mnt/rom  || {
				mount -n /mnt/proc -o noatime --move /proc
				false
			}
		} ||  {
			umount /mnt
			false
		}
	} || {
		umount /overlay
		detach_userdata ${mtd_no}
		return 1
	}

	mount -n /rom/dev -o noatime --move /dev && \
	mount -n /rom/sys -o noatime --move /sys && \
	mount -n /rom/overlay -o noatime --move /overlay
	return 0
}

root_overlay && echo 'overlayfs over rootfs successfully' || echo 'overlay over rootfs failed'

if ! [ -e /dev/zero ] && [ -e /dev ] && grep -q devtmpfs /proc/filesystems; then
  mount -n -t devtmpfs devtmpfs /dev
fi

if [ -e /sys/kernel/debug ] && grep -q debugfs /proc/filesystems; then
  mount -t debugfs debugfs /sys/kernel/debug
fi
