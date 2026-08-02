
proc del_ipsec_sa_help {} {
	puts "Usage:"
	puts "  del_ipsec_sa SA_ID"
}

proc del_ipsec_sa {{sa_id -1}} {

	if {$sa_id < 0} {
		del_ipsec_sa_help
		return 0
	}

	set ret [ ca_ipsec_sa_delete 0 $sa_id ]
	if {$ret != 0} {
		puts "ca_ipsec_sa_delete() is failed. (ret=$ret)"
		return -1
	}

	puts "IPSec SA of ID $sa_id is deleted."
	return 0
}

puts "Function del_ipsec_sa() is loaded."
del_ipsec_sa_help

