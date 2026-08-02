#####################################
#TCL scripts for IROS
# v0.1b4 - 05/23/2018
#   1) support g3 show UINT32/16/8 values
#
# v0.1b5 - 07/02/2018
#   1) support g3 innter vid/tpid for l3 interface
#
# v0.1b6 - 10/17/2018
#   1) support new mcast structure
#
# v0.1c0 - 01/16/2020
#   1) remove init varaible displaying during inialization
#	  2) support g3_rw base64 decoding
#
# v0.1c1 - 02/28/2020
#   1) adjust r/w file folder to /usr/local/bin to avoid conflicting
#
#####################################
# global array of parameters:
array set ga {}
array set gsadb {}
array set gl2tp {}
array set gpptp {}

# utitility functions
proc g3_ga {param} {
  global ga
  return $ga($param)
}
proc g3_ga_swap {param1 param2} {
  global ga
  set t $ga{$param1}
  set $ga{$param1} $ga{$param2}
  set $ga{$param2} $t
  return $t
}
proc g3_ga_exist {param {exist_and_none_empty 0}} {
  global ga
  set result 0
  catch {
    set r $ga($param)
    if {$exist_and_none_empty == 0 || "ab$r" != "ab"} {
      set result 1
    }
  } 
  return $result
}
proc g3_lines_from_file {filename} {
  set lines {}
  catch {
    set f [open "$filename" r]
    set data [read $f]
    close $f  
    set lines [split $data "\n"]
  } err
  if {"ab$err" != "ab"} {
    error "file - $filename read error: $err"
  }
  return $lines
}
proc g3_b64_decode {b64_name bin_name} {
  catch {
    set f [open "$b64_name" r]
    set data [read $f]
    close $f  
    set f [open "$bin_name" w]
    puts -nonewline $f [binary decode base64 $data]
    close $f 
  } err
  if {"ab$err" != "ab"} {
    error "base64 decode file - $b64_name to $bin_name error: $err"
    return -1
  }
  return 0
}
proc g3_list_match {lst string_to_match} {
  set l_cnt [llength $lst]
  for {set i 0} {$i < $l_cnt} {incr i} {
    set pos [string first [lindex $lst $i] $string_to_match]
    if {$pos >= 0 } {
      return $i
    }
  }
  return -1 
}
proc g3_list {args} {
  set lst {}
  foreach x_arg $args {
  foreach arg [split $x_arg] {
    incr parse
    # remove {} from strings
    while {1<3} {
      set pos [string first "\{" $arg]
      if {$pos < 0} {
        set pos [string first "\}" $arg]
      }
      if {$pos >= 0} {
        set arg [string replace $arg $pos $pos]
      } else {
        #search/replace finished
        break
      }
    }
    lappend lst $arg
  }}
  return $lst
}
proc g3_string_replace {str old_str {new_str ""}} {
  set rst $str
  set len [string length "$old_str"]
  if {$len == 0} {
    return $rst
  }
  set pos [string first "$old_str" "$rst"]
  while {$pos >= 0} {
    set rst [string replace $rst $pos [expr $pos+$len-1] $new_str]
    set pos [string first "$old_str" "$rst"]    
  }
  return $rst
}
proc g3_printk_lock {{new_printk_level ""}} {
  global ga
  if {"$new_printk_level" == ""} {
    set new_printk_level 4
  }
  exec echo "$new_printk_level" > /proc/sys/kernel/printk
  return $new_printk_level
}
proc g3_printk_unlock {} {
  global ga
  exec echo "$ga(printk)" > /proc/sys/kernel/printk
  return $ga(printk)
}
proc g3_var_reset {variable {reset_type "unsigned_int"}} {
  return [string range $variable 0 [string first _p_ $variable]]p_$reset_type
}
##proc g3_str : translate value to string or index(value) according to type
##usage: g3_str hash_id hmac-sha-1
##       g3_str hash_str 1
##       g3_str ciph_str 3des_cbc
##       g3_str ciph_id cbc
##       g3_str alg_str aes_cbc
##       g3_str alg_id 2
##       g3_str dpid_str 3
##       g3_str dpid_id pe0
##       g3_str spid_str 4
##       g3_str spid_id pe0
##       g3_str ntoh_x 0x04030201  - final result will be in heximal format
##       g3_str ntoh_d 12345678    - final result will be in signed decimal format
##       g3_str ntoh_u 12345678    - final result will be in unsigned decimal format
##       g3_str ip 192.168.60.1/32  - final result will be iros ip_address pointer
##       g3_str ip_str $ip_addr  - final result will be like: 192.168.60.1/32
##       g3_str vcmd_id push
##       g3_str vcmd_str 1
##       g3_str vlan 0x8100:100.7  - final result will be vid=100 pri=7 ca_vlan_t pointer
##       g3_str vlan untag  - final result will be untag ca_vlan_t pointer
##       g3_str mac 192.168.60.1  - final result will be in xx:xx:xx:xx:xx:xx
##       g3_str mac_byte 0:1:2:3:4:5  - final result will be in 000102030405
##       g3_str proto_id tcp  - final result will be 6
##       g3_str proto_str 6  - final result will be "tcp"
##       g3_str fport_id drop - final result will be flow/phy_port index - 0xff
##       g3_str fport_id eth1 - final result will be flow/phy_port index - 1
##       g3_str fport_str 255 - final result will be flow/phy_port name "drop"
##       g3_str fport_str 1 - final result will be  flow/phy_port name "eth1"
##       g3_str ftype_id l4 - final result will be flow/type index - 2
##       g3_str ftype_str 1 - final result will be flow/type name "l2"
proc g3_str {type src {default_str ""}} {
  global ga  
  set type [split $type "_"]
  set key [lindex $type 0]
  set way [lindex $type 1]

  if {"$key" == "ip" } {
    if {"$way" == "str"} {
      set s ""
      set len [ca_ip_address_get_addr_len $src]
      if {[ca_ip_address_get_afi $src] == 0} {
        set v [ca_l3_ip_addr_get_ipv4_addr [ca_ip_address_get_ip_addr $src]]
        set s [format "%d.%d.%d.%d"  [expr ($v>>24)&0xff] [expr ($v>>16)&0xff] [expr ($v>>8)&0xff] [expr $v&0xff]]
        if { $len != 32} {
          set s "$s/$len"
        }
      } else {
        for {set id 0} {$id < 4} {incr id} {
          set v [ca_l3_ip_addr_get_addr [ca_ip_address_get_ip_addr $src] $id]
          set s [format "%s:%x:%x" $s [expr ($v>>16)&0xffff] [expr $v&0xffff]]
        }
        set s [string range $s 1 end]
        if { $len != 128} {
          set s "$s/$len"
        }        
      }
      return $s
    } else {
      return [g3_ip $src]
    }
  }

  if {"$key" == "proto" } {
    array set pa {
      icmp 1
      igmp 2
      tcp 6
      udp 17
      esp 50
      ah 51
    }
    if {"$way" == "id"} {
      set p ""
      catch {
        set p $pa($src)
      }
      if {"$p" == ""} {
        set p $src
      }
      return $p
    } else {
      foreach p [array names pa] {
        if {[expr $pa($p)-$src] == 0} {
          return $p
        }
      }
      return $src
    }
  }

  if {"$key" == "fport" } {  
    if {"$way" == "id"} {
      if {"$src" == "drop"} {
        return 0xff
      }
    } else {
      if {[expr $src-0xff] == 0} {
        return "drop"
      } 
    }
  }

  if {"$key" == "ftype" } {  
    set lst {null l2 l4 mc l7 l2p ipmc l2mac mcl7 mcsw}
    if {"$way" == "id"} {
      set id [lsearch $lst $src]
      if {"$id" < 0} {
        set id $src
      }
      return $id
    } else {
      return [lindex $lst $src]
    }
  }
  
  if {"$key" == "mac" } {
    if {"$way" == "byte"} {
      return [g3_mac $src 1]
    } else {
      return [g3_mac $src]
    }
  }

  if {"$key" == "vcmd" } {  
    set lst {nop push pop swap}
    if {"$way" == "id"} {
      set id [lsearch $lst $src]
      if {"$id" < 0} {
        set id $src
      }
      return $id
    } else {
      return [lindex $lst $src]
    }
  }
  
  if {"$key" == "vlan" } {
    set lst {0x8100 0x9100 0x88a8 0x9200}
    if {"$way" == "str"} {
      set tpid [ca_vlan_get_tpid_encap_type $src]
      if {[expr $tpid-0xffffffff] == 0} {
        set tpid "untag"
      } else {
        if {$tpid < [llength $lst]} {
          set tpid [lindex $lst $tpid]
        } else {
          set tpid "#$tpid"
        }
      }
      set s [format "%s:%d.%d" $tpid [ca_vlan_get_vlan_id $src] [ca_vlan_get_priority $src]]
      return $s      
    }
    set vlan [ca_vlan_create]
    if {[string first ":" $src] > 0} {
      set tpid [lindex [split $src ":"] 0]
      set src [lindex [split $src ":"] end]
      if {"$tpid" == "untag"} {
        ca_vlan_set_tpid_encap_type $vlan 0xffffffff
      } else {
        set i 0
        foreach l $lst {
          if {[expr $l-$tpid] == 0} {
            ca_vlan_set_tpid_encap_type $vlan $i
            break
          }
          incr i
        }
      }
    }

    if {[string first "." $src] > 0} {
      ca_vlan_set_priority $vlan [lindex [split $src "."] end]
      set src [lindex [split $src "."] 0]
    }
    if {"$src" == "untag"} {
      ca_vlan_set_tpid_encap_type $vlan 0xffffffff
    } else {
      ca_vlan_set_vlan_id $vlan $src
    }
    return $vlan
  }
  
  if {"$key" == "ntoh" || "$key" == "hton"} {
    set v [expr (($src&0xff)<<24) + (($src&0xff00)<<8) + (($src>>8)&0xff00) + (($src>>24)&0xff)]
    if {"$way" == "d" || "$way" == "u"} {
      return [format "%$way" $v]
    } else {
      return [format "0x%08x" $v]
    }
  }
  
  set lst [split $ga(str_$key)]  
  if {"$way" == "id"} {
    set v [lsearch -nocase $lst $src]
    if {$v < 0} {
      set v [g3_list_match $lst $src]
    }
    if {$v >= 0 } {
      return $v
    }
    if {"$key" == "hash" } {
      return [g3_str hash2_id $src]
    }
  } else {
    if {$src < [llength $lst]} {
      return [lindex $lst $src]
    }
  }
  return $default_str
}

##proc g3_pool : translate value to string or index(value) according to type
##usage: g3_pool add nhop 0 - add nhop_id=0
##       g3_pool add nhop 10 - add nhop_id=10
##       g3_pool del nhop 7 - delete nhop_id=7
##       g3_pool del nhop - delete all nhop
##       g3_pool get nhop - get pool_nhop list
proc g3_pool {cmd field {value ""}} {
  global ga
  set lst $ga(pool_$field)
  while {1<3} {
    if {"$cmd" == "add"} {
      if {"$value" == ""} {
        break
      }
      if {[lsearch $lst $value] < 0} {
        lappend lst $value
      }
      break
    }

    if {"$cmd" == "del" || "$cmd" == "delete"} {
      if {"$value" == ""} {
        set lst {}
      } else {
        set pos [lsearch $lst $value]
        if { $pos >= 0} {
          set new_lst {}
          if { $pos > 0} {
            set new_lst [lrange $lst 0 [expr $pos-1]]
          }
          foreach l [lrange $lst [expr $pos+1] end] {
            lappend new_lst $l
          }
          set lst $new_lst
        }
      }
      break
    }

    if {"$cmd" == "get"} {
      return $lst
      break
    }
  }
  set ga(pool_$field) $lst
  return [llength $lst]
}


