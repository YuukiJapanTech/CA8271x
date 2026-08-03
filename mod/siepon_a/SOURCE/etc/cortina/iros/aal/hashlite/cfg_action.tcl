
### hash action

set hact [ aal_hash_action_create ]

# group 0
aal_hash_action_set_chk_l4_dp_vld		$hact	0
aal_hash_action_set_chk_l4_dp			$hact	0
aal_hash_action_set_chk_l4_sp_vld		$hact	0
aal_hash_action_set_chk_l4_sp			$hact	0
aal_hash_action_set_chk_ip_da_vld		$hact	0
aal_hash_action_set_chk_ip_da			$hact	0
aal_hash_action_set_chk_ip_sa_vld		$hact	0
aal_hash_action_set_chk_ip_sa			$hact	0
aal_hash_action_set_chk_mac_da_vld		$hact	0
aal_hash_action_set_chk_mac_da			$hact	0
aal_hash_action_set_chk_mac_sa_vld		$hact	0
aal_hash_action_set_chk_mac_sa			$hact	0

# group 1
aal_hash_action_set_l4_dp_vld			$hact	0
aal_hash_action_set_l4_dp			$hact	0

# group 2
aal_hash_action_set_l4_sp_vld			$hact	0
aal_hash_action_set_l4_sp			$hact	0

# group 3
aal_hash_action_set_ip_da_l_vld			$hact	0
aal_hash_action_set_ip_da_0			$hact	0

# group 4
aal_hash_action_set_ip_da_h_vld			$hact	0
aal_hash_action_set_ip_da_1			$hact	0
aal_hash_action_set_ip_da_2			$hact	0
aal_hash_action_set_ip_da_3			$hact	0

# group 5
aal_hash_action_set_ip_sa_l_vld			$hact	1
aal_hash_action_set_ip_sa_0			$hact	0xc0a86401

# group 6
aal_hash_action_set_ip_sa_h_vld			$hact	0
aal_hash_action_set_ip_sa_1			$hact	0
aal_hash_action_set_ip_sa_2			$hact	0
aal_hash_action_set_ip_sa_3			$hact	0

# group 7
aal_hash_action_set_pppoe_vld			$hact	0
aal_hash_action_set_pppoe_set			$hact	0
aal_hash_action_set_pppoe_session_id		$hact	0

# group 8
aal_hash_action_set_ip_ttl_vld			$hact	1
aal_hash_action_set_ip_ttl_zero_discard_en	$hact	1
aal_hash_action_set_ip_ttl_cmd			$hact	1
aal_hash_action_set_ip_ttl			$hact	100
aal_hash_action_set_six_rd_ipda_ctrl_vld	$hact	0
aal_hash_action_set_six_rd_ipda_from_v6		$hact	0
aal_hash_action_set_ip_mtu_enc_vld		$hact	0
aal_hash_action_set_ip_mtu_enc			$hact	0
aal_hash_action_set_l2_format_vld		$hact	0
aal_hash_action_set_l2_format			$hact	0
aal_hash_action_set_l3_egress_if_vld		$hact	1

# group 9
aal_hash_action_set_vlan_vld			$hact	0
aal_hash_action_set_inner_dei_sel		$hact	0
aal_hash_action_set_inner_dei			$hact	0
aal_hash_action_set_inner_vid			$hact	0
aal_hash_action_set_inner_tpid_enc		$hact	0
aal_hash_action_set_top_dei_sel			$hact	0
aal_hash_action_set_top_dei			$hact	0
aal_hash_action_set_top_vid			$hact	0
aal_hash_action_set_top_tpid_enc		$hact	0
aal_hash_action_set_vlan_cnt			$hact	0

# group 10
aal_hash_action_set_mac_sa_vld			$hact	1
aal_hash_action_set_mac_sa_0			$hact	0x01
aal_hash_action_set_mac_sa_1			$hact	0x00
aal_hash_action_set_mac_sa_2			$hact	0x00
aal_hash_action_set_mac_sa_3			$hact	0x25
aal_hash_action_set_mac_sa_4			$hact	0x13
aal_hash_action_set_mac_sa_5			$hact	0x00

# group 11
aal_hash_action_set_mac_da_vld			$hact	1
aal_hash_action_set_mac_da_0			$hact	0x64
aal_hash_action_set_mac_da_1			$hact	0x64
aal_hash_action_set_mac_da_2			$hact	0x00
aal_hash_action_set_mac_da_3			$hact	0x00
aal_hash_action_set_mac_da_4			$hact	0x00
aal_hash_action_set_mac_da_5			$hact	0x00

