set config [ us_rate_manager_global_control_create ]
us_rate_manager_global_control_set_max_rate_manager_app_spec_streams            $config         248
us_rate_manager_global_control_set_default_stream_bandwidth_percentage          $config         40
#/*cir_only = 0, strict_priority = 1 , cir_ratio = 2 */
us_rate_manager_global_control_set_remaining_bandwidth_distribution_scheme      $config         2
#/*schedule_sp  = 0, schedule_wrr = 1*/
us_rate_manager_global_control_set_default_stream_scheduler                     $config         1
us_rate_manager_global_control_set_default_stream_voq_weigths  $config 0x1 0
us_rate_manager_global_control_set_default_stream_voq_weigths  $config 0x2 1
us_rate_manager_global_control_set_default_stream_voq_weigths  $config 0x3 2
us_rate_manager_global_control_set_default_stream_voq_weigths  $config 0x4 3
us_rate_manager_global_control_set_default_stream_voq_weigths  $config 0x5 4
us_rate_manager_global_control_set_default_stream_voq_weigths  $config 0x6 5
us_rate_manager_global_control_set_default_stream_voq_weigths  $config 0x7 6
us_rate_manager_global_control_set_default_stream_voq_weigths  $config 0x8 7
us_rate_manager_global_control_set_max_egress_rate             $config   800000
ca_us_rate_manager_global_configuration_set  0  $config

source us_rate_manager-proc.tcl
ca_us_rate_manager_delete_all 0
for {set j 0} {$j < 8} {incr j} {
  for {set i 0} {$i < 16} {incr i} {
        set id [expr $j * 16 + $i]
	
        if {$i < 2 } {
                set_us_rate_manager $id  1000 10000 0
        } elseif {$i <= 3} {
                set_us_rate_manager $id 2000 20000 0
        } elseif {$i <= 7} {
                set_us_rate_manager $id 4000 40000 0
        } elseif {$i <= 15} {
                set_us_rate_manager $id 8000 80000 0
        } else {
                set_us_rate_manager $id 4000 40000 0
        }
  }
}

ca_classifier_rule_delete_all 0

proc call_set_cpu256 { udp_dst_port tmp_rule_idx flow_id shaper_id} {

        ##set tmp_src_ipaddr [ format %x $src_ipaddr ]
        ##set tmp_dst_ipaddr [ format %x $dst_ipaddr ]
        puts "tmp_rule_idx=$tmp_rule_idx"
        puts "flow_id=$flow_id"
        puts "shaper_id=$shaper_id"
        #puts "src_ipaddr=$tmp_src_ipaddr"
        #puts "dst_ipaddr=$tmp_dst_ipaddr"
        puts "udp_dst_port=$udp_dst_port"

        ## call the set one shaper sub routine
        source iros_cls_set_cpu256.tcl

        set rule_idx [ ca_uint32_create $tmp_rule_idx ]
        set index [ ca_uint32_get $rule_idx ]
        puts "rule_idx=$index"

        set ret [ ca_classifier_rule_add 0 11 $key $key_mask $action $rule_idx ]
        if {$ret != 0} {
                puts "ca_classifier_rule_add() is failed! (ret=$ret)"
        } else {
                set cls_rule_idx [ ca_uint32_get $rule_idx ]
                puts "cls_rule_idx = $cls_rule_idx"
        }
}

set tmp_rule_idx 1
set flow_id 1
set shaper_id 0
set udp_dst_port 49920

for {set i 0} {$i < 128} {incr i} {

        call_set_cpu256 $udp_dst_port $tmp_rule_idx $flow_id $shaper_id

        incr tmp_rule_idx
#        incr flow_id
        incr shaper_id
        incr udp_dst_port
}
