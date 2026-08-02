# add a hashmask with mac DA only for type1 hash

# Way 1: Add mask in source code aal_hash.c: like HASH_MASK_NAT to set profile 1
# in aal_hash_init(void) add line: HASH_MASK_TYPE1.mac_da = 0;

# /* LAN NAT profile */
# aal_hash_profile_t hash_profile_1 = {
#	.hit = {
#		{ TUPLE_TYPE_QOS,	&HASH_MASK_TYPE1, 1 },
#
# mask_id is based on the modification in the source code aal_hash.c. 
set mask_idx 2

#***** Way 2: BUT this need to add iros for aal_hash_profile_tuple_add() and aal_hash_profile_tuple_del()*****
# set hmask [ aal_hash_mask_create ]
# ca_hash_mask_unmask 0 $hmask
# aal_hash_mask_set_mac_da		$hmask	0x3f
# set rslt_mask_idx [ ca_uint32_create 0 ]
# set ret [ aal_mask_tbl_entry_add_iros 0 $hmask $rslt_mask_idx ]
# if {$ret != 0} {
#	puts "aal_mask_tbl_entry_add_iros() is failed! (ret=$ret)"
# } else {
#	set mask_idx [ ca_uint32_get $rslt_mask_idx ]
#	puts "Hashmask is added to Hash Engine."
#	puts "mask_idx = $mask_idx"
# }
# 

# ***** Also Need to add Profile 1 tuple type 1 with action group 2. Define a new action group and set it in Profile type1 hit


set hash_key [ aal_hash_key_create]
aal_hash_key_set_mac_da_0               $hash_key   0x02
aal_hash_key_set_mac_da_1               $hash_key   0x00
aal_hash_key_set_mac_da_2               $hash_key   0x00
aal_hash_key_set_mac_da_3               $hash_key   0x25
aal_hash_key_set_mac_da_4               $hash_key   0x13
aal_hash_key_set_mac_da_5               $hash_key   0x00

set hash_action [ aal_hash_action_create]
aal_hash_action_set_l4_sp		$hash_action	101
aal_hash_action_set_l4_sp_vld		$hash_action	1
aal_hash_action_set_chk_msk_ptr         $hash_action    $mask_idx

set hash_idx [ ca_uint32_create 0]
aal_hash_add 0 $hash_key $hash_action 1 7 $mask_idx 1 $hash_idx

set val [ ca_uint32_get $hash_idx]
puts $val

