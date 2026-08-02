## Add entry to DS-Lite table index 0
##
## 1. Setup Interface Table
## 2. Add hash into HashLite (NextHop)
## 3. Add LPM rule
## 4. Add hash into Hash (NAT)
##
## LAN-to-WAN, from port 1 to port 7
##   mac_sa = 00-c0-a8-12-34-56
##   mac_da = 00-13-25-00-00-02
##   v4_src = 192.168.1.10
##   v4_dest = 192.0.0.10
##   sport = 63
##   dport = 63
##   NO vid
## WAN2LAN, from port 0x7 to port 0x1
##   mac_sa = 00-c0-a8-ab-cd-ef
##   mac_da = 00-13-25-00-00-01
##   outer v6_src = 3001::1 (aftr)
##   outer v6_dest = 2001::1 (b4)
##   inner v4_src = 192.0.0.1
##   inner v4_dest = 192.168.1.10
##   sport = 63
##   dport = 63
##   NO vid
##
## DSLite entry 0:
##   b4_ip = 2001::1 (local)
##   aftr_ip = 3001::1 (peer)

set DSLITE_IDX		0

## common definition
source ../common/hashlite.tcl

## DS-Lite Table
set dsl_entry [ l3pe_dsl_tbl_entry_create ]

l3pe_dsl_tbl_entry_set_valid		$dsl_entry	1
l3pe_dsl_tbl_entry_set_mc		$dsl_entry	0
l3pe_dsl_tbl_entry_set_flwlabel		$dsl_entry	0
l3pe_dsl_tbl_entry_set_hoplimit_en	$dsl_entry	0
l3pe_dsl_tbl_entry_set_hoplimit		$dsl_entry	0
l3pe_dsl_tbl_entry_set_tc_en		$dsl_entry	0
l3pe_dsl_tbl_entry_set_tc		$dsl_entry	0
l3pe_dsl_tbl_entry_set_aftr_ip0		$dsl_entry	0x00000001
l3pe_dsl_tbl_entry_set_aftr_ip1		$dsl_entry	0x0
l3pe_dsl_tbl_entry_set_aftr_ip2		$dsl_entry	0x0
l3pe_dsl_tbl_entry_set_aftr_ip3		$dsl_entry	0x30010000
l3pe_dsl_tbl_entry_set_b4_ip0		$dsl_entry	0x00000001
l3pe_dsl_tbl_entry_set_b4_ip1		$dsl_entry	0x0
l3pe_dsl_tbl_entry_set_b4_ip2		$dsl_entry	0x0
l3pe_dsl_tbl_entry_set_b4_ip3		$dsl_entry	0x20010000

set ret [ ca_aal_dsl_add_by_idx 0 $dsl_entry $DSLITE_IDX ]
if {$ret != 0} {
	puts "ca_aal_dsl_add_by_idx() is failed. (ret=$ret)"
} else {
	puts "DS-Lite entry is added to index $DSLITE_IDX."
}

## HashLite (NextHop), upstream key/action
## Profile 14 is used, so $hlkey is MEANINGLESS.

set hlkey_useless [ aal_hash_key_create ]

set hlact [ aal_hash_action_create ]
aal_hash_action_set_ip_ttl_vld                  $hlact   1
aal_hash_action_set_ip_ttl_zero_discard_en      $hlact   1
aal_hash_action_set_ip_ttl_cmd                  $hlact   1
aal_hash_action_set_l3_egress_if_vld            $hlact   1
aal_hash_action_set_mac_da_vld                  $hlact   1
aal_hash_action_set_mac_da_0                    $hlact   0xef
aal_hash_action_set_mac_da_1                    $hlact   0xcd
aal_hash_action_set_mac_da_2                    $hlact   0xab
aal_hash_action_set_mac_da_3                    $hlact   0xa8
aal_hash_action_set_mac_da_4                    $hlact   0xc0
aal_hash_action_set_mac_da_5                    $hlact   0x00
aal_hash_action_set_mdata_w_vld_1               $hlact   0x3
aal_hash_action_set_mdata_w_1                   $hlact   [ expr $DSLITE_IDX + 48 ]
aal_hash_action_set_chk_msk_ptr                 $hlact   0
aal_hash_action_set_t5_ctrl_vld                 $hlact   1
aal_hash_action_set_t5_ctrl                     $hlact   0xf

set rslt_hashlite_idx [ ca_uint32_create 0 ]
set ret [ ca_aal_hashlite_hash_add 0 $hlkey_useless $HM_L3_NEIGHBOR $hlact $HL_ACTGRP_L3_GENERIC $HASHLITE_AGING_STATIC $rslt_hashlite_idx ]
if {$ret != 0} {
	puts "ca_aal_hashlite_hash_add() is failed! (ret=$ret)"
} else {
	set hashlite_idx [ ca_uint32_get $rslt_hashlite_idx ]
	puts "Hash is added to HashLite Engine."
	puts "hashlite_idx = $hashlite_idx"
}

