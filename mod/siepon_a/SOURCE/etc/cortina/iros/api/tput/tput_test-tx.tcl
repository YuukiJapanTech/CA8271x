ca_tput_init 0


set		SRC_IP_ADDR			0x0a0a0005  ;# 10.10.0.5
set		DST_IP_ADDR			0x0a0a0001  ;# 10.10.0.1
set		ADDR_LEN			32
set		IP_PROTOCOL			17
set		L4_SRC_PORT			0x3f
set		L4_DST_PORT 		0x3f
set		TX_COUNT			20000
set		FLOW_COUNT			1
set		TOS					0
set		TTL					0x40
set		TOL_LEN				1496		;#IP/UDP length
set		ID					0
set		FRAG_OFF			0
set		TX_RATE				962			;#UDP rate

;#set ::udp_mbps 9621
;#set ::tx_count 20000
if {[info exists ::udp_mbps]} {
   puts "TX_UDP_RATE = $::udp_mbps"
   set	TX_RATE		$::udp_mbps
}

if {[info exists ::tx_count]} {
   puts "TX_COUNT =   $::tx_count"
   set  TX_COUNT 	$::tx_count
}

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

set upstream_flow_entry [ ca_tput_upstream_flow_spec_create]

ca_tput_upstream_flow_spec_set_ip_proto				$upstream_flow_entry		$IP_PROTOCOL
ca_tput_upstream_flow_spec_set_l4_dst_port			$upstream_flow_entry		$L4_DST_PORT
ca_tput_upstream_flow_spec_set_l4_src_port			$upstream_flow_entry		$L4_SRC_PORT
ca_tput_upstream_flow_spec_set_dst_ip_addr      	$upstream_flow_entry		$dst_ip_addr
ca_tput_upstream_flow_spec_set_src_ip_addr        	$upstream_flow_entry		$src_ip_addr
ca_tput_upstream_flow_spec_set_tos					$upstream_flow_entry		$TOS
ca_tput_upstream_flow_spec_set_tot_len				$upstream_flow_entry		$TOL_LEN
ca_tput_upstream_flow_spec_set_frag_off				$upstream_flow_entry		$FRAG_OFF
ca_tput_upstream_flow_spec_set_ttl					$upstream_flow_entry		$TTL
ca_tput_upstream_flow_spec_set_id 					$upstream_flow_entry		$ID
ca_tput_upstream_flow_spec_set_tx_count				$upstream_flow_entry		$TX_COUNT
ca_tput_upstream_flow_spec_set_tx_rate				$upstream_flow_entry		$TX_RATE
;# ca_tput_upstream_flow_spec_dump $upstream_flow_entry

set ret [ca_tput_upstream_test_start 0 $FLOW_COUNT $upstream_flow_entry]
if {$ret != 0} {
        puts "ca_tput_upstream_test_start fail ret = $ret ??"
} else {
        puts "Throughput TX test start!!"
        set i 0
        set tx_pkt_cnt [ca_uint32_create 0]
        set ret 10

        while {$i < 20} {
				incr i
                after 1000

                set ret [ca_tput_upstream_test_stats_get 0 $tx_pkt_cnt]
                set tx [ca_uint32_get $tx_pkt_cnt]
                if {$ret != 0} {
                        puts "."
                } else {
                        puts "tx pkt count: $tx"
			puts "Throughput Tx test done!!"
			set i 100
		}
	}
}