# group 12
aal_hash_action_set_mdata_w_vld_0		$hact	0
aal_hash_action_set_mdata_w_0			$hact	0

# group 13
aal_hash_action_set_mdata_w_vld_1		$hact	0x3
aal_hash_action_set_mdata_w_1			$hact	0x0004

# group 14
aal_hash_action_set_mdata_w_vld_2		$hact	0
aal_hash_action_set_mdata_w_2			$hact	0

# group 15
aal_hash_action_set_mdata_w_vld_3		$hact	0
aal_hash_action_set_mdata_w_3			$hact	0

# group 16
aal_hash_action_set_pol_vld			$hact	0
aal_hash_action_set_qos_premark			$hact	0
aal_hash_action_set_pol_all_bypass		$hact	0
aal_hash_action_set_pol_en			$hact	0
aal_hash_action_set_pol_base			$hact	0
aal_hash_action_set_pol_sel			$hact	0
aal_hash_action_set_pol_table_sel		$hact	0
aal_hash_action_set_pol_grp_vld			$hact	0
aal_hash_action_set_pol_grp_id			$hact	0

# group 17
aal_hash_action_set_ip_ecn_vld			$hact	0
aal_hash_action_set_ip_ecn_en			$hact	0
aal_hash_action_set_ip_tos_vld			$hact	0
aal_hash_action_set_ip_tos_6			$hact	0
aal_hash_action_set_ip_dscp_marked_vld		$hact	0
aal_hash_action_set_ip_dscp_marked_down		$hact	0
aal_hash_action_set_ip_dscp_markdown_en		$hact	0
aal_hash_action_set_ip_dscp_update_en		$hact	0
aal_hash_action_set_ip_dscp_sel			$hact	0
aal_hash_action_set_ip_dscp			$hact	0
aal_hash_action_set_dscp_table_sel		$hact	0
aal_hash_action_set_inner_802_1p_sel		$hact	0
aal_hash_action_set_inner_802_1p		$hact	0
aal_hash_action_set_top_802_1p_sel		$hact	0
aal_hash_action_set_top_802_1p			$hact	0
aal_hash_action_set_qos_802_1p_table_sel	$hact	0
aal_hash_action_set_cos_table_sel		$hact	0
aal_hash_action_set_cos_sel			$hact	0
aal_hash_action_set_cos				$hact	0

# group 18
aal_hash_action_set_mrr_vld			$hact	0
aal_hash_action_set_mrr_en			$hact	0
aal_hash_action_set_no_drop_vld			$hact	0
aal_hash_action_set_no_drop			$hact	0
aal_hash_action_set_dpid_vld			$hact	0
aal_hash_action_set_dpid_pri			$hact	1
aal_hash_action_set_permit			$hact	1
aal_hash_action_set_deepq			$hact	1
aal_hash_action_set_mcgid			$hact	0x18
aal_hash_action_set_mc				$hact	0

# group 19
aal_hash_action_set_chk_msk_ptr			$hact	1
aal_hash_action_set_cache_ctrl			$hact	0
aal_hash_action_set_pop_l3_vld			$hact	0
aal_hash_action_set_pop_l3_chk_ecn_en		$hact	0
aal_hash_action_set_pop_l3_en			$hact	0
aal_hash_action_set_keep_ts_vld			$hact	0
aal_hash_action_set_keep_ts_en			$hact	0
aal_hash_action_set_keep_orig_pkt_vld		$hact	0
aal_hash_action_set_keep_orig_pkt		$hact	0
aal_hash_action_set_stage3_ctrl_vld		$hact	0
aal_hash_action_set_stage3_ctrl			$hact	0
aal_hash_action_set_stage2_ctrl_vld		$hact	0
aal_hash_action_set_stage2_ctrl			$hact	0
aal_hash_action_set_t5_ctrl_vld			$hact	0
aal_hash_action_set_t5_ctrl			$hact	0
aal_hash_action_set_t4_ctrl_vld			$hact	0
aal_hash_action_set_t4_ctrl			$hact	0
aal_hash_action_set_t3_ctrl_vld			$hact	0
aal_hash_action_set_t3_ctrl			$hact	0
aal_hash_action_set_t2_ctrl_vld			$hact	0
aal_hash_action_set_t2_ctrl			$hact	0


