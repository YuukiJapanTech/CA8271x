## Set IPv4 default route.

# INFO of this default route:
#   ::/0 -> NextHop ID 0x2
#   default dpid 0x2 (disabled)

# default_idx		: MDATA_L[11:0]
# default_ctrl		: t4ctrl, choose NextHop profile
# default_dpid		: LDPID
# default_dpid_vld	: valid bit of default_dpid
# default_stg		: bit 1: update HDR_I.stage3_ctrl
#			  bit 0: update HDR_I.stage2_ctrl
# default_stg_ud	: bit 1: enable/disable bit 1 of default_stg
#			  bit 0: enable/disable bit 0 of default_stg

set lpm [ lpm_action_ctrl_create ]

lpm_action_ctrl_set_default_idx		$lpm	0x7
lpm_action_ctrl_set_default_ctrl	$lpm	0
lpm_action_ctrl_set_default_dpid	$lpm	0
lpm_action_ctrl_set_default_dpid_vld	$lpm	0
lpm_action_ctrl_set_default_stg		$lpm	0
lpm_action_ctrl_set_default_stg_ud	$lpm	0

set ret [ ca_aal_lpm_default_set 0 1 $lpm ]
if {$ret != 0} {
	puts "ca_aal_lpm_default_set() is failed. (ret=$ret)"
}

