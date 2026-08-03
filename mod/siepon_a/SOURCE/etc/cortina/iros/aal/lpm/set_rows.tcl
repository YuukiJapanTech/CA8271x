## Set first_row and last_row for each LPM profile.

# default value of profile#0 IPv4 row 0~3
set v4_0_first_row	0
set v4_0_last_row	3

# default value of profile#1 IPv4 row 4~7
set v4_1_first_row	4
set v4_1_last_row	7

# default value of profile#2 IPv4 row 8~11
set v4_2_first_row	8
set v4_2_last_row	11

# default value of profile#3 IPv4 row 12~15
set v4_3_first_row	12
set v4_3_last_row	15

# default value of profile#0 IPv6 row 31~28
set v6_0_first_row	31
set v6_0_last_row	28

# default value of profile#1 IPv6 row 27~24
set v6_1_first_row	27
set v6_1_last_row	24

# default value of profile#2 IPv6 row 23~20
set v6_2_first_row	23
set v6_2_last_row	20

# default value of profile#3 IPv6 row 19~16
set v6_3_first_row	19
set v6_3_last_row	16

set ret [ ca_aal_lpm_first_row_set 0 0 0 $v4_0_first_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_first_row_set() for IPv4 is failed. (ret=$ret)"
} else {
	puts "IPv4 profile#0: first_row=$v4_0_first_row"
}

set ret [ ca_aal_lpm_last_row_set 0 0 0 $v4_0_last_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_last_row_set() for IPv4 is failed. (ret=$ret)"
} else {
	puts "IPv4 profile#0: last_row=$v4_0_last_row"
}

set ret [ ca_aal_lpm_first_row_set 0 0 1 $v4_1_first_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_first_row_set() for IPv4 is failed. (ret=$ret)"
} else {
	puts "IPv4 profile#1: first_row=$v4_1_first_row"
}

set ret [ ca_aal_lpm_last_row_set 0 0 1 $v4_1_last_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_last_row_set() for IPv4 is failed. (ret=$ret)"
} else {
	puts "IPv4 profile#1: last_row=$v4_1_last_row"
}

set ret [ ca_aal_lpm_first_row_set 0 0 2 $v4_2_first_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_first_row_set() for IPv4 is failed. (ret=$ret)"
} else {
	puts "IPv4 profile#2: first_row=$v4_2_first_row"
}

set ret [ ca_aal_lpm_last_row_set 0 0 2 $v4_2_last_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_last_row_set() for IPv4 is failed. (ret=$ret)"
} else {
	puts "IPv4 profile#2: last_row=$v4_2_last_row"
}

set ret [ ca_aal_lpm_first_row_set 0 0 3 $v4_3_first_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_first_row_set() for IPv4 is failed. (ret=$ret)"
} else {
	puts "IPv4 profile#3: first_row=$v4_3_first_row"
}

set ret [ ca_aal_lpm_last_row_set 0 0 3 $v4_3_last_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_last_row_set() for IPv4 is failed. (ret=$ret)"
} else {
	puts "IPv4 profile#3: last_row=$v4_3_last_row"
}

set ret [ ca_aal_lpm_first_row_set 0 1 0 $v6_0_first_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_first_row_set() for IPv6 is failed. (ret=$ret)"
} else {
	puts "IPv6 profile#0: first_row=$v6_0_first_row"
}

set ret [ ca_aal_lpm_last_row_set 0 1 0 $v6_0_last_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_last_row_set() for IPv6 is failed. (ret=$ret)"
} else {
	puts "IPv6 profile#0: last_row=$v6_0_last_row"
}

set ret [ ca_aal_lpm_first_row_set 0 1 1 $v6_1_first_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_first_row_set() for IPv6 is failed. (ret=$ret)"
} else {
	puts "IPv6 profile#1: first_row=$v6_1_first_row"
}

set ret [ ca_aal_lpm_last_row_set 0 1 1 $v6_1_last_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_last_row_set() for IPv6 is failed. (ret=$ret)"
} else {
	puts "IPv6 profile#1: last_row=$v6_1_last_row"
}

set ret [ ca_aal_lpm_first_row_set 0 1 2 $v6_2_first_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_first_row_set() for IPv6 is failed. (ret=$ret)"
} else {
	puts "IPv6 profile#2: first_row=$v6_2_first_row"
}

set ret [ ca_aal_lpm_last_row_set 0 1 2 $v6_2_last_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_last_row_set() for IPv6 is failed. (ret=$ret)"
} else {
	puts "IPv6 profile#2: last_row=$v6_2_last_row"
}

set ret [ ca_aal_lpm_first_row_set 0 1 3 $v6_3_first_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_first_row_set() for IPv6 is failed. (ret=$ret)"
} else {
	puts "IPv6 profile#3: first_row=$v6_3_first_row"
}

set ret [ ca_aal_lpm_last_row_set 0 1 3 $v6_3_last_row ]
if {$ret != 0} {
	puts "ca_aal_lpm_last_row_set() for IPv6 is failed. (ret=$ret)"
} else {
	puts "IPv6 profile#3: last_row=$v6_3_last_row"
}


