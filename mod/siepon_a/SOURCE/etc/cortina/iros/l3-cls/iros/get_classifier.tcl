#########################
#### Create CLS Data ####
#########################
set priority [ ca_uint32_create 0 ]
#### create cls key
set key [ ca_classifier_key_create ]
#### create cls l2
set l2_key [ ca_classifier_l2_create ]
#### create cls ip
set ip_key [ ca_classifier_ip_create ]
#### create cls l4
set l4_key [ ca_classifier_l4_create ]
#### create cls key mask
set key_mask [ ca_classifier_key_mask_create ]
#### create cls action
set action [ ca_classifier_action_create ]
set options [ ca_classifier_action_option_create ]
set action_handle [ ca_classifier_handle_create ]
set action_mask [ ca_classifier_action_option_mask_create ]

##########################
####   Get CLS Rule   ####
##########################
ca_classifier_rule_get 0 1 $priority $key $key_mask $action

#########################
####   Dump CLS Rule   ####
#########################
#### get priority
ca_uint32_get $priority

#### get key
puts "======================= dump key"
ca_classifier_key_dump $key
 
#### get key_mask
puts "======================= dump key_mask"
ca_classifier_key_mask_dump $key_mask

### get action
puts "======================= dump action"
ca_classifier_action_dump $action

puts "======================= dump action->options"
set options [ca_classifier_action_get_options $action]
ca_classifier_action_option_dump $options

puts "======================= dump action->options->action_handle"
set action_handle [ca_classifier_action_option_get_action_handle $options]
#ca_classifier_action_option_action_handle_dump $action_handle
ca_classifier_handle_dump $action_handle

puts "======================= dump action->options->masks"
set action_mask [ca_classifier_action_option_get_masks $options]
ca_classifier_action_option_mask_dump $action_mask
