
# common definition
source ../common/hashlite.tcl

# $hkey for hash key
source cfg_key_v4_lan2wan.tcl

# $hact for hash action
source cfg_action_v4_lan2wan.tcl

# add a hash
set rslt_hash_idx [ ca_uint32_create 0 ]
set ret [ ca_aal_hashlite_hash_add 0 $hkey $HM_L3_NEIGHBOR $hact $HL_ACTGRP_L3_GENERIC $HASHLITE_AGING_STATIC $rslt_hash_idx ]
if {$ret != 0} {
	puts "ca_aal_hashlite_hash_add() is failed! (ret=$ret)"
} else {
	set hash_idx [ ca_uint32_get $rslt_hash_idx ]
	puts "Hash is added to HashLite Engine."
	puts "hash_idx = $hash_idx"
}

