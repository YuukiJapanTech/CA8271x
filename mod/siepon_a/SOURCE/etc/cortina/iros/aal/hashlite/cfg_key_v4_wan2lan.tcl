
### hash key

set hkey [ aal_hash_key_create ]

# L4
aal_hash_key_set_l4_chksum_zero		$hkey	0
aal_hash_key_set_tcp_rdp_ctrl		$hkey	0
aal_hash_key_set_l4_dp_exact_range	$hkey	0
aal_hash_key_set_l4_sp_exact_range	$hkey	0

# L3
aal_hash_key_set_l3_chksum_err		$hkey	0
aal_hash_key_set_spi			$hkey	0
aal_hash_key_set_spi_vld		$hkey	0
aal_hash_key_set_icmp_type		$hkey	0
aal_hash_key_set_icmp_vld		$hkey	0
aal_hash_key_set_ipv6_doh		$hkey	0
aal_hash_key_set_ipv6_rh		$hkey	0
aal_hash_key_set_ipv6_hbh		$hkey	0
aal_hash_key_set_ip_fragment_flag	$hkey	0
aal_hash_key_set_ip_da_sa_equal		$hkey	0
aal_hash_key_set_ip_options		$hkey	0
aal_hash_key_set_ip_ttl			$hkey	0
aal_hash_key_set_ipv6_flow_lbl		$hkey	0
aal_hash_key_set_ip_da_0		$hkey	0xc0a8010a
aal_hash_key_set_ip_da_1		$hkey	0
aal_hash_key_set_ip_da_2		$hkey	0
aal_hash_key_set_ip_da_3		$hkey	0
aal_hash_key_set_ip_sa_0		$hkey	0
aal_hash_key_set_ip_sa_1		$hkey	0
aal_hash_key_set_ip_sa_2		$hkey	0
aal_hash_key_set_ip_sa_3		$hkey	0
aal_hash_key_set_ip_l4_type		$hkey	0
aal_hash_key_set_ip_protocol		$hkey	0x11
aal_hash_key_set_ip_ecn			$hkey	0
aal_hash_key_set_ip_dscp		$hkey	0
aal_hash_key_set_ip_ver			$hkey	0
aal_hash_key_set_ip_vld			$hkey	1

# PPP / PPPoE
aal_hash_key_set_ppp_protocol_enc	$hkey	0
aal_hash_key_set_pppoe_session_id	$hkey	0
aal_hash_key_set_pppoe_code_enc		$hkey	0
aal_hash_key_set_pppoe_type		$hkey	0

# VLAN
aal_hash_key_set_inner_dei		$hkey	0
aal_hash_key_set_inner_8021p		$hkey	0
aal_hash_key_set_inner_vid		$hkey	0
aal_hash_key_set_inner_tpid_enc		$hkey	0
aal_hash_key_set_top_dei		$hkey	0
aal_hash_key_set_top_8021p		$hkey	0
aal_hash_key_set_top_vid		$hkey	10
aal_hash_key_set_top_tpid_enc		$hkey	0
aal_hash_key_set_vlan_cnt		$hkey	1

# L2 Format
aal_hash_key_set_llc_type_enc		$hkey	0
aal_hash_key_set_llc_snap		$hkey	0
aal_hash_key_set_pktlen_rng_match_vec	$hkey	0
aal_hash_key_set_len_encoded		$hkey	0

# L2
aal_hash_key_set_ethertype_enc		$hkey	0
aal_hash_key_set_ethertype		$hkey	0
aal_hash_key_set_mac_sa_0		$hkey	0x0
aal_hash_key_set_mac_sa_1		$hkey	0x0
aal_hash_key_set_mac_sa_2		$hkey	0x0
aal_hash_key_set_mac_sa_3		$hkey	0x0
aal_hash_key_set_mac_sa_4		$hkey	0x0
aal_hash_key_set_mac_sa_5		$hkey	0x0
aal_hash_key_set_mac_da_rsvd		$hkey	0
aal_hash_key_set_mac_da_rng		$hkey	0
aal_hash_key_set_mac_da_ip_mc		$hkey	0
aal_hash_key_set_mac_da_an_sel		$hkey	0
aal_hash_key_set_mac_da_0		$hkey	0x02
aal_hash_key_set_mac_da_1		$hkey	0x00
aal_hash_key_set_mac_da_2		$hkey	0x00
aal_hash_key_set_mac_da_3		$hkey	0x25
aal_hash_key_set_mac_da_4		$hkey	0x13
aal_hash_key_set_mac_da_5		$hkey	0x00

# Special Packet
aal_hash_key_set_spcl_pkt_hdr_mtch	$hkey	0
aal_hash_key_set_spcl_pkt_enc		$hkey	0

# MDATA
aal_hash_key_set_mdata			$hkey	0x1

# POL ID
aal_hash_key_set_qos_premark		$hkey	0
aal_hash_key_set_pol_grp_id		$hkey	0
aal_hash_key_set_pol_id			$hkey	0

# COS
aal_hash_key_set_cos			$hkey	7

# Dest Port ID
aal_hash_key_set_mcgid			$hkey	0
aal_hash_key_set_mc			$hkey	0

# Source Port ID
aal_hash_key_set_mc_idx_vld		$hkey	0
aal_hash_key_set_orig_lspid		$hkey	0x19
aal_hash_key_set_lspid			$hkey	0x19

# Hash Control
aal_hash_key_set_hkey_id		$hkey	1
aal_hash_key_set_ctrl_set_id		$hkey	0
aal_hash_key_set_table_id		$hkey	0



