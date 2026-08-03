#########################
#### Create CLS Data ####
#########################
#### create cls key
set key [ ca_classifier_key_create ]
set l2_key [ ca_classifier_l2_create ]
set ip_key [ ca_classifier_ip_create ]
set ip_address [ ca_ip_address_create ]
set ip_addr [ ca_l3_ip_addr_create ]
set ip_da_address [ ca_ip_address_create ]
set ip_da_addr [ ca_l3_ip_addr_create ]
#### create cls key mask
set key_mask [ ca_classifier_key_mask_create ]
set ip_mask [ ca_classifier_ip_mask_create ]
set l2_mask [ ca_classifier_l2_mask_create ]
#### create cls action
set action [ ca_classifier_action_create ]
set dest [ ca_classifier_action_dest_create ]
set options [ ca_classifier_action_option_create ]
set action_mask [ ca_classifier_action_option_mask_create ]

set shaper_id 127

#########################
####   Set CLS Key   ####
#########################

#### set src_port
ca_classifier_key_set_src_port $key 0x80019

#### set dst mac
set dst_mac [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x02 ]
ca_classifier_l2_set_dst_mac $l2_key $dst_mac

ca_classifier_key_set_l2 $key $l2_key

##########################
#### Set CLS Key Mask ####
##########################

ca_classifier_key_mask_set_l2 $key_mask 1

#### set src_port mask
ca_classifier_key_mask_set_src_port $key_mask 1

#### set dest mac maske
ca_classifier_l2_mask_set_dst_mac $l2_mask 0x3f

ca_classifier_key_mask_set_l2_mask $key_mask $l2_mask

##########################
####  Set CLS Action  ####
##########################

#### set forward to fe
ca_classifier_action_set_forward $action 1
ca_classifier_action_set_dest $action $dest

#### set sw_shaper_id
ca_classifier_action_option_set_sw_shaper_id $options $shaper_id

##############################
####  Set CLS Action Mask ####
##############################
#### set sw_shaper_id mask
ca_classifier_action_option_mask_set_sw_shaper_id $action_mask 1
ca_classifier_action_option_set_masks $options $action_mask
ca_classifier_action_set_options $action $options

set tmp_rule_idx 128

set rule_idx [ ca_uint32_create $tmp_rule_idx ]
set index [ ca_uint32_get $rule_idx ]
puts "rule_idx=$index"

set ret [ ca_classifier_rule_add 0 10 $key $key_mask $action $rule_idx ]
if {$ret != 0} {
           puts "ca_classifier_rule_add() is failed! (ret=$ret)"
} else {
           set cls_rule_idx [ ca_uint32_get $rule_idx ]
           puts "cls_rule_idx = $cls_rule_idx"
}

