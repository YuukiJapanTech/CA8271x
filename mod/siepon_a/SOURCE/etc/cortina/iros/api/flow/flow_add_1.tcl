# Add flow key (hash key) and flow action (hash action) with flow key type $FLOW_KEY_TYPE.
# Please update the following data.

#########################################
##### constant; DO NOT CHANGE BELOW #####

# ca_classifier_forward_flag_t
set CA_FORWARD_FLAG_DENY		0
set CA_FORWARD_FLAG_FE			1
set CA_FORWARD_FLAG_INTERFACE		2
set CA_FORWARD_FLAG_PORT		3
set CA_FORWARD_FLAG_TUNNEL		4
set CA_FORWARD_FLAG_NO_DROP		5

# ca_classifier_vlan_action_t
set CA_VLAN_ACTION_NOP			0
set CA_VLAN_ACTION_PUSH			1
set CA_VLAN_ACTION_POP			2
set CA_VLAN_ACTION_SWAP			3
set CA_VLAN_ACTION_SET			4

##### constant; DO NOT CHANGE ABOVE #####
#########################################

##### user-defined #####

# enum ca_flow_key_type_t, range 0~7
set FLOW_KEY_TYPE	0

# zero is static flow, non-zero is aging flow
set AGING_TIME		0

set KEY_IP_SA_0		0x01020304
set KEY_IP_SA_1		0x0
set KEY_IP_SA_2		0x0
set KEY_IP_SA_3		0x0
set KEY_IP_SA_LEN	32
set KEY_IP_SA_AFI	0

set KEY_IP_DA_0		0xc0000212
set KEY_IP_DA_1		0x0
set KEY_IP_DA_2		0x0
set KEY_IP_DA_3		0x0
set KEY_IP_DA_LEN	32
set KEY_IP_DA_AFI	0

set KEY_SRC_L4_PORT	1024
set KEY_DEST_L4_PORT	1232

set ACT_IP_SA_0		0x01020304
set ACT_IP_SA_1		0x0
set ACT_IP_SA_2		0x0
set ACT_IP_SA_3		0x0
set ACT_IP_SA_LEN	32
set ACT_IP_SA_AFI	0

set ACT_IP_DA_0		0xc0a80164
set ACT_IP_DA_1		0x0
set ACT_IP_DA_2		0x0
set ACT_IP_DA_3		0x0
set ACT_IP_DA_LEN	32
set ACT_IP_DA_AFI	0

set ACT_SRC_L4_PORT	1024
set ACT_DEST_L4_PORT	1024

### key

set outer_vlan [ ca_classifier_vlan_create ]
ca_classifier_vlan_set_tpid		$outer_vlan	0
ca_classifier_vlan_set_pri		$outer_vlan	0
ca_classifier_vlan_set_dei		$outer_vlan	0
ca_classifier_vlan_set_vid		$outer_vlan	0

set inner_vlan [ ca_classifier_vlan_create ]
ca_classifier_vlan_set_tpid		$inner_vlan	0
ca_classifier_vlan_set_pri		$inner_vlan	0
ca_classifier_vlan_set_dei		$inner_vlan	0
ca_classifier_vlan_set_vid		$inner_vlan	0

