ca_tput_init 0

set		SRC_IP_ADDR			0x0a0a0001    	;# 10.10.0.1
set		DST_IP_ADDR			0x0a0a0005   	;# 10.10.0.5
set		ADDR_LEN			32
set		IP_PROTOCOL			17
set		L4_SRC_PORT			0x3f
set		L4_DST_PORT			0x3f
set		RX_COUNT			20000
set		FLOW_COUNT			1

;#      SRC_IP_ADDR
set l3_src_ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr                     $l3_src_ip_addr                 $SRC_IP_ADDR
set src_ip_addr [ ca_ip_address_create ]
ca_ip_address_set_afi                           $src_ip_addr                    0
ca_ip_address_set_ip_addr                       $src_ip_addr                    $l3_src_ip_addr
ca_ip_address_set_addr_len                      $src_ip_addr                    $ADDR_LEN

;#      DST_IP_ADDR
set l3_dst_ip_addr [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr                     $l3_dst_ip_addr                 $DST_IP_ADDR
set dst_ip_addr [ ca_ip_address_create ]
ca_ip_address_set_afi                           $dst_ip_addr                    0
ca_ip_address_set_ip_addr                       $dst_ip_addr                    $l3_dst_ip_addr
ca_ip_address_set_addr_len                      $dst_ip_addr                    $ADDR_LEN


set downstream_flow_entry [ ca_tput_downstream_flow_spec_create]
ca_tput_downstream_flow_spec_set_ip_proto		$downstream_flow_entry		$IP_PROTOCOL
ca_tput_downstream_flow_spec_set_l4_dst_port		$downstream_flow_entry		$L4_DST_PORT
ca_tput_downstream_flow_spec_set_l4_src_port		$downstream_flow_entry		$L4_SRC_PORT
ca_tput_downstream_flow_spec_set_dst_ip_addr            $downstream_flow_entry		$dst_ip_addr
ca_tput_downstream_flow_spec_set_src_ip_addr            $downstream_flow_entry		$src_ip_addr
ca_tput_downstream_flow_spec_set_rx_count		$downstream_flow_entry		$RX_COUNT
;# ca_tput_downstream_flow_spec_dump			$downstream_flow_entry

;#exec echo 0x20 >  /proc/driver/cortina/aal/aal_debug

set ret [ca_tput_downstream_test_start 0 $FLOW_COUNT $downstream_flow_entry]
if {$ret != 0} {
	puts "==== Throughput RX test fail ret = $ret ??"
} else {
	puts "==== Throughput RX test start !!"
	set i 0
	set rx_pkt_cnt [ca_uint32_create 0]
	set ret 10

	while {$i < 20} {
		incr i
		after 1000

		set ret [ca_tput_downstream_test_stats_get 0 $rx_pkt_cnt]
		set rx [ca_uint32_get $rx_pkt_cnt]
		if {$ret != 0} {
			puts "."
		} else {
			puts "rcv pkt count: $rx"
			set i 100
		}
	}

	set ret [ca_tput_downstream_test_stop 0]
	puts "==== Throughput RX test done ret = $ret"
}
