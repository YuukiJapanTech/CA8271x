#!/bin/sh -x

# SPDX-License-Identifier: Apache-2.0
# Copyright 2020 IBM Corp.
# Source : https://amboar.github.io/notes/2020/01/21/ddconvnotrunc.html

set -eu

ARG_IF=
ARG_OF=
ARG_BS=
ARG_COUNT=
ARG_SKIP=
ARG_SEEK=
ARG_APPEND=
ARG_CONV_NOTRUNC=
DD=/bin/dd

for arg in "$@"
do
	case "$arg" in
		if=*)
			ARG_IF="${arg#*=}"
			;;
		of=*)
			ARG_OF="${arg#*=}"
			;;
		bs=*)
			ARG_BS="${arg#*=}"
			;;
		count=*)
			ARG_COUNT="${arg#*=}"
			;;
		skip=*)
			ARG_SKIP="${arg#*=}"
			;;
		seek=*)
			ARG_SEEK="${arg#*=}"
			;;
		conv=notrunc)
			ARG_CONV_NOTRUNC=1
			;;
		*)
			ARG_APPEND+="${arg#*=}"
			;;
	esac
done

# If conv=notrunc isn't supplied, invoke system dd
if [ -z "$ARG_CONV_NOTRUNC" ]
then
	exec $DD "$@"
fi

# If conv=notrunc is supplied and system dd supports it, invoke system dd
if $DD conv=notrunc < /dev/null > /dev/null 2> /dev/null
then
	exec $DD "$@"
fi

# Otherwise, emulate conv=notrunc support

# Examples:
#
# Inject foo into bar at offset 100:
#
# $ dd if=foo of=bar bs=1 seek=100 conv=notrunc
if [ "$ARG_IF" = "$ARG_OF" ]
then
	>&2 echo "Add support for self-modification"
	exit 1
fi

cleanup()
{
	rm -f $OF_FILE
}

filesize()
{
	# busybox stat(1) doesn't support --format=%s
	wc -c "$1" | awk '{print $1}'
}

trap cleanup EXIT

if [ -z "$ARG_OF" ]
then
	DATA_SOURCE=
else
	DATA_SOURCE='if='$ARG_OF
fi

# Intermediate output file
OF_FILE=$(mktemp)

# Generate the prefix
if [ -z "$ARG_SEEK" ]
then
	PREFIX_COUNT=
else
	PREFIX_COUNT='count='$ARG_SEEK
fi

if [ -z "$ARG_BS" ]
then
	PREFIX_BS=
else
	PREFIX_BS='bs='$ARG_BS
fi
$DD $DATA_SOURCE of="$OF_FILE" $PREFIX_BS $PREFIX_COUNT $ARG_APPEND
OF_UPDATE_OFF=$(filesize "$OF_FILE")

# Append the source data
if [ -z "$ARG_IF" ]
then
	cat >> "$OF_FILE"
else
	cat < "$ARG_IF" >> "$OF_FILE"
fi
OF_SUFFIX_OFF=$(filesize "$OF_FILE")

if [ -z "$ARG_OF" ]
then
	OF_SUFFIX_OFF=$(($OF_SUFFIX_OFF - $OF_UPDATE_OFF))
fi

# Append the suffix
$DD $DATA_SOURCE of="$OF_FILE" bs=1 skip=$OF_SUFFIX_OFF seek=$OF_SUFFIX_OFF $ARG_APPEND

mv "$OF_FILE" "$ARG_OF"

