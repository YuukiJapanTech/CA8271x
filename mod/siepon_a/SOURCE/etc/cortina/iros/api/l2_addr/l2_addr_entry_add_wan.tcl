### Add WAN MAC address to FDB for L3_WAN(0x18)
set l2_addr [ ca_l2_addr_entry_create ]
set l2_mac [ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x01]
ca_l2_addr_entry_set_mac_addr $l2_addr $l2_mac
##ca_l2_addr_entry_set_key_vid $l2_addr 0
ca_l2_addr_entry_set_vid $l2_addr 0
ca_l2_addr_entry_set_static_flag $l2_addr 1
ca_l2_addr_entry_set_port_id $l2_addr 0x18
ca_l2_addr_entry_set_mc_group_id $l2_addr 0xffffffff
ca_l2_addr_entry_set_aging_timer $l2_addr 65535
ca_l2_addr_entry_set_da_permit $l2_addr 1
ca_l2_addr_add 0 $l2_addr

### Disable unknown vlan drop for Port 3
set port_control [ca_vlan_port_control_create ]
ca_l2_vlan_port_control_get 0 0x30003 $port_control
ca_vlan_port_control_set_drop_unknown_vlan $port_control 0
ca_l2_vlan_port_control_set 0 0x30003 $port_control
