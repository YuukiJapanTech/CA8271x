
set p_up_packet_sent [ca_uint32_create 0]
ca_tput_upstream_test_stats_get 0 $p_up_packet_sent

set p_down_packet_sent [ca_uint32_create 0]
ca_tput_downstream_test_stats_get 0 $p_down_packet_sent

set ret [ca_tput_downstream_test_stop 0]
puts "==== DS ret = $ret"

