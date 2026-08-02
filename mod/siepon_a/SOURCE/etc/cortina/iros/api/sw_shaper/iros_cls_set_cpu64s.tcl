
##########################
####   Add CLS Rule   ####
##########################

set tmp_rule_idx 0
set shaper_id 0
set flow_id 0x800
set src_ipaddr 0xc0a80165
set dst_ipaddr 0xc0a86465

	set tmp_src_ipaddr [ format %x $src_ipaddr ]
	set tmp_dst_ipaddr [ format %x $dst_ipaddr ]
	puts "tmp_rule_idx=$tmp_rule_idx"
	puts "shaper_id=$shaper_id"
	puts "src_ipaddr=$tmp_src_ipaddr"
	puts "dst_ipaddr=$tmp_dst_ipaddr"

	## call the set one shaper sub routine
	source iros_cls_set_cpu64.tcl

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


