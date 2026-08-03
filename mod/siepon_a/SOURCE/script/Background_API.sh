#!/bin/sh

#----------------------------------------
#Init
#----------------------------------------

FORCE_BRIDGE=$(fw_printenv -n CA8271_FORCE_BRIDGE 2>/dev/null || echo 0)
FORCE_TRAFFIC=$(fw_printenv -n CA8271_FORCE_TRAFFIC 2>/dev/null || echo 0)
FORCE_BRIDGE_MAC=$(fw_printenv -n CA8271_FORCE_BRIDGE_MAC 2>/dev/null || echo 00:00:00:00:00:00)
MAC_FILTER=1

echo "$FORCE_BRIDGE_MAC" | grep -Eq '^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$'
if [ $? -ne 0 ]; then
    FORCE_BRIDGE_MAC="00:00:00:00:00:00"
fi

if [ $FORCE_BRIDGE_MAC = "00:00:00:00:00:00" ]; then
    MAC_FILTER=0
fi

#----------------------------------------
#Only for 1st time
#----------------------------------------

if [ $FORCE_BRIDGE -eq 1 ]; then
    if [ $MAC_FILTER -eq 1 ]; then
        iros <<EOF > /dev/null 2>&1
source /script/tcl/Background_API.tcl
wca_classifier_rule_add -device_id 0 -priority 1 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x0007 -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x0007 -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x090f -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x1217 -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x1b1f -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x2427 -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x2d2f -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x3637 -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x3f3f -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x4047 -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x494f -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x5257 -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x5b5f -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x6467 -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x6d6f -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x7677 -mac_sa $FORCE_BRIDGE_MAC
wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x7f7f -mac_sa $FORCE_BRIDGE_MAC
network_pon_classifier_force_bridge_down
EOF
    else
        iros <<EOF > /dev/null 2>&1
source /script/tcl/Background_API.tcl
network_pon_classifier_force_bridge_up
network_pon_classifier_force_bridge_down
EOF
    fi
fi

iros <<EOF > /dev/null 2>&1
ca_port_enable_set 0 0x20007 1
EOF
echo "PON port Enabled."

#----------------------------------------
#Loop
#----------------------------------------

while true
do

if [ $FORCE_TRAFFIC -eq 1 ]; then
        iros <<EOF > /dev/null 2>&1
source /script/tcl/Background_API.tcl
network_pon_mpcp_force_traffic_enable
EOF
fi

    sleep 30
done

#----------------------------------------
