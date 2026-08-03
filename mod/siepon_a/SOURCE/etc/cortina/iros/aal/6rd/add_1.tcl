## Add entry to 6RD table index 1
##
## 1. Setup Interface Table
## 2. Add hash into HashLite (NextHop)
## 3. Add LPM rule
## 4. Add hash into Hash (NAT)
##
## WAN2LAN, BR-to-CE, from port 0x7 to port 0x1
##   mac_sa = 00-c0-a8-ab-cd-ef
##   mac_da = 01-00-5e-00-00-01
##   outer v4_src = 192.0.0.1 (BR)
##   outer v4_dest = 239.0.0.1 (CE)
##   inner v6_src = 3001::c000:0001
##   inner v6_dest = ff38::ef00:0001
##   sport = 63
##   dport = 63
##   NO vid
##
## 6RD entry 0:
##   ce_ip = 239.0.0.1 (local)
##   br_ip = 192.0.0.1 (peer)
##   6rd_v6_prfx = ff38::/64
##   6rd_id_start = 1000
##   6rd_id_end = 60000
##   6rd_ingr_chk_en = 1
##   6rd_v6_prfx_len = 16
##   6rd_v4_msk_len = 8

set SIXRD_IDX		1

## common definition
source ../common/hashlite.tcl

## 6RD Table
set sixrd_entry [ l3pe_sixrd_tbl_entry_create ]

l3pe_sixrd_tbl_entry_set_valid		$sixrd_entry	1
l3pe_sixrd_tbl_entry_set_ingr_chk_en	$sixrd_entry	0
l3pe_sixrd_tbl_entry_set_br_only	$sixrd_entry	0
l3pe_sixrd_tbl_entry_set_ipsa_mtch	$sixrd_entry	0
l3pe_sixrd_tbl_entry_set_id_start	$sixrd_entry	1000
l3pe_sixrd_tbl_entry_set_id_end		$sixrd_entry	60000
l3pe_sixrd_tbl_entry_set_ttl_en		$sixrd_entry	1
l3pe_sixrd_tbl_entry_set_ttl		$sixrd_entry	40
l3pe_sixrd_tbl_entry_set_tos_en		$sixrd_entry	0
l3pe_sixrd_tbl_entry_set_tos		$sixrd_entry	0
l3pe_sixrd_tbl_entry_set_br_v4_ip	$sixrd_entry	0xc0000001
l3pe_sixrd_tbl_entry_set_v6_prfx	$sixrd_entry	0xff38000000000000
l3pe_sixrd_tbl_entry_set_v6_prfx_len	$sixrd_entry	16
l3pe_sixrd_tbl_entry_set_v4_msk_len	$sixrd_entry	8
l3pe_sixrd_tbl_entry_set_ce_v4_ip	$sixrd_entry	0xef000001

set ret [ ca_aal_sixrd_add_by_idx 0 $sixrd_entry $SIXRD_IDX ]
if {$ret != 0} {
	puts "ca_aal_sixrd_add_by_idx() is failed. (ret=$ret)"
} else {
	puts "6RD entry is added to index $SIXRD_IDX."
}

## HashLite (NextHop), upstream key/action
## Profile 14 is used, so $hlkey is MEANINGLESS.

set hlkey_useless [ aal_hash_key_create ]
aal_hash_key_set_ip_ver				$hlkey_useless	1

set hlact [ aal_hash_action_create ]
aal_hash_action_set_six_rd_ipda_ctrl_vld        $hlact   1
aal_hash_action_set_six_rd_ipda_from_v6         $hlact   1
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
aal_hash_action_set_mdata_w_1                   $hlact   [ expr $SIXRD_IDX + 32 ]
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

## 1st LPM, upstream CE-to-BR
##   IP_DA 3001::/16
##   rst_ctrl 1
##   rst_idx 32

set lpm_entry [ lpm_tbl_entry_array_create 4 ]

# entry[0]
set lpm_0 [ lpm_tbl_entry_create ]
lpm_tbl_entry_set_data		$lpm_0	0x30010000
lpm_tbl_entry_set_mask		$lpm_0	16
lpm_tbl_entry_set_attr		$lpm_0	1
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