proc g3_parse {type pattern line {strict_pos ""} {default_str ""}} {
  set pos [string first $pattern $line]
  set v $default_str
  if {$pos >= 0} {
    if {"ab$strict_pos" != "ab" && "$pos" != "$strict_pos"} {
      return $v
    }
    set lst [split [string range $line [expr $pos+[string length $pattern]] end]]
    for {set i 0} {$i < [llength $lst]} {incr i} {
      set v [string trim [lindex $lst $i] ","]
      if {"ab$v" != "ab"} {
        break;
      }
    }
    while {1<3} {
      if {"$type" == "raw"} {
        break
      }
      if {"$type" == "tolower"} {
        set v [string tolower $v]
        break
      }
      if {"$type" == "toupper"} {
        set v [string toupper $v]
        break
      }
      if {"$type" == "flag"} {
        set v 1
        break
      }
      if {"$type" == "flag0"} {
        set v 0
        break
      }
      error "error type($type) for $pattern from $line \n"
      break
    }
  }
  return $v
}

proc g3_ret_chk {ret {info ""}} {
  if {$ret != 0} {
    set msg ""
    if {[expr $ret] == 65535} {
      set msg "error"
    } else {
      set msg [g3_str err_str $ret]
    }
    if {"ab$info" != "ab"} {
      set info " @ $info"
    }
    if {"ab$msg" == "ab"} {
      set msg "error: ret=$ret, unknown return code$info"
    } else {
      set msg "error: ret=$ret, ca_e_$msg$info"
    }
    error $msg
  }
  return $ret
}


##proc g3_ip : generate ca_ip_address_t structure
##usage: g3_ip 192.168.1.0/24
##       g3_ip 192.168.1.10
##       g3_ip 2001:0:0:1::/64
##       g3_ip 2001:0:0:1::1
proc g3_ip {ip} {
# keep host endian
  set ipa [ca_ip_address_create]
  set def_addr_len 32
  set split_str "."
  if { [string first ":" "$ip"] >= 0 } {
    ca_ip_address_set_afi $ipa 1
    set def_addr_len 128
    set split_str ":"
  } else {
    ca_ip_address_set_afi $ipa 0
  }

  set pos [string first "/" "$ip"]
  if { $pos >= 0 } {
    ca_ip_address_set_addr_len $ipa [expr [string range "$ip" [expr $pos+1] end]]
  } else {
    ca_ip_address_set_addr_len $ipa $def_addr_len
    set pos [string length "$ip"]
  }

  set lst [split [string range "$ip" 0 [expr $pos-1]] $split_str]
  set _ip [ca_l3_ip_addr_create]  
  if {$def_addr_len == 32} {
    set ne_ip 0
    set mul 0x1000000
    foreach e $lst {
      set ne_ip [expr $ne_ip+$e*$mul]
      set mul [expr $mul/256]
    }
    ca_l3_ip_addr_set_ipv4_addr $_ip $ne_ip
  }  else {
    set lst_cnt [llength $lst]
    if {$lst_cnt <= 8} { # check even when cnt==8 to resovle 2001::1:2:3:4:5:6 case
      set insert_id 0
      for {set i 0} {$i < $lst_cnt} {incr i} {
        if { "[lindex $lst $i]ab" == "ab" } {
          set lst [lreplace $lst $i $i 0]
          if {$insert_id == 0} {
            set insert_id $i
          }
        }
      }
      for {set i $lst_cnt} {$i < 8} {incr i} {
        set lst [linsert $lst $insert_id 0]
      }
    }
    set ne_ip 0
    set mul 0x10000
    set id 0
    foreach e $lst {
      set ne_ip [expr $ne_ip+0x$e*$mul]
      set mul [expr $mul/65536]
      if {$mul < 1} {
        ca_l3_ip_addr_set_ipv6_addr $_ip $ne_ip $id
        set mul 0x10000
        set ne_ip 0
        set id [incr id]
      }
    }
    
  }
  ca_ip_address_set_ip_addr $ipa $_ip
  return $ipa
}
proc g3_ip_ne {ip} {
# change host to network endian
  set ipa [ca_ip_address_create]
  set def_addr_len 32
  set split_str "."
  if { [string first ":" "$ip"] >= 0 } {
    ca_ip_address_set_afi $ipa 1
    set def_addr_len 128
    set split_str ":"
  } else {
    ca_ip_address_set_afi $ipa 0
  }

  set pos [string first "/" "$ip"]
  if { $pos >= 0 } {
    ca_ip_address_set_addr_len $ipa [expr [string range "$ip" [expr $pos+1] end]]
  } else {
    ca_ip_address_set_addr_len $ipa $def_addr_len
    set pos [string length "$ip"]
  }

  set lst [split [string range "$ip" 0 [expr $pos-1]] $split_str]
  set _ip [ca_l3_ip_addr_create]  
  if {$def_addr_len == 32} {
    set ne_ip 0
    set mul 1
    foreach e $lst {
      set ne_ip [expr $ne_ip+$e*$mul]
      set mul [expr $mul*256]
    }
    ca_l3_ip_addr_set_ipv4_addr $_ip $ne_ip
  }  else {
    set lst_cnt [llength $lst]
    if {$lst_cnt < 8 } {
      set insert_id 0
      for {set i 0} {$i < $lst_cnt} {incr i} {
        if { "[lindex $lst $i]ab" == "ab" } {
          set lst [lreplace $lst $i $i 0]
          if {$insert_id == 0} {
            set insert_id $i
          }
        }
      }
      for {set i $lst_cnt} {$i < 8} {incr i} {
        set lst [linsert $lst $insert_id 0]
      }
    }
    set ne_ip 0
    set mul 1
    set id 0
    foreach e $lst {
      set ne_ip [expr $ne_ip+((0x$e>>8)+((0x$e&0xff)<<8))*$mul]
      set mul [expr $mul*65536]
      if {$mul > 65536} {
        ca_l3_ip_addr_set_ipv6_addr $_ip $ne_ip $id
        set mul 1
        set ne_ip 0
        set id [incr id]
      }
    }
    
  }
  ca_ip_address_set_ip_addr $ipa $_ip
  return $ipa
}


##proc g3_local_subnet : check whether ip is a local subnet of given interface
##usage: g3_local_subnet eth1 192.168.1.10 - return 1 if eth1 is 192.168.1.xx, or return 0 if eth1 is 192.168.2/3/....
##           g3_local_subnet eth0 2001:0:0:60::2 - return 1 if eth1 is 2001:0:0:60::xx, or return 0 if eth1 is others
proc g3_local_subnet {eth_name ip} {
  set subs ""
  if {[string first ":" $ip] >= 0} {
    set subs [ip -6 route show dev $eth_name proto kernel]
  } else {
    set subs [ip route show dev $eth_name proto kernel]
  }
  foreach sub $subs {
    set pos [string first "/" $sub]
    if { $pos > 2 } {
      set prefix [string range $sub 0 [expr $pos-2]]
      if {[string first $prefix $ip] == 0} {
        return 1
      }
    }
  }
  return 0
}


##proc g3_mac : generate xx:xx:xx:xx:xx:xx mac address
##usage: g3_mac eth0 - generate mac address structure from interface mac
##       g3_mac 192.168.60.2 - generate mac address from IP (arp)
##       g3_mac 2001:0:0:60::2 - generate mac address from IP (ndp)
##       g3_mac 00:11:22:33:44:55 - generate mac address directly
##       g3_mac pppoe - generate peer mac address for ppppoe connection
##       g3_mac pppoe_own - generate my mac address for ppppoe connection
proc g3_mac {eth_or_ip_or_mac {byte_format 0}} {
  global ga
  #handle pppoe case in advance
  if {$eth_or_ip_or_mac == "pppoe" || $eth_or_ip_or_mac == "pppoe_own"} {
    set own_flag 0
    if {$eth_or_ip_or_mac == "pppoe_own"} {
      set own_flag 1
    }
    set mac ""
    foreach pip {1.1.1.1 1.1.1.2} {
      set own 0
      catch {
        # ignore if pip is my owned ip
        set msg [ip addr | grep $pip]
        set own 1
      }
      if {$own != $own_flag} {
        continue
      }
      set mac [g3_mac $pip]
      if {"$mac" != "0:0:0:0:0:0"} {
        if {$ga(flag_dbg_print) != 0} {
          puts "get mac $mac from $pip for pppoe nhop"
        }
        break
      }
    }
    return $mac
  }    

  #handle normal cases
  set s [lindex [split $eth_or_ip_or_mac "/"] 0]
  set mac ""
  set ifs [exec ifconfig -a | grep HWaddr | cut -f 1 -d { }]
  set ifs [split $ifs]
  if {[lsearch $ifs $s] < 0} {
    set ip_eth ""
    foreach ifn $ifs {
      catch {
        set ip_eth [exec ip addr show dev $ifn | grep "$s/"]
        set ip_eth $ifn
      }
      if {"$ip_eth" != ""} {
        set s $ip_eth
        break
      }
    }
  }
  if {[llength [split "$s" "."]] != 4 && [string first ":" "$s"] < 0 } {
    set eth_mac ""
    catch {set eth_mac [exec ifconfig $s | grep -o -e "HWaddr .*"]}
    set eth_mac [lindex [split $eth_mac] 1]
    set mac $eth_mac
  } else {
    set mac $s
    set retry 0
    if {[string first "." "$s"] > 0 || [string first "::" "$s"] >= 0 || [llength [split "$s" ":"]] == 8 } {
      set retry 3
    }    
    
    for {set i 0} {$i < $retry} {incr i} {
      set ip_mac ""
      catch {
        set ip_mac [exec ip neigh show | grep "$s "]
      } err
      if { "ab$ip_mac" == "ab" } {
        set ip_mac ""
      } else {
        set ip_mac [lindex [split $ip_mac] 4]
        if {[string first ":" "$ip_mac"] < 0} {    
          set ip_mac ""
        }
      }
      if { "ab$ip_mac" == "ab" } {
        puts "try #$i ping $s -c 1 -W 1 to get the mac address"
        catch {exec ping $s -c 1 -W 1}
        puts "......"
      } else {
        set mac $ip_mac
        break
      }
    }
  }
  if {[string first ":" "$mac"] < 0 || [string first "::" "$mac"] > 0 || [llength [split "$mac" ":"]] > 6 } {
    set mac "0:0:0:0:0:0"
  }
  if {$byte_format != 0} {
    set lst [split $mac ":"]
    set bstr [format "%02x" 0x[lindex $lst 0]]
    for {set i 1} {$i < 6} {incr i} {
      set bstr [format "%s%02x" $bstr 0x[lindex $lst $i]]
    }
    set mac $bstr
  }
  return $mac
}
proc g3_ca_mac {mac_str} {
  set mac [g3_mac $mac_str]
  set lst [split $mac ":"]
  set ca_mac [ca_mac_addr_create 0x[lindex $lst 0] 0x[lindex $lst 1] 0x[lindex $lst 2] 0x[lindex $lst 3] 0x[lindex $lst 4] 0x[lindex $lst 5]]
  return $ca_mac
}
proc g3_ca_mac_str {ca_mac} {
  return [format "%02x:%02x:%02x:%02x:%02x:%02x" [ca_mac_addr_get $ca_mac 0] [ca_mac_addr_get $ca_mac 1]\
  [ca_mac_addr_get $ca_mac 2] [ca_mac_addr_get $ca_mac 3] [ca_mac_addr_get $ca_mac 4] [ca_mac_addr_get $ca_mac 5] ]
  
}
proc g3_arg_help {param_list} {
    puts "Supported parameters:"
    set param_list [g3_list $param_list]
    foreach  f $param_list {
      puts "  $f"
    }
    puts "\nConfiguration guide/examples:"
    uplevel 1 g3 help {[lindex [info level 0] 0]}
    error "Parameter error"
}

