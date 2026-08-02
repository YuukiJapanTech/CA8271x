## Add an LPM IPv4 entry
##
## NOTE:
##   IPv4 prefix len 1~32, use lpm[0]
##   IPv6 prefix len 1~32, use lpm[0]
##   IPv6 prefix len 33~64, use lpm[0~1]
##   IPv6 prefix len 65~128, use lpm[0~3]
##   Prefix len 0 is default route, DO NOT use this script.
##
## LPM entry contents:
##   data: IP DA, host order
##   attr: attribute
##         0 for IPv4
##         1 for IPv6 prefix len 1~32 of whole entry
##         2 for IPv6 prefix len 33~64 of whole entry
##         3 for IPv6 prefix len 65~128 of whole entry
##   rst_idx: NextHop index, this is set to MDATA_L[11:0]. Currently fill the egress IF ID.
##   rst_ctrl: choose NextHop profile which is assigned in default_t4ctrl
##   valid: must be 1
##   profile: LPM profile number, also t3ctrl, valid range 0~3.


# INFO of this LPM entry:
#   LPM profile #0 (t3ctrl)
#   rst_ctrl 0
#   dest 2001:a801::/32
#   NextHop_ID 0x1

# create an entry named $lpm
set entry [ lpm_tbl_entry_array_create 4 ]

# entry[0]
set lpm_0 [ lpm_tbl_entry_create ]
lpm_tbl_entry_set_data		$lpm_0	0x2001a801
lpm_tbl_entry_set_mask		$lpm_0	32
lpm_tbl_entry_set_attr		$lpm_0	1
lpm_tbl_entry_set_rst_idx	$lpm_0	0x1
lpm_tbl_entry_set_rst_ctrl	$lpm_0	0
lpm_tbl_entry_set_valid		$lpm_0	1
lpm_tbl_entry_set_profile	$lpm_0	0

lpm_tbl_entry_array_set		$entry	$lpm_0	0

# entry[1]
set lpm_1 [ lpm_tbl_entry_create ]
lpm_tbl_entry_set_data		$lpm_1	0x00000000
lpm_tbl_entry_set_mask		$lpm_1	0
lpm_tbl_entry_set_attr		$lpm_1	0
lpm_tbl_entry_set_rst_idx	$lpm_1	0
lpm_tbl_entry_set_rst_ctrl	$lpm_1	0
lpm_tbl_entry_set_valid		$lpm_1	1
lpm_tbl_entry_set_profile	$lpm_1	0

lpm_tbl_entry_array_set		$entry	$lpm_1	1

# entry[2]
set lpm_2 [ lpm_tbl_entry_create ]
lpm_tbl_entry_set_data		$lpm_2	0x00000000
lpm_tbl_entry_set_mask		$lpm_2	0
lpm_tbl_entry_set_attr		$lpm_2	0
lpm_tbl_entry_set_rst_idx	$lpm_2	0
lpm_tbl_entry_set_rst_ctrl	$lpm_2	0
lpm_tbl_entry_set_valid		$lpm_2	1
lpm_tbl_entry_set_profile	$lpm_2	0

lpm_tbl_entry_array_set		$entry	$lpm_2	2

# entry[3]
set lpm_3 [ lpm_tbl_entry_create ]
lpm_tbl_entry_set_data		$lpm_3	0x00000000
lpm_tbl_entry_set_mask		$lpm_3	0
lpm_tbl_entry_set_attr		$lpm_3	0
lpm_tbl_entry_set_rst_idx	$lpm_3	0
lpm_tbl_entry_set_rst_ctrl	$lpm_3	0
lpm_tbl_entry_set_valid		$lpm_3	1
lpm_tbl_entry_set_profile	$lpm_3	0

lpm_tbl_entry_array_set		$entry	$lpm_3	3

# add the LPM entry
set rslt_lpm_idx [ ca_uint32_create 0 ]
set ret [ ca_aal_lpm_add 0 $entry $rslt_lpm_idx ]
if {$ret != 0} {
	puts "ca_aal_lpm_add() is failed. (ret=$ret)"
} else {
	set lpm_idx [ ca_uint32_get $rslt_lpm_idx ]
	puts "lpm_idx = $lpm_idx"
}

