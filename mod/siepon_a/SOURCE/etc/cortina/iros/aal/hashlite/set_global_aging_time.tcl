## Set global aging time in second.
## This is for all hash entries in HashLite.

set time_in_sec		30

set ret [ ca_aal_hashlite_aging_timer_set 0 $time_in_sec ]
if {$ret != 0} {
	puts "ca_aal_hashlite_aging_timer_set() is failed. (ret=$ret)"
} else {
	puts "Global aging time is $time_in_sec second(s) in HashLite."
}

