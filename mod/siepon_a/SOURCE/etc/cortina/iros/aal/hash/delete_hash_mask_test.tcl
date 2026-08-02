
proc del_mask_help {} {
	puts "Usage:"
	puts "  del_mask MASK_IDX"
}

proc del_mask {{mask_idx -1}} {

	if {$mask_idx < 0} {
		del_mask_help
		return 0
	}

	set ret [ aal_mask_tbl_entry_del_iros 0 $mask_idx ]
	if {$ret != 0} {
		puts "aal_mask_tbl_entry_del_iros() is failed. (ret=$ret)"
		return -1
	}

	puts "mask_idx $mask_idx in Hash Engine is deleted."
	return 0
}

puts "Function del_mask() is loaded."
del_mask_help

