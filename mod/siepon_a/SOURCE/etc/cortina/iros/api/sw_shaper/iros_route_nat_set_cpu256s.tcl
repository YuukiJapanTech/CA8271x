
##########################
####   Add CLS Rule   ####
##########################

source /etc/cortina/iros/api/sw_shaper/iros_cls_set_cpu256_default_shaper.tcl
source /etc/cortina/iros/api/sw_shaper/iros_cls_set_cpu256s.tcl

## create LAN interface
source /etc/cortina/iros/api/intf/add_lan.tcl
## turn on nat_enable
set l3_intf [ ca_l3_intf_create ]

ca_l3_intf_set_intf_id $l3_intf   1
ca_l3_intf_get 0 $l3_intf
ca_l3_intf_set_nat_enable $l3_intf  1
ca_l3_intf_update 0 $l3_intf

## setup interface id for all of shapers
set src_ipaddr 0xc0a80164
set dst_ipaddr 0xc0a86464
set wan_intf_id   6
set port_id 	0x40020

## setup WAN interface
source /etc/cortina/iros/api/intf/add_wan_cpu256.tcl

## setup nexthop/NAT for default shaper
set src_ipaddr 0xc0a801e3
set dst_ipaddr 0xc0a864e3

## each sw shaper should setup nexthop/NAT entry
## setup nexthop
source /etc/cortina/iros/api/route/add_nexthop_cpu256.tcl

## setup nat
source /etc/cortina/iros/api/nat/nat_entry_add_lan_to_wan_cpu256.tcl

## setup nexthop/NAT for shapers
set src_ipaddr 0xc0a80164
set dst_ipaddr 0xc0a86464

for {set i 0} {$i < 8} {incr i} {

	set tmp_src_ipaddr [ format %x $src_ipaddr ]
	set tmp_dst_ipaddr [ format %x $dst_ipaddr ]
	puts "src_ipaddr=$tmp_src_ipaddr"
	puts "dst_ipaddr=$tmp_dst_ipaddr"

	## setup nexthop
	source /etc/cortina/iros/api/route/add_nexthop_cpu256.tcl

	## setup nat
	source /etc/cortina/iros/api/nat/nat_entry_add_lan_to_wan_cpu256.tcl

	incr src_ipaddr
	incr dst_ipaddr
}

