#########################
#### Create CLS Data ####
#########################
#### create cls key
set key [ ca_classifier_key_create ]
set handle_key [ ca_classifier_handle_create ]
set l2_key [ ca_classifier_l2_create ]
set outer_vlan_key [ ca_classifier_vlan_create ]
set outer_vlan_key_max [ ca_classifier_vlan_create ]
set inner_vlan_key [ ca_classifier_vlan_create ]
set outer_vlan_range [ ca_classifier_vlan_range_create ]
set inner_vlan_range [ ca_classifier_vlan_range_create ]
set mac_sa_range [ ca_classifier_mac_addr_range_create ]
set mac_da_range [ ca_classifier_mac_addr_range_create ]
set ip_key [ ca_classifier_ip_create ]
set ip_address [ ca_ip_address_create ]
set ip_address_max [ ca_ip_address_create ]
set ip_da_address [ ca_ip_address_create ]
set ip_da_address_max [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
set ip_addr_max [ ca_l3_ip_addr_create ]
set ip_da_addr [ ca_l3_ip_addr_create ]
set ip_da_addr_max [ ca_l3_ip_addr_create ]
set l4_key [ ca_classifier_l4_create ]
set port_range_key [ ca_classifier_l4_port_range_create ]
set dst_port_range_key [ ca_classifier_l4_port_range_create ]
set ext_key [ ca_classifier_ext_create ]
#### create cls key mask
set key_mask [ ca_classifier_key_mask_create ]
set l2_mask [ ca_classifier_l2_mask_create ]
set vlan_mask [ ca_classifier_vlan_mask_create ]
set ivlan_mask [ ca_classifier_vlan_mask_create ]
set ip_mask [ ca_classifier_ip_mask_create ]
set l4_mask [ ca_classifier_l4_mask_create ]
#### create cls action
set action [ ca_classifier_action_create ]
set dest [ ca_classifier_action_dest_create ]
set options [ ca_classifier_action_option_create ]
set action_handle [ ca_classifier_handle_create ]
set action_mask [ ca_classifier_action_option_mask_create ]

#########################
####   Set CLS Key   ####
#########################
#### set orig_src_port
ca_classifier_key_set_orig_src_port $key 0x2

#### set src_port
ca_classifier_key_set_src_port $key 0x70019

#### set key_handle
ca_classifier_handle_set_llid_cos_index $handle_key 6
ca_classifier_key_set_key_handle $key $handle_key

#### set handle_type
ca_classifier_key_set_handle_type $key 2

#### set src_intf
ca_classifier_key_set_src_intf $key 1

#### set dst_intf
ca_classifier_key_set_dst_intf $key 1

#### set merge_prio
ca_classifier_key_set_merge_prio $key 1

#### set ingress_lan
ca_classifier_key_set_ingress_lan $key 1

#### set packet_length_low
ca_classifier_key_set_packet_length_low $key 128

#### set packet_length_high
ca_classifier_key_set_packet_length_high $key 1024

#### set ethertype
ca_classifier_l2_set_ethertype $l2_key 0x0800
#### set src mac
set mac_sa_min [ ca_mac_addr_create 0x5c 0x26 0x0a 0x76 0xb0 0xf1 ]
set mac_sa_max [ ca_mac_addr_create 0x5c 0x26 0x0a 0x76 0xb0 0xf1 ]
ca_classifier_mac_addr_range_set_mac_min $mac_sa_range $mac_sa_min
ca_classifier_mac_addr_range_set_mac_max $mac_sa_range $mac_sa_max
ca_classifier_l2_set_mac_sa $l2_key $mac_sa_range
#### set dst mac
set mac_da_min [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x02 ]
set mac_da_max [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x02 ]
ca_classifier_mac_addr_range_set_mac_min $mac_da_range $mac_da_min
ca_classifier_mac_addr_range_set_mac_max $mac_da_range $mac_da_max
ca_classifier_l2_set_mac_da $l2_key $mac_da_range
#### set is_multicast
ca_classifier_l2_set_is_multicast $l2_key 1
#### set is_length
ca_classifier_l2_set_is_length $l2_key 1
#### set cfm_opcode
ca_classifier_l2_set_cfm_opcode $l2_key 1
#### set ppp_proto
ca_classifier_l2_set_ppp_proto $l2_key 0xC021
#### set pppoe_session_id
ca_classifier_l2_set_pppoe_session_id $l2_key 0

#### set vlan count
ca_classifier_l2_set_vlan_count $l2_key 1

#### set outer vlan tpid
ca_classifier_vlan_set_tpid $outer_vlan_key 0x88a8
#### set outer vlan pri
ca_classifier_vlan_set_pri $outer_vlan_key 0
#### set outer vlan dei
ca_classifier_vlan_set_dei $outer_vlan_key 0
#### set outer vlan vid
ca_classifier_vlan_set_vid $outer_vlan_key 10

#### set outer vlan tpid
ca_classifier_vlan_set_tpid $outer_vlan_key_max 0x88a8
#### set outer vlan pri
ca_classifier_vlan_set_pri $outer_vlan_key_max 0
#### set outer vlan dei
ca_classifier_vlan_set_dei $outer_vlan_key_max 0
#### set outer vlan vid max
ca_classifier_vlan_set_vid $outer_vlan_key_max 100

ca_classifier_vlan_range_set_vlan_min $outer_vlan_range $outer_vlan_key
ca_classifier_vlan_range_set_vlan_max $outer_vlan_range $outer_vlan_key_max
ca_classifier_l2_set_vlan_otag $l2_key $outer_vlan_range

#### set inner vlan tpid
ca_classifier_vlan_set_tpid $inner_vlan_key 0x8100
#### set inner vlan pri
ca_classifier_vlan_set_pri $inner_vlan_key 3
#### set inner vlan dei
ca_classifier_vlan_set_dei $inner_vlan_key 0
#### set inner vlan vid
ca_classifier_vlan_set_vid $inner_vlan_key 99

ca_classifier_vlan_range_set_vlan_min $inner_vlan_range $inner_vlan_key
ca_classifier_vlan_range_set_vlan_max $inner_vlan_range $inner_vlan_key
ca_classifier_l2_set_vlan_itag $l2_key $inner_vlan_range

ca_classifier_key_set_l2 $key $l2_key

#### set ip_valid
ca_classifier_ip_set_ip_valid $ip_key 1
#### set ip_version
ca_classifier_ip_set_ip_version $ip_key 4
#### set ip_protocol
ca_classifier_ip_set_ip_protocol $ip_key 17
#### set dscp
ca_classifier_ip_set_dscp $ip_key 20
#### set ecn
ca_classifier_ip_set_ecn $ip_key 0
ca_classifier_key_set_ip $key $ip_key

#### set ip_sa_v4
ca_ip_address_set_afi $ip_address 0
ca_l3_ip_addr_set_ipv4_addr $ip_addr 0xc0a80164
ca_ip_address_set_addr_len $ip_address 32
#### set ip_sa_v6
##ca_ip_address_set_afi $ip_address 1
##ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x6000 0
##ca_l3_ip_addr_set_ipv6_addr $ip_addr 0 1
##ca_l3_ip_addr_set_ipv6_addr $ip_addr 0 2
##ca_l3_ip_addr_set_ipv6_addr $ip_addr 1 3
##ca_ip_address_set_addr_len $ip_address 128
ca_ip_address_set_ip_addr  $ip_address $ip_addr
ca_classifier_ip_set_ip_sa $ip_key $ip_address
#### set ip_sa_max_v4
ca_ip_address_set_afi $ip_address_max 0
ca_l3_ip_addr_set_ipv4_addr $ip_addr_max 0xc0a801c8
ca_ip_address_set_addr_len $ip_address_max 32
#### set ip_sa_v6
##ca_ip_address_set_afi $ip_address_max 1
##ca_l3_ip_addr_set_ipv6_addr $ip_addr_max 0x6000 0
##ca_l3_ip_addr_set_ipv6_addr $ip_addr_max 0 1
##ca_l3_ip_addr_set_ipv6_addr $ip_addr_max 0 2
##ca_l3_ip_addr_set_ipv6_addr $ip_addr_max 1 30
##ca_ip_address_set_addr_len $ip_address_max 128
ca_ip_address_set_ip_addr  $ip_address_max $ip_addr_max
ca_classifier_ip_set_ip_sa_max $ip_key $ip_address_max

#### set ip_da_v4
ca_ip_address_set_afi $ip_da_address 0
ca_l3_ip_addr_set_ipv4_addr $ip_da_addr 0xc0a86464
ca_ip_address_set_addr_len $ip_da_address 32
#### set ip_da_v6
##ca_ip_address_set_afi $ip_da_address 1
##ca_l3_ip_addr_set_ipv6_addr $ip_da_addr 0x3000 0
##ca_l3_ip_addr_set_ipv6_addr $ip_da_addr 0 1
##ca_l3_ip_addr_set_ipv6_addr $ip_da_addr 0 2
##ca_l3_ip_addr_set_ipv6_addr $ip_da_addr 1 3
##ca_ip_address_set_addr_len $ip_da_address 128
ca_ip_address_set_ip_addr  $ip_da_address $ip_da_addr
ca_classifier_ip_set_ip_da $ip_key $ip_da_address
#### set ip_da_max_v4
ca_ip_address_set_afi $ip_da_address_max 0
ca_l3_ip_addr_set_ipv4_addr $ip_da_addr_max 0xc0a864c8
ca_ip_address_set_addr_len $ip_da_address_max 32
#### set ip_da_v6
##ca_ip_address_set_afi $ip_da_address_max 1
##ca_l3_ip_addr_set_ipv6_addr $ip_da_addr_max 0x3000 0
##ca_l3_ip_addr_set_ipv6_addr $ip_da_addr_max 0 1
##ca_l3_ip_addr_set_ipv6_addr $ip_da_addr_max 0 2
##ca_l3_ip_addr_set_ipv6_addr $ip_da_addr_max 1 30
##ca_ip_address_set_addr_len $ip_da_address_max 128
ca_ip_address_set_ip_addr  $ip_da_address_max $ip_da_addr_max
ca_classifier_ip_set_ip_da_max $ip_key $ip_da_address_max

#### set fragment
ca_classifier_ip_set_fragment $ip_key 1
#### set have_options
ca_classifier_ip_set_have_options $ip_key 1
#### set flow label
ca_classifier_ip_set_flow_label $ip_key 12345
#### set ext_header
ca_classifier_ip_set_ext_header $ip_key 0
#### set icmp_type
ca_classifier_ip_set_icmp_type $ip_key 8
#### set igmp_type
ca_classifier_ip_set_igmp_type $ip_key 0x16
#### set is_multicast
ca_classifier_ip_set_is_multicast $ip_key 1

ca_classifier_key_set_ip $key $ip_key

#### set l4_valid
ca_classifier_l4_set_l4_valid $l4_key 1
#### set l4 src_port
ca_classifier_l4_port_range_set_min $port_range_key 60
ca_classifier_l4_port_range_set_max $port_range_key 70
ca_classifier_l4_set_src_port $l4_key $port_range_key
#### set l4 dst_port
ca_classifier_l4_port_range_set_min $dst_port_range_key 60
ca_classifier_l4_port_range_set_max $dst_port_range_key 70
ca_classifier_l4_set_dst_port $l4_key $dst_port_range_key
#### set tcp_flags
ca_classifier_l4_set_tcp_flags $l4_key 3

ca_classifier_key_set_l4 $key $l4_key

#### set starting_location
ca_classifier_ext_set_starting_location $ext_key 2
#### set offset
ca_classifier_ext_set_offset $ext_key 4
#### set length
ca_classifier_ext_set_length $ext_key 4
#### set data
ca_classifier_ext_set_data $ext_key 0x12 0
ca_classifier_ext_set_data $ext_key 0x34 1
ca_classifier_ext_set_data $ext_key 0x56 2
ca_classifier_ext_set_data $ext_key 0x78 3
#### set mask
ca_classifier_ext_set_mask $ext_key 0xff 0
ca_classifier_ext_set_mask $ext_key 0x00 1
ca_classifier_ext_set_mask $ext_key 0x00 2
ca_classifier_ext_set_mask $ext_key 0xff 3

ca_classifier_key_set_ext $key $ext_key

##########################
#### Set CLS Key Mask ####
##########################
#### set orig_src_port mask
## ca_classifier_key_mask_set_orig_src_port $key_mask 1

#### set src_port mask
ca_classifier_key_mask_set_src_port $key_mask 1

#### set key_handle mask
## ca_classifier_key_mask_set_key_handle $key_mask 1

#### set src_intf mask
## ca_classifier_key_mask_set_src_intf $key_mask 1

#### set dst_intf mask
## ca_classifier_key_mask_set_dst_intf $key_mask 1

#### set merge_prio
## ca_classifier_key_mask_set_merge_prio $key_mask 1

#### set ingress_lan
## ca_classifier_key_mask_set_ingress_lan $key_mask 1

#### set packet_length
## ca_classifier_key_mask_set_packet_length $key_mask 1

#### set l2 mask
ca_classifier_key_mask_set_l2 $key_mask 1

## set ethertype mask
## ca_classifier_l2_mask_set_ethertype $l2_mask 1
#### set src mac mask
## ca_classifier_l2_mask_set_mac_sa $l2_mask 1
#### set dst mac mask
## ca_classifier_l2_mask_set_mac_da $l2_mask 1
#### set is_multicast
## ca_classifier_l2_mask_set_is_multicast $l2_mask 1
#### set is_length
## ca_classifier_l2_mask_set_is_length $l2_mask 1
#### set cfm_opcode
## ca_classifier_l2_mask_set_cfm_opcode $l2_mask 1
#### set ppp_proto
## ca_classifier_l2_mask_set_ppp_proto $l2_mask 1
#### set pppoe_session_id
## ca_classifier_l2_mask_set_pppoe_session_id $l2_mask 1

#### set outer vlan tag mask
## ca_classifier_l2_mask_set_vlan_otag $l2_mask 1
#### set inner vlan tag mask
## ca_classifier_l2_mask_set_vlan_itag $l2_mask 1
#### set vlan count mask
## ca_classifier_l2_mask_set_vlan_count $l2_mask 1

#### set vlan tpid mask
## ca_classifier_vlan_mask_set_tpid $vlan_mask 1
#### set vlan vid mask
## ca_classifier_vlan_mask_set_vid $vlan_mask 1
#### set vlan dei mask
## ca_classifier_vlan_mask_set_dei $vlan_mask 1
#### set vlan pri mask
## ca_classifier_vlan_mask_set_pri $vlan_mask 1

ca_classifier_l2_mask_set_vlan_otag_mask $l2_mask $vlan_mask

#### set vlan tpid mask
## ca_classifier_vlan_mask_set_tpid $ivlan_mask 1
#### set vlan vid mask
## ca_classifier_vlan_mask_set_vid $ivlan_mask 1
#### set vlan dei mask
## ca_classifier_vlan_mask_set_dei $ivlan_mask 1
#### set vlan pri mask
## ca_classifier_vlan_mask_set_pri $ivlan_mask 1
#ca_classifier_l2_mask_set_vlan_itag_mask $l2_mask $ivlan_mask

ca_classifier_key_mask_set_l2_mask $key_mask $l2_mask

#### set ip mask
ca_classifier_key_mask_set_ip $key_mask 1

#### set ip_valid mask
## ca_classifier_ip_mask_set_ip_valid $ip_mask 1
#### set ip_version mask
## ca_classifier_ip_mask_set_ip_version $ip_mask 1
#### set ip_protocol mask
## ca_classifier_ip_mask_set_ip_protocol $ip_mask 1
#### set dscp mask
## ca_classifier_ip_mask_set_dscp $ip_mask 1
#### set ecn mask
## ca_classifier_ip_mask_set_ecn $ip_mask 1
#### set ip_sa mask
## ca_classifier_ip_mask_set_ip_sa $ip_mask 1
#### set ip_sa_max mask
## ca_classifier_ip_mask_set_ip_sa_max $ip_mask 1
#### set ip_da mask
## ca_classifier_ip_mask_set_ip_da $ip_mask 1
#### set ip_da_max mask
## ca_classifier_ip_mask_set_ip_da_max $ip_mask 1
#### set fragment mask
## ca_classifier_ip_mask_set_fragment $ip_mask 1
#### set have_options mask
## ca_classifier_ip_mask_set_have_options $ip_mask 1
#### set flow_label mask
## ca_classifier_ip_mask_set_flow_label $ip_mask 1
#### set ext_header mask
## ca_classifier_ip_mask_set_ext_header $ip_mask 1
#### set icmp_type
## ca_classifier_ip_mask_set_icmp_type $ip_mask 1
#### set igmp_type
## ca_classifier_ip_mask_set_igmp_type $ip_mask 1
#### set is_multicast
## ca_classifier_ip_mask_set_is_multicast $ip_mask 1

ca_classifier_key_mask_set_ip_mask $key_mask $ip_mask

#### set l4 mask
ca_classifier_key_mask_set_l4 $key_mask 1

#### set l4_valid
## ca_classifier_l4_mask_set_l4_valid $l4_mask 1
#### set l4 src_port mask
## ca_classifier_l4_mask_set_src_port $l4_mask 1
#### set l4 dst_port mask
## ca_classifier_l4_mask_set_dst_port $l4_mask 1
#### set tcp_flags
## ca_classifier_l4_mask_set_tcp_flags $l4_mask 3

ca_classifier_key_mask_set_l4_mask $key_mask $l4_mask

#### set ext mask
## ca_classifier_key_mask_set_ext $key_mask 1

##########################
####  Set CLS Action  ####
##########################
#### set forward to deny
## ca_classifier_action_set_forward $action 0

#### set forward to fe
## ca_classifier_action_set_forward $action 1

#### set forward to intf
## ca_classifier_action_set_forward $action 2
#### set intf
## ca_classifier_action_dest_set_intf $dest 0x4

#### set forward to port
ca_classifier_action_set_forward $action 3
#### set port
ca_classifier_action_dest_set_port $dest 0x3

ca_classifier_action_set_dest $action $dest

#### set action_handle
ca_classifier_handle_set_flow_id $action_handle 0xb0a
ca_classifier_action_option_set_action_handle $options $action_handle

#### set handle_type
ca_classifier_action_option_set_handle_type $options 2

#### set priority
ca_classifier_action_option_set_priority $options 5

#### set dscp
ca_classifier_action_option_set_dscp $options 60

#### set mark
ca_classifier_action_option_set_mark $options 1

#### set outer dot1p
ca_classifier_action_option_set_outer_dot1p $options 7
#### set outer vid
ca_classifier_action_option_set_outer_vid $options 200
#### set outer vlan act
ca_classifier_action_option_set_outer_vlan_act $options 2
#### set outer tpid
ca_classifier_action_option_set_outer_tpid $options 0x9100
#### set outer dei
ca_classifier_action_option_set_outer_dei $options 1

#### set inner dot1p
ca_classifier_action_option_set_inner_dot1p $options 5
#### set inner vid
ca_classifier_action_option_set_inner_vid $options 100
#### set inner vlan act
ca_classifier_action_option_set_inner_vlan_act $options 2
#### set inner tpid
ca_classifier_action_option_set_inner_tpid $options 0x88a8
#### set inner dei
ca_classifier_action_option_set_inner_dei $options 0

#### set da mac
set mac_da [ ca_mac_addr_create 0x00 0x13 0x25 0xaa 0xbb 0xcc ]
ca_classifier_action_option_set_mac_da $options $mac_da

#### set sw_id
ca_classifier_action_option_set_sw_id $options 0x0123 0
ca_classifier_action_option_set_sw_id $options 0x4567 1
ca_classifier_action_option_set_sw_id $options 0x89ab 2
ca_classifier_action_option_set_sw_id $options 0xcdef 3

#### set sw_shaper_id
ca_classifier_action_option_set_sw_shaper_id $options 9

#### set mcg_id
ca_classifier_action_option_set_mcg_id $options 9

##############################
####  Set CLS Action Mask ####
##############################
#### set action_handle mask
## ca_classifier_action_option_mask_set_action_handle $action_mask 1

#### set priority mask
## ca_classifier_action_option_mask_set_priority $action_mask 1

#### set dscp mask
## ca_classifier_action_option_mask_set_dscp $action_mask 1

#### set mark mask
## ca_classifier_action_option_mask_set_mark $action_mask 1

#### set outer dot1p mask
## ca_classifier_action_option_mask_set_outer_dot1p $action_mask 1

#### set outer vlan_act mask
## ca_classifier_action_option_mask_set_outer_vlan_act $action_mask 1

#### set outer tpid mask
## ca_classifier_action_option_mask_set_outer_tpid $action_mask 1

#### set outer dei mask
## ca_classifier_action_option_mask_set_outer_dei $action_mask 1

#### set inner dot1p mask
## ca_classifier_action_option_mask_set_inner_dot1p $action_mask 1

#### set inner vlan_act mask
## ca_classifier_action_option_mask_set_inner_vlan_act $action_mask 1

#### set inner tpid mask
## ca_classifier_action_option_mask_set_inner_tpid $action_mask 1

#### set inner dei mask
## ca_classifier_action_option_mask_set_inner_dei $action_mask 1

#### set mac_da mask
## ca_classifier_action_option_mask_set_mac_da $action_mask 1

#### set sw_id
## ca_classifier_action_option_mask_set_sw_id $action_mask 1

#### set sw_shaper_id
## ca_classifier_action_option_mask_set_sw_shaper_id $action_mask 1

#### set mcg_id
## ca_classifier_action_option_mask_set_mcg_id $action_mask 1

ca_classifier_action_option_set_masks $options $action_mask

ca_classifier_action_set_options $action $options

##########################
####   Add CLS Rule   ####
##########################
set rule_idx [ ca_uint32_create 0 ]
set ret [ ca_classifier_rule_add 0 15 $key $key_mask $action $rule_idx ]
if {$ret != 0} {
	puts "ca_classifier_rule_add() is failed! (ret=$ret)"
} else {
	set cls_rule_idx [ ca_uint32_get $rule_idx ]
	puts "cls_rule_idx = $cls_rule_idx"
}