##proc g3_l3_intf : generate l3 interface strcture
##usage: g3_l3_intf type=1 port=0x18 ip=192.168.2.1 mac=00:13:25:00:00:02
##       g3_l3_intf type=3 ip=192.168.2.1 tunnel_id=1 vid=100 mac=auto
##       g3_l3_intf ip=192.168.2.1 mtu=1400 type=2 outer_vid=0xffff mac=auto
proc g3_l3_intf {args} {
  #form correct id/smac/dmac/pppoes/vid1/2/dip/intf_id
  global ga
  array set a {
    type    	1
    intf_id  	""
    port_id 	"" 
    mac_addr	""
    outer_tpid ""
    outer_vid ""
    inner_tpid ""
    inner_vid ""
    tunnel_id	""
    mtu		""
    ip_addr	""
    nat_enable	""
    
    mac ""
    ip ""
    port ""
  }
  set args [g3_list $args]
  if { [llength $args] == 0 } {
    g3_arg_help [array names a]
  }
  foreach arg $args {
    set v ""
    foreach f [array names a] {
      set v [g3_parse tolower "$f=" "$arg" 0]
      if {"ab$v" != "ab"} {
        set a($f) $v
        break
      }
    }
    if {"ab$v" == "ab"} {
      puts "ignore arg: $arg" 
      g3_arg_help [array names a]
    }
  }

  # redundant parameters
  if { "ab$a(mac_addr)" == "ab" } {
    set a(mac_addr) $a(mac)
  }
  if { "ab$a(ip_addr)" == "ab" } {
    set a(ip_addr) $a(ip)
  }
  if { "ab$a(port_id)" == "ab" } {
    set a(port_id) $a(port)
  }
  # remove redundant parameters
  set a(mac) ""
  set a(ip) ""
  set a(port) ""
  
  # smart parameters
  if { "$a(mac_addr)" == "auto" &&  "ab$a(ip_addr)" != "ab" } {
    set a(mac_addr) $a(ip_addr)
  }

  set r [ca_l3_intf_create]

  if { "ab$a(mac_addr)" != "ab" } {
    g3 $r.mac_addr=[g3_ca_mac $a(mac_addr)]
    g3 $r.mask.mac_addr=1
    set a(mac_addr) ""
  }
  if { "ab$a(ip_addr)" != "ab" } {
    g3 $r.ip_addr=[g3_ip  $a(ip_addr)]
    g3 $r.mask.ip_addr=1
    set a(ip_addr) ""
  }
  
  foreach f [array names a] {
    if {"ab$a($f)" != "ab"} {
      g3 $r.$f=$a($f)
      if { "$f" != "type" && "$f" != "intf_id" } {
        g3 $r.mask.$f=1
      }
    }
  }
  return $r
}

proc g3_l3_intf_dump {args} {
  #form correct id/smac/dmac/pppoes/vid1/2/dip/intf_id
  set v $args
  puts "\[ca_l3_intf_t - $v\]"
  puts -nonewline "  intf_id=[g3 $v.intf_id] type=[g3 $v.type]"
  foreach f {port_id mtu nat_enable outer_tpid outer_vid inner_tpid inner_vid tunnel_id} {
    if { [g3 $v.mask.$f] != 0 } {
      puts -nonewline " $f=[g3 $v.$f]"
    }
  }
  puts ""
  if { [g3 $v.mask.ip_addr] != 0 } {
    puts "  ip_addr=[g3_str ip_str [g3 $v.ip_addr]]"
  }
  if { [g3 $v.mask.mac_addr] != 0 } {
    puts "  mac_addr=[g3_ca_mac_str [g3 $v.mac_addr]]"
  }
}

##proc g3_l3_intf_add : generate l3 interface strcture and provision to HW
##usage: g3_l3_intf_add intf_id=1 type=1 port=0x18 ip=192.168.2.1 mac=00:13:25:00:00:02
##       g3_l3_intf_add intf_id=2 ip=192.168.2.1 vid=100 
##       g3_l3_intf_add intf_id=3 ip=192.168.2.1 mtu=1400 type=2 vid=0xffff
proc g3_l3_intf_add { args } {
  set l3 [g3_l3_intf $args]
  set ret [g3 ca_l3_intf_add [g3_ga dev_id] $l3]
  if {$ret == 0} {
    g3_pool add var $l3
    g3_pool add l3_intf [g3 $l3.intf_id]
  }
  return [g3 $l3.intf_id]
}

##proc g3_l3_intf_delete : delete l3 interface from hardware by intf_id
##usage: g3_l3_intf_delete  - delete all l3 interfaces
##       g3_l3_intf_delete 0~63 - delete l3 interface id 1~64
proc g3_l3_intf_delete { {intf_ids "0~63"} {no_display 0} } {
  set l3 [ca_l3_intf_create]
  set cnt 0
  set del_lst {}
  foreach intf_id_lst $intf_ids {
  foreach intf_id [split $intf_id_lst] {
    set lst [split $intf_id "~"]
    set id0 [lindex $lst 0]
    set id1 $id0
    if {[llength $lst] > 1} {
      set id1 [lindex $lst 1]
    }
    for {set i $id0} {$i <= $id1} {incr i} {
      ca_l3_intf_set_intf_id $l3 $i
      if {[ca_l3_intf_get [g3_ga dev_id] $l3] != 0} {
        continue
      }
      if {[ca_l3_intf_delete [g3_ga dev_id] $i] == 0} {
        incr cnt
        lappend del_lst $i
        g3_pool del l3_intf $i
      }
    }
  }}
  if {$no_display == 0} {
    puts "delete l3 interface count: $cnt"
    puts "delete l3 interface index: $del_lst"
  }
  return $cnt
}

##proc g3_nhop : generate nexthop strcture
##usage: g3_nhop intf_id=1 ip=192.168.2.123 mac=192.168.2.123
##       g3_nhop flags=1 intf_id=64 ip=192.168.2.123 mac=192.168.2.1
##       g3_nhop intf_id=1 ip=192.168.100.10
proc g3_nhop {args} {
  global ga
  array set a {
    nexthop_id ""
    attr_flags ""
    addr ""
    intf_id ""
    da_mac ""
    aging_timer 0
    ip ""
    mac ""
    flags 1
  }

  set args [g3_list $args]
  if { [llength $args] == 0 } {
    g3_arg_help [array names a]
  }  
  foreach arg $args {
    set v ""
    foreach f [array names a] {
      set v [g3_parse tolower "$f=" "$arg" 0]
      if {"ab$v" != "ab"} {
        set a($f) $v
        break
      }
    }

    if {"ab$v" == "ab"} {
      puts "ignore arg: $arg" 
      g3_arg_help [array names a]     
    }
  }

  # redundant parameters
  if { "ab$a(attr_flags)" == "ab" } {
    set a(attr_flags) $a(flags)
  }
  if { "ab$a(da_mac)" == "ab" } {
    set a(da_mac) $a(mac)
  }
  if { "ab$a(addr)" == "ab" } {
    set a(addr) $a(ip)
  }
  # remove redundant parameters
  set a(mac) ""
  set a(ip) ""
  set a(flags) ""
  
  set r [ca_l3_nexthop_create]

  #use ip as da_mac if da_mac is empty
  if { "ab$a(da_mac)" == "ab" } {
    set a(da_mac) a(addr)
  }
  
  # remove da_mac after setting to variable
  g3 $r.da_mac=[g3_ca_mac $a(da_mac)]
  set a(da_mac) ""
  
  # remove addr after setting to variable
  g3 $r.addr=[g3_ip $a(addr)]
  set a(addr) ""
  
  foreach f [array names a] {
    if {"ab$a($f)" != "ab"} {
      g3 $r.$f=$a($f)
    }
  }

#  ca_l3_nexthop_dump $nh
  return $r
}

proc g3_l3_nexthop_dump {args} {
  set v $args
  puts "\[ca_l3_nexthop_t - $v\]"
  puts "  attr_flags=[g3 $v.attr_flags] nexthop_id=[g3 $v.nexthop_id] intf_id=[g3 $v.intf_id] aging_timer=[g3 $v.aging_timer]"
  puts "  addr=[g3_str ip_str [g3 $v.addr]]"
  puts "  da_mac=[g3_ca_mac_str [g3 $v.da_mac]]"
}

#proc g3_nhop_add : add nexthop to hardware
##usage: g3_nhop_add intf_id=1 ip=192.168.2.123 mac=192.168.2.123 flags=0
##       g3_nhop_add intf_id=64 ip=192.168.100.10 
proc g3_nhop_add { args } {
  set nhop_id [ca_uint16_create 0xffff]
  set nhop [g3_nhop $args]
  set ret [g3 ca_l3_nexthop_add [g3_ga dev_id] $nhop $nhop_id]
  if {$ret == 0} {
    g3_pool add nhop [ca_uint16_get $nhop_id]
    g3_pool add var $nhop
  }
  return [ca_uint16_get $nhop_id]
}


##proc g3_nhop_delete : delete nexthop from hardware by nhop_id
##usage: g3_nhop_delete  - delete all nexthops
##       g3_nhop_delete 0~2079 - delete nexthop id 0~2079
proc g3_nhop_delete { {nhop_ids "0~2079"} {no_display 0} } {
  set cnt 0
  set del_lst {}
  foreach nhop_id_lst $nhop_ids {
  foreach nhop_id [split $nhop_id_lst] {
    set lst [split $nhop_id "~"]
    set id0 [lindex $lst 0]
    set id1 $id0
    if {[llength $lst] > 1} {
      set id1 [lindex $lst 1]
    }
    for {set i $id0} {$i <= $id1} {incr i} {
      if {[ca_l3_nexthop_delete [g3_ga dev_id] $i] == 0} {
        incr cnt
        lappend del_lst $i
        g3_pool del nhop $i
      }
    }
  }}
  if {$no_display == 0} {
    puts "delete nexthop count: $cnt"
    puts "delete nexthop index: $del_lst"
  }
  return $cnt
}


