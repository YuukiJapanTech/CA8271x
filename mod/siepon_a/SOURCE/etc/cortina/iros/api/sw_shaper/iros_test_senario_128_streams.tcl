set config [ us_rate_manager_global_control_create ]
us_rate_manager_global_control_set_max_rate_manager_app_spec_streams            $config         256
us_rate_manager_global_control_set_default_stream_bandwidth_percentage          $config         40
us_rate_manager_global_control_set_remaining_bandwidth_distribution_scheme      $config         2
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
        if {$i == 0} {
                set_us_rate_manager $id  1000 10000 0
        } elseif {$i <= 2} {
                set_us_rate_manager $id 2000 20000 0
        } elseif {$i <= 6} {
                set_us_rate_manager $id 4000 40000 0
        } elseif {$i <= 15} {
                set_us_rate_manager $id 8000 80000 0
        } else {
                set_us_rate_manager $id 4000 40000 0
        }
  }
}

source iros_cls_set_cpu256s_128_streams.tcl
