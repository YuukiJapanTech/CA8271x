################
## WAN nexthop
################
ca_l3_nexthop_aging_timer_set 1 300
## create a nexthop
set l3_nexthop_wan  [ ca_l3_nexthop_create ]

## set ip address
set ip_address_wan [ ca_ip_address_create ]
##ca_ip_address_set_afi $ip_address_wan 0

set ip_addr_wan [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr  $ip_addr_wan 0xc0a86465

ca_ip_address_set_ip_addr  $ip_address_wan $ip_addr_wan
ca_ip_address_set_addr_len $ip_address_wan 32

## set intf if
ca_l3_nexthop_set_addr  $l3_nexthop_wan   $ip_address_wan
ca_l3_nexthop_set_intf_id  $l3_nexthop_wan  4

## set MAC address
set mac_addr_wan [ ca_mac_addr_create 0x00 0xc0 0x52 0x00 0x01 0x01 ]
ca_l3_nexthop_set_da_mac  $l3_nexthop_wan $mac_addr_wan

## set attr to static
ca_l3_nexthop_set_attr_flags $l3_nexthop_wan 1

set nexthop_id_wan [ ca_uint16_create 0 ]
ca_l3_nexthop_add 1 $l3_nexthop_wan $nexthop_id_wan
set nexthop_id_wan_value [ ca_uint16_get $nexthop_id_wan ]
puts nexthop_id_wan_value=$nexthop_id_wan_value

##ca_l3_nexthop_dump $l3_nexthop_wan

################
## LAN nexthop
################
ca_l3_nexthop_aging_timer_set 1 300
## create a nexthop
set l3_nexthop_lan  [ ca_l3_nexthop_create ]

## set ip address
set ip_address_lan [ ca_ip_address_create ]
##ca_ip_address_set_afi $ip_address_lan 0

set ip_addr_lan [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr  $ip_addr_lan 0xc0a80165

ca_ip_address_set_ip_addr  $ip_address_lan $ip_addr_lan
ca_ip_address_set_addr_len $ip_address_lan 32

## set intf if
ca_l3_nexthop_set_addr  $l3_nexthop_lan   $ip_address_lan
ca_l3_nexthop_set_intf_id  $l3_nexthop_lan  1

## set MAC address
set mac_addr_lan [ ca_mac_addr_create 0x00 0xc0 0x52 0x00 0x01 0x02 ]
ca_l3_nexthop_set_da_mac  $l3_nexthop_lan $mac_addr_lan

## set attr to static
ca_l3_nexthop_set_attr_flags $l3_nexthop_lan 1

set nexthop_id_lan [ ca_uint16_create 0 ]
ca_l3_nexthop_add 1 $l3_nexthop_lan $nexthop_id_lan

set nexthop_id_lan_value [ ca_uint16_get $nexthop_id_lan ]
puts nexthop_id_lan_value=$nexthop_id_lan_value

ca_l3_nexthop_dump $l3_nexthop_lan

