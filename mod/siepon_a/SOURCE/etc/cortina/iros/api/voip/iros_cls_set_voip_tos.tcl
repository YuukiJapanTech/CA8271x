#########################
#### Create CLS Data ####
#########################
#### create cls key
set key [ ca_classifier_key_create ]
set ip_key [ ca_classifier_ip_create ]
#### create cls key mask
set key_mask [ ca_classifier_key_mask_create ]
set ip_mask [ ca_classifier_ip_mask_create ]
#### create cls action
set action [ ca_classifier_action_create ]
set options [ ca_classifier_action_option_create ]
set action_mask [ ca_classifier_action_option_mask_create ]

#########################
####   Set CLS Key   ####
#########################
ca_classifier_key_set_src_port $key 0xc0007
ca_classifier_ip_set_dscp $ip_key 46
ca_classifier_ip_set_ecn $ip_key 0
ca_classifier_key_set_ip $key $ip_key

##########################
#### Set CLS Key Mask ####
##########################
ca_classifier_key_mask_set_src_port $key_mask 1
ca_classifier_key_mask_set_ip $key_mask 1
ca_classifier_ip_mask_set_dscp $ip_mask 1
ca_classifier_ip_mask_set_ecn $ip_mask 1
ca_classifier_key_mask_set_ip_mask $key_mask $ip_mask
##########################
####  Set CLS Action  ####
##########################
#### set forward to fe
ca_classifier_action_set_forward		$action 	1
ca_classifier_action_option_set_priority	$options 	7

##############################
####  Set CLS Action Mask ####
##############################
ca_classifier_action_option_mask_set_priority $action_mask 1
ca_classifier_action_option_set_masks $options $action_mask
ca_classifier_action_set_options $action $options

##########################
####   Add CLS Rule   ####
##########################
set rule_idx [ ca_uint32_create 0 ]
set ret [ ca_classifier_rule_add 0 12 $key $key_mask $action $rule_idx ]
if {$ret != 0} {
        puts "ca_classifier_rule_add() is failed! (ret=$ret)"
} else {
        set cls_rule_idx [ ca_uint32_get $rule_idx ]
        puts "cls_rule_idx = $cls_rule_idx"
}
