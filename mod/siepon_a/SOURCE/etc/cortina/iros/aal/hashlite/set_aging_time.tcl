## Set aging time for each hash entry in HashLite.

proc set_aging_time_help {} {
	puts "Usage:"
	puts "  set_aging_time HASH_IDX AGING"
	puts ""
	puts "The valid range of AGING is 0 to 15."
	puts "  0: hash entry is aged / invalid."
	puts "  1 ~ 14: Hash entry is aging. The larger the longer."
	puts "  15: Hash entry is never aged. Static entry."
}

proc set_aging_time {{hash_idx -1} {aging 14}} {

	if {$hash_idx < 0} {
		set_aging_time_help
		return 0
	}

	set ret [ ca_aal_hashlite_age_set 0 $hash_idx $aging ]
	if {$ret != 0} {
		puts "ca_aal_hashlite_age_set() is failed. (ret=$ret)"
		return -1
	}

	puts "Aging of hash_idx $hash_idx in HashLite is set to $aging."
	return 0
}

puts "Function set_aging_time() is loaded."
set_aging_time_help

