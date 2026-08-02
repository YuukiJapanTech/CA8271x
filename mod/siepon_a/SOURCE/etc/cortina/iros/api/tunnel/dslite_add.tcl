## tunnel type 6 (DSLITE)
##
## upstream for encap:
## mac_sa = 00-00-00-00-01-64 or any
## mac_da = 00-13-25-00-00-02 (G3 LAN)
## inner_ipv4sa = 192.168.1.100
## inner_ipv4da = any
##
## downstream for decap:
## mac_sa = 00-00-00-00-64-64 or any
## mac_da = 00-13-25-00-00-01 (G3 WAN)
## outer_ipv6sa = 3001::1
## outer_ipv6da = 2001::1
## inner_ipv4sa = any
## inner_ipv4da = 192.168.1.100

# tunnnel src(local) = 2001::1
set src [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr $ip 0x20010000 0
ca_l3_ip_addr_set_ipv6_addr $ip 0 1
ca_l3_ip_addr_set_ipv6_addr $ip 0 2
ca_l3_ip_addr_set_ipv6_addr $ip 0x00000001 3
ca_ip_address_set_addr_len $src 128
ca_ip_address_set_afi $src 1
ca_ip_address_set_ip_addr $src $ip

# tunnnel dest(remote) = 3001::1
set dest [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr $ip 0x30010000 0
ca_l3_ip_addr_set_ipv6_addr $ip 0 1
ca_l3_ip_addr_set_ipv6_addr $ip 0 2
ca_l3_ip_addr_set_ipv6_addr $ip 0x00000001 3
ca_ip_address_set_addr_len $dest 128
ca_ip_address_set_afi $dest 1
ca_ip_address_set_ip_addr $dest $ip

set tcfg_dslite [ ca_dslite_config_create ]
ca_dslite_config_set_dsl_ipmc_illegal_chk_en $tcfg_dslite 0
ca_dslite_config_set_dsl_ipmc_to_l2fe $tcfg_dslite 0
ca_dslite_config_set_dsl_ipmc_addr_prefix_chk_en $tcfg_dslite 0
ca_dslite_config_set_dsl_ipmc_addr_consistency_chk_en $tcfg_dslite 0
ca_dslite_config_set_dsl_reverse_path_chk_en $tcfg_dslite 0
ca_dslite_config_set_dsl_ttl_keep_outer $tcfg_dslite 0
ca_dslite_config_set_dsl_dscp_keep_outer $tcfg_dslite 0
ca_dslite_config_set_dsl_ecn_keep_outer $tcfg_dslite 0
ca_dslite_config_set_dsl_ecn_check_enable $tcfg_dslite 0
ca_dslite_config_set_rebuild_mc_mac $tcfg_dslite 1
ca_dslite_config_set_mc_flag $tcfg_dslite 0
ca_dslite_config_set_mc_mac $tcfg_dslite [ ca_mac_addr_create 0x01 0x00 0x5e 0x00 0x00 0x00 ]
ca_dslite_config_set_mc_drop $tcfg_dslite 0
ca_dslite_config_set_validation_check_failed_dest_port $tcfg_dslite 0x3f
ca_dslite_config_set_egress_tc_value $tcfg_dslite 0
ca_dslite_config_set_egress_hoplimit_value $tcfg_dslite 100
ca_dslite_config_set_egress_flow_label_value $tcfg_dslite 0

set tcfg_union [ ca_tunnel_cfg_union_create ]
ca_tunnel_cfg_union_set_dslite $tcfg_union $tcfg_dslite

set tcfg [ ca_tunnel_cfg_create ]
ca_tunnel_cfg_set_type $tcfg 6
ca_tunnel_cfg_set_src_addr $tcfg $src
ca_tunnel_cfg_set_dest_addr $tcfg $dest
ca_tunnel_cfg_set_parent_l3_intf_id $tcfg 0
ca_tunnel_cfg_set_tunnel $tcfg $tcfg_union

set ret_tunnel_id [ ca_uint16_create 0 ]
set ret [ ca_tunnel_add 0 $tcfg $ret_tunnel_id ]
if {$ret != 0} {
	puts "ca_tunnel_add() is failed! (ret=$ret)"
	exit 1
} else {
	set tunnel_id [ ca_uint16_get $ret_tunnel_id ]
	puts "tunnel_id=$tunnel_id"
}

#########################################################

# WAN interface, tunnel type
# intf_id 48
# ip 2001::1
# mac 00-13-25-00-00-01
set mask [ ca_l3_intf_mask_create ]
ca_l3_intf_mask_set_port_id $mask 1
ca_l3_intf_mask_set_mac_addr $mask 1
ca_l3_intf_mask_set_outer_tpid $mask 0
ca_l3_intf_mask_set_outer_vid $mask 0
ca_l3_intf_mask_set_inner_tpid $mask 0
ca_l3_intf_mask_set_inner_vid $mask 0
ca_l3_intf_mask_set_tunnel_id $mask 1
ca_l3_intf_mask_set_mtu $mask 1
ca_l3_intf_mask_set_ip_addr $mask 1
ca_l3_intf_mask_set_nat_enable $mask 1

set intf_wan [ ca_l3_intf_create ]
ca_l3_intf_set_mask $intf_wan $mask
ca_l3_intf_set_type $intf_wan 3
ca_l3_intf_set_intf_id $intf_wan 48
ca_l3_intf_set_port_id $intf_wan 0x80018
ca_l3_intf_set_outer_vid $intf_wan 0xffff
ca_l3_intf_set_tunnel_id $intf_wan 0
ca_l3_intf_set_mtu $intf_wan 1280
ca_l3_intf_set_nat_enable $intf_wan 0
ca_l3_intf_set_mac_addr $intf_wan [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x01 ]

# create and set wan ip_addr
set ip_wan [ ca_ip_address_create ]
set ip_addr_wan [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr  $ip_addr_wan 0x20010000 0
ca_l3_ip_addr_set_ipv6_addr  $ip_addr_wan 0 1
ca_l3_ip_addr_set_ipv6_addr  $ip_addr_wan 0 2
ca_l3_ip_addr_set_ipv6_addr  $ip_addr_wan 0x00000001 3
ca_ip_address_set_addr_len $ip_wan 128
ca_ip_address_set_afi $ip_wan 1
ca_ip_address_set_ip_addr $ip_wan $ip_addr_wan
ca_l3_intf_set_ip_addr $intf_wan $ip_wan

ca_l3_intf_add 0 $intf_wan

#########################################################

# nexthop 192.168.100.100, 00:00:00:00:64:64, intf_id 48

set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip_addr 0xc0a86464
ca_ip_address_set_addr_len $ip 32
ca_ip_address_set_afi $ip 0
ca_ip_address_set_ip_addr $ip $ip_addr

set mac_addr [ ca_mac_addr_create 0x00 0x00 0x00 0x00 0x64 0x64 ]

set nh [ ca_l3_nexthop_create ]

ca_l3_nexthop_set_nexthop_id $nh 0
ca_l3_nexthop_set_attr_flags $nh 1
ca_l3_nexthop_set_addr $nh $ip
ca_l3_nexthop_set_intf_id $nh 48
ca_l3_nexthop_set_da_mac $nh $mac_addr
ca_l3_nexthop_set_aging_timer $nh 0

set ret_nhid [ ca_uint16_create 0 ]
set ret [ ca_l3_nexthop_add 0 $nh $ret_nhid ]
if {$ret != 0} {
	puts "ca_l3_nexthop_add() is failed! (ret=$ret)"
	exit 2
} else {
	set nhid [ ca_uint16_get $ret_nhid ]
	puts "nhid=$nhid"
}

#########################################################

# route to WAN
# prefix 0.0.0.0/0 (default route), nexthop_id is $nhid

set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip_addr 0x00000000
ca_ip_address_set_addr_len $ip 0
ca_ip_address_set_afi $ip 0
ca_ip_address_set_ip_addr $ip $ip_addr

set rt [ ca_l3_route_create ]

ca_l3_route_set_nexthop_id $rt $nhid
ca_l3_route_set_prefix $rt $ip

set ret [ ca_l3_route_add 0 $rt ]
if {$ret != 0} {
	puts "ca_l3_route_add() is failed! (ret=$ret)"
	exit 3
} else {
	puts "route is added successfully."
}

#########################################################

# LAN interface, broadcast type
# intf_id 1
# ip 192.168.1.1
# mac 00-13-25-00-00-02
set mask [ ca_l3_intf_mask_create ]
ca_l3_intf_mask_set_port_id $mask 1
ca_l3_intf_mask_set_mac_addr $mask 1
ca_l3_intf_mask_set_outer_tpid $mask 0
ca_l3_intf_mask_set_outer_vid $mask 0
ca_l3_intf_mask_set_inner_tpid $mask 0
ca_l3_intf_mask_set_inner_vid $mask 0
ca_l3_intf_mask_set_tunnel_id $mask 0
ca_l3_intf_mask_set_mtu $mask 1
ca_l3_intf_mask_set_ip_addr $mask 1
ca_l3_intf_mask_set_nat_enable $mask 1

set intf_lan [ ca_l3_intf_create ]
ca_l3_intf_set_mask $intf_lan $mask
ca_l3_intf_set_type $intf_lan 1
ca_l3_intf_set_intf_id $intf_lan 1
ca_l3_intf_set_port_id $intf_lan 0x30019
ca_l3_intf_set_outer_vid $intf_lan 0xffff
ca_l3_intf_set_mtu $intf_lan 1280
ca_l3_intf_set_nat_enable $intf_lan 0
ca_l3_intf_set_mac_addr $intf_lan [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x02 ]

# create and set lan ip_addr
set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr  $ip_addr 0xc0a80101
ca_ip_address_set_addr_len $ip 32
ca_ip_address_set_afi $ip 0
ca_ip_address_set_ip_addr $ip $ip_addr
ca_l3_intf_set_ip_addr $intf_lan $ip

ca_l3_intf_add 0 $intf_lan

#########################################################

# nexthop 0.0.0.0, 00:00:00:00:00:00, intf_id 1

set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip_addr 0x00000000
ca_ip_address_set_addr_len $ip 0
ca_ip_address_set_afi $ip 0
ca_ip_address_set_ip_addr $ip $ip_addr

set mac_addr [ ca_mac_addr_create 0x00 0x00 0x00 0x00 0x00 0x00 ]

set nh [ ca_l3_nexthop_create ]

ca_l3_nexthop_set_nexthop_id $nh 0
ca_l3_nexthop_set_attr_flags $nh 1
ca_l3_nexthop_set_addr $nh $ip
ca_l3_nexthop_set_intf_id $nh 1
ca_l3_nexthop_set_da_mac $nh $mac_addr
ca_l3_nexthop_set_aging_timer $nh 0

set ret_nhid [ ca_uint16_create 0 ]
set ret [ ca_l3_nexthop_add 0 $nh $ret_nhid ]
if {$ret != 0} {
	puts "ca_l3_nexthop_add() is failed! (ret=$ret)"
	exit 2
} else {
	set nhid [ ca_uint16_get $ret_nhid ]
	puts "nhid=$nhid"
}

#########################################################

# route to LAN
# prefix 192.168.1.0/24, nexthop_id is $nhid

set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip_addr 0xc0a80100
ca_ip_address_set_addr_len $ip 24
ca_ip_address_set_afi $ip 0
ca_ip_address_set_ip_addr $ip $ip_addr

set rt [ ca_l3_route_create ]

ca_l3_route_set_nexthop_id $rt $nhid
ca_l3_route_set_prefix $rt $ip

set ret [ ca_l3_route_add 0 $rt ]
if {$ret != 0} {
	puts "ca_l3_route_add() is failed! (ret=$ret)"
	exit 3
} else {
	puts "route is added successfully."
}

#########################################################

# ARP result for LAN host
# nexthop 192.168.1.100, 00:00:00:00:01:64, intf_id 1

set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip_addr 0xc0a80164
ca_ip_address_set_addr_len $ip 32
ca_ip_address_set_afi $ip 0
ca_ip_address_set_ip_addr $ip $ip_addr

set mac_addr [ ca_mac_addr_create 0x00 0x00 0x00 0x00 0x01 0x64 ]

set nh [ ca_l3_nexthop_create ]

ca_l3_nexthop_set_nexthop_id $nh 0
ca_l3_nexthop_set_attr_flags $nh 1
ca_l3_nexthop_set_addr $nh $ip
ca_l3_nexthop_set_intf_id $nh 1
ca_l3_nexthop_set_da_mac $nh $mac_addr
ca_l3_nexthop_set_aging_timer $nh 0

set ret_nhid [ ca_uint16_create 0 ]
set ret [ ca_l3_nexthop_add 0 $nh $ret_nhid ]
if {$ret != 0} {
	puts "ca_l3_nexthop_add() is failed! (ret=$ret)"
	exit 2
} else {
	set nhid [ ca_uint16_get $ret_nhid ]
	puts "nhid=$nhid"
}


