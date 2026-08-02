#################################
# Tx SA
#################################

set sa_db_flags [ ca_sa_db_flags_create ]
set sa_db_mask [ ca_macsec_sa_db_mask_create ]
set macsec_sa_db [ ca_macsec_sa_db_create ]
set macsec_sa [ ca_macsec_sa_create ]

ca_sa_db_flags_set_end_station				$sa_db_flags	0
ca_sa_db_flags_set_sci_encoded				$sa_db_flags	1
ca_sa_db_flags_set_single_copy_broadcast		$sa_db_flags	0
ca_sa_db_flags_set_frame_validation			$sa_db_flags	0
ca_sa_db_flags_set_replay_check 			$sa_db_flags	0
ca_sa_db_flags_set_association_number			$sa_db_flags	0
ca_sa_db_flags_set_confidential_offset			$sa_db_flags	0
ca_sa_db_flags_set_security_mode			$sa_db_flags	0

ca_macsec_sa_db_mask_set_key0_valid			$sa_db_mask	1
ca_macsec_sa_db_mask_set_key1_valid			$sa_db_mask	0
ca_macsec_sa_db_mask_set_key2_valid			$sa_db_mask	0
ca_macsec_sa_db_mask_set_key3_valid			$sa_db_mask	0
ca_macsec_sa_db_mask_set_lapn_valid			$sa_db_mask	1
ca_macsec_sa_db_mask_set_npn_valid			$sa_db_mask	1
ca_macsec_sa_db_mask_set_sa_db_control_flags_valid	$sa_db_mask	1
ca_macsec_sa_db_mask_set_sci_valid			$sa_db_mask	1
ca_macsec_sa_db_mask_set_pn_threshold_valid		$sa_db_mask	1
ca_macsec_sa_db_mask_set_replay_window_valid		$sa_db_mask	1
ca_macsec_sa_db_mask_set_mac_addr			$sa_db_mask	1

#sa_db_mask is bitfield struct so need to set the value 0x3ff manually
ca_macsec_sa_db_set_mask			$macsec_sa_db	$sa_db_mask
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x10	0
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x11	1
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x12	2
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x13	3
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x14	4
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x15	5
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x16	6
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x17	7
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x18	8
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x19	9
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x1a	10
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x1b	11
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x1c	12
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x1d	13
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x1e	14
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x1f	15

ca_macsec_sa_db_set_lapn			$macsec_sa_db	200
ca_macsec_sa_db_set_npn				$macsec_sa_db	100
ca_macsec_sa_db_set_sa_db_control_flags		$macsec_sa_db	$sa_db_flags
ca_macsec_sa_db_set_sci				$macsec_sa_db	0x0013250000010001
ca_macsec_sa_db_set_pn_threshold		$macsec_sa_db	1000
ca_macsec_sa_db_set_replay_window		$macsec_sa_db	500
ca_macsec_sa_db_set_mac_addr			$macsec_sa_db	[ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x01 ]

ca_macsec_sa_set_sa_id				$macsec_sa	0
ca_macsec_sa_set_direction			$macsec_sa	0
ca_macsec_sa_set_association_number		$macsec_sa	0
ca_macsec_sa_set_sa_db				$macsec_sa	$macsec_sa_db

set ret [ ca_macsec_sa_add 0 $macsec_sa ]
if {$ret != 0} {
	puts "ca_macsec_sa_add() for Tx is failed! (ret=$ret)"
	exit $ret
} else {
	set tx_sa_id [ ca_macsec_sa_get_sa_id $macsec_sa ]
	puts "tx_sa_id=$tx_sa_id"
}

#################################
# Rx SA
#################################

set sa_db_flags [ ca_sa_db_flags_create ]
set sa_db_mask [ ca_macsec_sa_db_mask_create ]
set macsec_sa_db [ ca_macsec_sa_db_create ]
set macsec_sa [ ca_macsec_sa_create ]

ca_sa_db_flags_set_end_station				$sa_db_flags	0
ca_sa_db_flags_set_sci_encoded				$sa_db_flags	1
ca_sa_db_flags_set_single_copy_broadcast		$sa_db_flags	0
ca_sa_db_flags_set_frame_validation			$sa_db_flags	0
ca_sa_db_flags_set_replay_check 			$sa_db_flags	0
ca_sa_db_flags_set_association_number			$sa_db_flags	0
ca_sa_db_flags_set_confidential_offset			$sa_db_flags	0
ca_sa_db_flags_set_security_mode			$sa_db_flags	0

ca_macsec_sa_db_mask_set_key0_valid			$sa_db_mask	1
ca_macsec_sa_db_mask_set_key1_valid			$sa_db_mask	0
ca_macsec_sa_db_mask_set_key2_valid			$sa_db_mask	0
ca_macsec_sa_db_mask_set_key3_valid			$sa_db_mask	0
ca_macsec_sa_db_mask_set_lapn_valid			$sa_db_mask	1
ca_macsec_sa_db_mask_set_npn_valid			$sa_db_mask	1
ca_macsec_sa_db_mask_set_sa_db_control_flags_valid	$sa_db_mask	1
ca_macsec_sa_db_mask_set_sci_valid			$sa_db_mask	1
ca_macsec_sa_db_mask_set_pn_threshold_valid		$sa_db_mask	1
ca_macsec_sa_db_mask_set_replay_window_valid		$sa_db_mask	1
ca_macsec_sa_db_mask_set_mac_addr			$sa_db_mask	1

#sa_db_mask is bitfield struct so need to set the value 0x3ff manually
ca_macsec_sa_db_set_mask			$macsec_sa_db	$sa_db_mask
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x20	0
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x21	1
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x22	2
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x23	3
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x24	4
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x25	5
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x26	6
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x27	7
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x28	8
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x29	9
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x2a	10
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x2b	11
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x2c	12
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x2d	13
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x2e	14
ca_macsec_sa_db_set_key0			$macsec_sa_db	0x2f	15

ca_macsec_sa_db_set_lapn			$macsec_sa_db	200
ca_macsec_sa_db_set_npn				$macsec_sa_db	100
ca_macsec_sa_db_set_sa_db_control_flags		$macsec_sa_db	$sa_db_flags
ca_macsec_sa_db_set_sci				$macsec_sa_db	0x0013250000010001
ca_macsec_sa_db_set_pn_threshold		$macsec_sa_db	1000
ca_macsec_sa_db_set_replay_window		$macsec_sa_db	500
ca_macsec_sa_db_set_mac_addr			$macsec_sa_db	[ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x01 ]

ca_macsec_sa_set_sa_id				$macsec_sa	0
ca_macsec_sa_set_direction			$macsec_sa	1
ca_macsec_sa_set_association_number		$macsec_sa	0
ca_macsec_sa_set_sa_db				$macsec_sa	$macsec_sa_db

set ret [ ca_macsec_sa_add 0 $macsec_sa ]
if {$ret != 0} {
	puts "ca_macsec_sa_add() for Rx is failed! (ret=$ret)"
	exit $ret
} else {
	set rx_sa_id [ ca_macsec_sa_get_sa_id $macsec_sa ]
	puts "rx_sa_id=$rx_sa_id"
}


