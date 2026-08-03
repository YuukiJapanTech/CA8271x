#========================================================
# FileName: eth.tcl
# Desc: Ethernet Port API Test with Tcl
# Note: all port is 0 based, neednt add port type like 0x30000
#========================================================
set device_id 0
set port_base 0x30000

# Following are show Cmds

proc eth_show_mib {port} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set mib [ca_eth_port_stat_create]
    set ret [ca_eth_port_stat_get $device_id $ep 0 $mib]

    if {$ret == 0} {
        ca_eth_port_stat_dump $mib
    } else {
        puts "fail to get stats, return code $ret"
    }
}

proc eth_show_link {port} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set link [ca_uint32_create 0]
    set ret [ca_eth_port_link_status_get $device_id $ep $link]

    if {$ret == 0} {
        puts "link : [ca_uint32_get $link]"
    } else {
        puts "fail to get link status, return code $ret"
    }
}

proc eth_show_pause {port} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_rx [ca_uint8_create 0]
    set get_tx [ca_uint8_create 0]
    set get_pfc [ca_uint8_create 0]

	set ret [ca_eth_port_pause_get $device_id $ep $get_pfc $get_rx $get_tx]
	if {$ret != 0} {
		puts "ca_eth_port_pause_get fail, return code $ret"
	} else {
		puts "PFC: [ca_uint8_get $get_pfc], RX_PAUSE: [ca_uint8_get $get_rx], TX_PAUSE: [ca_uint8_get $get_tx] "
	}

}

proc eth_show_quanta {port} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_quanta [ca_uint16_create 0]

	set ret [ca_eth_port_pause_quanta_get $device_id $ep $get_quanta]
	if {$ret != 0} {
		puts "ca_eth_port_pause_quanta_get fail, return code $ret"
	} else {
		puts "PAUSE Quanta: [ca_uint16_get $get_quanta]"
	}

}

proc eth_show_mdix {port} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_mdix [ca_uint32_create 0]

	set ret [ca_eth_port_mdix_get $device_id $ep $get_mdix]
	if {$ret != 0} {
		puts "ca_eth_port_pause_quanta_get fail, return code $ret"
	} else {
		puts "MDIX: [ca_uint32_get $get_mdix]"
	}
}

proc eth_show_autoneg {port} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_autoneg [ca_uint8_create 0]

	set ret [ ca_eth_port_autoneg_get $device_id $ep $get_autoneg ]
	if {$ret != 0} {
		puts "ca_eth_port_autoneg_get fail, return code $ret"
	} else {
		puts "AutoNeg: [ca_uint8_get $get_autoneg]"
	}

}

proc eth_show_speed {port} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_speed [ca_uint32_create 0]

	set ret [ ca_eth_port_speed_get $device_id $ep $get_speed ]
	if {$ret != 0} {
		puts "ca_eth_port_speed_get fail, return code $ret"
	} else {
		puts "Speed:  [ca_uint32_get $get_speed]"
	}

}

proc eth_show_duplex {port} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_duplex  [ca_uint32_create 0]

        set ret [ ca_eth_port_duplex_get $device_id $ep $get_duplex ]
        if {$ret != 0} {
            puts "ca_eth_port_duplex_get fail, return code $ret"
        } else {
            puts "Duplex: [ca_uint32_get $get_duplex]"
        }
}

proc eth_show_adv {port} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set rmt_adv [ca_eth_port_ability_create ]

    set ret [ca_eth_port_advert_get $device_id $ep $rmt_adv ]

    if {$ret != 0} {
        puts "ca_eth_port_advert_get FAIL, return code $ret"
    } else {
        ca_eth_port_ability_dump $rmt_adv
    }

}


proc eth_show_rmt_adv {port} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set rmt_adv [ca_eth_port_ability_create ]

    set ret [ca_eth_port_advert_remote_get $device_id $ep $rmt_adv ]

    if {$ret != 0} {
        puts "ca_eth_port_advert_remote_get FAIL, return code $ret"
    } else {
        ca_eth_port_ability_dump $rmt_adv
    }

}


# Following are Test Cmds

