
proc del_lpm_help {} {
	puts "Usage:"
	puts "  del_lpm lpm_IDX"
}

proc del_lpm {{lpm_idx -1}} {

	if {$lpm_idx < 0} {
		del_lpm_help
		return 0
	}

	set ret [ ca_aal_lpm_delete 0 $lpm_idx ]
	if {$ret != 0} {
		puts "ca_aal_lpm_delete() is failed. (ret=$ret)"
		return -1
	}

	puts "lpm_idx $lpm_idx in LPM is deleted."
	return 0
}

puts "Function del_lpm() is loaded."
del_lpm_help

