source delete_hash_mask_test.tcl
del_mask 0
del_mask 1

set hmask [ aal_hash_mask_create ]

;# LAN to WAN hash mask
ca_hash_mask_unmask 0 $hmask

aal_hash_mask_set_ip_vld                $hmask  0
aal_hash_mask_set_ip_ver                $hmask  0
aal_hash_mask_set_ip_sa               $hmask  32

set rslt_mask_idx [ ca_uint32_create 0 ]
set ret [ aal_mask_tbl_entry_add_iros 0 $hmask $rslt_mask_idx ]
if {$ret != 0} {
        puts "aal_mask_tbl_entry_add_iros() is failed! (ret=$ret)"
} else {
        set mask_idx [ ca_uint32_get $rslt_mask_idx ]
        puts "Hashmask is added to Hash Engine."
        puts "mask_idx = $mask_idx"
}

;# WAN to LAN hash mask
ca_hash_mask_unmask 0 $hmask

aal_hash_mask_set_ip_vld                $hmask  0
aal_hash_mask_set_ip_ver                $hmask  0
aal_hash_mask_set_ip_da               $hmask  32

set rslt_mask_idx [ ca_uint32_create 0 ]
set ret [ aal_mask_tbl_entry_add_iros 0 $hmask $rslt_mask_idx ]
if {$ret != 0} {
        puts "aal_mask_tbl_entry_add_iros() is failed! (ret=$ret)"
} else {
        set mask_idx [ ca_uint32_get $rslt_mask_idx ]
        puts "Hashmask is added to Hash Engine."
        puts "mask_idx = $mask_idx"
}