# 2nd LPM rule, upstream CE-to-CE
##   IP_DA 2001::/16
##   rst_ctrl 1
##   rst_idx 32
set lpm_entry [ lpm_tbl_entry_array_create 4 ]

# entry[0]
set lpm_0 [ lpm_tbl_entry_create ]
lpm_tbl_entry_set_data		$lpm_0	0x20010000
lpm_tbl_entry_set_mask		$lpm_0	16
lpm_tbl_entry_set_attr		$lpm_0	1
lpm_tbl_entry_set_rst_idx	$lpm_0	$hashlite_idx
lpm_tbl_entry_set_rst_ctrl	$lpm_0	1
lpm_tbl_entry_set_valid		$lpm_0	1
lpm_tbl_entry_set_profile	$lpm_0	0

lpm_tbl_entry_array_set		$lpm_entry	$lpm_0	0

set rslt_lpm_idx [ ca_uint32_create 0 ]
set ret [ ca_aal_lpm_add 0 $lpm_entry $rslt_lpm_idx ]
if {$ret != 0} {
	puts "ca_aal_lpm_add() is failed. (ret=$ret)"
} else {
	set lpm_idx [ ca_uint32_get $rslt_lpm_idx ]
	puts "lpm_idx = $lpm_idx"
}


## Hash (NAT)
set hash_type 0
set profile_id 1
set age 7
set mask_id 1

# 1st Hash rule, upstream CE-to-BR
# do nothing, just for bypassing default rule
set hash_key [ aal_hash_key_create]
aal_hash_key_set_ip_protocol            $hash_key       17
aal_hash_key_set_ip_vld                 $hash_key       1
aal_hash_key_set_ip_ver                 $hash_key       1
aal_hash_key_set_ip_sa_0                $hash_key       0x00000001
aal_hash_key_set_ip_sa_1                $hash_key       0x0
aal_hash_key_set_ip_sa_2                $hash_key       0x0a000000
aal_hash_key_set_ip_sa_3                $hash_key       0x2001a801
aal_hash_key_set_ip_da_0                $hash_key       0x00000001
aal_hash_key_set_ip_da_1                $hash_key       0x0
aal_hash_key_set_ip_da_2                $hash_key       0x01000000
aal_hash_key_set_ip_da_3                $hash_key       0x30010000
aal_hash_key_set_l4_sp_exact_range      $hash_key       0x3f
aal_hash_key_set_l4_dp_exact_range      $hash_key       0x3f

set hash_action [ aal_hash_action_create]
aal_hash_action_set_ip_sa_l_vld         $hash_action    0
aal_hash_action_set_ip_sa_0             $hash_action    0xc0a8010a
aal_hash_action_set_l4_sp               $hash_action    0x3f
aal_hash_action_set_l4_sp_vld           $hash_action    0
aal_hash_action_set_cache_ctrl          $hash_action    1
aal_hash_action_set_chk_msk_ptr         $hash_action    $mask_id

set hash_idx [ ca_uint32_create 0]
aal_hash_add 0 $hash_key $hash_action $hash_type $age $mask_id $profile_id $hash_idx

set val [ ca_uint32_get $hash_idx]
puts "hash_idx = $val"

# 2nd Hash rule, upstream CE-to-CE
# do nothing, just for bypassing default rule
set hash_key [ aal_hash_key_create]
aal_hash_key_set_ip_protocol            $hash_key       17
aal_hash_key_set_ip_vld                 $hash_key       1
aal_hash_key_set_ip_ver                 $hash_key       1
aal_hash_key_set_ip_sa_0                $hash_key       0x00000001
aal_hash_key_set_ip_sa_1                $hash_key       0x0
aal_hash_key_set_ip_sa_2                $hash_key       0x0a000000
aal_hash_key_set_ip_sa_3                $hash_key       0x2001a801
aal_hash_key_set_ip_da_0                $hash_key       0x00000001
aal_hash_key_set_ip_da_1                $hash_key       0x0
aal_hash_key_set_ip_da_2                $hash_key       0x0a000000
aal_hash_key_set_ip_da_3                $hash_key       0x2001a864
aal_hash_key_set_l4_sp_exact_range      $hash_key       0x3f
aal_hash_key_set_l4_dp_exact_range      $hash_key       0x3f