proc eth_pause {port pfc pause_rx pause_tx} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_rx [ca_uint8_create 0]
    set get_tx [ca_uint8_create 0]
    set get_pfc  [ca_uint8_create 0]
    set ret [ca_eth_port_pause_set $device_id $ep $pfc $pause_rx $pause_tx]

    if {$ret == 0} {
        set ret [ca_eth_port_pause_get $device_id $ep $get_pfc $get_rx $get_tx]
        if {$ret != 0} {
            puts "ca_eth_port_pause_get fail, return code $ret"
        } else {
            if {[ca_uint8_get $get_rx] != $pause_rx || [ca_uint8_get $get_tx] != $pause_tx || [ca_uint8_get $get_pfc] != $pfc} {
                puts "Test FAIL : get is not equal set,  set: $pause_rx $pause_tx $pfc get:[ca_uint32_get $get_rx] [ca_uint32_get $get_tx]  [ca_uint32_get $get_pfc]"
            } else {
                puts "Test PASS"
            }
        }
    } else {
            puts "ca_eth_port_pause_set fail, return code $ret"
    }

}


proc eth_quanta {port quanta} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_quanta [ca_uint16_create 0]

    set ret [ca_eth_port_pause_quanta_set $device_id $ep $quanta]

    if {$ret == 0} {
        set ret [ca_eth_port_pause_quanta_get $device_id $ep $get_quanta]
        if {$ret != 0} {
            puts "ca_eth_port_pause_quanta_get fail, return code $ret"
        } else {
            if {[ca_uint16_get $get_quanta] != $quanta } {
                puts "Test FAIL : get is not equal set,  set: $quanta  get:[ca_uint16_get $get_quanta]"
            } else {
                puts "Test PASS"
            }
        }
    } else {
            puts "ca_eth_port_pause_quanta_set fail, return code $ret"
    }

}

proc eth_mdix {port mdix} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_mdix [ca_uint32_create 0]

    set ret [ca_eth_port_mdix_set $device_id $ep $mdix]

    if {$ret == 0} {
        set ret [ca_eth_port_mdix_get $device_id $ep $get_mdix]
        if {$ret != 0} {
            puts "ca_eth_port_pause_quanta_get fail, return code $ret"
        } else {
            if {[ca_uint32_get $get_mdix] != $mdix } {
                puts "Test FAIL : get is not equal set,  set: $mdix  get:[ca_uint32_get $get_mdix]"
            } else {
                puts "Test PASS"
            }
        }
    } else {
            puts "ca_eth_port_mdix_set fail, return code $ret"
    }

}



proc eth_autoneg {port enable_autoneg} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_autoneg [ca_uint8_create 0]

    set ret [ ca_eth_port_autoneg_set $device_id $ep $enable_autoneg ]

    if {$ret == 0} {
        set ret [ ca_eth_port_autoneg_get $device_id $ep $get_autoneg ]
        if {$ret != 0} {
            puts "ca_eth_port_autoneg_get fail, return code $ret"
        } else {
            if {[ca_uint8_get $get_autoneg] != $enable_autoneg} {
                puts "Test FAIL : get is not equal set,  set: $enable_autoneg get: $get_autoneg"
            } else {
                puts "Test PASS"
            }
        }
    } else {
            puts "ca_eth_port_autoneg_set fail, return code $ret"
    }

}

proc eth_speed {port speed} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_speed [ca_uint32_create 0]

    set ret [ ca_eth_port_speed_set $device_id $ep $speed ]

    if {$ret == 0} {
        set ret [ ca_eth_port_speed_get $device_id $ep $get_speed ]
        if {$ret != 0} {
            puts "ca_eth_port_speed_get fail, return code $ret"
        } else {
            if {[ca_uint32_get $get_speed] != $speed} {
                puts "Test FAIL : get is not equal set,  set: $speed get: [ca_uint32_get $get_speed]"
            } else {
                puts "Test PASS"
            }
        }
    } else {
            puts "ca_eth_port_speed_set fail, return code $ret"
    }
}


proc eth_duplex {port duplex} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_duplex  [ca_uint8_create 0]

    set ret [ ca_eth_port_duplex_set $device_id $ep $duplex ]

    if {$ret == 0} {
        set ret [ ca_eth_port_duplex_get $device_id $ep $get_duplex ]
        if {$ret != 0} {
            puts "ca_eth_port_duplex_get fail, return code $ret"
        } else {
            if {[ca_uint8_get $get_duplex] != $duplex} {
                puts "Test FAIL : get is not equal set,  set: $duplex get: [ca_uint8_get $get_duplex]"
            } else {
                puts "Test PASS"
            }
        }
    } else {
            puts "ca_eth_port_duplex_set fail, return code $ret"
    }

}


