wca_l3_route_delete_all
wca_l3_nexthop_delete_all
wca_l3_intf_delete_all
wca_nat_entry_delete_all
wca_classifier_rule_delete_all

### WAN, gem_id 1024, gem_index 0x1616
wca_l3_intf_add -type 1 -port_id 0x10018 -sub_port_id 0x51616 -mac_addr 00:13:25:00:00:01 -nat_enable 1 -mtu 1500 -outer_vid 100
set intf_wan $aOut(-intf_id)
wca_l3_nexthop_add -device_id 0 -addr 0.0.0.0 -attr_flags 1 -intf_id $intf_wan -da_mac 00:00:00:00:00:00 -aging_timer 0
wca_l3_route_add -device_id 0 -prefix 192.168.0.0/24 -nexthop_id $aOut(-nexthop_id)
wca_l3_nexthop_add -device_id 0 -addr 192.168.0.100 -attr_flags 1 -intf_id $intf_wan -da_mac 00:00:00:00:00:64 -aging_timer 0

### LAN
wca_l3_intf_add -type 1 -port_id 0xa0019 -mac_addr 00:13:25:00:00:02 -nat_enable 1 -mtu 1500 -outer_vid 0xffff
set intf_lan $aOut(-intf_id)
wca_l3_nexthop_add -device_id 0 -addr 0.0.0.0 -attr_flags 1 -intf_id $intf_lan -da_mac 00:00:00:00:00:00 -aging_timer 0
wca_l3_route_add -device_id 0 -prefix 192.168.1.0/24 -nexthop_id $aOut(-nexthop_id)
wca_l3_nexthop_add -device_id 0 -addr 192.168.1.100 -attr_flags 1 -intf_id $intf_lan -da_mac 00:00:00:00:01:64 -aging_timer 0

### GEM mapping
# upstream, egress_if_id 0x1, udp, dport 63 --> dscp 1
wca_classifier_rule_add -src_port 0xa0019 -priority 0 -dst_intf $intf_wan -ip_protocol 0x11 -l4_dst_port 63 -action_option_dscp 1 -action_option_gem_index 0x1616 -action_option_handle_type 1

# upstream for CPU-to-PON, egress_if_id = $intf_wan, udp, dport 63 --> dscp 1
wca_classifier_rule_add -src_port 0xa0010 -priority 0 -dst_intf $intf_wan -action_option_gem_index 0x1616 -action_option_handle_type 1

# downstream
wca_classifier_rule_add -src_port 0x10007 -priority 0 -gem_index 0x1616 -action_dest_fe 1 -action_forward 1

