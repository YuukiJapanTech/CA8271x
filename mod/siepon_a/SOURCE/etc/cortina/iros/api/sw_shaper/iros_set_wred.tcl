set profile [ ca_queue_wred_profile_create ]

set port_id 0x40020

for {set i 0} {$i < 8} {incr i} {

	source iros_set_wred_cos0.tcl
	source iros_set_wred_cos1.tcl
	source iros_set_wred_cos2.tcl
	source iros_set_wred_cos3.tcl
	source iros_set_wred_cos4.tcl
	source iros_set_wred_cos5.tcl
	source iros_set_wred_cos6.tcl
	source iros_set_wred_cos7.tcl

        incr port_id
}

## for default shaper
set port_id 0x4002f

source iros_set_wred_cos0.tcl
source iros_set_wred_cos1.tcl
source iros_set_wred_cos2.tcl
source iros_set_wred_cos3.tcl
source iros_set_wred_cos4.tcl
source iros_set_wred_cos5.tcl
source iros_set_wred_cos6.tcl
source iros_set_wred_cos7.tcl

