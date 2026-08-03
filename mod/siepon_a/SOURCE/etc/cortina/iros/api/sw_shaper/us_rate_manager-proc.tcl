proc set_us_rate_manager_help {} {
	puts "Usage:"
	puts "  set_us_rate_manager id cir pir sp"
	puts "  example:"
	puts "	  set_us_rate_manager 10 10000 100000 0"
	puts "  =============================="
	puts "  stream#10 cir 10mbps pir 100mbps sp=0"
}

proc set_us_rate_manager  {{id 0} {cir 1000} {pir 1000} {sp 0}} {

	set rate_mgr [ us_rate_manager_app_spec_stream_create ]
	us_rate_manager_app_spec_stream_set_app_stream_id $rate_mgr $id
	us_rate_manager_app_spec_stream_set_cir_kbps $rate_mgr $cir
	us_rate_manager_app_spec_stream_set_pir_kbps $rate_mgr $pir
	us_rate_manager_app_spec_stream_set_strict_prio $rate_mgr $sp

	ca_us_rate_manager_entry_add 0 $rate_mgr

        return 0
}

puts "Function set_us_rate_manager() is loaded."
set_us_rate_manager_help

