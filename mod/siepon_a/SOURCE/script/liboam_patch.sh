#!/bin/sh

TARGET_LIB=libca-oam.so.1.0.0
LIB_BASE=/script/lib/libca-oam_base
LIB_PATH=/tmp/lib
ETC_PATH=/tmp/etc
IMGVER="21.04.21.1"
IMGINFO="xxxx.xxxx.xxxx.xxxx.xxxx.xxxx.xx"

patch_lib() {
        FILE=$LIB_PATH/$TARGET_LIB
        OFFSET=$1
        VALUE=$2
        LENGTH=$3

        if ! hex_check "$VALUE" "$LENGTH"; then
                echo "ERROR : Invalid VALUE ($VALUE)"
                return 1
        fi

        echo "Patch : TARGET-FILE=$FILE OFFSET=$OFFSET VALUE=$VALUE"
        printf "$(echo $VALUE | sed 's/../\\x&/g')" | busybox.full dd of="$FILE" bs=1 seek=$(($OFFSET)) conv=notrunc 2>/dev/null
}

hex_check(){
        VAL=$1
        LEN=$2
        case "$VAL" in
                ''|*[!0-9A-Fa-f]*)
                        return 1
                ;;
        esac
        [ "${#VAL}" -eq "$LEN" ]
}

echo 4 > /proc/sys/kernel/printk

echo "Stick check..."
mkdir $ETC_PATH
CIG=$(cat /proc/mtd | grep 'mfginfo' 2>/dev/null)
CIGXG=$(cat /proc/mtd | grep 'uboot-env2' 2>/dev/null)

if [ "$CIGXG" != "" ]; then
        echo "Stick is CIG XG-99S."
        echo "CIG XG-99S" > /tmp/stick
        cp /etc/fw_env.config.XG99S $ETC_PATH/fw_env.config
elif [ "$CIG" != "" ]; then
        echo "Stick is CIG XE-99S."
        echo "CIG XE-99S" > /tmp/stick
        cp /etc/fw_env.config.XE99S $ETC_PATH/fw_env.config
else
        echo "Stick is Hisence LTF726x-BH+"
        echo "Hisence LTF726x-BH+" > /tmp/stick
        cp /etc/fw_env.config.LTF7 $ETC_PATH/fw_env.config
fi

echo "ubootenv init..."
ENV_IMGVER0=$(fw_printenv -n img_version0 2>/dev/null)
ENV_IMGVER1=$(fw_printenv -n img_version1 2>/dev/null)
ENV_IMGINFO0=$(fw_printenv -n img_info0 2>/dev/null)
ENV_IMGINFO1=$(fw_printenv -n img_info1 2>/dev/null)

if [ "$ENV_IMGVER0" = "" ]; then
        echo "set img_version0 env."
        fw_setenv img_version0 $IMGVER
fi

if [ "$ENV_IMGVER1" = "" ]; then
        echo "set img_version1 env."
        fw_setenv img_version1 $IMGVER
fi

if [ "$ENV_IMGINFO0" = "" ]; then
        echo "set img_info0 env."
        fw_setenv img_info0 $IMGINFO
fi

if [ "$ENV_IMGINFO1" = "" ]; then
        echo "set img_info1 env."
        fw_setenv img_info1 $IMGINFO
fi

echo "ca-app path..."

mkdir $LIB_PATH
cp $LIB_BASE $LIB_PATH/$TARGET_LIB
chmod 755 $LIB_PATH/$TARGET_LIB

#FORCE_BRIDGE
ENV_FORCE_BRIDGE=$(fw_printenv -n CA8271_FORCE_BRIDGE 2>/dev/null || echo 0)
if [ "$ENV_FORCE_BRIDGE" = "1" ]; then
        patch_lib "0x78c4c" "ffff0234" "8"
        patch_lib "0x78c80" "5c006210" "8"
fi

#REBOOT_BLOCK
ENV_REBOOT_BLOCK=$(fw_printenv -n CA8271_REBOOT_BLOCK 2>/dev/null || echo 0)
if [ "$ENV_REBOOT_BLOCK" = "1" ]; then
        patch_lib "0x8a48c" "0800e00300000000" "16"
fi

#D7/0003
ENV_FW_BOOTVER=$(fw_printenv -n CA8271_FW_BOOTVER 2>/dev/null || echo 0000)
patch_lib "0x64654" $ENV_FW_BOOTVER "4"

ENV_FW_BOOTCRC=$(fw_printenv -n CA8271_FW_BOOTCRC 2>/dev/null || echo 00000000)
patch_lib "0x64658" ${ENV_FW_BOOTCRC:0:4} "4"
patch_lib "0x6465c" ${ENV_FW_BOOTCRC:4:4} "4"

ENV_FW_FWVER=$(fw_printenv -n CA8271_FW_FWVER 2>/dev/null || echo 0000)
patch_lib "0x6467c" ${ENV_FW_FWVER:0:2} "2"
patch_lib "0x64680" ${ENV_FW_FWVER:2:2} "2"

ENV_FW_FWCRC=$(fw_printenv -n CA8271_FW_FWCRC 2>/dev/null || echo 00000000)
patch_lib "0x64678" ${ENV_FW_FWCRC:0:4} "4"
patch_lib "0x6466c" ${ENV_FW_FWCRC:4:4} "4"

#D7/0004
ENV_CHIP_ID=$(fw_printenv -n CA8271_CHIP_ID 2>/dev/null || echo 0000)
patch_lib "0x64818" $ENV_CHIP_ID "4"

ENV_CHIP_MODEL=$(fw_printenv -n CA8271_CHIP_MODEL 2>/dev/null || echo 0000)
patch_lib "0x648a0" $ENV_CHIP_MODEL "4"

#D7/0005
ENV_MANU_YEAR=$(fw_printenv -n CA8271_MANU_YEAR 2>/dev/null || echo 0000)
patch_lib "0x64b18" ${ENV_MANU_YEAR:0:2} "2"
patch_lib "0x64b1c" ${ENV_MANU_YEAR:2:2} "2"

ENV_MANU_MON=$(fw_printenv -n CA8271_MANU_MON 2>/dev/null || echo 00)
patch_lib "0x64b04" $ENV_MANU_MON "2"

#D7/0011
ENV_VEN_NAME=$(fw_printenv -n CA8271_VEN_NAME 2>/dev/null || echo 0000000000000000000000000000)
patch_lib "0xb748c" $ENV_VEN_NAME "28"

#D7/0013
ENV_HW_VER=$(fw_printenv -n CA8271_HW_VER 2>/dev/null || echo 00000000)
patch_lib "0x65650" ${ENV_HW_VER:0:4} "4"
patch_lib "0x65648" ${ENV_HW_VER:4:4} "4"

iros <<EOF > /dev/null 2>&1
ca_port_enable_set 0 0x20007 0
EOF

echo "PON port disabled."

sleep 1

/etc/init.d/ca-app stop
usleep 500000
/etc/init.d/ca-app start

sleep 5

iros <<EOF > /dev/null 2>&1
wca_classifier_rule_delete_all
EOF

/script/ProcMonitor.sh &
/script/Background_API.sh &
/script/arpd.sh &
