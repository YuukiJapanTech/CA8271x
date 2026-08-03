
### Create WAN interface of type BCAST

# create a intf etnry named
set intf_wan [ ca_l3_intf_create ]

# set type BCAST
ca_l3_intf_set_type $intf_wan 1

# set intf_id
ca_l3_intf_set_intf_id $intf_wan 4

# set port_id
ca_l3_intf_set_port_id $intf_wan 0x30018

# create and set mac_addr
set mac_addr_wan [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x01 ]
ca_l3_intf_set_mac_addr $intf_wan $mac_addr_wan

# set vid
ca_l3_intf_set_vid $intf_wan 0xffff

# set tunnel_id
##ca_l3_intf_set_tunnel_id $intf_wan 1895

# set mtu
ca_l3_intf_set_mtu $intf_wan 1280

# create and set wan ip_addr
set ip_wan [ ca_ip_address_create ]
set ip_addr_wan [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr  $ip_addr_wan 0xc0a86401
ca_ip_address_set_addr_len $ip_wan 32
ca_ip_address_set_ip_addr $ip_wan $ip_addr_wan
ca_l3_intf_set_ip_addr $intf_wan $ip_wan

# set nat_enable
ca_l3_intf_set_nat_enable $intf_wan 0

# set session id
##ca_l3_intf_set_pppoe_session_id $intf_wan 4321

# Cortina API
ca_l3_intf_add 0 $intf_wan
ca_l3_intf_dump $intf_wan

### Create WAN interface of type CPU

# set intf_id
 #ca_l3_intf_set_intf_id $intf_wan 5

# set type CPU
 #ca_l3_intf_set_type $intf_wan 4

# Cortina API
 #ca_l3_intf_add 0 $intf_wan
 #ca_l3_intf_dump $intf_wan