set key_ip_sa [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr		$ip		$KEY_IP_SA_0	0
ca_l3_ip_addr_set_ipv6_addr		$ip		$KEY_IP_SA_1	1
ca_l3_ip_addr_set_ipv6_addr		$ip		$KEY_IP_SA_2	2
ca_l3_ip_addr_set_ipv6_addr		$ip		$KEY_IP_SA_3	3
ca_ip_address_set_addr_len		$key_ip_sa	$KEY_IP_SA_LEN
ca_ip_address_set_afi			$key_ip_sa	$KEY_IP_SA_AFI
ca_ip_address_set_ip_addr		$key_ip_sa	$ip

set key_ip_da [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr		$ip		$KEY_IP_DA_0	0
ca_l3_ip_addr_set_ipv6_addr		$ip		$KEY_IP_DA_1	1
ca_l3_ip_addr_set_ipv6_addr		$ip		$KEY_IP_DA_2	2
ca_l3_ip_addr_set_ipv6_addr		$ip		$KEY_IP_DA_3	3
ca_ip_address_set_addr_len		$key_ip_da	$KEY_IP_DA_LEN
ca_ip_address_set_afi			$key_ip_da	$KEY_IP_DA_AFI
ca_ip_address_set_ip_addr		$key_ip_da	$ip

# L2 key
set l2_key [ ca_flow_key_l2_create ]
ca_flow_key_l2_set_o_lspid		$l2_key		0
ca_flow_key_l2_set_lspid		$l2_key		0
ca_flow_key_l2_set_mac_sa		$l2_key		[ ca_mac_addr_create 0x00 0x00 0x00 0x00 0x64 0x64 ]
ca_flow_key_l2_set_mac_da		$l2_key		[ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x01 ]
ca_flow_key_l2_set_outer_vlan		$l2_key		$outer_vlan
ca_flow_key_l2_set_inner_vlan		$l2_key		$inner_vlan

# L3 key
set l3_key [ ca_flow_key_l3_create ]
ca_flow_key_l3_set_ip_valid		$l3_key		1
ca_flow_key_l3_set_ip_version		$l3_key		4
ca_flow_key_l3_set_ip_protocol		$l3_key		0x11
ca_flow_key_l3_set_dscp			$l3_key		0
ca_flow_key_l3_set_ecn			$l3_key		0
ca_flow_key_l3_set_ip_sa		$l3_key		$key_ip_sa
ca_flow_key_l3_set_ip_da		$l3_key		$key_ip_da
ca_flow_key_l3_set_ip_ttl		$l3_key		0
ca_flow_key_l3_set_fragment		$l3_key		0
ca_flow_key_l3_set_icmp_type		$l3_key		0
ca_flow_key_l3_set_igmp_type		$l3_key		0
ca_flow_key_l3_set_hbh_header		$l3_key		0
ca_flow_key_l3_set_routing_header	$l3_key		0
ca_flow_key_l3_set_dest_opt_header	$l3_key		0

# L4 key
set l4_key [ ca_flow_key_l4_create ]
ca_flow_key_l4_set_src_l4_port		$l4_key		$KEY_SRC_L4_PORT
ca_flow_key_l4_set_dst_l4_port		$l4_key		$KEY_DEST_L4_PORT
ca_flow_key_l4_set_tcp_flags		$l4_key		0

set flow_key [ ca_flow_key_create ]
ca_flow_key_set_l2_key			$flow_key	$l2_key
ca_flow_key_set_l3_key			$flow_key	$l3_key
ca_flow_key_set_l4_key			$flow_key	$l4_key
ca_flow_key_set_sw_id			$flow_key	0x0000	0
ca_flow_key_set_sw_id			$flow_key	0x0000	1
ca_flow_key_set_sw_id			$flow_key	0x0000	2
ca_flow_key_set_sw_id			$flow_key	0x0000	3

### action

set act_ip_sa [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr		$ip		$ACT_IP_SA_0	0
ca_l3_ip_addr_set_ipv6_addr		$ip		$ACT_IP_SA_1	1
ca_l3_ip_addr_set_ipv6_addr		$ip		$ACT_IP_SA_2	2
ca_l3_ip_addr_set_ipv6_addr		$ip		$ACT_IP_SA_3	3
ca_ip_address_set_addr_len		$act_ip_sa	$ACT_IP_SA_LEN
ca_ip_address_set_afi			$act_ip_sa	$ACT_IP_SA_AFI
ca_ip_address_set_ip_addr		$act_ip_sa	$ip

set act_ip_da [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr		$ip		$ACT_IP_DA_0	0
ca_l3_ip_addr_set_ipv6_addr		$ip		$ACT_IP_DA_1	1
ca_l3_ip_addr_set_ipv6_addr		$ip		$ACT_IP_DA_2	2
ca_l3_ip_addr_set_ipv6_addr		$ip		$ACT_IP_DA_3	3
ca_ip_address_set_addr_len		$act_ip_da	$ACT_IP_DA_LEN
ca_ip_address_set_afi			$act_ip_da	$ACT_IP_DA_AFI
ca_ip_address_set_ip_addr		$act_ip_da	$ip

# dest

set dest [ ca_classifier_action_dest_create ]
ca_classifier_action_dest_set_drop	$dest		0
ca_classifier_action_dest_set_fe	$dest		1
ca_classifier_action_dest_set_intf	$dest		0
ca_classifier_action_dest_set_port	$dest		0
ca_classifier_action_dest_set_tunnel_id	$dest		0

# action options mask
set option_mask [ ca_flow_action_option_mask_create ]
ca_flow_action_option_mask_set_flow_id		$option_mask	0
ca_flow_action_option_mask_set_cos		$option_mask	0
ca_flow_action_option_mask_set_dscp		$option_mask	0
ca_flow_action_option_mask_set_inner_vlan_act	$option_mask	0
ca_flow_action_option_mask_set_inner_dot1p	$option_mask	0
ca_flow_action_option_mask_set_inner_tpid	$option_mask	0
ca_flow_action_option_mask_set_inner_dei	$option_mask	0
ca_flow_action_option_mask_set_outer_vlan_act	$option_mask	0
ca_flow_action_option_mask_set_outer_dot1p	$option_mask	0
ca_flow_action_option_mask_set_outer_tpid	$option_mask	0
ca_flow_action_option_mask_set_outer_dei	$option_mask	0
ca_flow_action_option_mask_set_mac_da		$option_mask	0
ca_flow_action_option_mask_set_mac_sa		$option_mask	0
ca_flow_action_option_mask_set_egress_pppoe_action	$option_mask	0
ca_flow_action_option_mask_set_ip_da		$option_mask	1
ca_flow_action_option_mask_set_ip_sa		$option_mask	1
ca_flow_action_option_mask_set_src_l4_port	$option_mask	1
ca_flow_action_option_mask_set_dst_l4_port	$option_mask	1
ca_flow_action_option_mask_set_sw_id		$option_mask	0

# action options

set options [ ca_flow_action_option_create ]
ca_flow_action_option_set_flow_id		$options	0
ca_flow_action_option_set_cos			$options	0
ca_flow_action_option_set_dscp			$options	0
ca_flow_action_option_set_inner_vlan_act	$options	$CA_VLAN_ACTION_NOP
ca_flow_action_option_set_inner_dot1p		$options	0
ca_flow_action_option_set_inner_tpid		$options	0
ca_flow_action_option_set_inner_dei		$options	0
ca_flow_action_option_set_inner_vid		$options	0
ca_flow_action_option_set_outer_vlan_act	$options	$CA_VLAN_ACTION_NOP
ca_flow_action_option_set_outer_dot1p		$options	0
ca_flow_action_option_set_outer_tpid		$options	0
ca_flow_action_option_set_outer_dei		$options	0
ca_flow_action_option_set_outer_vid		$options	0
ca_flow_action_option_set_mac_da		$options	[ ca_mac_addr_create 0x01 0x00 0x5e 0x00 0x00 0x00 ]
ca_flow_action_option_set_mac_sa		$options	[ ca_mac_addr_create 0x01 0x00 0x5e 0x00 0x00 0x00 ]
ca_flow_action_option_set_pppoe_session_id	$options	0
ca_flow_action_option_set_ip_da			$options	$act_ip_da
ca_flow_action_option_set_ip_sa			$options	$act_ip_sa
ca_flow_action_option_set_src_l4_port		$options	$ACT_SRC_L4_PORT
ca_flow_action_option_set_dst_l4_port		$options	$ACT_DEST_L4_PORT
ca_flow_action_option_set_sw_id			$options	0x0000	0
ca_flow_action_option_set_sw_id			$options	0x0000	1
ca_flow_action_option_set_sw_id			$options	0x0000	2
ca_flow_action_option_set_sw_id			$options	0x0000	3
ca_flow_action_option_set_masks			$options	$option_mask

set action [ ca_flow_action_create ]
ca_flow_action_set_forward		$action		$CA_FORWARD_FLAG_FE
ca_flow_action_set_dest			$action		$dest
ca_flow_action_set_options		$action		$options

### flow

set flow [ ca_flow_create ]
ca_flow_set_key_type			$flow		$FLOW_KEY_TYPE
ca_flow_set_key				$flow		$flow_key
ca_flow_set_actions			$flow		$action
ca_flow_set_aging_time			$flow		$AGING_TIME

set ret [ ca_flow_add 0 $flow ]
if {$ret != 0} {
	puts "ca_flow_add() is failed! (ret=$ret)"
} else {
	set flow_id [ ca_flow_get_index $flow ]
	puts "flow_id=$flow_id"
}

