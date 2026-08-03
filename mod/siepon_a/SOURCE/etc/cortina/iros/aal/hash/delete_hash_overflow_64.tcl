for {set i 0x10000} { $i<= 0x10040 } {incr i} {
	aal_hash_delete 0 $i
}
