
proc del_hash_help {} {
	puts "Usage:"
	puts "  del_hash HASH_IDX"
}

proc del_hash {{hash_idx -1}} {

	if {$hash_idx < 0} {
		del_hash_help
		return 0
	}

	set ret [ ca_aal_hashlite_hash_delete 0 $hash_idx ]
	if {$ret != 0} {
		puts "ca_aal_hashlite_hash_delete() is failed. (ret=$ret)"
		return -1
	}

	puts "hash_idx $hash_idx in HashLite is deleted."
	return 0
}

puts "Function del_hash() is loaded."
del_hash_help

