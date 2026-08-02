## tunnel type 10 (MAP-T)
##
## The example follows RFC7599 example 1~3.
## https://tools.ietf.org/html/rfc7599
##
## upstream for encap:
## mac_sa = 00-00-00-00-01-64 or any
## mac_da = 00-13-25-00-00-02 (G3 LAN)
## inner_ipv4sa = 192.168.1.100
## inner_ipv4da = 10.2.3.4
##
## downstream for decap:
## mac_sa = 00-00-00-00-64-64 or any
## mac_da = 00-13-25-00-00-01 (G3 WAN)
## outer_ipv6sa = 2001:0db8:ffff:0000:000a:0203:0400:0000
## outer_ipv6da = 2001:0db8:0012:3400:0000:c000:0212:0034
## inner_ipv4sa = 10.2.3.4
## inner_ipv4da = 192.0.2.18
##
## Available ports (63 ranges): 1232-1235, 2256-2259, ...... , 63696-63699, 64720-64723

# QA's library, load this for ca-iros compatibility
source  /etc/cortina/iros/qa/wca/SC_COMMAND_LIB.tcl
namespace import gw::*

# tunnnel src(local)
set src [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr $ip 0x20010db8 0
ca_l3_ip_addr_set_ipv6_addr $ip 0x00123400 1
ca_l3_ip_addr_set_ipv6_addr $ip 0 2
ca_l3_ip_addr_set_ipv6_addr $ip 0x00000000 3
ca_ip_address_set_addr_len $src 56
ca_ip_address_set_afi $src 1
ca_ip_address_set_ip_addr $src $ip

# tunnnel dest(remote)
set dest [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr $ip 0x20010db8 0
ca_l3_ip_addr_set_ipv6_addr $ip 0xffff0000 1
ca_l3_ip_addr_set_ipv6_addr $ip 0 2
ca_l3_ip_addr_set_ipv6_addr $ip 0x00000001 3
ca_ip_address_set_addr_len $dest 64
ca_ip_address_set_afi $dest 1
ca_ip_address_set_ip_addr $dest $ip

# ipv6_prefix, Rule IPv6 prefix
set ipv6_prefix [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr $ip 0x20010db8 0
ca_l3_ip_addr_set_ipv6_addr $ip 0 1
ca_l3_ip_addr_set_ipv6_addr $ip 0 2
ca_l3_ip_addr_set_ipv6_addr $ip 0 3
ca_ip_address_set_addr_len $ipv6_prefix 40
ca_ip_address_set_afi $ipv6_prefix 1
ca_ip_address_set_ip_addr $ipv6_prefix $ip

# ipv4_prefix, Rule IPv4 prefix
set ipv4_prefix [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip 0xc0000212
ca_ip_address_set_addr_len $ipv4_prefix 24
ca_ip_address_set_afi $ipv4_prefix 0
ca_ip_address_set_ip_addr $ipv4_prefix $ip

set tcfg_map_t [ ca_map_config_create ]
ca_map_config_set_map_type $tcfg_map_t 1
ca_map_config_set_ipv6_prefix $tcfg_map_t $ipv6_prefix
ca_map_config_set_ipv4_prefix $tcfg_map_t $ipv4_prefix
ca_map_config_set_ea_bit_length $tcfg_map_t 16
ca_map_config_set_psid_offset $tcfg_map_t 6
ca_map_config_set_psid_length $tcfg_map_t 8
ca_map_config_set_psid_id $tcfg_map_t 0x34
ca_map_config_set_validation_check_failed_dest_port $tcfg_map_t 0x1f
ca_map_config_set_egress_tc_copied_from_ipv4_tos $tcfg_map_t 0
ca_map_config_set_egress_tc_value $tcfg_map_t 0
ca_map_config_set_egress_hoplimit_value $tcfg_map_t 0
ca_map_config_set_egress_flow_label_value $tcfg_map_t 0

set tcfg_union [ ca_tunnel_cfg_union_create ]
ca_tunnel_cfg_union_set_map $tcfg_union $tcfg_map_t

set tcfg [ ca_tunnel_cfg_create ]
ca_tunnel_cfg_set_type $tcfg 10
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
# intf_id 4
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
ca_l3_intf_set_intf_id $intf_wan 4
ca_l3_intf_set_port_id $intf_wan 0x80018
ca_l3_intf_set_outer_vid $intf_wan 0xffff
ca_l3_intf_set_outer_tpid $intf_wan 0x8100
ca_l3_intf_set_inner_vid $intf_wan 0xffff
ca_l3_intf_set_inner_tpid $intf_wan 0x8100
ca_l3_intf_set_tunnel_id $intf_wan $tunnel_id
ca_l3_intf_set_mtu $intf_wan 1280
ca_l3_intf_set_nat_enable $intf_wan 1
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
set tunnel_intf_id [ ca_l3_intf_get_intf_id $intf_wan ]
puts "tunnel_intf_id=$tunnel_intf_id"

#########################################################

#### NOTE: If kernel hook exists, must follow system settings such as intf_id.

# ARP result for LAN host
# nexthop 192.168.1.100, 00:00:00:00:01:64, intf_id 2

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
ca_l3_nexthop_set_intf_id $nh 2
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

# nexthop 10.2.3.4, 00:00:00:00:64:64, intf_id is tunnel_intf_id

set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip_addr 0x0a020304
ca_ip_address_set_addr_len $ip 32
ca_ip_address_set_afi $ip 0
ca_ip_address_set_ip_addr $ip $ip_addr

set mac_addr [ ca_mac_addr_create 0x00 0x00 0x00 0x00 0x64 0x64 ]

set nh [ ca_l3_nexthop_create ]

ca_l3_nexthop_set_nexthop_id $nh 0
ca_l3_nexthop_set_attr_flags $nh 1
ca_l3_nexthop_set_addr $nh $ip
ca_l3_nexthop_set_intf_id $nh $tunnel_intf_id
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

# upstream, SNAT
# src=192.168.1.100:63, dst=10.2.3.4:63, UDP -> src=192.0.2.18:1232, dst=10.2.3.4:63
wca_nat_entry_add -src_ip_addr 192.168.1.100 -src_l4_port 63 -dst_ip_addr 10.2.3.4 -dst_l4_port 63 -ip_proto 17 -new_src_ip_addr 192.0.2.18 -new_src_l4_port 1232 -new_dst_ip_addr 10.2.3.4 -new_dst_l4_port 63 -xlate_flags 0xd

# downstream, DNAT
# src=10.2.3.4:63, dst=192.0.2.18:1232, UDP -> src=10.2.3.4:63, dst=192.168.1.100:63
wca_nat_entry_add -src_ip_addr 10.2.3.4 -src_l4_port 63 -dst_ip_addr 192.0.2.18 -dst_l4_port 1232 -ip_proto 17 -new_src_ip_addr 10.2.3.4 -new_src_l4_port 63 -new_dst_ip_addr 192.168.1.100 -new_dst_l4_port 63 -xlate_flags 0xe


