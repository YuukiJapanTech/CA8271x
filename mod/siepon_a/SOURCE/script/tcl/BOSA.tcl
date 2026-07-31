source /etc/cortina/iros/qa/wca/SC_COMMAND_LIB.tcl
namespace import gw::*

proc BOSA_read_dom {} {

    set rx [ca_uint8_array_create 0 1]

    foreach {name addr scale unit signed} {
        Temperature 0x60 256.0     C    1
        Vcc         0x62 10000.0   V    0
        TxBias      0x64 500.0     mA   0
        TxPower     0x66 10000.0   dBm  0
        RxPower     0x68 10000.0   dBm  0
    } {

        cap_i2c_read 0 0xa2 $addr 2 $rx

        set value [expr {([ca_uint8_array_get $rx 0] << 8) | \
                         [ca_uint8_array_get $rx 1]}]

        if {$signed && $value >= 0x8000} {
            set value [expr {$value - 0x10000}]
        }

        switch -- $name {

            Temperature {
                puts [format "%-11s : %.2f C" \
                    $name [expr {$value/$scale}]]
            }

            Vcc {
                puts [format "%-11s : %.4f V" \
                    $name [expr {$value/$scale}]]
            }

            TxBias {
                puts [format "%-11s : %.2f mA" \
                    $name [expr {$value/$scale}]]
            }

            default {
                set mw [expr {$value/$scale}]
                if {$mw > 0} {
                    set dbm [expr {10.0 * log10($mw)}]
                    puts [format "%-11s : %.2f dBm" $name $dbm]
                } else {
                    puts [format "%-11s : -Inf dBm" $name]
                }
            }
        }
    }
}