set hash_action [ aal_hash_action_create]
aal_hash_action_set_ip_sa_l_vld         $hash_action    0
aal_hash_action_set_ip_sa_0             $hash_action    0xc0a8010a
aal_hash_action_set_l4_sp               $hash_action    0x3f
aal_hash_action_set_l4_sp_vld           $hash_action    0
aal_hash_action_set_cache_ctrl          $hash_action    1
aal_hash_action_set_chk_msk_ptr         $hash_action    $mask_id

set hash_idx [ ca_uint32_create 0]
aal_hash_add 0 $hash_key $hash_action $hash_type $age $mask_id $profile_id $hash_idx

set val [ ca_uint32_get $hash_idx]

# 1st Hash rule, downstream BR-to-CE
# do nothing, just for bypassing default rule
set hash_key [ aal_hash_key_create]
aal_hash_key_set_ip_protocol            $hash_key       17
aal_hash_key_set_ip_vld                 $hash_key       1
aal_hash_key_set_ip_ver                 $hash_key       1
aal_hash_key_set_ip_sa_0                $hash_key       0x00000001
aal_hash_key_set_ip_sa_1                $hash_key       0x0
aal_hash_key_set_ip_sa_2                $hash_key       0x01000000
aal_hash_key_set_ip_sa_3                $hash_key       0x30010000
aal_hash_key_set_ip_da_0                $hash_key       0x00000001
aal_hash_key_set_ip_da_1                $hash_key       0x0
aal_hash_key_set_ip_da_2                $hash_key       0x0a000000
aal_hash_key_set_ip_da_3                $hash_key       0x2001a801
aal_hash_key_set_l4_sp_exact_range      $hash_key       0x3f
aal_hash_key_set_l4_dp_exact_range      $hash_key       0x3f

set hash_action [ aal_hash_action_create]
aal_hash_action_set_ip_sa_l_vld         $hash_action    0
aal_hash_action_set_ip_sa_0             $hash_action    0xc0a8010a
aal_hash_action_set_l4_sp               $hash_action    0x3f
aal_hash_action_set_l4_sp_vld           $hash_action    0
aal_hash_action_set_cache_ctrl          $hash_action    1
aal_hash_action_set_chk_msk_ptr         $hash_action    $mask_id

set hash_idx [ ca_uint32_create 0]
aal_hash_add 0 $hash_key $hash_action $hash_type $age $mask_id $profile_id $hash_idx

set val [ ca_uint32_get $hash_idx]

# 2nd Hash rule, downstream CE-to-CE
# do nothing, just for bypassing default rule
set hash_key [ aal_hash_key_create]
aal_hash_key_set_ip_protocol            $hash_key       17
aal_hash_key_set_ip_vld                 $hash_key       1
aal_hash_key_set_ip_ver                 $hash_key       1
aal_hash_key_set_ip_sa_0                $hash_key       0x00000001
aal_hash_key_set_ip_sa_1                $hash_key       0x0
aal_hash_key_set_ip_sa_2                $hash_key       0x0a000000
aal_hash_key_set_ip_sa_3                $hash_key       0x2001a864
aal_hash_key_set_ip_da_0                $hash_key       0x00000001
aal_hash_key_set_ip_da_1                $hash_key       0x0
aal_hash_key_set_ip_da_2                $hash_key       0x0a000000
aal_hash_key_set_ip_da_3                $hash_key       0x2001a801
aal_hash_key_set_l4_sp_exact_range      $hash_key       0x3f
aal_hash_key_set_l4_dp_exact_range      $hash_key       0x3f

set hash_action [ aal_hash_action_create]
aal_hash_action_set_ip_sa_l_vld         $hash_action    0
aal_hash_action_set_ip_sa_0             $hash_action    0xc0a8010a
aal_hash_action_set_l4_sp               $hash_action    0x3f
aal_hash_action_set_l4_sp_vld           $hash_action    0
aal_hash_action_set_cache_ctrl          $hash_action    1
aal_hash_action_set_chk_msk_ptr         $hash_action    $mask_id

set hash_idx [ ca_uint32_create 0]
aal_hash_add 0 $hash_key $hash_action $hash_type $age $mask_id $profile_id $hash_idx

set val [ ca_uint32_get $hash_idx]
puts "hash_idx = $val"

