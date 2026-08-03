## tunnel type 7 (6RD)
##
## upstream for encap: (CE-to-BR; encapsulation is done by pure SW)
## mac_sa = 00-00-00-00-01-64 or any
## mac_da = 01-00-5e-00-00-01
## inner_ipv6sa = 2001:A801:A00::64
## inner_ipv6da = FF38::EF00:0001 (not sure)
##
## downstream for decap: (BR-to-CE)
## mac_sa = 00-00-00-00-64-64 or any
## mac_da = 01-00-5e-00-00-01
## outer_ipv4sa = 192.0.0.1
## outer_ipv4da = 239.0.0.1
## inner_ipv6sa = 3001::c000:0001
## inner_ipv6da = FF38::EF00:0001

# tunnl src(local) = 239.0.0.1
set src [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip 0xef000001
ca_ip_address_set_addr_len $src 32
ca_ip_address_set_afi $src 0
ca_ip_address_set_ip_addr $src $ip

# tunnl dest(remote) = 192.0.0.1
set dest [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip 0xc0000001
ca_ip_address_set_addr_len $dest 32
ca_ip_address_set_afi $dest 0
ca_ip_address_set_ip_addr $dest $ip

# 6rd delegated IPv6 prefix and length
set prefix [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr $ip 0xff380000 0
ca_l3_ip_addr_set_ipv6_addr $ip 0x0 1
ca_l3_ip_addr_set_ipv6_addr $ip 0x0 2
ca_l3_ip_addr_set_ipv6_addr $ip 0x0 3
ca_ip_address_set_addr_len $prefix 16
ca_ip_address_set_afi $prefix 1
ca_ip_address_set_ip_addr $prefix $ip

set tcfg_6rd [ ca_6rd_config_create ]
ca_6rd_config_set_ipv6_6rd_prefix $tcfg_6rd $prefix
ca_6rd_config_set_six_rd_v6_prefix_len $tcfg_6rd 16
ca_6rd_config_set_six_rd_v4_mask_len $tcfg_6rd 8
ca_6rd_config_set_six_rd_ingress_chk_en $tcfg_6rd 0
ca_6rd_config_set_six_rd_ipsa_match $tcfg_6rd 0
ca_6rd_config_set_six_rd_ipmc_illegal_chk_en $tcfg_6rd 0
ca_6rd_config_set_six_rd_ttl_keep_outer $tcfg_6rd 0
ca_6rd_config_set_six_rd_dscp_keep_outer $tcfg_6rd 0
ca_6rd_config_set_six_rd_ecn_keep_outer $tcfg_6rd 0
ca_6rd_config_set_six_rd_ecn_check_enable $tcfg_6rd 0
ca_6rd_config_set_rebuild_mc_mac $tcfg_6rd 1
ca_6rd_config_set_mc_mac $tcfg_6rd [ ca_mac_addr_create 0x33 0x33 0x00 0x00 0x00 0x00 ]
ca_6rd_config_set_mc_drop $tcfg_6rd 0
ca_6rd_config_set_validation_check_failed_dest_port $tcfg_6rd 0x3f
ca_6rd_config_set_ce_ce_allowed $tcfg_6rd 0
ca_6rd_config_set_egress_tos_value $tcfg_6rd 0
ca_6rd_config_set_egress_ttl_value $tcfg_6rd 100
ca_6rd_config_set_egress_identification_start $tcfg_6rd 1000
ca_6rd_config_set_egress_identification_end $tcfg_6rd 60000
ca_6rd_config_set_six_rd_ipda_from_v6 $tcfg_6rd 0

set tcfg_union [ ca_tunnel_cfg_union_create ]
ca_tunnel_cfg_union_set_six_rd $tcfg_union $tcfg_6rd

set tcfg [ ca_tunnel_cfg_create ]
ca_tunnel_cfg_set_type $tcfg 7
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
# intf_id 32
# ip 192.168.100.1
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
ca_l3_intf_set_intf_id $intf_wan 32
ca_l3_intf_set_port_id $intf_wan 0x80018
ca_l3_intf_set_outer_vid $intf_wan 0xffff
ca_l3_intf_set_tunnel_id $intf_wan 0
ca_l3_intf_set_mtu $intf_wan 1280
ca_l3_intf_set_nat_enable $intf_wan 0
ca_l3_intf_set_mac_addr $intf_wan [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x01 ]

# create and set wan ip_addr
set ip_wan [ ca_ip_address_create ]
set ip_addr_wan [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr  $ip_addr_wan 0xc0a86401
ca_ip_address_set_addr_len $ip_wan 32
ca_ip_address_set_afi $ip_wan 0
ca_ip_address_set_ip_addr $ip_wan $ip_addr_wan
ca_l3_intf_set_ip_addr $intf_wan $ip_wan

ca_l3_intf_add 0 $intf_wan

#########################################################

# nexthop 3001::64, 00:00:00:00:64:64, intf_id 32

set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr  $ip_addr 0x30010000 0
ca_l3_ip_addr_set_ipv6_addr  $ip_addr 0 1
ca_l3_ip_addr_set_ipv6_addr  $ip_addr 0 2
ca_l3_ip_addr_set_ipv6_addr  $ip_addr 0x00000064 3
ca_ip_address_set_addr_len $ip 128
ca_ip_address_set_afi $ip 1
ca_ip_address_set_ip_addr $ip $ip_addr

set mac_addr [ ca_mac_addr_create 0x00 0x00 0x00 0x00 0x64 0x64 ]

set nh [ ca_l3_nexthop_create ]

ca_l3_nexthop_set_nexthop_id $nh 0
ca_l3_nexthop_set_attr_flags $nh 1
ca_l3_nexthop_set_addr $nh $ip
ca_l3_nexthop_set_intf_id $nh 32
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
# prefix ::0/0 (default route), nexthop_id is $nhid

set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x00000000 0
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x00000000 1
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x00000000 2
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x00000000 3
ca_ip_address_set_addr_len $ip 0
ca_ip_address_set_afi $ip 1
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
# ip 2001:A801:A00::1
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
ca_l3_ip_addr_set_ipv6_addr  $ip_addr 0x2001a801 0
ca_l3_ip_addr_set_ipv6_addr  $ip_addr 0x0a000000 1
ca_l3_ip_addr_set_ipv6_addr  $ip_addr 0x00000000 2
ca_l3_ip_addr_set_ipv6_addr  $ip_addr 0x00000001 3
ca_ip_address_set_addr_len $ip 128
ca_ip_address_set_afi $ip 1
ca_ip_address_set_ip_addr $ip $ip_addr
ca_l3_intf_set_ip_addr $intf_lan $ip

ca_l3_intf_add 0 $intf_lan

#########################################################

# nexthop ::0, 00:00:00:00:00:00, intf_id 1

set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x00000000 0
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x00000000 1
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x00000000 2
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x00000000 3
ca_ip_address_set_addr_len $ip 0
ca_ip_address_set_afi $ip 1
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
# prefix 2001:A801:A00::0/64, nexthop_id is $nhid

set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x2001a801 0
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x0a000000 1
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x0 2
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x0 3
ca_ip_address_set_addr_len $ip 64
ca_ip_address_set_afi $ip 1
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
# nexthop 2001:A801:A00::64, 00:00:00:00:01:64, intf_id 1

set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x2001a801 0
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x0a000000 1
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x00000000 2
ca_l3_ip_addr_set_ipv6_addr $ip_addr 0x00000064 3
ca_ip_address_set_addr_len $ip 128
ca_ip_address_set_afi $ip 1
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

