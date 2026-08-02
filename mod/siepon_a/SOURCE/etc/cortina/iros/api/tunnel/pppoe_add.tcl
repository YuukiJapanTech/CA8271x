# tunnel type 1 (PPPOE)

set PPPOE_SESSION_ID 0
set SRC_MAC [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x01 ]
set DEST_MAC [ ca_mac_addr_create 0x00 0x00 0x00 0x00 0x64 0x64 ]
set PARENT_INTF_ID 0

set src [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip 0x00000000
ca_ip_address_set_addr_len $src 0
ca_ip_address_set_afi $src 0
ca_ip_address_set_ip_addr $src $ip

set dest [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip 0x00000000
ca_ip_address_set_addr_len $dest 0
ca_ip_address_set_afi $dest 0
ca_ip_address_set_ip_addr $dest $ip

set tcfg_union [ ca_tunnel_cfg_union_create ]
set tcfg_pppoe [ ca_pppoe_tunnel_cfg_create ]
ca_pppoe_tunnel_cfg_set_mac_da $tcfg_pppoe $DEST_MAC
ca_pppoe_tunnel_cfg_set_pppoe_session_id $tcfg_pppoe $PPPOE_SESSION_ID
ca_tunnel_cfg_union_set_pppoe $tcfg_union $tcfg_pppoe

set tcfg [ ca_tunnel_cfg_create ]
ca_tunnel_cfg_set_type $tcfg 1
ca_tunnel_cfg_set_src_addr $tcfg $src
ca_tunnel_cfg_set_dest_addr $tcfg $dest
ca_tunnel_cfg_set_parent_l3_intf_id $tcfg $PARENT_INTF_ID
ca_tunnel_cfg_set_tunnel $tcfg $tcfg_union

set ret_tunnel_id [ ca_uint16_create 0 ]
set ret [ ca_tunnel_add 0 $tcfg $ret_tunnel_id ]
if {$ret != 0} {
	puts "ca_tunnel_add() is failed! (ret=$ret)"
} else {
	set tunnel_id [ ca_uint16_get $ret_tunnel_id ]
	puts "tunnel_id=$tunnel_id"
}



