ca_tput_init 0

    if { $argc != 7 } {
        puts "iperf-test-up.tcl requires four parameters"
	puts "parm1: srcIP  -32-bit"
	puts "parm2: dstIP  -32-bit"
	puts "parm3: srcIP  -16bit" 
	puts "parm4: dstIP  -16bit"
	puts "parm5: rate   - 32-bit"
	puts "parm6: pkt_burst - 32-bit"
	puts "parm7: pkt_size - 32-bit"
	puts "Using defaults"
	set  SRC_IP_ADDR                     0xc0a86401              ;# 192.168.100.1
	set  DST_IP_ADDR                     0xc0a86464              ;# 192.168.100.100
	set  L4_SRC_PORT                     0x3f
	set  L4_DST_PORT                     0x3f
	set  TX_RATE                         200
	set  TX_COUNT                        0x20
	set  TOL_LEN                         0x2e

    } else {

	puts "argv: $argv"
	puts "argc: $argc"

	scan [lindex $argv 0] %s TMP
	set  SRC_IP_ADDR                     0x$TMP
	puts $SRC_IP_ADDR

	scan [lindex $argv 1] %s TMP
	set  DST_IP_ADDR                     0x$TMP
	puts $DST_IP_ADDR

	scan [lindex $argv 2] %d L4_SRC_PORT
	puts $L4_SRC_PORT

	scan [lindex $argv 3] %d L4_DST_PORT
	puts $L4_DST_PORT

	scan [lindex $argv 4] %d TX_RATE
	puts $TX_RATE

	scan [lindex $argv 5] %d TX_COUNT
	puts $TX_COUNT

	scan [lindex $argv 6] %d TOL_LEN
	puts $TOL_LEN
    }

set		ADDR_LEN			32
set             IP_PROTOCOL                     17
set		FLOW_COUNT			1
set		TOS				0
set		TTL				0x40
set		ID				0
set		FRAG_OFF			0

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
ca_tput_upstream_flow_spec_set_dst_ip_addr      		$upstream_flow_entry		$dst_ip_addr
ca_tput_upstream_flow_spec_set_src_ip_addr        		$upstream_flow_entry		$src_ip_addr
ca_tput_upstream_flow_spec_set_tos				$upstream_flow_entry		$TOS
ca_tput_upstream_flow_spec_set_tot_len				$upstream_flow_entry		$TOL_LEN
ca_tput_upstream_flow_spec_set_frag_off				$upstream_flow_entry		$FRAG_OFF
ca_tput_upstream_flow_spec_set_ttl				$upstream_flow_entry		$TTL
ca_tput_upstream_flow_spec_set_id 				$upstream_flow_entry		$ID
ca_tput_upstream_flow_spec_set_tx_count				$upstream_flow_entry		$TX_COUNT	
ca_tput_upstream_flow_spec_set_tx_rate				$upstream_flow_entry		$TX_RATE	
;# ca_tput_upstream_flow_spec_dump $upstream_flow_entry

ca_tput_upstream_test_start 0 $FLOW_COUNT $upstream_flow_entry