## LPM, upstream rule
##   IP_DA 192.0.0.0/29
##   rst_ctrl 1
##   rst_idx 48

set lpm_entry [ lpm_tbl_entry_array_create 4 ]

# entry[0]
set lpm_0 [ lpm_tbl_entry_create ]
lpm_tbl_entry_set_data		$lpm_0	0xc0000000
lpm_tbl_entry_set_mask		$lpm_0	29
lpm_tbl_entry_set_attr		$lpm_0	0
lpm_tbl_entry_set_rst_idx	$lpm_0	$hashlite_idx
lpm_tbl_entry_set_rst_ctrl	$lpm_0	1
lpm_tbl_entry_set_valid		$lpm_0	1
lpm_tbl_entry_set_profile	$lpm_0	0

lpm_tbl_entry_array_set		$lpm_entry	$lpm_0	0

# entry[1]
set lpm_1 [ lpm_tbl_entry_create ]
lpm_tbl_entry_set_data		$lpm_1	0x00000000
lpm_tbl_entry_set_mask		$lpm_1	0
lpm_tbl_entry_set_attr		$lpm_1	0
lpm_tbl_entry_set_rst_idx	$lpm_1	0
lpm_tbl_entry_set_rst_ctrl	$lpm_1	0
lpm_tbl_entry_set_valid		$lpm_1	1
lpm_tbl_entry_set_profile	$lpm_1	0

lpm_tbl_entry_array_set		$lpm_entry	$lpm_1	1

# entry[2]
set lpm_2 [ lpm_tbl_entry_create ]
lpm_tbl_entry_set_data		$lpm_2	0x00000000
lpm_tbl_entry_set_mask		$lpm_2	0
lpm_tbl_entry_set_attr		$lpm_2	0
lpm_tbl_entry_set_rst_idx	$lpm_2	0
lpm_tbl_entry_set_rst_ctrl	$lpm_2	0
lpm_tbl_entry_set_valid		$lpm_2	1
lpm_tbl_entry_set_profile	$lpm_2	0

lpm_tbl_entry_array_set		$lpm_entry	$lpm_2	2

# entry[3]
set lpm_3 [ lpm_tbl_entry_create ]
lpm_tbl_entry_set_data		$lpm_3	0x00000000
lpm_tbl_entry_set_mask		$lpm_3	0
lpm_tbl_entry_set_attr		$lpm_3	0
lpm_tbl_entry_set_rst_idx	$lpm_3	0
lpm_tbl_entry_set_rst_ctrl	$lpm_3	0
lpm_tbl_entry_set_valid		$lpm_3	1
lpm_tbl_entry_set_profile	$lpm_3	0

lpm_tbl_entry_array_set		$lpm_entry	$lpm_3	3

# add the LPM entry
set rslt_lpm_idx [ ca_uint32_create 0 ]
set ret [ ca_aal_lpm_add 0 $lpm_entry $rslt_lpm_idx ]
if {$ret != 0} {
	puts "ca_aal_lpm_add() is failed. (ret=$ret)"
} else {
	set lpm_idx [ ca_uint32_get $rslt_lpm_idx ]
	puts "lpm_idx = $lpm_idx"
}

## Hash (NAT), upstream rule (do nothing now)
set hash_type 0
set profile_id 1
set age 7
set mask_id 0

set hash_key [ aal_hash_key_create]
aal_hash_key_set_ip_protocol            $hash_key       17
aal_hash_key_set_ip_vld                 $hash_key       1
aal_hash_key_set_ip_ver                 $hash_key       0
aal_hash_key_set_ip_sa_0                $hash_key       0xc0a8010a
aal_hash_key_set_ip_da_0                $hash_key       0xc0000001
aal_hash_key_set_l4_sp_exact_range      $hash_key       0x3f
aal_hash_key_set_l4_dp_exact_range      $hash_key       0x3f

set hash_action [ aal_hash_action_create]
aal_hash_action_set_ip_sa_l_vld         $hash_action    0
aal_hash_action_set_ip_sa_0             $hash_action    0xc0a86401
aal_hash_action_set_l4_sp               $hash_action    0x64
aal_hash_action_set_l4_sp_vld           $hash_action    0
aal_hash_action_set_cache_ctrl          $hash_action    1
aal_hash_action_set_chk_msk_ptr         $hash_action    $mask_id

set hash_idx [ ca_uint32_create 0]
aal_hash_add 0 $hash_key $hash_action $hash_type $age $mask_id $profile_id $hash_idx

set val [ ca_uint32_get $hash_idx]
puts "hash_idx = $val"