##proc g3_route : generate a new LPM route strcuture (not installed to hardware yet)
##usage: g3_route prefix=192.168.2.0/24 nexthop_id=1296
##       g3_route 192.168.2.0/24@1296 - generate route (prefix=192.168.2.0/24 nexthop_id=1296)
proc g3_route {args} {
  array set a {
    nexthop_id ""
    prefix ""
  }

  if { [string first "@" $args] > 0 } {
    # simple format xxx.xx.xx.xxx/xx@XXXX
    set args [split $args "@"]
    set a(prefix) [lindex $args 0]
    set a(nexthop_id) [lindex $args end]

  } else {

    set args [g3_list $args]
    if { [llength $args] == 0  || "$args" == "" } {
      g3_arg_help [array names a]
    }  
    
    foreach arg $args {
      set v ""
      foreach f [array names a] {
        set v [g3_parse tolower "$f=" "$arg" 0]
        if {"ab$v" != "ab"} {
          set a($f) $v
          break
        }
      }

      if {"ab$v" == "ab"} {
        puts "ignore arg: $arg" 
        g3_arg_help [array names a]      
      }
    }

  }
  
  set r [ca_l3_route_create]
  g3 $r.nexthop_id=$a(nexthop_id) $r.prefix=[g3_ip $a(prefix)]
  return $r
}

proc g3_l3_route_dump {args} {
  set v $args
  puts "\[ca_l3_route_t - $v\]"
  puts "  prefix=[g3_str ip_str [g3 $v.prefix]] nexthop_id=[g3 $v.nexthop_id]"
}

##proc g3_route_add : add LPM route strcture to hardware
##usage: g3_route_add prefix=192.168.2.0/24 nexthop_id=1296
##       g3_route_add 192.168.2.0/24@1296 - add route (prefix=192.168.2.0/24 nexthop_id=1296)
proc g3_route_add {args} {
  set route [g3_route $args]
  set ret [g3 ca_l3_route_add [g3_ga dev_id] $route]
  if {$ret == 0} {
    g3_pool add var $route  
    g3_pool add route "[g3_str ip_str [g3 $route.prefix]]@[ca_l3_route_get_nexthop_id $route]"
  }  
  return $ret
}

##proc g3_route_delete : delete LPM route from hardware
##usage: g3_route_delete - delete all routes
##       g3_route_delete 192.168.2.0/24@1296 - delete route (prefix=192.168.2.0/24 nexthop_id=1296)
proc g3_route_delete { {routes ""} {no_display 0} } {
  set r [ca_l3_route_create]
  set cnt 0
  set del_lst {}
  
  if { "ab$routes" == "ab" } {
     set routes [g3_pool get route]
  }
  foreach route_lst $routes {
  foreach route [split $route_lst] {
    set lst [split $route "@"]
    set prefix [lindex $lst 0]
    set nexthop_id [lindex $lst end]
    ca_l3_route_set_prefix $r [g3_ip $prefix]
    ca_l3_route_set_nexthop_id $r $nexthop_id
    if {[ca_l3_route_delete [g3_ga dev_id] $r] == 0} {
      incr cnt
      lappend del_lst $route
      g3_pool del route $route
    }
    
  }}
  if {$no_display == 0} {
    puts "delete route count: $cnt"
    puts "delete route index: $del_lst"
  }
  return $cnt
}
#proc g3_iros_sub_cmd_gen : generate iros command by given params 
proc g3_iros_sub_cmd_gen {cmd_str params} {
  set params [g3_list $params]
  set fields {dev_id opr_id p_var}
  set lst {}
  foreach p $params {
    set process 0
    foreach f $fields {
      if {"$f" != "$"} {
        continue
      }
      if {"$f" == "dev_id"} {
        lappend lst [g3_ga dev_id]
        set process 1
        break
      }
      if {"$f" == "dev_id"} {
        lappend lst [g3_ga dev_id]
        set process 1
        break
      }
      if {$process == 0} {
        lappend lst $p
      }
    }
        
    
  }
  return $lst
}

##proc g3_nat : generate nat strcture (or the reverse nat structure for the opposite direction)
##usage: g3_nat sip=192.168.1.100->192.168.60.1 dip=202.168.10.100 proto=udp sport=1024->10444 dport=80
##           g3_nat reverse sip=192.168.1.100->192.168.60.1 dip=202.168.10.100 proto=udp sport=1024->10444 dport=80 
proc g3_nat {args} {
  global ga
  set reverse 0
  array set a {
    dip ""
    sip ""
    sport ""
    dport ""
  }
  array set b [array get a]
  array set cntl {
    proto "17"
    xlate_flags ""
    aging_timer ""
    nexthop_id "65535"
  }
  array set parser {
    sip {src_ip_addr "g3_str ip_id"}
    dip {dst_ip_addr "g3_str ip_id"}
    proto {ip_proto "g3_str proto_id"}
    sport {src_l4_port ""}
    dport {dst_l4_port ""}
    xlate_flags {xlate_flags ""}
    aging_timer {aging_timer ""}
    nexthop_id {nexthop_id ""}
  }
 
  set n [ca_nat_entry_create]

  set args [g3_list $args]
  if { [llength $args] == 0 || "$args" == "{}"  } {
    g3_arg_help [array names parser]
  }    
  
  foreach arg $args {
    if {"$arg" == ""} {
      continue
    }
    if {"$arg" == "reverse"} {
      set reverse 1
      continue;
    }
    set f [lindex [split $arg "="] 0]
    set v [lindex [split $arg "="] end]
    while {1<3} {
      if {[lsearch [array names a] $f] >= 0 } {
        set v0 [lindex [split "$v" "->"] 0]
        set v1 [lindex [split "$v" "->"] end]
        if {"$v0" == "auto"} {
          set v0 ""
        }
        if {"$v1" == "auto"} {
          set v1 ""
        }
        set a($f) $v0
        set b($f) $v1
        break
      } 
      if {[lsearch [array names cntl] $f] >= 0 } {
        set cntl($f) $v
        break
      } 
      puts "g3_nat: ignore unsupported fields '$arg'"
      g3_arg_help [array names parser]      
      break      
    }
  }

  # reverse the dip/sip sport/dport a/b for opposite direction
  if { $reverse != 0 } {
    array set t [array get a]
    set a(dip) $b(sip)
    set b(sip) $t(dip)
    set a(sip) $b(dip)
    set b(dip) $t(sip)
    set a(sport) $b(dport)
    set b(dport) $t(sport)
    set a(dport) $b(sport)
    set b(sport) $t(dport)
    puts "reverse chnage"
  }
  
  foreach an {a b} {
    set prefix ""
    if {"$an" == "b"} {
      set prefix "new_"
    }
    foreach f [array names $an] {
      set v $a($f)
      if {"$an" == "b"} {
        set v $b($f)
      }
      if {"$v" == ""} {
        continue
      }
      set field "$prefix[lindex $parser($f) 0]"
      set cmd [lindex $parser($f) 1]
      if {"$cmd" != ""} {
        set cmd [eval $cmd $v]
      } else {
        set cmd $v
      }
      if {[g3_ga flag_dbg_print] != 0} {
        puts "g3 $n.$field=$cmd"
      }
      g3 $n.$field=$cmd
    }
  }

# auto choose flags if not specified
  if {"$cntl(xlate_flags)ab" == "ab" } {
    set cntl(xlate_flags) 0
    if {"$a(sip)" != "$b(sip)"} {
      set cntl(xlate_flags) [expr $cntl(xlate_flags)|1];
    }
    if {"$a(dip)" != "$b(dip)"} {
      set cntl(xlate_flags) [expr $cntl(xlate_flags)|2];
    }
    if {"$a(sport)" != "$b(sport)"} {
      set cntl(xlate_flags) [expr $cntl(xlate_flags)|4];
    }
    if {"$a(dport)" != "$b(dport)"} {
      set cntl(xlate_flags) [expr $cntl(xlate_flags)|4];
    }
    if {"$cntl(aging_timer)" == "" || [expr $cntl(aging_timer)] == 0 } {
        set cntl(xlate_flags) [expr $cntl(xlate_flags)|8];
    }
  }
  
  foreach f [array names cntl] {
    set v $cntl($f)
    if {"$v" == ""} {
      continue
    }
    set field [lindex $parser($f) 0]
    set cmd [lindex $parser($f) 1]
    if {"$cmd" != ""} {
      set cmd [eval $cmd $v]
    } else {
      set cmd $v
    }
    if {[g3_ga flag_dbg_print] != 0} {    
      puts "g3 $n.$field=$cmd"
    }
    g3 $n.$field=$cmd
  }

  return $n
}

#proc g3_nat_add : add nat entry to hardware
##usage: g3_nat_add sip=192.168.1.100->192.168.60.1 dip=202.168.10.100 proto=udp sport=1024->10444 dport=80
proc g3_nat_add { args } {
  set nat [g3_nat $args]
  set ret [g3 ca_nat_entry_add [g3_ga dev_id] $nat]
  if {$ret == 0} {
    g3_pool add var $nat
  } else {
    ca_data_free $nat
  }
  return $ret
}

#proc g3_nat_delete : delete nat entry from hardware
##usage: g3_nat_delete sip=192.168.1.100->192.168.60.1 dip=202.168.10.100 proto=udp sport=1024->10444 dport=80
proc g3_nat_delete { args } {
  set nat [g3_nat $args]
  set ret [g3 ca_nat_entry_delete [g3_ga dev_id] $nat]
  ca_data_free $nat
  return $ret
}

#proc g3_nat_pair_add : add both in/out nat entry to hardware
##usage: g3_nat_pair_add sip=192.168.1.100->192.168.60.1 dip=202.168.10.100 proto=udp sport=1024->10444 dport=80
proc g3_nat_pair_add { args } {
  set ret_o [g3_nat_add $args]
  set ret_i [g3_nat_add $args reverse] 
  set ret $ret_o
  if {$ret == 0} {
    set ret $ret_i
  } 
  return $ret
}

#proc g3_nat_pair_delete : delete both in/out nat entry from hardware
##usage: g3_nat_pair_delete sip=192.168.1.100->192.168.60.1 dip=202.168.10.100 proto=udp sport=1024->10444 dport=80
proc g3_nat_pair_delete { args } {
  set ret_o [g3_nat_delete $args]
  set ret_i [g3_nat_delete $args reverse] 
  set ret $ret_o
  if {$ret == 0} {
    set ret $ret_i
  } 
  return $ret
}

