#### create cfg data
set cfg [ aal_l2_vlan_port_tx_tpid_sel_create ]

##################################
####  Set VLAN TPID Sel Value
##################################
#### set cfg.svlan
aal_l2_vlan_port_tx_tpid_sel_set_svlan $cfg 0
#### set cfg.cvlan
aal_l2_vlan_port_tx_tpid_sel_set_cvlan $cfg 1
#### set cfg.inner_svlan
aal_l2_vlan_port_tx_tpid_sel_set_inner_svlan $cfg 2
#### set cfg.inner_cvlan
aal_l2_vlan_port_tx_tpid_sel_set_inner_cvlan $cfg 3

aal_l2_vlan_port_tx_tpid_sel_dump $cfg

##################################
####  Set VLAN TPID Sel Mask
##################################
#### set MASK
#### bit 0: svlan
#### bit 1: cvlan
#### bit 2: inner_svlan
#### bit 3: inner_cvlan
set MASK 2

aal_l2_vlan_tx_tpid_sel_set 0 1 $MASK $cfg
