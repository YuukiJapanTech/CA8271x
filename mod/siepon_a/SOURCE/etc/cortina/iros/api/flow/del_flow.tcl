
proc del_flow_help {} {
	puts "Usage:"
	puts "  del_flow FLOW_ID"
}

proc del_flow {{flow_id -1}} {

	if {$flow_id < 0} {
		del_flow_help
		return 0
	}

	set ret [ ca_flow_delete 0 $flow_id ]
	if {$ret != 0} {
		puts "ca_flow_delete() is failed. (ret=$ret)"
		return -1
	}

	puts "Flow ID $flow_id is deleted."
	return 0
}

puts "Function del_flow() is loaded."
del_flow_help

