### NAT
wca_nat_entry_add -device_id 0 -xlate_flags 0xd -src_ip_addr 192.168.1.100 -src_l4_port 63 -dst_ip_addr 192.168.0.100 -dst_l4_port 63 -ip_proto 0x11 -new_src_ip_addr 192.168.0.1 -new_src_l4_port 63 -new_dst_l4_port 63
wca_nat_entry_add -device_id 0 -xlate_flags 0xe -src_ip_addr 192.168.0.100 -src_l4_port 63 -dst_ip_addr 192.168.0.1 -dst_l4_port 63 -ip_proto 0x11 -new_dst_ip_addr 192.168.1.100 -new_src_l4_port 63 -new_dst_l4_port 63

# override default drop
wca_l2_mac_filter_default_set -port_id 0x30003 -drop_flag 0

