

##########################
####   Add CLS Rule   ####
##########################

proc call_set_cpu256 { udp_dst_port tmp_rule_idx flow_id shaper_id} {

        ##set tmp_src_ipaddr [ format %x $src_ipaddr ]
        ##set tmp_dst_ipaddr [ format %x $dst_ipaddr ]
        puts "tmp_rule_idx=$tmp_rule_idx"
        puts "flow_id=$flow_id"
        puts "shaper_id=$shaper_id"
        #puts "src_ipaddr=$tmp_src_ipaddr"
        #puts "dst_ipaddr=$tmp_dst_ipaddr"
	puts "udp_dst_port=$udp_dst_port"

        ## call the set one shaper sub routine
        source iros_cls_set_cpu256.tcl

        set rule_idx [ ca_uint32_create $tmp_rule_idx ]
        set index [ ca_uint32_get $rule_idx ]
        puts "rule_idx=$index"

        set ret [ ca_classifier_rule_add 0 11 $key $key_mask $action $rule_idx ]
        if {$ret != 0} {
                puts "ca_classifier_rule_add() is failed! (ret=$ret)"
        } else {
                set cls_rule_idx [ ca_uint32_get $rule_idx ]
                puts "cls_rule_idx = $cls_rule_idx"
        }
}

set tmp_rule_idx 1
set flow_id 10
set shaper_id 0
set udp_dst_port 50100

for {set i 0} {$i < 64} {incr i} {

        call_set_cpu256 $udp_dst_port $tmp_rule_idx $flow_id $shaper_id

        incr tmp_rule_idx
        incr flow_id
        incr shaper_id
        incr udp_dst_port
}
