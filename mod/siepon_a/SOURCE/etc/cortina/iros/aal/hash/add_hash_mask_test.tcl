set hmask [ aal_hash_mask_create ]

ca_hash_mask_unmask 0 $hmask

aal_hash_mask_set_ip_vld		$hmask	0
aal_hash_mask_set_ip_ver		$hmask	0
aal_hash_mask_set_l4_chksum_zero 	$hmask	0
aal_hash_mask_set_tcp_rdp_ctrl		$hmask	0

### L4
#aal_hash_mask_set_l4_chksum_zero	$hmask	1
#aal_hash_mask_set_tcp_rdp_ctrl		$hmask	0x1f
#aal_hash_mask_set_l4_dp_exact_range	$hmask	0x1ffff
#aal_hash_mask_set_l4_sp_exact_range	$hmask	0x1ffff

### L3
#aal_hash_mask_set_l3_chksum_err	$hmask	1
#aal_hash_mask_set_spi			$hmask	1
#aal_hash_mask_set_spi_vld		$hmask	1
#aal_hash_mask_set_icmp_type		$hmask	1
#aal_hash_mask_set_icmp_vld		$hmask	1
#aal_hash_mask_set_ipv6_doh		$hmask	1
#aal_hash_mask_set_ipv6_rh		$hmask	1
#aal_hash_mask_set_ipv6_hbh		$hmask	1
#aal_hash_mask_set_ip_fragment_flag	$hmask	1
#aal_hash_mask_set_ip_da_sa_equal	$hmask	1
#aal_hash_mask_set_ip_options		$hmask	1
#aal_hash_mask_set_ip_ttl		$hmask	0
#aal_hash_mask_set_ipv6_flow_lbl	$hmask	1
#aal_hash_mask_set_ip_da		$hmask	0x0
#aal_hash_mask_set_ip_sa		$hmask	0x0
#aal_hash_mask_set_ip_l4_type		$hmask	1
#aal_hash_mask_set_ip_protocol		$hmask	1
#aal_hash_mask_set_ip_ecn		$hmask	3
#aal_hash_mask_set_ip_dscp		$hmask	0x3f
#aal_hash_mask_set_ip_ver		$hmask	1
#aal_hash_mask_set_ip_vld		$hmask	1

### PPP / PPPoE
#aal_hash_mask_set_ppp_protocol_enc	$hmask	1
#aal_hash_mask_set_pppoe_session_id	$hmask	1
#aal_hash_mask_set_pppoe_code_enc	$hmask	1
#aal_hash_mask_set_pppoe_type		$hmask	1

### VLAN
#aal_hash_mask_set_inner_dei		$hmask	1
#aal_hash_mask_set_inner_8021p		$hmask	1
#aal_hash_mask_set_inner_vid		$hmask	1
#aal_hash_mask_set_inner_tpid_enc	$hmask	1
#aal_hash_mask_set_top_dei		$hmask	1
#aal_hash_mask_set_top_8021p		$hmask	1
#aal_hash_mask_set_top_vid		$hmask	1
#aal_hash_mask_set_top_tpid_enc		$hmask	1
#aal_hash_mask_set_vlan_cnt		$hmask	1

### L2 Format
#aal_hash_mask_set_llc_type_enc		$hmask	1
#aal_hash_mask_set_llc_snap		$hmask	1
#aal_hash_mask_set_pktlen_rng_match_vec	$hmask	0xf
#aal_hash_mask_set_len_encoded		$hmask	1

### L2
#aal_hash_mask_set_ethertype_enc	$hmask	1
#aal_hash_mask_set_ethertype		$hmask	1
#aal_hash_mask_set_mac_sa		$hmask	0x3f
#aal_hash_mask_set_mac_da_rsvd		$hmask	1
#aal_hash_mask_set_mac_da_rng		$hmask	1
#aal_hash_mask_set_mac_da_ip_mc		$hmask	1
#aal_hash_mask_set_mac_da_an_sel	$hmask	1
#aal_hash_mask_set_mac_da		$hmask	0x3f

### Special Packet
#aal_hash_mask_set_spcl_pkt_hdr_mtch	$hmask	0xff
#aal_hash_mask_set_spcl_pkt_enc		$hmask	1

### MDATA
#aal_hash_mask_set_mdata		$hmask	0xffffffffffffffff

### POL ID
#aal_hash_mask_set_qos_premark		$hmask	1
#aal_hash_mask_set_pol_grp_id		$hmask	1
#aal_hash_mask_set_pol_id		$hmask	1

### COS
#aal_hash_mask_set_cos			$hmask	1

### Dest Port ID
#aal_hash_mask_set_mcgid		$hmask	0x3ff
#aal_hash_mask_set_mc			$hmask	1

### Source Port ID
#aal_hash_mask_set_mc_idx_vld		$hmask	1
#aal_hash_mask_set_orig_lspid		$hmask	1
#aal_hash_mask_set_lspid		$hmask	1

### Hash Control
#aal_hash_mask_set_hmask_id		$hmask	1
#aal_hash_mask_set_ctrl_set_id		$hmask	1
#aal_hash_mask_set_table_id		$hmask	1

# add a hashmask
set rslt_mask_idx [ ca_uint32_create 0 ]
set ret [ aal_mask_tbl_entry_add_iros 0 $hmask $rslt_mask_idx ]
if {$ret != 0} {
	puts "aal_mask_tbl_entry_add_iros() is failed! (ret=$ret)"
} else {
	set mask_idx [ ca_uint32_get $rslt_mask_idx ]
	puts "Hashmask is added to Hash Engine."
	puts "mask_idx = $mask_idx"
}