proc g3_nat_entry_dump {args} {
  set v $args
  set sip [g3_str ip_str [g3 $v.src_ip_addr]]
  set sip_n [g3_str ip_str [g3 $v.new_src_ip_addr]]
  set dip [g3_str ip_str [g3 $v.dst_ip_addr]]
  set dip_n [g3_str ip_str [g3 $v.new_dst_ip_addr]]
  set flags [g3 $v.xlate_flags]
  set sport [g3 $v.src_l4_port]
  set sport_n [g3 $v.new_src_l4_port]
  set dport [g3 $v.dst_l4_port]
  set dport_n [g3 $v.new_dst_l4_port]
  
  set sip_str ""
  if { [expr $flags & 0x1] != 0 } {
    set sip_str " sip=$sip->$sip_n"
  } else {
    if { $sip != $sip_n } {
      set sip_str " sip=$sip (warning new: $sip_n) "
    } else {
      set sip_str " sip=$sip"
    }
  }
  set dip_str ""
  if { [expr $flags & 0x2] != 0 } {
    set dip_str " dip=$dip->$dip_n"
  } else {
    if { $dip != $dip_n } {
      set dip_str " dip=$dip (warning new: $dip_n) "
    } else {
      set dip_str " dip=$dip"
    }
  }
  set sport_str ""
  set dport_str ""

  if { [expr $flags & 0x4] != 0 } {
    set sport_str " sport=$sport->$sport_n"
    set dport_str " dport=$dport->$dport_n"
  } else {
    if { $sport != $sport_n } {
      set sport_str " sport=$sport (warning new: $sport_n) "
    } else {
      set sport_str " sport=$sport"
    }
    if { $dport != $dport_n } {
      set dport_str " dport=$dport (warning new: $dport_n) "
    } else {
      set dport_str " dport=$dport"
    }
  }
  set age_str ""
  if { [g3 $v.aging_timer] != 0 } {
    set age_str " aging_timer=[g3 $v.aging_timer]"
  }

  set nid_str ""
  if { [g3 $v.nexthop_id] != 65535 } {
    set nid_str " nexthop_id=[g3 $v.nexthop_id]"
  }
  
  puts "$v:$sip_str$dip_str proto=[g3_str proto_str [g3 $v.ip_proto]]$sport_str$dport_str$age_str$nid_str"
  
}

proc g3_mcast_entry_dump {args} {
  #form correct id/smac/dmac/pppoes/vid1/2/dip/intf_id
  set v $args
  set type "l2"
  if  { [string first "ca_l3_mcast" $v] >= 0 } {
    set type "l3"
    set typestr ""
    puts "\[ca_l3_mcast_entry_t - $v\]"
    puts "  mcg_id=[g3 $v.mcg_id] ip=[g3_str ip_str [g3 $v.group_ip_addr]] src=[g3_str ip_str [g3 $v.src_ip_address]]"
  } else {
    puts "\[ca_l3_mcast_entry_t - $v\]"  
    set typestr ""
    puts "  mcg_id=[g3 $v.mcg_id] mc_llid=[g3 $v.mc_llid] vid=[g3 $v.mcast_vlan] mac=[g3_ca_mac_str [g3 $v.group_mac_addr]] src=[g3_str ip_str [g3 $v.src_ip_address]]"
  }
}
proc g3_l2_mcast_entry_dump {args} {
  g3_mcast_entry_dump $args
}
proc g3_l3_mcast_entry_dump {args} {
  g3_mcast_entry_dump $args
}

proc g3_mcast_member_dump {type_print args} {
  #form correct id/smac/dmac/pppoes/vid1/2/dip/intf_id
  set v $args
  set type "l2"
  if  { [string first "ca_l3_mcast" $v] >= 0 } {
    set type "l3"
  }
  if { $type_print > 0 } {
    puts "\[ca_${type}_mcast_member_t - $v\]"
  }
  if { $type == "l2" } {
    puts -nonewline "  port=[g3 $v.member_port]"
  } else {
    puts -nonewline "  port=[g3 $v.member_intf]"
  }
  if { [g3 $v.action_mask.mac_da_overwrite] != 0 } {
    puts -nonewline " da=[g3_ca_mac_str [g3 $v.new_mac_da]]"
  }
  set vcmd [g3 $v.action_mask.vlan_action]
  if { $vcmd != 0 } {
    puts -nonewline " vcmd=[g3_str vcmd_str $vcmd] vid=[g3 $v.vid]"
  }
  puts ""
}

proc g3_mcast_group_dump {args} {
  #form correct id/smac/dmac/pppoes/vid1/2/dip/intf_id
  set v $args
  set type "l2"
  if  { [string first "ca_l3_mcast" $v] >= 0 } {
    set type "l3"
  }
  set cnt [g3 $v.member_count]
  puts "\[ca_${type}_mcast_group_members_t - $v\]"
  puts "  mcg_id=[g3 $v.mcg_id] member_count=$cnt"
  for {set i 0} {$i < $cnt} {incr i} {
    set mm [g3 $v.member.$i]
    puts -nonewline " #$i:"
    g3_mcast_member_dump 0 $mm
  }
}
proc g3_l2_mcast_group_members_dump {args} {
  g3_mcast_group_dump $args
}
proc g3_l3_mcast_group_members_dump {args} {
  g3_mcast_group_dump $args
}

##proc g3_mcast_config : dump or set mcast mode and flooding
##usage: g3_mcast_config - dump current mcast mode and flooding setup
##       g3_mcast_config 1 1 - choose l2 mcast with flooding
##       g3_mcast_config 1 0 - choose l2 mcast without flooding
##       g3_mcast_config 2 1 - choose l3 mcast with flooding
##       g3_mcast_config 2 0 - choose l3 mcast without flooding
proc g3_mcast_config {{l3 ""} {flooding "0"}} {
  global ga
  set ret 0
  set cfg [ca_l2_mcast_config_create]
  if { $l3 != "" } {
    g3 $cfg.mcast_flooding_enable=$flooding
    g3 $cfg.mode=$l3 
    set ret [g3 ca_mcast_config_set [g3_ga dev_id] $cfg]
  }

  if { $ret == 0 } {
    set ret [g3 ca_mcast_config_get [g3_ga dev_id] $cfg]
  }

  if {$ret != 0} {
    puts "error in calling config set/get! ret=$ret"
  } else {
    puts "mode=[g3 $cfg.mode] mcast_flooding_enable=[g3 $cfg.mcast_flooding_enable]"
  }

  ca_data_free $cfg
  return $ret
}

##proc g3_mcast : generate l2 or l3 mcast entry strcture
##usage: g3_mcast type=l2 vid=100 mac=01:00:5e:0a:0a:0a src=192.168.100.10
##       set mc [g3_mcast type=l2 mac=01:00:5e:0a:0a:0a]
##       set mc [g3_mcast type=l3 ip=ff00:0:10:10::10 src=2001:0:0:100::10]
proc g3_mcast {args} {
  global ga
  array set a {
    type "l2"
    vid "0xffff"
    mcg_id ""
    mc_llid ""
    ip ""
    mac ""
    src ""
  }

  set args [g3_list $args]
  if { [llength $args] == 0 } {
    g3_arg_help [array names a]
  }  
  foreach arg $args {
    set v ""
    foreach f [array names a] {
      set v [g3_parse tolower "$f=" "$arg" 0]
      if {"ab$v" != "ab"} {
        set a($f) $v
        break
      }
    }

    if {"ab$v" == "ab"} {
      puts "ignore arg: $arg" 
      g3_arg_help [array names a]     
    }
  }

  set r [ca_l2_mcast_entry_create]
  if {"$a(type)" == "l3" } {
    ca_data_free $r
    set r [ca_l3_mcast_entry_create]
  }

  if { "$a(type)" == "l2" } {
    if {  "$a(vid)" != "" } {
      g3 $r.mcast_vlan=$a(vid) 
    }
    if {  "$a(mcg_id)" != "" } {
      g3 $r.mcg_id=$a(mcg_id) 
    }
    if {  "$a(mc_llid)" != "" } {
      g3 $r.mc_llid=$a(mc_llid) 
    }    
  }
  if { "$a(ip)" != "" } {
    g3 $r.group_ip_addr=[g3_ip $a(ip)] 
  }
  if { "$a(mac)" != "" } {
    g3 $r.group_mac_addr=[g3_ca_mac $a(mac)] 
  }  
  if { "$a(src)" != "" } {
    g3 $r.src_ip_address=[g3_ip $a(src)]
  }
  
#  g3 show $r
  return $r
}

proc g3_mcast_opr {add_delete mc} {
  set v $mc
  set type "l2"
  set cnt 0
  if  { [string first "ca_l3_mcast" $v] >= 0 } {
    set type "l3"
  }
#  g3 show $mc
    set cmd "ca_${type}_mcast_group_${add_delete}"
    if { $add_delete == "delete"} {
    puts mcgid=[g3 $mc.mcg_id]
      set mc [g3 $mc.mcg_id]
    }
    set ret [$cmd [g3_ga dev_id] $mc]
    set result "ok"
    if { $ret != 0 } {
      set result "failed (result=$ret,[g3_str err_str $ret])"
    } 
    puts "$add_delete : $result from $cmd"
  
  return $ret
}

##proc g3_mcast_add : add port/intf set into given mcast variable
##usage: g3_mcast_add $mc
##       set mc [g3_mcast type=l2 ip=224.10.10.10]
##       g3_mcast_add $mc
proc g3_mcast_add {mc} {
  return [g3_mcast_opr add $mc]
}

##proc g3_mcast_delete : delete port set into given mcast variable
##usage: g3_mcast_delete $mc
##       set mc [g3_mcast type=l2 ip=224.10.10.10]
##       g3_mcast_add $mc
##       g3_mcast_delete $mc
proc g3_mcast_delete {mc} {
  return [g3_mcast_opr delete $mc]
}

##proc g3_mcast_member_update : update mcast member structure by given params
##usage: g3_mcast_member_update $mm intf_id=1 da=00:01:02:03:04:05
##       g3_mcast_member_update $mm intf_id=1
##       g3_mcast_member_update $mm port=0x30001 da=00:01:02:03:04:05 vcmd=push vid=100
##       g3_mcast_member_update $mm port=0x30001 
##       g3_mcast_member_update $mm port=0x30001 vcmd=pop
##       g3_mcast_member_update $mm port=0x30001 vcmd=swap vid=200
proc g3_mcast_member_update {r args} {
  array set a {
    intf_id ""
    port ""
    da ""
    vcmd ""
    vid ""
  }

  set args [g3_list $args]
  if { [llength $args] == 0 } {
    g3_arg_help [array names a]
  }  
  foreach arg $args {
    set v ""
    foreach f [array names a] {
      set v [g3_parse tolower "$f=" "$arg" 0]
      if {"ab$v" != "ab"} {
        set a($f) $v
        break
      }
    }

    if {"$v" == ""} {
      puts "ignore arg: $arg" 
      g3_arg_help [array names a]     
    }
  }

  if { "$a(intf_id)" != "" } {
    g3 $r.member_intf=$a(intf_id) 
  }
  if { "$a(port)" != "" } {
    g3 $r.member_port=$a(port) 
  }
  set msk [g3 $r.action_mask]
  if { "$a(da)" != "" } {
    g3 $r.new_mac_da=[g3_ca_mac $a(da)]
    g3 $msk.mac_da_overwrite=1
  }
  if { "$a(vcmd)" != "" } {
    g3 $r.vlan_action=[g3_str vcmd_id $a(vcmd)]
    g3 $msk.vlan_action=1
  }
  if { "$a(vid)" != "" } {
    g3 $r.vid=$a(vid) 
  }
  
#  g3 show $r
  return $r
}

