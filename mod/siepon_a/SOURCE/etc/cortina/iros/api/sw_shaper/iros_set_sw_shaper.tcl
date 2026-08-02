
set shaper_id 0
set internal_port 0x40020
set prio 0

for {set i 0} {$i < 8} {incr i} {

    set sw_shaper [ ca_sw_shaper_entry_create ]
    set shaper    [ ca_shaper_create ]

    ca_shaper_set_enable $shaper 1
    ca_shaper_set_rate	 $shaper 20000

    ca_sw_shaper_entry_set_sw_shaper_id  $sw_shaper  $shaper_id
    ca_sw_shaper_entry_set_internal_port $sw_shaper  $internal_port
    ca_sw_shaper_entry_set_prio          $sw_shaper  $prio
    ca_sw_shaper_entry_set_shaper        $sw_shaper  $shaper
    ca_sw_shaper_entry_add 0 $sw_shaper
	
	incr shaper_id
	incr prio
	
	if { $prio > 7 } {
	incr internal_port
        set prio 0
	}

}

