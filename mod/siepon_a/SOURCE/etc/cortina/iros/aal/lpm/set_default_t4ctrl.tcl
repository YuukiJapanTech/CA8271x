## Set default t4ctrl (NextHop profile#).
## There are two default t4ctrl for each IPv4 or IPv6,
## it is chosen by rst_ctrl of LPM entry.

set v4_t4ctrl_0		0
set v4_t4ctrl_1		14
set v6_t4ctrl_0		0
set v6_t4ctrl_1		14

set ret [ ca_aal_lpm_default_t4ctrl_set 0 0 $v4_t4ctrl_0 $v4_t4ctrl_1 ]
if {$ret != 0} {
	puts "ca_aal_lpm_default_t4ctrl_set() for IPv4 is failed. (ret=$ret)"
} else {
	puts "IPv4 t4ctrl_0=$v4_t4ctrl_0"
	puts "IPv4 t4ctrl_1=$v4_t4ctrl_1"
}

set ret [ ca_aal_lpm_default_t4ctrl_set 0 1 $v6_t4ctrl_0 $v6_t4ctrl_1 ]
if {$ret != 0} {
	puts "ca_aal_lpm_default_t4ctrl_set() for IPv6 is failed. (ret=$ret)"
} else {
	puts "IPv6 t4ctrl_0=$v4_t4ctrl_0"
	puts "IPv6 t4ctrl_1=$v4_t4ctrl_1"
}

