
set l3_te_policer [ ca_policer_create ]
set flow_id 0x800

ca_policer_set_mode $l3_te_policer 1
ca_policer_set_pps	$l3_te_policer 0
ca_policer_set_cir	$l3_te_policer 2048
ca_policer_set_cbs	$l3_te_policer 1024
ca_policer_set_pir  $l3_te_policer 2048
ca_policer_set_pbs  $l3_te_policer 1024

ca_flow_policer_set 0 $flow_id $l3_te_policer

set l3_te_policer [ ca_policer_create ]
set flow_id 0x801

ca_policer_set_mode $l3_te_policer 1
ca_policer_set_pps	$l3_te_policer 0
ca_policer_set_cir	$l3_te_policer 20480
ca_policer_set_cbs	$l3_te_policer 1024
ca_policer_set_pir  $l3_te_policer 20480
ca_policer_set_pbs  $l3_te_policer 1024

ca_flow_policer_set 0 $flow_id $l3_te_policer

set l3_te_policer [ ca_policer_create ]
set flow_id 0x802

ca_policer_set_mode $l3_te_policer 1
ca_policer_set_pps	$l3_te_policer 0
ca_policer_set_cir	$l3_te_policer 102400
ca_policer_set_cbs	$l3_te_policer 1024
ca_policer_set_pir  $l3_te_policer 102400
ca_policer_set_pbs  $l3_te_policer 1024

ca_flow_policer_set 0 $flow_id $l3_te_policer