##proc g3_mcast_group : join interface/port into given mcast variable
##usage: g3_mcast_group $mc intf_id=1 da=00:01:02:03:04:05
##       set mg [g3_mcast_group $mc intf_id=1]
##       set mg [g3_mcast_group $mc port=0x30001 da=00:01:02:03:04:05 vlan=push vid=100]
##       set mg [g3_mcast_group $mc port=0x30001]
##       set mg [g3_mcast_group $mc port=0x30001 vlan=pop]
##       set mg [g3_mcast_group $mc port=0x30001 vlan=swap vid=200]
proc g3_mcast_group {mc args} {
  set type "l3"
  if {[string first "l2" $mc] >= 0} {
    set type "l2"
  }
  set mg [ca_${type}_mcast_group_members_create]
  set mm [g3 $mg.member.0]
  g3 $mg.mcg_id=$mc.mcg_id $mg.member_count=1
  g3_mcast_member_update $mm $args
  return $mg
}

proc g3_mcast_member_opr {add_or_delete mc args} {
  set mg [g3_mcast_group $mc $args]
  set type "l3"
  if {[string first "l2" $mc] >= 0} {
    set type "l2"
  }
  set ret [g3 ca_${type}_mcast_member_${add_or_delete} [g3_ga dev_id] $mg]
  ca_data_free $mg
  return $ret
}

##proc g3_mcast_join : join interface/port into given mcast variable
##usage: g3_mcast_join $mc intf_id=1 da=00:01:02:03:04:05
##       g3_mcast_join $mc intf_id=1
##       g3_mcast_join $mc port=0x30001 da=00:01:02:03:04:05 vlan=push vid=100
##       g3_mcast_join $mc port=0x30001 
##       g3_mcast_join $mc port=0x30001 vlan=pop
##       g3_mcast_join $mc port=0x30001 vlan=swap vid=200
proc g3_mcast_join {mc args} {
  return [g3_mcast_member_opr add $mc $args]
}

##proc g3_mcast_leave : leave interface/port from given mcast variable
##usage: g3_mcast_leave $mc intf_id=1 da=00:01:02:03:04:05
##       g3_mcast_leave $mc intf_id=1
##       g3_mcast_leave $mc port=0x30001 da=00:01:02:03:04:05 vlan=push vid=100
##       g3_mcast_leave $mc port=0x30001 
##       g3_mcast_leave $mc port=0x30001 vlan=pop
##       g3_mcast_leave $mc port=0x30001 vlan=swap vid=200
proc g3_mcast_leave {mc args} {
  return [g3_mcast_member_opr delete $mc $args]
}

##proc g3_tunnel : generate tunnel strcture
##usage: g3_tunnel 1 pppoes=10 da=00:11:22:33:44:55
##       g3_tunnel ipsec sip=192.168.60.1 dip=192.168.60.2 nhop_id=9 policy=1
##       g3_tunnel ipsec sip=192.168.60.2 dip=192.168.60.1 nhop_id=10 policy=1
##       g3_tunnel l2tp sip=192.168.60.1 dip=192.168.60.2 tid=0x0102
##       g3_tunnel l2tp_ipsec sip=192.168.60.1 dip=192.168.60.2 tid=0x0102 policy=1
##       g3_tunnel pptp sip=192.168.60.1 dip=192.168.60.10 up_call_id=12 dn_call_id=999 up_sa_id=1 dn_sa_id=2
##       g3_tunnel 6rd sip=192.168.60.1 dip=192.168.60.2 mc_mac=01:00:5e:00:00:00 intf_id=32
##       g3_tunnel dslite sip=2001:0:0:60::1 dip=2001:0:0:60::2 mc_mac=01:00:5e:00:00:00 intf_id=48
proc g3_tunnel {{tunnel_type 1} args} {
  #form correct id/smac/dmac/pppoes/vid1/2/dip/intf_id
  global ga
  set nhop_id ""
  set tc [g3 ca_tunnel_cfg_create]
  set pppoe [g3 $tc.tunnel.pppoe]
  set l2tp [g3 $tc.tunnel.l2tp]
  set pptp [g3 $tc.tunnel.pptp]
  set ipsec [g3 $tc.tunnel.ipsec]
  set six_rd [g3 $tc.tunnel.six_rd]
  set dslite [g3 $tc.tunnel.dslite]
  
  array set a {
    intf_id ""
    sip 0.0.0.0
    dip 0.0.0.0
    pppoes ""
    vid1 ""
    vid2 ""  
    policy ""
    ver ""
    len ""
    sport ""
    dport ""
    tid 0
    sid 0
    cookie 0
    offset ""
    sa ""
    da ""
    spec_len ""
    spec_type ""
    send_seq ""
    ns ""
    encap ""
    dir 0
    nhop_id ""
    auto_nhop 0
    up_call_id ""
    dn_call_id ""
    up_sa_id ""
    dn_sa_id ""
    replace_inner_sa 1
    replace_inner_da 1
    default_tos 0
    flow_label 2
  }

  if { [llength $args] == 0 } {
    g3_arg_help [array names a]
  }
  
  set tunnel_id [g3_str tunnel_id $tunnel_type]
  if {$tunnel_id == ""} {
    set tunnel_id $tunnel_type
  }
  set tunnel_str [g3_str tunnel_str $tunnel_id]
  set require_mac_lst {pppoe}
  
  set args [g3_list $args]
  foreach arg $args {
    set parse 0
    foreach f [array names a] {
      set pos [string first "$f=" "$arg"]
      if {$pos == 0} {
        set a($f) [string range "$arg" [expr $pos+[string length "$f"]+1] end]
        set parse 1
        break      
      }
    }
    if {$parse != 0} {
      continue;
    }
    
    # dslite
    set var ""
    if {$tunnel_str == "dslite" } {
      set var $dslite
    } else {
      if {$tunnel_str == "6rd" } {
        set var $six_rd
      }
    }

    if { "$var" != "" } {    
      while {1<3} {
        set f "mc_mac"
        set pos [string first "$f=" "$arg"]
        if {$pos == 0} {
          g3 $var.mc_mac=[g3_ca_mac  [string range "$arg" [expr $pos+[string length "$f"]+1] end]]
          break;
        } 

        set f "ipv6_6rd_prefix"
        set pos [string first "$f=" "$arg"]
        if {$pos == 0} {
          g3 $var.ipv6_6rd_prefix=[g3_ip  [string range "$arg" [expr $pos+[string length "$f"]+1] end]]
          break;
        } 
        
        g3 $var.$arg
        break
      }
    }
    
  }

  # translate default sa/da only when specific tunnel types
  if {[lsearch $require_mac_lst $tunnel_str] >= 0 } {
    if {"$a(sa)" == ""} {
      set a(sa) [g3_mac $a(sip)]
    }
    if {"$a(da)" == ""} {
      set a(da) [g3_mac $a(dip)]
    }
  }

  # common settings
  g3 $tc.type=$tunnel_id
  set dip [g3_ip $a(dip)]
  set sip [g3_ip $a(sip)]
  g3 $tc.dest_addr=$dip
  g3 $tc.src_addr=$sip
  ca_data_free $dip
  ca_data_free $sip
  if {"$a(intf_id)" != ""} {
    g3 $tc.parent_l3_intf_id=$a(intf_id)
  }
  
  # pppoe
  if {$tunnel_str == "pppoe"} {
    set da [g3_ca_mac $a(da)]
    g3 $pppoe.mac_da=$da
    g3 $pppoe.pppoe_session_id=$a(pppoes)
    ca_data_free $da
  }
  
  # l2tp
  if {$tunnel_str == "l2tp" || $tunnel_str == "l2tp_ipsec"} {
    foreach f {len dport sport} {
      if {"$a($f)" == ""} {
        set a($f) [g3_ga l2tp_$f]
      }
    }
    g3 $l2tp.ver=2 $l2tp.len=$a(len) $l2tp.tid=$a(tid) $l2tp.dest_port=$a(dport) $l2tp.src_port=$a(sport)
    if {"$a(policy)" != ""} {    
      g3 $l2tp.ipsec_policy=$a(policy)
    }
  }

  # pptp
  if {$tunnel_str == "pptp"} {
    g3 $gre.up_call_id=$a(up_call_id) $gre.down_call_id=$a(dn_call_id)
    g3 $gre.overlay_tunnel_egress.pptp_sa_id=$a(up_sa_id) $gre.overlay_tunnel_ingress.pptp_sa_id=$a(dn_sa_id)
  }

  if {$tunnel_str == "dslite" || $tunnel_str == "6rd"} {
        # record intf_id as parent_l3_intf_id. it will be loaded during g3_tunnel_add
      g3 $tc.parent_l3_intf_id=$a(intf_id)
  }
  
  return $tc
}


##proc g3_tunnel_add : add tunnel to hardware
##usage: g3_tunnel_add 4 sip=192.168.60.1 dip=192.168.60.2 policy=1
##       g3_tunnel_add ipsec sip=192.168.60.1 dip=192.168.60.2 nhop_id=9 policy=1
proc g3_tunnel_add { tunnel_type args } {
  set tunnel [g3_tunnel $tunnel_type $args auto_nhop=1]
  set tunnel_id [ca_uint16_create [g3 $tunnel.parent_l3_intf_id]]
  set ret [g3 ca_tunnel_add [g3_ga dev_id] $tunnel $tunnel_id]
  if {$ret == 0} {
    g3_pool add tunnel [ca_uint16_get $tunnel_id]
  } else {
    error "tunnel_create error: type=$type args=$args tunnel=$tunnel"
    g3_show $tunnel
  }
  return [ca_uint16_get $tunnel_id]
}

##proc g3_tunnel_delete : delete tunnel from hardware
##usage: g3_tunnel_delete 1 - delete tunnel #1
##       g3_tunnel_delete 0~1023 - delete tunnel #0~#1023
proc g3_tunnel_delete { {tunnel_ids "0~2079"} {no_display 0} } {
  set cnt 0
  set del_lst {}
  foreach tunnel_id_lst $tunnel_ids {
  foreach tunnel_id [split $tunnel_id_lst] {
    set lst [split $tunnel_id "~"]
    set id0 [lindex $lst 0]
    set id1 $id0
    if {[llength $lst] > 1} {
      set id1 [lindex $lst 1]
    }
    for {set i $id0} {$i <= $id1} {incr i} {
      if {[ca_tunnel_delete [g3_ga dev_id] $i] == 0} {
        incr cnt
        lappend del_lst $i
        g3_pool del tunnel $i
      }
    }
  }}
  if {$no_display == 0} {
    puts "delete tunnel count: $cnt"
    puts "delete tunnel index: $del_lst"
  }
  return $cnt
}
proc g3_tunnel_cfg_dump {args} {
  set v $args
  puts "\[ca_tunnel_cfg_t - $v\]"

  set tunnel_str [g3_str tunnel_str [g3 $v.type]]
  puts -nonewline "  type=[g3 $v.type]($tunnel_str) intf_id=[g3 $v.parent_l3_intf_id]"
  puts " [g3_str ip_str [g3 $v.src_addr]]->[g3_str ip_str [g3 $v.dest_addr]]"
  while { 1 < 3 } { 
    # pppoe dump
    if {$tunnel_str == "pppoe"} {
      set pppoe [g3 $v.tunnel.pppoe]
      set da [g3_ca_mac_str [g3 $pppoe.dest_mac]]
      set sa [g3_ca_mac_str [g3 $pppoe.port_encap.src_mac]]
      puts -nonewline "  sa=$sa da=$da"
      set ptype [g3 $pppoe.port_encap.type]
      if {$ptype >= 2} {
          puts -nonewline " vid1=[g3 $pppoe.port_encap.tag.0]"
      }
      if {$ptype >= 3} {
        puts -nonewline " vid2=[g3 $pppoe.port_encap.tag.1]"
      }
      puts " pppoes=[g3 $pppoe.pppoe_session_id]"
      break
    }
    # other unsupported types
    ca_tunnel_cfg_dump $v
    break
  }
}

