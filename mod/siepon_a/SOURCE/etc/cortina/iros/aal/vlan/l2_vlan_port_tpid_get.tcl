#### create cfg data
set cfg [ aal_l2_vlan_port_tx_tpid_sel_create ]
##################################
####  Get VLAN TPID Sel Value
##################################
aal_l2_vlan_tx_tpid_sel_get 0 1 $cfg
aal_l2_vlan_port_tx_tpid_sel_dump $cfg
