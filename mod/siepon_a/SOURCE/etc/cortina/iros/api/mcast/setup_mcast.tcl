## Functions:
## mcast_l3_l2_add: Add IPv4 IGMPv3 group
## mcast_l2_delete_all: Delete all L2 node
##
## Test steps:
## mcast_l3_l2_add -> mcast_l2_delete_all -> mcast_l3_delete_all

source /etc/cortina/iros/qa/iros_lib.tcl

## DELETE

proc mcast_l2_delete_all {} {
	set ret [ca_l2_mcast_group_delete_all 0]
}

######################################## L3 only #########################################

proc l3_intf_add {} {
	set intf [ca_l3_intf_create]
	set mac_addr [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x02 ]
	set ip [ca_ip_address_create]
	set addr [ca_l3_ip_addr_create]

	ca_l3_ip_addr_set_ipv4_addr		$addr	0xC0A80001
	ca_ip_address_set_afi			$ip	0
	ca_ip_address_set_ip_addr		$ip	$addr
	ca_ip_address_set_addr_len		$ip	32
	ca_l3_intf_set_mac_addr			$intf	$mac_addr
	ca_l3_intf_set_port_id			$intf	0x19
	ca_l3_intf_set_intf_id			$intf	5
	ca_l3_intf_set_ip_addr			$intf	$ip

	set ret [ca_l3_intf_add 0 $intf]

	ca_l3_intf_set_port_id			$intf	2
	ca_l3_intf_set_intf_id			$intf	6
	ca_l3_intf_set_vid			$intf	100

	set ret [ca_l3_intf_add 0 $intf]
}

proc mcast_l3_l2_add {} {
	for {set b 1} {$b <=1} {incr b 1} {
		set l3mc$b [g3_mcast type=l3 ip=224.1.1.$b src=192.168.1.1]
		g3_mcast_add [set l3mc$b]
		g3_mcast_join [set l3mc$b] intf_id=1
		set l2mc$b [g3_mcast type=l2 ip=224.1.1.$b src=192.168.1.1 vid=0xFFFF]
		g3_mcast_add [set l2mc$b]
		g3_mcast_join [set l2mc$b] port=0x30002 vcmd=push vid=100 da=01:02:03:04:05:06
		g3_mcast_join [set l2mc$b] port=0x30003 da=01:02:03:04:05:06
	}
}

proc mcast_l3_l2_256_add {} {
	for {set b 0} {$b <=255} {incr b 1} {
		set l3mc$b [g3_mcast type=l3 ip=224.1.1.$b]
		g3_mcast_add [set l3mc$b]
		g3_mcast_join [set l3mc$b] intf_id=1
		set l2mc$b [g3_mcast type=l2 ip=224.1.1.$b vid=0xFFFF]
		g3_mcast_add [set l2mc$b]
		g3_mcast_join [set l2mc$b] port=0x30002 vcmd=push vid=100 da=01:02:03:04:05:06
		g3_mcast_join [set l2mc$b] port=0x30003 da=01:02:03:04:05:06
	}
}

proc mcast_l3_only_add {} {
	for {set b 1} {$b <=1} {incr b 1} {
		set l3mc$b [g3_mcast type=l3 ip=224.1.1.$b src=192.168.1.1]
		g3_mcast_add [set l3mc$b]
		g3_mcast_join [set l3mc$b] intf_id=1
	}
}

proc mcast_l2_only_add {} {
	for {set b 1} {$b <=1} {incr b 1} {
		set l2mc$b [g3_mcast type=l2 ip=224.1.1.$b src=192.168.1.1 vid=0x20]
		g3_mcast_add [set l2mc$b]
		g3_mcast_join [set l2mc$b] port=0x30002
	}
}

proc mcast_config_set {} {
	set mc_config [ca_l2_mcast_config_create]
	ca_l2_mcast_config_set_unknown_multicast_flooding_enable $mc_config 0
	ca_l2_mcast_config_set_mode $mc_config 2
	ca_l2_mcast_config_set_igmp_use_mc_vlan $mc_config 1
	ca_l2_mcast_config_set_mld_use_mc_vlan $mc_config 1
	set ret [ca_l2_mcast_config_set 0 $mc_config]
}

proc mcast_cls_l2_add {} {
	for {set b 1} {$b <=1} {incr b 1} {
		set l2mc$b [g3_mcast type=l2 vid=0xFFFF mc_llid=0x88$b]
		g3_mcast_add [set l2mc$b]
		g3_mcast_join [set l2mc$b] port=0x30002 vcmd=push vid=100 da=01:02:03:04:05:06
		g3_mcast_join [set l2mc$b] port=0x30003 da=01:02:03:04:05:06
	}
}

## DELETE
proc mcast_l3_delete_all {} {
	set ret [ca_l3_mcast_group_delete_all 0]
}

