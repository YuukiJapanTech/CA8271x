#########################
#### Create CLS Data ####
#########################
#### create cls action
set action [ ca_classifier_default_action_create ]

##################################
####   Set Default CLS Rule   ####
##################################
ca_classifier_port_default_action_get 0 0x80018 $action
ca_classifier_default_action_dump $action
