#########################
#### Create CLS Data ####
#########################
#### create cls action
set action [ ca_classifier_default_action_create ]
set dest [ ca_classifier_action_dest_create ]

##########################
####  Set CLS Action  ####
##########################
#### set forward to port
ca_classifier_default_action_set_action_type $action 3
#### set port
ca_classifier_action_dest_set_port $dest 0x7
ca_classifier_default_action_set_dest $action $dest

##################################
####   Set Default CLS Rule   ####
##################################
ca_classifier_port_default_action_set 0 0x80018 $action

