
proc del_mask_help {} {
	puts "Usage:"
	puts "  del_mask MASK_IDX"
}

proc del_mask {{mask_idx -1}} {

	if {$mask_idx < 0} {
		del_mask_help
		return 0
	}

	set ret [ ca_aal_hashlite_hashmask_delete 0 $mask_idx ]
	if {$ret != 0} {
		puts "ca_aal_hashlite_hash_delete() is failed. (ret=$ret)"
		return -1
	}

	puts "mask_idx $mask_idx in HashLite is deleted."
	return 0
}

puts "Function del_mask() is loaded."
del_mask_help

