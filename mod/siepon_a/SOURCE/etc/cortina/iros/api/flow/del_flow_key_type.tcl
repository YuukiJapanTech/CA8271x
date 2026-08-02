
proc del_flow_key_type_help {} {
	puts "Usage:"
	puts "  del_flow_key_type FLOW_KEY_TYPE"
}

proc del_flow_key_type {{flow_key_type -1}} {

	if {$flow_key_type < 0} {
		del_flow_key_type_help
		return 0
	}

	set ret [ ca_flow_key_type_delete 0 $flow_key_type ]
	if {$ret != 0} {
		puts "ca_flow_key_type_delete() is failed. (ret=$ret)"
		return -1
	}

	puts "Flow Key Type $flow_key_type is deleted."
	return 0
}

puts "Function del_flow_key_type() is loaded."
del_flow_key_type_help

