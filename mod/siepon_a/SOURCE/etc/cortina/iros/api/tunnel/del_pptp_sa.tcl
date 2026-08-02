
proc del_pptp_sa_help {} {
	puts "Usage:"
	puts "  del_pptp_sa SA_ID"
}

proc del_pptp_sa {{sa_id -1}} {

	if {$sa_id < 0} {
		del_pptp_sa_help
		return 0
	}

	set ret [ ca_pptp_sa_delete 0 $sa_id ]
	if {$ret != 0} {
		puts "ca_pptp_sa_delete() is failed. (ret=$ret)"
		return -1
	}

	puts "PPTP SA of ID $sa_id is deleted."
	return 0
}

puts "Function del_pptp_sa() is loaded."
del_pptp_sa_help

