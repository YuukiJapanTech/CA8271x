
proc del_6rd_help {} {
	puts "*** Only delete entry in 6RD table ***"
	puts ""
	puts "Usage:"
	puts "  del_6rd sixrd_idx"
}

proc del_6rd {{sixrd_idx -1}} {

	if {$sixrd_idx < 0} {
		del_6rd_help
		return 0
	}

	set ret [ ca_aal_sixrd_delete 0 $sixrd_idx ]
	if {$ret != 0} {
		puts "ca_aal_sixrd_delete() is failed. (ret=$ret)"
		return -1
	}

	puts "sixrd_idx $sixrd_idx in 6RD Table is deleted."
	return 0
}

puts "Function del_6rd() is loaded."
del_6rd_help

