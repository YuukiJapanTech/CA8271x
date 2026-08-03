set device_id 0
set hash_type 0

# 0: wan2lan
# 1: lan2wan
set profile_id 1
set age 6
set mask_id 0
set ip_protocol 17


set hash_key [ aal_hash_key_create]
aal_hash_key_set_ip_protocol		$hash_key	17
aal_hash_key_set_ip_vld			$hash_key	1
aal_hash_key_set_ip_ver			$hash_key	0
aal_hash_key_set_ip_sa_0		$hash_key	0xc0a8010a
aal_hash_key_set_ip_da_0		$hash_key	0xc0a8640a
aal_hash_key_set_l4_sp_exact_range	$hash_key	0x3f
aal_hash_key_set_l4_dp_exact_range	$hash_key	0x3f

set hash_action [ aal_hash_action_create]
aal_hash_action_set_ip_sa_l_vld		$hash_action	1
aal_hash_action_set_ip_sa_0		$hash_action	0xc0a86401
aal_hash_action_set_l4_sp		$hash_action	0x64
aal_hash_action_set_l4_sp_vld		$hash_action	1
aal_hash_action_set_cache_ctrl		$hash_action	0
aal_hash_action_set_chk_msk_ptr		$hash_action	$mask_id

set hash_idx [ ca_uint32_create 0]
aal_hash_add $device_id $hash_key $hash_action $hash_type $age $mask_id $profile_id $hash_idx

set val [ ca_uint32_get $hash_idx]
puts $val

