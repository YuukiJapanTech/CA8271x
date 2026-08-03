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
#### create cls key mask
set key_mask [ ca_classifier_key_mask_create ]
set ip_mask [ ca_classifier_ip_mask_create ]
#### create cls action
set action [ ca_classifier_action_create ]
set dest [ ca_classifier_action_dest_create ]
set options [ ca_classifier_action_option_create ]
set action_mask [ ca_classifier_action_option_mask_create ]

#########################
####   Set CLS Key   ####
#########################
#### set src_port
ca_classifier_key_set_src_port $key 0x80019
#### set ip_sa_v4
ca_ip_address_set_afi $ip_address 0
ca_l3_ip_addr_set_ipv4_addr $ip_addr $src_ipaddr
ca_ip_address_set_addr_len $ip_address 32
ca_ip_address_set_ip_addr  $ip_address $ip_addr
ca_classifier_ip_set_ip_sa $ip_key $ip_address
#### set ip_da_v4
ca_ip_address_set_afi $ip_da_address 0
ca_l3_ip_addr_set_ipv4_addr $ip_da_addr $dst_ipaddr 
ca_ip_address_set_addr_len $ip_da_address 32
ca_ip_address_set_ip_addr  $ip_da_address $ip_da_addr
ca_classifier_ip_set_ip_da $ip_key $ip_da_address
ca_classifier_key_set_ip $key $ip_key
##########################
#### Set CLS Key Mask ####
##########################
#### set src_port mask
ca_classifier_key_mask_set_src_port $key_mask 1
#### set ip mask
ca_classifier_key_mask_set_ip $key_mask 1
#### set ip_sa mask
ca_classifier_ip_mask_set_ip_sa $ip_mask 1
#### set ip_da mask
ca_classifier_ip_mask_set_ip_da $ip_mask 1
ca_classifier_key_mask_set_ip_mask $key_mask $ip_mask
##########################
####  Set CLS Action  ####
##########################

ca_classifier_action_option_set_flow_id $options 0x800

#### set forward to fe
ca_classifier_action_set_forward 	$action 	3
ca_classifier_action_dest_set_port   	$dest		0x3
ca_classifier_action_set_dest 		$action 	$dest

##############################
####  Set CLS Action Mask ####
##############################
#### set sw_shaper_id mask
ca_classifier_action_option_mask_set_flow_id $action_mask 1

ca_classifier_action_option_set_masks $options $action_mask
ca_classifier_action_set_options $action $options

