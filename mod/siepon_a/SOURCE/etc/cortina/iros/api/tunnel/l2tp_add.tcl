# tunnel type 2 (L2TP)
# L2TPv3

set L2TP_SESSION_ID 3000
set SRC_MAC [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x01 ]
set DEST_MAC [ ca_mac_addr_create 0x00 0x00 0x00 0x00 0x64 0x64 ]
set PARENT_INTF_ID 4

set src [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip 0x01010101
ca_ip_address_set_addr_len $src 32
ca_ip_address_set_afi $src 0
ca_ip_address_set_ip_addr $src $ip

set dest [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip 0x02020202
ca_ip_address_set_addr_len $dest 32
ca_ip_address_set_afi $dest 0
ca_ip_address_set_ip_addr $dest $ip

set tcfg_union [ ca_tunnel_cfg_union_create ]
set tcfg_l2tp [ ca_l2tp_tunnel_cfg_create ]
ca_l2tp_tunnel_cfg_set_version $tcfg_l2tp 3
ca_l2tp_tunnel_cfg_set_len $tcfg_l2tp 0
ca_l2tp_tunnel_cfg_set_tunnel_id $tcfg_l2tp 0
ca_l2tp_tunnel_cfg_set_dest_l4_port $tcfg_l2tp 1701
ca_l2tp_tunnel_cfg_set_src_l4_port $tcfg_l2tp 1071
ca_l2tp_tunnel_cfg_set_session_id $tcfg_l2tp $L2TP_SESSION_ID
ca_l2tp_tunnel_cfg_set_encap_type $tcfg_l2tp 0
ca_l2tp_tunnel_cfg_set_l2_specific_len $tcfg_l2tp 4
ca_l2tp_tunnel_cfg_set_l2_specific_type $tcfg_l2tp 1
ca_l2tp_tunnel_cfg_set_send_seq $tcfg_l2tp 0
ca_l2tp_tunnel_cfg_set_calc_udp_csum $tcfg_l2tp 0
ca_l2tp_tunnel_cfg_set_sequence_number $tcfg_l2tp 0
ca_l2tp_tunnel_cfg_set_cookie_len $tcfg_l2tp 4

ca_l2tp_tunnel_cfg_set_cookie $tcfg_l2tp 0x00 0
ca_l2tp_tunnel_cfg_set_cookie $tcfg_l2tp 0x01 1
ca_l2tp_tunnel_cfg_set_cookie $tcfg_l2tp 0x02 2
ca_l2tp_tunnel_cfg_set_cookie $tcfg_l2tp 0x03 3
ca_l2tp_tunnel_cfg_set_cookie $tcfg_l2tp 0x04 4
ca_l2tp_tunnel_cfg_set_cookie $tcfg_l2tp 0x05 5
ca_l2tp_tunnel_cfg_set_cookie $tcfg_l2tp 0x06 6
ca_l2tp_tunnel_cfg_set_cookie $tcfg_l2tp 0x07 7

ca_l2tp_tunnel_cfg_set_offset $tcfg_l2tp 0
ca_l2tp_tunnel_cfg_set_l2tp_src_mac $tcfg_l2tp $SRC_MAC
ca_l2tp_tunnel_cfg_set_peer_l2tp_src_mac $tcfg_l2tp $DEST_MAC

ca_tunnel_cfg_union_set_l2tp $tcfg_union $tcfg_l2tp

set tcfg [ ca_tunnel_cfg_create ]
ca_tunnel_cfg_set_type $tcfg 2
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



