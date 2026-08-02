set		ADDR_LEN			32
set		IP_PROTOCOL			17
set		L4_SRC_PORT			0x3f
set		L4_DST_PORT			0x3f
set		NEW_L4_SRC_PORT			0x64
set		NEW_L4_DST_PORT			0x3f
set		AGING_TIMER			0

;#	Enable change SIP(0x1 << 0)
;#	Enable change DIP(0x1 << 1)
;#	Enable change port ID(0x1 << 2)
set		XLATE_FLAGS			5			;# SNAT:5 DNAT:6
set		SRC_IP_ADDR			0xc0a8010a		;# 192.168.1.10
set		DST_IP_ADDR			0xc0a8640a		;# 192.168.100.10
set		NEW_SRC_IP_ADDR			0xc0a86401		;# 192.168.100.1
set		NEW_DST_IP_ADDR			0xc0a8640a		;# 192.168.100.10




;#	SRC_IP_ADDR
set l3_src_ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr			$l3_src_ip_addr			$SRC_IP_ADDR
set src_ip_addr [ ca_ip_address_create ]
ca_ip_address_set_afi				$src_ip_addr			0
ca_ip_address_set_ip_addr			$src_ip_addr			$l3_src_ip_addr
ca_ip_address_set_addr_len			$src_ip_addr			$ADDR_LEN

;#	DST_IP_ADDR
set l3_dst_ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr			$l3_dst_ip_addr			$DST_IP_ADDR
set dst_ip_addr [ ca_ip_address_create ]
ca_ip_address_set_afi				$dst_ip_addr			0
ca_ip_address_set_ip_addr			$dst_ip_addr			$l3_dst_ip_addr
ca_ip_address_set_addr_len			$dst_ip_addr			$ADDR_LEN

;#	NEW_SRC_IP_ADDR
set l3_new_src_ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr			$l3_new_src_ip_addr		$NEW_SRC_IP_ADDR
set new_src_ip_addr [ ca_ip_address_create ]
ca_ip_address_set_afi				$new_src_ip_addr		0
ca_ip_address_set_ip_addr			$new_src_ip_addr		$l3_new_src_ip_addr
ca_ip_address_set_addr_len			$new_src_ip_addr		$ADDR_LEN

;#	NEW_DST_IP_ADDR
set l3_new_dst_ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr			$l3_new_dst_ip_addr		$NEW_DST_IP_ADDR
set new_dst_ip_addr [ ca_ip_address_create ]
ca_ip_address_set_afi				$new_dst_ip_addr		0
ca_ip_address_set_ip_addr			$new_dst_ip_addr		$l3_new_dst_ip_addr
ca_ip_address_set_addr_len			$new_dst_ip_addr		$ADDR_LEN


set nat_entry [ ca_nat_entry_create]
ca_nat_entry_set_new_dst_ip_addr	$nat_entry				$new_dst_ip_addr
ca_nat_entry_set_new_src_ip_addr	$nat_entry				$new_src_ip_addr
ca_nat_entry_set_dst_ip_addr		$nat_entry				$dst_ip_addr
ca_nat_entry_set_src_ip_addr		$nat_entry				$src_ip_addr
ca_nat_entry_set_ip_proto		$nat_entry				$IP_PROTOCOL
ca_nat_entry_set_src_l4_port		$nat_entry				$L4_SRC_PORT
ca_nat_entry_set_dst_l4_port		$nat_entry				$L4_DST_PORT
ca_nat_entry_set_xlate_flags		$nat_entry				$XLATE_FLAGS
ca_nat_entry_set_new_src_l4_port	$nat_entry				$NEW_L4_SRC_PORT
ca_nat_entry_set_new_dst_l4_port	$nat_entry				$NEW_L4_DST_PORT
ca_nat_entry_set_aging_timer		$nat_entry				$AGING_TIMER

ca_nat_entry_delete 0 $nat_entry

