set config [ us_rate_manager_global_control_create ]
us_rate_manager_global_control_set_max_rate_manager_app_spec_streams            $config         256
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
us_rate_manager_global_control_set_max_egress_rate             $config   2000000
ca_us_rate_manager_global_configuration_set  0  $config

source us_rate_manager-proc.tcl
ca_us_rate_manager_delete_all 0
set_us_rate_manager 7  80000    80000 1
set_us_rate_manager 6  80000  1000000 1
set_us_rate_manager 5 200000 10000000 0
set_us_rate_manager 4 200000 10000000 0
set_us_rate_manager 3 100000 10000000 0
set_us_rate_manager 2 300000 10000000 0

##########################
####   Add CLS Rule   ####
##########################
ca_classifier_rule_delete_all 0

proc call_set_cpu256 { udp_dst_port flow_id shaper_id} {

        ##set tmp_src_ipaddr [ format %x $src_ipaddr ]
        ##set tmp_dst_ipaddr [ format %x $dst_ipaddr ]
        puts "flow_id=$flow_id"
        puts "shaper_id=$shaper_id"
        #puts "src_ipaddr=$tmp_src_ipaddr"
        #puts "dst_ipaddr=$tmp_dst_ipaddr"
        puts "udp_dst_port=$udp_dst_port"

        ## call the set one shaper sub routine
        source iros_cls_set_cpu256.tcl

        set rule_idx [ ca_uint32_create 0]
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

set flow_id 1
set shaper_id 0
set udp_dst_port 49920

call_set_cpu256 50000  0 7
call_set_cpu256 52000  0 6
call_set_cpu256 54000  0 5
call_set_cpu256 56000  0 4
call_set_cpu256 58000  0 3
call_set_cpu256 60000  0 2