proc eth_adv {port half_10 full_10 half_100 full_100 full_1g full_10g flow_ctrl asym_flow_ctrl} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set set_adv [ca_eth_port_ability_create]
    set get_adv [ca_eth_port_ability_create]

    ca_eth_port_ability_set_half_10 $set_adv $half_10
    ca_eth_port_ability_set_full_10 $set_adv $full_10
    ca_eth_port_ability_set_half_100 $set_adv $half_100
    ca_eth_port_ability_set_full_100 $set_adv $full_100
    ca_eth_port_ability_set_full_1g $set_adv $full_1g
    ca_eth_port_ability_set_full_10g $set_adv $full_10g
    ca_eth_port_ability_set_flow_ctrl $set_adv $flow_ctrl
    ca_eth_port_ability_set_asym_flow_ctrl $set_adv $asym_flow_ctrl

    set ret [ ca_eth_port_advert_set $device_id $ep $set_adv ]

    if {$ret == 0} {
        set ret [ ca_eth_port_advert_get $device_id $ep $get_adv ]
        if {$ret != 0} {
            puts "ca_eth_port_advert_set fail, return code $ret"
        } else {
            set tmpset [ca_eth_port_ability_get_half_10 $set_adv]
            set tmpget [ca_eth_port_ability_get_half_10 $get_adv]
            if {$tmpset != $tmpget} {
                puts "Test FAIL : get half_10 is not equal set,  set: $tmpset get: $tmpget"
            } else {
                puts "Test PASS"
            }

            set tmpset [ca_eth_port_ability_get_half_100 $set_adv]
            set tmpget [ca_eth_port_ability_get_half_100 $get_adv]
            if {$tmpset != $tmpget} {
                puts "Test FAIL : get half_100 is not equal set,  set: $tmpset get: $tmpget"
            } else {
                puts "Test PASS"
            }

            set tmpset [ca_eth_port_ability_get_full_10 $set_adv]
            set tmpget [ca_eth_port_ability_get_full_10 $get_adv]
            if {$tmpset != $tmpget} {
                puts "Test FAIL : get full_10 is not equal set,  set: $tmpset get: $tmpget"
            } else {
                puts "Test PASS"
            }

            set tmpset [ca_eth_port_ability_get_full_100 $set_adv]
            set tmpget [ca_eth_port_ability_get_full_100 $get_adv]
            if {$tmpset != $tmpget} {
                puts "Test FAIL : get full_100 is not equal set,  set: $tmpset get: $tmpget"
            } else {
                puts "Test PASS"
            }

            set tmpset [ca_eth_port_ability_get_full_1g $set_adv]
            set tmpget [ca_eth_port_ability_get_full_1g $get_adv]
            if {$tmpset != $tmpget} {
                puts "Test FAIL : get full_1g is not equal set,  set: $tmpset get: $tmpget"
            } else {
                puts "Test PASS"
            }

            set tmpset [ca_eth_port_ability_get_full_10g $set_adv]
            set tmpget [ca_eth_port_ability_get_full_10g $get_adv]
            if {$tmpset != $tmpget} {
                puts "Test FAIL : get full_10g is not equal set,  set: $tmpset get: $tmpget"
            } else {
                puts "Test PASS"
            }

            set tmpset [ca_eth_port_ability_get_flow_ctrl $set_adv]
            set tmpget [ca_eth_port_ability_get_flow_ctrl $get_adv]
            if {$tmpset != $tmpget} {
                puts "Test FAIL : get flow_ctrl is not equal set,  set: $tmpset get: $tmpget"
            } else {
                puts "Test PASS"
            }

            set tmpset [ca_eth_port_ability_get_asym_flow_ctrl $set_adv]
            set tmpget [ca_eth_port_ability_get_asym_flow_ctrl $get_adv]
            if {$tmpset != $tmpget} {
                puts "Test FAIL : get asym_flow_ctrl is not equal set,  set: $tmpset get: $tmpget"
            } else {
                puts "Test PASS"
            }

        }
    } else {
            puts "ca_eth_port_ability_set fail, return code $ret"
    }

}

proc eth_link_scan {port enable_scan} {
    global device_id
	global port_base
	set ep [expr $port + $port_base]
    set get_scan [ca_uint8_create 0]

    set ret [ ca_eth_port_link_scan_set $device_id $ep $enable_scan ]

    if {$ret == 0} {
        set ret [ ca_eth_port_link_scan_get $device_id $ep $get_scan ]
        if {$ret != 0} {
            puts "ca_eth_port_link_scan_get fail, return code $ret"
        } else {
            if {[ca_uint8_get $get_scan] != $enable_scan} {
                puts "Test FAIL : get is not equal set,  set: $enable_scan get: $get_scan"
            } else {
                puts "Test PASS"
            }
        }
    } else {
            puts "ca_eth_port_link_scan_set fail, return code $ret"
    }

}


