## Get aging time for each hash entry in HashLite.

proc get_aging_time_help {} {
	puts "Usage:"
	puts "  get_aging_time HASH_IDX"
	puts ""
	puts "The clock of FPGA board runs 10 times slower, so the returned time is 10 times smaller."
}

proc get_aging_time {{hash_idx -1}} {

	if {$hash_idx < 0} {
		get_aging_time_help
		return 0
	}

	set ret_age [ ca_uint32_create 0 ]
	set ret_time [ ca_uint32_create 0 ]

	set ret [ ca_aal_hashlite_age_get 0 $hash_idx $ret_age $ret_time ]
	if {$ret != 0} {
		puts "ca_aal_hashlite_age_get() is failed. (ret=$ret)"
		return -1
	}

	set age [ ca_uint32_get $ret_age ]
	set time [ ca_uint32_get $ret_time ]

	puts "age = $age rounds"
	puts "time = $time seconds (roughly)"
	return 0
}

puts "Function get_aging_time() is loaded."
get_aging_time_help

