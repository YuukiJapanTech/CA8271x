# This script is same as add_64k_hash_bidirection.tcl

# enable aal_debug for running aal_hash_crc_sw_hw_calc_check() in aal_hash.c
exec echo 0x20 > /proc/driver/cortina/aal/aal_debug
# This will print a lot of message.
# Suggestion: If you want to run this, please remove all printk in aal_hash_add() path in aal_hash.c
# 		And only print when (hw_crc32 != sw_crc32 || hw_crc16 != sw_crc16)
source add_64k_hash_bidirection.tcl