proc g3_net_from_ip {ip} {
  set lst {}
  for {set i 1} {$i < 32} {incr i} {
    lappend lst "192.168.60.${i}"
    lappend lst "192.168.${i}.0/24"
    lappend lst "2001:0:0:60::${i}"
    lappend lst "2001:0:0:${i}::/64"
  }
  set ip [lindex [split $ip "/"] 0]
  foreach {l_ip l_net} $lst {
    if {"$ip" == "$l_ip"} {
      return $l_net
    }
  }
  return ""
}

##proc g3_clone : clone a new structure with same content of existing structure
##usage: g3_clone $flow1 - clone a new structure pointer with same content of $flow1
proc g3_clone {var} {
  set t [g3_get_ca_type_by_var $var]
  set lst {}
  if {"$t" == "ca_flow"} {
    set lst {flow_type dec_ttl ingress_pkt egress_pkt voq_offset flow_id life_time swid_array.0 swid_array.1 swid_array.2}
  }
  set nf [${t}_create]
  foreach l $lst {
    g3 $nf.$l=$var.$l
  }
  return $nf
}


##proc g3_show : show information
##usage: g3_show ga - display global variable arrays
##       g3_show ga pool - dispaly all global parameters containing the name of pool
##       g3_show var - dispaly all var pool entries 
##       g3_show help - dispaly help information
proc g3_show {args} {
  global ga
  set parse 0
  set lst [g3_list $args]
  set f1 ""
  if {[llength $lst] > 1} {
    set f1 [lindex $lst 1]
  }

  while {1<3} {
    if {"[lindex $lst 0]" == "ga"} {
      incr parse
      puts "ga - global array of parameters:"
      foreach p [lsort [array names ga]] {
        if {"$f1" != "" && [string first "$f1" "$p"] < 0} {
          continue
        }
        puts [format "  %20s - %s" $p $ga($p)]
      }
      break
    }

    if {"[lindex $lst 0]" == "var"} {
      incr parse
      puts "var pool of global array: "
      puts [format "  %20s - %s" pool_var $ga(pool_var)]
      foreach p $ga(pool_var) {
        if { [llength $lst] > 1 } {
          set match 0
          foreach l [lrange $lst 1 end] {
            if { [string first $l $p] >= 0 } {
              set match 1
              break
            }
          }

          if { $match == 0 } {
            continue
          }
        }
        puts ""
        g3_show $p
        
      }
      break
    }
    
    if {"[lindex $lst 0]" == "help"} {
      incr parse
      set lines [g3_lines_from_file /qa/iros_lib.tcl]
      set help_blks 0
      set help_print 0
      foreach line $lines {
        if {[string first "##" $line] == 0} {
          if {"$f1" != "" && [string first "$f1" "$line"] < 0} {
            continue
          }
          if {$help_print == 0} {
            incr help_blks
            if {$help_blks > 1} {
              puts "\n"
            }
            set help_print 1            
          }
          puts [string range $line 2 end]
        } else {
          set help_print 0
        }
      }
      puts "\n\n[g3_ga iros_lib_version]"
      break
    }

    set v [g3_get [lindex $lst 0]]  
    if {"$v" != ""} {
      incr parse
      set type [g3_get_ca_type_by_var $v]
      if {"$type" != ""} {
        set display 0
        if {$ga(flag_smart_dump) != 0 && [lsearch $ga(pool_smart) ${type}_dump] >= 0} {
          set type [string replace $type 0 1 "g3"]
          ${type}_dump $v
          set display 1
        }
        if {$display == 0} {
          if { [string first "ca_uint" $type] == 0 } {
            puts "${type}_get $v"
            puts [${type}_get $v]
          } else {
            puts "${type}_dump $v"
            ${type}_dump $v
          }
        }
      } else {
        puts $v
      }
      break       
    }
    
    puts [format "\nunknown show fields: %s\n" $lst]
    break
  }
  if {$parse == 0} {    
    g3_show help g3_show
  }
}

proc g3_flush { {types "all"} } {
  set cnt 0
  if {"$types" == "all" || "$types" == ""} {
    #set types {mcast route nhop l3_intf nat}
    set types {route nhop l3_intf nat}
  }
  set types [g3_list $types]
  foreach type $types {
    #special delete, no need to retrieve ga(pool)
    if {"$type" == "nat"} {
      ca_nat_entry_delete_all [g3_ga dev_id]
      continue
    } 
    if {"$type" == "mcast"} {
      ca_l2_mcast_group_delete_all [g3_ga dev_id]
      ca_l3_mcast_group_delete_all [g3_ga dev_id]
      continue
    } 
    
    #normal detete from saved software pool
    set lst [g3_pool get $type]
    if {"$lst" == ""} {
      continue
    }   
    if {"$type" == "l3_intf"} {
      set cnt [expr $cnt+[g3_l3_intf_delete $lst]]
      continue
    }      
    if {"$type" == "route"} {
      set cnt [expr $cnt+[g3_route_delete $lst]]
      continue
    }  
    if {"$type" == "tunnel"} {
      set tc [ca_tunnel_cfg_create]
      foreach tid $lst {
        set ret [ca_tunnel_delete [g3_ga dev_id] $tid]
        if {$ret == 0} {
          g3_pool del tunnel $tid
          incr cnt
        }
      }
      continue
    } 
    if {"$type" == "nhop"} {
      set cnt [expr $cnt+[g3_nhop_delete [g3_pool get nhop]]]
      continue
    }    
    if {"$type" == "pptp_sa"} {
      ca_pptp_session_clear_all [g3_ga dev_id]
      set cnt [expr $cnt+[llength [g3_pool get pptp_sa]]]
      continue
    }
    if {"$type" == "var"} {
      set cnt [expr $cnt+[llength [g3_pool get var]]]
      foreach var [g3_pool get var] {
        g3 ca_data_free $var
      }
      continue
    }
    if {"$type" == "flow"} {
      set cnt [expr $cnt+[g3_flow_delete [g3_pool get flow]]]
      continue
    }    
    if {"$type" == "rtp"} {
      set cnt [expr $cnt+[g3_rtp_delete [g3_pool get rtp]]]
      continue
    }
    if {"$type" == "xlat"} {
      set cnt [expr $cnt+[g3_xlat_delete [g3_pool get xlat]]]
      continue
    }
  }
  return $cnt
}

##proc g3_init : init iros
##usage: g3_init - check & init (only if the init has never been performed)
##       g3_init 1 - always init the tcl variables
##       g3_init 2 - always init the tcl variables and iros drivers
proc g3_init {{forced_init 1}} {
  global ga
  global gsadb
  global gpptp
  global gl2tp
  if { [file exists /qa] == 0 } {
    exec ln -s /etc/cortina/iros/qa /qa
  } 
  if { [file exists /qa/g3_rw] == 0 } {
    if { [g3_b64_decode "/qa/g3_rw.b64.tcl" "/qa/g3_rw" ] == 0 } {
      set err ""
      catch {
        exec mkdir -p /usr/local/bin
        exec chmod 755 /qa/g3_rw
        exec ln -s /qa/g3_rw /usr/local/bin/r
        exec ln -s /qa/g3_rw /usr/local/bin/w
      } err
      puts "g3_rw is prepared!"      
    }
  }
  
  if { "$forced_init" == "0" } {
    set f ""
    catch { 
      set f [open "/tmp/g3_init_flag" r]
      close $f
    } err
    if {"$f" == ""} {
      set forced_init 2
    } else {
      if {"[array name ga]" == ""} {
        set forced_init 1
      }
    }
  }

  if {$forced_init < 1} {
    return ""
  }  
  
#  puts "init local variables"
  unset ga
  array set ga {
    dev_id              0
    printk              "7 4 1 7"
    flag_dbg_print    0
    flag_smart_dump 1
    str_hash            "null md5 sha1"
    str_hash2           "null md-5 sha-1"
    str_ciph            "ecb cbc crt ccm gcm ofb cfb"
    str_alg             "null des aes"
    str_dpid            "eth0 eth1 eth2 pe0 pe1 rootmc cpu0 cpu1 cpu2 cpu3 cpu4 cpu5 cpu6 cpu7"
    str_spid            "eth0 eth1 eth2 cpu pe0 pe1 rootmc mirror"  
    str_fport           "eth0 eth1 eth2 pe0 pe1 cpu c0 c1 c2 c3"
    str_err             "ok resource param not_found conflict timeout internal not_support config unavail memory busy full empty exists device port llid vlan init intf nexthop route db_change inactive"
    str_nhop            "unknown direct intf iplip ipsec l2tp_ipsec pptp gre l2tp xlat etherip_ipsec"
    str_tunnel          "invalid pppoe l2tp ipsec pptp 4in4 dslite 6rd 6in6"
    str_mppe            "none mppe40 mppe128"    
    pool_l3_intf         {}
    pool_nhop           {}
    pool_route          {}
    pool_tunnel         {}
    pool_spd            {}
    pool_policy         {}
    pool_sa             {}
    pool_pptp_sa        {}
    pool_var            {}
    pool_l2tp           {}
    pool_flow           {}
    pool_rtp            {}
    pool_smart          {ca_l3_intf_dump ca_l3_nexthop_dump ca_l3_route_dump ca_nat_entry_dump\
 ca_l2_mcast_entry_dump ca_l3_mcast_entry_dump ca_l2_mcast_group_members_dump ca_l3_mcast_group_members_dump\
 ca_tunnel_cfg_dump}
    pool_xlat           {}
    l2tp_len            0
    l2tp_sport          1701
    l2tp_dport          1701
    l2tp_spec_len       4
    l2tp_spec_type      1
    l2tp_send_seq       0
    l2tp_ns             0
    l2tp_offset         0
    upg_ip              192.168.2.123
  }
  set ga(str_err) "$ga(str_err) mcast_addr_exists mcast_addr_add_fail mcast_addr_delete_fail mem_alloc"
  set ga(str_err) "$ga(str_err) nexthop_invalid nexthop_not_found route_max_limit route_not_found"
  array unset gsadb
  array set gsadb {}
  array unset gl2tp
  array set gl2tp {}
  array unset gpptp
  array set gpptp {}
  
  if {$forced_init < 2} {
    return ""
  }
#  puts "init iros modules"
  exec echo "init" > /tmp/g3_init_flag
  return ""
}

proc upg {{ip ""}} {
  if {"$ip" == ""} {
    set ip [g3_ga upg_ip]
  } else {
    global ga
    set ga(upg_ip) $ip
  }
  file delete /qa/g3_rw.b64.tcl
  file delete /qa/g3_rw  
  catch { 
    exec wget ftp://r:r@$ip/script/g3/g3_rw.b64.tcl -O /qa/g3_rw.b64.tcl
  } err
  puts $err
  catch {
  exec wget ftp://r:r@$ip/script/g3/iros_lib.tcl -O /qa/iros_lib.tcl
  } err
  catch {
  exec md5sum /qa/iros_lib.tcl
  } err2
  puts $err
  puts $err2
  catch { 
    exec md5sum /qa/g3_rw.b64.tcl     
  } err
  puts $err  
  uplevel 1 source /qa/iros_lib.tcl
}


