
proc del_tunnel_help {} {
	puts "Usage:"
	puts "  del_tunnel TUNNEL_ID"
}

proc del_tunnel {{tunnel_id -1}} {

	if {$tunnel_id < 0} {
		del_tunnel_help
		return 0
	}

	set ret [ ca_tunnel_delete 0 $tunnel_id ]
	if {$ret != 0} {
		puts "ca_tunnel_delete() is failed. (ret=$ret)"
		return -1
	}

	puts "Tunnel of ID $tunnel_id is deleted."
	return 0
}

puts "Function del_tunnel() is loaded."
del_tunnel_help

