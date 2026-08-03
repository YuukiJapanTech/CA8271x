set		ADDR_LEN			128
set		IP_PROTOCOL			17
set		L4_SRC_PORT			0x3f
set		L4_DST_PORT			0x3f
set		NEW_L4_SRC_PORT			0x64
set		NEW_L4_DST_PORT			0x3f
set		AGING_TIMER			0

;#	Enable change SIP(0x1 << 0)
;#	Enable change DIP(0x1 << 1)
;#	Enable change port ID(0x1 << 2)
set		XLATE_FLAGS			5				;#	SNAT:5	DNAT:6

set		SRC_IP_ADDR_0			0x20500000 			;# 2050::230/128
set		SRC_IP_ADDR_1			0x00000000			;#
set		SRC_IP_ADDR_2			0x00000000			;#
set		SRC_IP_ADDR_3			0x00000230			;#

set		DST_IP_ADDR_0			0x10600000 			;# 1060::210/128
set		DST_IP_ADDR_1			0x00000000			;#
set		DST_IP_ADDR_2			0x00000000			;#
set		DST_IP_ADDR_3			0x00000210			;#

set		NEW_SRC_IP_ADDR_0		0x11600000 			;# 1160::220/128
set		NEW_SRC_IP_ADDR_1		0x00000000			;#
set		NEW_SRC_IP_ADDR_2		0x00000000			;#
set		NEW_SRC_IP_ADDR_3		0x00000220			;#

set		NEW_DST_IP_ADDR_0		0x10600000 			;# 1060::210/128
set		NEW_DST_IP_ADDR_1		0x00000000			;#
set		NEW_DST_IP_ADDR_2		0x00000000			;#
set		NEW_DST_IP_ADDR_3		0x00000210			;#


;#	SRC_IP_ADDR
set l3_src_ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr			$l3_src_ip_addr			$SRC_IP_ADDR_0	0
ca_l3_ip_addr_set_ipv6_addr			$l3_src_ip_addr			$SRC_IP_ADDR_1	1
ca_l3_ip_addr_set_ipv6_addr			$l3_src_ip_addr			$SRC_IP_ADDR_2	2
ca_l3_ip_addr_set_ipv6_addr			$l3_src_ip_addr			$SRC_IP_ADDR_3	3
set src_ip_addr [ ca_ip_address_create ]
ca_ip_address_set_afi				$src_ip_addr			1
ca_ip_address_set_ip_addr			$src_ip_addr			$l3_src_ip_addr
ca_ip_address_set_addr_len			$src_ip_addr			$ADDR_LEN

;#	DST_IP_ADDR
set l3_dst_ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr			$l3_dst_ip_addr			$DST_IP_ADDR_0	0
ca_l3_ip_addr_set_ipv6_addr			$l3_dst_ip_addr			$DST_IP_ADDR_1	1
ca_l3_ip_addr_set_ipv6_addr			$l3_dst_ip_addr			$DST_IP_ADDR_2	2
ca_l3_ip_addr_set_ipv6_addr			$l3_dst_ip_addr			$DST_IP_ADDR_3	3
set dst_ip_addr [ ca_ip_address_create ]
ca_ip_address_set_afi				$dst_ip_addr			1
ca_ip_address_set_ip_addr			$dst_ip_addr			$l3_dst_ip_addr
ca_ip_address_set_addr_len			$dst_ip_addr			$ADDR_LEN

;#	NEW_SRC_IP_ADDR
set l3_new_src_ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr			$l3_new_src_ip_addr		$NEW_SRC_IP_ADDR_0	0
ca_l3_ip_addr_set_ipv6_addr			$l3_new_src_ip_addr		$NEW_SRC_IP_ADDR_1	1
ca_l3_ip_addr_set_ipv6_addr			$l3_new_src_ip_addr		$NEW_SRC_IP_ADDR_2	2
ca_l3_ip_addr_set_ipv6_addr			$l3_new_src_ip_addr		$NEW_SRC_IP_ADDR_3	3
set new_src_ip_addr [ ca_ip_address_create ]
ca_ip_address_set_afi				$new_src_ip_addr		1
ca_ip_address_set_ip_addr			$new_src_ip_addr		$l3_new_src_ip_addr
ca_ip_address_set_addr_len			$new_src_ip_addr		$ADDR_LEN

;#	NEW_DST_IP_ADDR
set l3_new_dst_ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv6_addr			$l3_new_dst_ip_addr		$NEW_DST_IP_ADDR_0	0
ca_l3_ip_addr_set_ipv6_addr			$l3_new_dst_ip_addr		$NEW_DST_IP_ADDR_1	1
ca_l3_ip_addr_set_ipv6_addr			$l3_new_dst_ip_addr		$NEW_DST_IP_ADDR_2	2
ca_l3_ip_addr_set_ipv6_addr			$l3_new_dst_ip_addr		$NEW_DST_IP_ADDR_3	3
set new_dst_ip_addr [ ca_ip_address_create ]
ca_ip_address_set_afi				$new_dst_ip_addr		1
ca_ip_address_set_ip_addr			$new_dst_ip_addr		$l3_new_dst_ip_addr
ca_ip_address_set_addr_len			$new_dst_ip_addr		$ADDR_LEN



set nat_entry [ ca_nat_entry_create]
ca_nat_entry_set_new_dst_ip_addr		$nat_entry			$new_dst_ip_addr
ca_nat_entry_set_new_src_ip_addr		$nat_entry			$new_src_ip_addr
ca_nat_entry_set_dst_ip_addr			$nat_entry			$dst_ip_addr
ca_nat_entry_set_src_ip_addr			$nat_entry			$src_ip_addr
ca_nat_entry_set_ip_proto			$nat_entry			$IP_PROTOCOL
ca_nat_entry_set_src_l4_port			$nat_entry			$L4_SRC_PORT
ca_nat_entry_set_dst_l4_port			$nat_entry			$L4_DST_PORT
ca_nat_entry_set_xlate_flags			$nat_entry			$XLATE_FLAGS
ca_nat_entry_set_new_src_l4_port		$nat_entry			$NEW_L4_SRC_PORT
ca_nat_entry_set_new_dst_l4_port		$nat_entry			$NEW_L4_DST_PORT
ca_nat_entry_set_aging_timer			$nat_entry			$AGING_TIMER


ca_nat_entry_add	0	$nat_entry
