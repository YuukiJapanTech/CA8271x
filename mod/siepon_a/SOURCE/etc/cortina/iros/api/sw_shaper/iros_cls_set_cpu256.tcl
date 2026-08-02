proc add {a b} {
    expr {$a + $b}
}
#########################
#### Create CLS Data ####
#########################
#### create cls key
set key [ ca_classifier_key_create ]
set ip_key [ ca_classifier_ip_create ]
set ip_address [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
set ip_da_address [ ca_ip_address_create ]
set ip_da_addr [ ca_l3_ip_addr_create ]
set l4_key [ ca_classifier_l4_create ]
set udp_dst_port_range_key [ ca_classifier_range_create ]
#### create cls key mask
set key_mask [ ca_classifier_key_mask_create ]
set ip_mask [ ca_classifier_ip_mask_create ]
set l4_mask [ ca_classifier_l4_mask_create ]
#### create cls action
set action [ ca_classifier_action_create ]
set dest [ ca_classifier_action_dest_create ]
set options [ ca_classifier_action_option_create ]
set action_handle [ ca_classifier_handle_create ]
set action_mask [ ca_classifier_action_option_mask_create ]

#########################
####   Set CLS Key   ####
#########################
#### set src_port
ca_classifier_key_set_src_port $key 0x80019
#### set ip_sa_v4
##ca_ip_address_set_afi $ip_address 0
##ca_l3_ip_addr_set_ipv4_addr $ip_addr $src_ipaddr
##ca_ip_address_set_addr_len $ip_address 32
##ca_ip_address_set_ip_addr  $ip_address $ip_addr
##ca_classifier_ip_set_ip_sa $ip_key $ip_address
#### set ip_da_v4
##ca_ip_address_set_afi $ip_da_address 0
##ca_l3_ip_addr_set_ipv4_addr $ip_da_addr $dst_ipaddr
##ca_ip_address_set_addr_len $ip_da_address 32
##ca_ip_address_set_ip_addr  $ip_da_address $ip_da_addr
##ca_classifier_ip_set_ip_da $ip_key $ip_da_address
##ca_classifier_key_set_ip $key $ip_key
#### set l4 dst_port
ca_classifier_range_set_min $udp_dst_port_range_key $udp_dst_port
ca_classifier_range_set_max $udp_dst_port_range_key $udp_dst_port
ca_classifier_l4_set_dst_port $l4_key $udp_dst_port_range_key
### set l4_valid
ca_classifier_l4_set_l4_valid $l4_key 1
ca_classifier_key_set_l4 $key $l4_key
##########################
#### Set CLS Key Mask ####
##########################
#### set src_port mask
ca_classifier_key_mask_set_src_port $key_mask 1
#### set ip mask
##ca_classifier_key_mask_set_ip $key_mask 1
#### set ip_sa mask
##ca_classifier_ip_mask_set_ip_sa $ip_mask 1
#### set ip_da mask
##ca_classifier_ip_mask_set_ip_da $ip_mask 1
##ca_classifier_key_mask_set_ip_mask $key_mask $ip_mask
#### set l4 dst_port mask
ca_classifier_l4_mask_set_dst_port $l4_mask 1
ca_classifier_key_mask_set_l4 $key_mask 1
ca_classifier_key_mask_set_l4_mask $key_mask $l4_mask
##########################
####  Set CLS Action  ####
##########################

#### set forward to fe
ca_classifier_action_set_forward $action 1
ca_classifier_action_set_dest $action $dest

#### set sw_shaper_id
ca_classifier_action_option_set_sw_shaper_id $options $shaper_id

#### set flow_id
##set flow_id [ add 0x800 $shaper_id ]
puts flow_id=$flow_id
ca_classifier_handle_set_flow_id $action_handle $flow_id
ca_classifier_action_option_set_action_handle $options $action_handle

##############################
####  Set CLS Action Mask ####
##############################
#### set sw_shaper_id mask
ca_classifier_action_option_mask_set_sw_shaper_id $action_mask 1
ca_classifier_action_option_mask_set_action_handle $action_mask 1
ca_classifier_action_option_set_masks $options $action_mask
ca_classifier_action_set_options $action $options

