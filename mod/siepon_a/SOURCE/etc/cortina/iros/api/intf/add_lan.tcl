
### Create LAN interface of type BCAST

# create a intf etnry named
set intf_lan [ ca_l3_intf_create ]

# set type BCAST
ca_l3_intf_set_type $intf_lan 1

# set intf_id
ca_l3_intf_set_intf_id $intf_lan 1

# set port_id
ca_l3_intf_set_port_id $intf_lan 0x30019

# create and set mac_addr
set mac_addr_lan [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x02 ]
ca_l3_intf_set_mac_addr $intf_lan $mac_addr_lan

# set vid
ca_l3_intf_set_vid $intf_lan 0xffff

# set mtu
ca_l3_intf_set_mtu $intf_lan 1280

# create and set lan ip_addr
set ip [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr  $ip_addr 0xc0a80101
ca_ip_address_set_addr_len $ip 24
ca_ip_address_set_ip_addr $ip $ip_addr
ca_l3_intf_set_ip_addr $intf_lan $ip

# set nat_enable
ca_l3_intf_set_nat_enable $intf_lan 0

# Cortina API
ca_l3_intf_add 0 $intf_lan
ca_l3_intf_dump $intf_lan


### Create LAN interface of type CPU

# set intf_id
 #ca_l3_intf_set_intf_id $intf_lan 2

# set type CPU
 #ca_l3_intf_set_type $intf_lan 4

# Cortina API
 #ca_l3_intf_add 0 $intf_lan
 #ca_l3_intf_dump $intf_lan

