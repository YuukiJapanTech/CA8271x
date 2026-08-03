# Add flow key type (hash mask) of index $FLOW_KEY_TYPE.
# Please update the following data.

##### user-defined data #####

# enum ca_flow_key_type_t, range 0~7
set FLOW_KEY_TYPE	0

### key type; key mask

set outer_vlan_mask [ ca_classifier_vlan_mask_create ]
ca_classifier_vlan_mask_set_tpid	$outer_vlan_mask	0
ca_classifier_vlan_mask_set_vid		$outer_vlan_mask	0
ca_classifier_vlan_mask_set_dei		$outer_vlan_mask	0
ca_classifier_vlan_mask_set_pri		$outer_vlan_mask	0

set inner_vlan_mask [ ca_classifier_vlan_mask_create ]
ca_classifier_vlan_mask_set_tpid	$inner_vlan_mask	0
ca_classifier_vlan_mask_set_vid		$inner_vlan_mask	0
ca_classifier_vlan_mask_set_dei		$inner_vlan_mask	0
ca_classifier_vlan_mask_set_pri		$inner_vlan_mask	0

# L2 key mask
set l2_mask [ ca_flow_key_l2_mask_create ]
ca_flow_key_l2_mask_set_o_lspid		$l2_mask	0
ca_flow_key_l2_mask_set_lspid		$l2_mask	0
ca_flow_key_l2_mask_set_mac_sa		$l2_mask	0
ca_flow_key_l2_mask_set_mac_da		$l2_mask	0
ca_flow_key_l2_mask_set_outer_vlan	$l2_mask	$outer_vlan_mask
ca_flow_key_l2_mask_set_inner_vlan	$l2_mask	$inner_vlan_mask

# L3 key mask
set l3_mask [ ca_flow_key_l3_mask_create ]
ca_flow_key_l3_mask_set_ip_valid	$l3_mask	0
ca_flow_key_l3_mask_set_ip_version	$l3_mask	1
ca_flow_key_l3_mask_set_ip_protocol	$l3_mask	1
ca_flow_key_l3_mask_set_dscp		$l3_mask	0
ca_flow_key_l3_mask_set_ecn		$l3_mask	0
ca_flow_key_l3_mask_set_ip_sa		$l3_mask	1
ca_flow_key_l3_mask_set_ip_da		$l3_mask	1
ca_flow_key_l3_mask_set_fragment	$l3_mask	0
ca_flow_key_l3_mask_set_icmp_type	$l3_mask	0
ca_flow_key_l3_mask_set_igmp_type	$l3_mask	0
ca_flow_key_l3_mask_set_hbh_header	$l3_mask	0
ca_flow_key_l3_mask_set_routing_header	$l3_mask	0
ca_flow_key_l3_mask_set_dest_opt_header	$l3_mask	0
ca_flow_key_l3_mask_set_ip_ttl		$l3_mask	0

# L4 key mask
set l4_mask [ ca_flow_key_l4_mask_create ]
ca_flow_key_l4_mask_set_src_l4_port	$l4_mask	1
ca_flow_key_l4_mask_set_dst_l4_port	$l4_mask	1
ca_flow_key_l4_mask_set_tcp_flags	$l4_mask	0x0

set kmask [ ca_flow_key_mask_create ]
ca_flow_key_mask_set_sw_id		$kmask		0
ca_flow_key_mask_set_l2_keys		$kmask		0
ca_flow_key_mask_set_l2_mask		$kmask		$l2_mask
ca_flow_key_mask_set_l3_keys		$kmask		1
ca_flow_key_mask_set_l3_mask		$kmask		$l3_mask
ca_flow_key_mask_set_l4_keys		$kmask		1
ca_flow_key_mask_set_l4_mask		$kmask		$l4_mask

set flow_key_type [ ca_flow_key_type_config_create ]
ca_flow_key_type_config_set_key_type	$flow_key_type	$FLOW_KEY_TYPE
ca_flow_key_type_config_set_prio	$flow_key_type	0
ca_flow_key_type_config_set_key_mask	$flow_key_type	$kmask

set ret [ ca_flow_key_type_add 0 $flow_key_type ]
if {$ret != 0} {
        puts "ca_flow_key_type_add() is failed! (ret=$ret)"
} else {
	puts "flow_key_type $FLOW_KEY_TYPE is added succesfully!"
}

