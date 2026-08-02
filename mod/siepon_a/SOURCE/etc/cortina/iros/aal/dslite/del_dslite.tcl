
proc del_dslite_help {} {
	puts "*** Only delete entry in DS-Lite table ***"
	puts ""
	puts "Usage:"
	puts "  del_dslite DSLITE_IDX"
}

proc del_dslite {{dslite_idx -1}} {

	if {$dslite_idx < 0} {
		del_dslite_help
		return 0
	}

	set ret [ ca_aal_dsl_delete 0 $dslite_idx ]
	if {$ret != 0} {
		puts "ca_aal_dsl_delete() is failed. (ret=$ret)"
		return -1
	}

	puts "dslite_idx $dslite_idx in DS-Lite Table is deleted."
	return 0
}

puts "Function del_dslite() is loaded."
del_dslite_help

