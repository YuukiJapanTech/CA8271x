source /etc/cortina/iros/qa/wca/SC_COMMAND_LIB.tcl
namespace import gw::*

proc network_pon_classifier_force_bridge_up {} {
    #LAN->PON
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x0007
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x090f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x1217
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x1b1f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x2427
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x2d2f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x3637
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x3f3f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x4047
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x494f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x5257
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x5b5f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x6467
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x6d6f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x7677
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x30006 -action_forward 3 -action_dest_port 0x20007 -action_option_flow_id 0x7f7f
}

proc network_pon_classifier_force_bridge_down {} {
    #PON->LAN
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x0007
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x090f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x1217
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x1b1f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x2427
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x2d2f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x3637
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x3f3f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x4047
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x494f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x5257
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x5b5f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x6467
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x6d6f
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x7677
    wca_classifier_rule_add -device_id 0 -priority 7 -src_port 0x20007 -action_forward 3 -action_dest_port 0x30006 -llid_cos_index 0x7f7f
}

proc network_pon_mpcp_force_traffic_enable {} {
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x00 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x01 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x02 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x03 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x04 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x05 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x06 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x07 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x08 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x09 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x0a -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x0b -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x0c -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x0d -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x0e -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x0f -upstream 1 -downstream 1

    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x10 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x11 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x12 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x13 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x14 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x15 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x16 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x17 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x18 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x19 -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x1a -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x1b -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x1c -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x1d -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x1e -upstream 1 -downstream 1
    wca_epon_llid_traffic_enable_set -device_id 0 -port_id 0x20007 -llid 0x1f -upstream 1 -downstream 1
}

