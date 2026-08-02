set hash_key [ aal_hash_key_create]
aal_hash_key_set_ip_protocol		$hash_key	17
aal_hash_key_set_ip_vld			$hash_key	1
aal_hash_key_set_ip_ver			$hash_key	0
aal_hash_key_set_ip_sa_0		$hash_key	0xc0a8010A
aal_hash_key_set_ip_da_0		$hash_key	0xc0a83c01
aal_hash_key_set_l4_sp_exact_range	$hash_key	0x3f
aal_hash_key_set_l4_dp_exact_range	$hash_key	0x3f

set hash_action [ aal_hash_action_create]
aal_hash_action_set_ip_sa_l_vld		$hash_action	1
aal_hash_action_set_ip_sa_0		$hash_action	0xc0a86401
aal_hash_action_set_l4_sp		$hash_action	100
aal_hash_action_set_l4_sp_vld		$hash_action	1

set hash_idx [ ca_uint32_create 0]
aal_hash_add 0 $hash_key $hash_action 0 7 0 1 $hash_idx

set val [ ca_uint32_get $hash_idx]
puts $val

