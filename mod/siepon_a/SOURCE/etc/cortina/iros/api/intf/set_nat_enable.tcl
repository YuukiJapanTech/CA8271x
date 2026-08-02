 ## set nat_enable=1 for L3 interface
 ## echo 0x1000 > /proc/driver/cortina/kernel_hook/ca_kh_debug to get the intf_id

 set l3_intf [ ca_l3_intf_create ]

 ca_l3_intf_set_intf_id $l3_intf   2
 ca_l3_intf_get 0 $l3_intf
 ca_l3_intf_set_nat_enable $l3_intf  1
 ca_l3_intf_update 0 $l3_intf