proc g3_source {args} {
  set args [g3_list $args]
  set cmd ""
  foreach arg $args {
    if {"$cmd" == ""} {
      set cmd $arg
    } else {
      set cmd "$cmd $arg"
    }
  }
  return [eval $cmd]
}

proc g3_exec {args} {
  return [g3_source exec $args]
}

##proc g3_rw - execute the regular /g3_rw functions 
##usage: g3_rw lpm -v
##       g3_rw hash -v -uc
##       g3_rw hit -v -c
proc g3_rw {args} { 
  return [g3_exec /qa/g3_rw $args]
}
proc r {args} { 
  return [g3_exec /qa/g3_rw $args]
}
proc w {args} { 
  return [g3_exec /qa/g3_rw set $args]
}

proc g3_get_ca_type_by_var {ca_var} {
  set type ""
  set known_pattern {_p_unsigned_char _p_unsigned_short _p_unsigned_long_long _p_unsigned_long _p_unsigned_int}
  set known_type {ca_uint8 ca_uint16 ca_uint64 ca_uint32 ca_uint32}
  while {1<3} {  
    set i 0
    foreach p $known_pattern {
      if {[string first $p $ca_var] >= 0} {
        set type [lindex $known_type $i]
        break
      }
      incr i
    }
    if {"$type" != ""} {
      break
    }

    set elst [split $ca_var "_"]
    set cnt [llength $elst]
    if {$cnt < 6} {
      break
    }
    if {"[lindex $elst 0]" != "" || "[lindex $elst 2]" != "p" || "[lindex $elst 3]" != "ca"} {
      break
    }
    if {[lsearch {t e s u} [lindex $elst end]] >= 0} {
      incr cnt -1
    }

    set type "ca"
    for {set i 4} {$i < $cnt} {incr i} {
      set type "${type}_[lindex $elst $i]"
    }
    break
  }
  return $type
}

proc g3_set_single {ca_var field value {index ""}} {
  set type [g3_get_ca_type_by_var $ca_var]  
  if {"$type" == ""} {
    return ""
  }
  if {"$index" == "" && [string first "@" $field] > 0} {
    set lst [split $field "@"]
    set field [lindex $lst 0]
    set index [lindex $lst end]
  }
  if {"$index" == ""} {
    ${type}_set_$field $ca_var $value
  } else {
    if {"$index" == "*"} {
      #load byte string to field
      if { [string first "0x" $value] == 0 } {
        set value [string range $value 2 end]
      }
      set index 0
      for {set i 0} {$i < [string length $value]} {incr i 2} {
        ${type}_set_$field $ca_var 0x[string range $value $i [expr $i+1]] $index
        incr index
      }
    } else {
      ${type}_set_$field $ca_var $value $index
    }
  }
  return $value
}

proc g3_get_single {ca_var field {index ""}} {
  set type [g3_get_ca_type_by_var $ca_var]  
  if {"$type" == ""} {
    return ""
  }
  if {"$index" == "" && [string first "@" $field] > 0} {
    set lst [split $field "@"]
    set field [lindex $lst 0]
    set index [lindex $lst end]
  }
  if {"$index" == ""} {
    return [${type}_get_$field $ca_var]
  } else {
    if {"$index" == "*"} {
      set index 0
      error "error in get $ca_var.$field.*. only support set * operation!"
    }
    return [${type}_get_$field $ca_var $index]  
  }
}

proc g3_set {var value} {
  set ret ""
  set lst [split $var "."]
  set cnt [llength $lst]
  set index ""  
  catch {
    set index [expr [lindex $lst end]]
  } 
  if {"$index" == "" && "[lindex $lst end]" == "*"} {
    set index "*"
  }
  if {"$index" != ""} {
    incr cnt -1
  }
  while {1<3} {
    if {$cnt <= 1} {
      break
    }
    if {$cnt <= 2} {
      set ret [g3_set_single [lindex $lst 0] [lindex $lst 1] $value $index]
      break
    }
    set v [g3_get_single [lindex $lst 0] [lindex $lst 1] ] 
    if {"$v" == ""} {
      break
    }
    for {set i 2} {$i < [expr $cnt-1]} {incr i} {
      set v [g3_get_single $v [lindex $lst $i]]      
      if {"$v" == ""} {
        break
      }
    }
    set ret [g3_set_single $v [lindex $lst [expr $cnt-1]] $value $index]
    break
  }
  return $ret
}

proc g3_get {var} {
  set ret ""
  set lst [split $var "."]
  set cnt [llength $lst]
  set index ""  
  catch {
    set index [expr [lindex $lst end]]
  } 
  if {"$index" != ""} {
    incr cnt -1
  }
  while {1<3} {
    if {$cnt <= 1} {
      if {"[g3_get_ca_type_by_var $var]" == ""} {
        set ret ""
      } else {
        set ret $var
      }
      break
    }

    if {$cnt <= 2} {
      set ret [g3_get_single [lindex $lst 0] [lindex $lst 1] $index]
      break
    } else {
      set ret [g3_get_single [lindex $lst 0] [lindex $lst 1]]
    }
    incr cnt -1
    for {set i 2} {$i < $cnt} {incr i} {
      set ret [g3_get_single $ret [lindex $lst $i]]
    }
    set ret [g3_get_single $ret [lindex $lst $i] $index]
    break
  }
  return $ret
}


##proc g3 : versatile g3 commands
##usage: g3 show ga pool - display general array for pool fields
##       g3 acl          - display acl settings from g3_rw
##       g3 lpm -v      - display lpm settings from g3_rw
##       g3 hit -v -c   - display hash hitting status  from g3_rw
##       g3 hash -v -port - display unicast hash entries  from g3_rw
##       g3 ca_ipsec_policy_delete 0 0 1 - display unicast hash entries  from g3_rw
##       g3 set $nhop.nhid.addr.ip_addr.ipv4_addr 0x0a01a8c0 - set nexthop's ip to 192.168.1.10
##       g3 show $nhop  - dump (display) nexthop structure
##       g3 show $route - dump (display) route structure
##       g3 show $sa.sa_id - dump sa_id from the sa strcuture
##       g3 l2tp_offload - offload l2tp (or l2tp+ipsec) for both in&out directions
##       g3 ipsec_offload - offload ipsec for both in&out directions
##       g3 $sa.dir=0 $sa.state=$sa.sa_id=1 $sa.key.*=00010203040506070809101112131415
##       g3 $ip.ip_addr.addr.0=$ip.addr.1 $ip.addr.2=$ip.addr.3
##       g3 $flow.ingress_pkt.tag@0.vlan_id=100 $flow.egress_pkt.tag@0.vlan_id=200
##       g3 flush - flush all route/offload settings from hardware
##       g3 flush var - clear the saved variable from ga(pool_va)
##       g3 help - display help information
##       g3 help tst - display help information for keyword: tst
proc g3 {{cmd0 ""} {args ""}} {
  set args [g3_list $args]
  set g3_rw_cmds {drop fdb l2cnt l2}
  while {1<3} {
    if {"$cmd0" == ""} {
      g3_show help g3
      return 
    }
    if {"$cmd0" == "help"} {
      g3_show help $args
      return 
    }    
    if {[string first "ca_" $cmd0] == 0} {
      set r [g3_source $cmd0 $args]
      set opr [lindex [split $cmd0 "_"] end]
      while {1<3} {
        if { "$opr" == "create" } {
          g3_pool add var $r
          break
        }
        if { "$opr" == "free" } {
          g3_pool del var $args
          break
        }
        if {$r != 0} {
          g3_ret_chk $r "$cmd0 $args"
        }
        break
      }
      return $r
    }

    if {[lsearch $g3_rw_cmds $cmd0] >= 0} {
      return [g3_rw $cmd0 $args]
    }

    if {"[g3_get_ca_type_by_var $cmd0]" != ""} {
      set args [g3_list [list $cmd0 $args]]
      set r ""
      foreach arg $args {
        if {"$arg" == ""} {
          continue
        }
        set plst [split $arg "="]
        set r [lindex $plst end]
        if {"[g3_get_ca_type_by_var [lindex [split $r .] 0]]" != ""} {
          set r [g3_get $r]
        }
        if {[llength $plst] >= 2} {
          for {set i 0} {$i < [expr [llength $plst]-1]} {incr i} {
            if { "[g3_set [lindex $plst $i] $r]" == "" } {
              error "error in set [lindex $plst $i]=$r"
            }
          }
        }
      }
      return $r
    }
    if {[string first "g3_" $cmd0] == 0} {    
      return [g3_source $cmd0 $args]
    }

    break
  }

  return [g3_source g3_$cmd0 $args]  
}


# linux quick function call
proc arp {args} { return [g3_exec arp $args] } 
proc cat {args} { return [g3_exec cat $args] } 
proc conntrack {args} { return [g3_exec conntrack $args] } 
proc dmesg {args} { return [g3_exec dmesg $args] } 
proc dump_sadb {args} { return [g3_exec /dump_sadb/dump_sadb $args] } 
proc echo {args} { return [g3_exec echo $args] } 
proc ethtool {args} { return [g3_exec ethtool $args] }
proc grep {args} { return [g3_exec grep $args] }
proc g3_diags {args} { return [g3_exec g3_diags $args] }
proc ifconfig {args} { return [g3_exec ifconfig $args] } 
proc ip {args} { return [g3_exec ip $args] } 
proc iptables {args} { return [g3_exec iptables $args] } 
proc ls {args} { return [g3_exec ls $args] } 
proc l2tpv3tun {args} { return [g3_exec l2tpv3tun $args] } 
proc ping {args} { return [g3_exec ping -c 1 -w 1 $args] } 
proc ps {args} { return [g3_exec ps $args] } 
proc route {args} { return [g3_exec route $args] } 
proc setkey {args} { return [g3_exec setkey $args] } 
# return cpu %idle load in four list items: #0=%idle #1=avg %idel #2=cpu0 #3=cpu1
proc cpu {{intvl 1} {cnt 1} {load 0} {display 0}} {
  g3_exec mpstat -P ALL $intvl $cnt > /tmp/cpu.txt
  set lst {}
  foreach line [g3_lines_from_file /tmp/cpu.txt] {
    if {$display != 0} {
      puts $line
    }  
    if {[string first "Average:" $line] == 0} {
      set v [lindex [split $line] end]
      if {[llength $lst] > 0 && $load != 0} {
        #change to %load instead of %idle
        set v [format "%.2f" [expr 100-$v]]
      }
      lappend lst $v
    }
  }
  if {$load != 0} {
    set lst [lreplace $lst 0 0 "%load"]
  }
  return $lst
}

g3_init 0
puts [set ga(iros_lib_version) "qa iros library ver-0.1c1"]
#puts "note: printk level is set to [g3_printk_lock 4]. use g3_printk_unlock to restore it!"

