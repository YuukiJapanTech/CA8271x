package provide GW_UTILS
namespace eval ::gw_utils:: {
  namespace export *
}
proc ::gw_utils::utils_mac_addr_incr {args} {
  set res 0
  set aIn(-count) 1
  set aIn(-mac) 00:00:00:11:00:01
  set aIn(-step) 00:00:00:00:00:01
  array set aIn $args

  set mac $aIn(-mac)
  set step $aIn(-step)
  set count $aIn(-count)
  if {[info exists aIn(-out)]} {
    upvar $aIn(-out) aOut
  } else {
    upvar aOut aOut
  }
  catch {array unset aOut} err
  set aOut(-mac_addr_l) ""
  set ov_flag 0
  set mac_l [split $mac :]
  set step_l [split [string trim $step "-"] :]
  set op ""
  if {[string first {-} $step ] >= 0} {
    set op "-"
  }
  for {set cnt 0 } {$cnt < $count} {incr cnt} {
      set v_l ""
      for {set i 5} {$i >= 0 } {incr i -1} {
        set m 0x[lindex $mac_l $i]
        set s 0x[lindex $step_l $i]
        if {$m > 0xff} {
          log -tag error -msg "Input mac value illegal: $m > 255"
          set res -1
          break
        } 
        if {$s > 0xff} {
          log -tag error -msg "Input step value illegal: $s > 255"
          set res -1
          break
        } 
       
        set sum [expr $m + ${op}$s + $ov_flag]   
        set v [expr int(fmod($sum,256))]
        set v [format %02x [expr abs($v)]]
        set ov_flag [expr $sum/256]
        set v_l [linsert $v_l 0 $v]
      }
      if {$res} {break}
      lappend aOut(-mac_addr_l) [join $v_l :]
      set mac_l $v_l
  } 
}

proc ::gw_utils::utils_ipv4_addr_incr {args} {
  set res 0
  set aIn(-count) 1
  set aIn(-ipaddr) 192.168.1.1
  set aIn(-step) 0.0.0.1
  array set aIn $args

  set element $aIn(-element)
  set step $aIn(-step)
  set count $aIn(-count)
  if {[info exists aIn(-out)]} {
    upvar $aIn(-out) aOut
  } else {
    upvar aOut aOut
  }
  catch {array unset aOut} err
  set aOut(-ipv4_addr_l) ""
  set ov_flag 0
  set element_l [split $element .]
  set step_l [split [string trim $step "-"] .]
  set op ""
  if {[string first {-} $step ] >= 0} {
    set op "-"
  }
  for {set cnt 0 } {$cnt < $count} {incr cnt} {
      set v_l ""
      for {set i 3} {$i >= 0 } {incr i -1} {
        set e [lindex $element_l $i]
        set s [lindex $step_l $i]
        if {$e > 256} {
          log -tag error -msg "Input value illegal: $e > 255"
          set res -1
          break
        } 
        if {$s > 256} {
          log -tag error -msg "Input step value illegal: $s > 255"
          set res -1
          break
        } 
       
        set sum [expr $e + ${op}$s + $ov_flag]   
        set v [expr int(fmod($sum,256))]
        set v [expr abs($v)]]
        set ov_flag [expr $sum/256]
        set v_l [linsert $v_l 0 $v]
      }
      if {$res} {break}
      lappend aOut(-ipv4_addr_l) [join $v_l :]
      set element_l $v_l
  } 
}
proc ::gw_utils::utils_script_join {args} {
    global env   auto_path
    set aarg(-ifdir) {D:\ITEST\ITEST_WORKSPACE\g3_generic\lib\gw}
    set aarg(-ofdir) $env(HOME)
    set aarg(-ofname) SC_COMMAND_LIB.tcl
    if {[catch {array set aarg $args} err]} {
      puts "Input parameters error: $err"
      return -1
    }
    
    set iFPath $aarg(-ifdir)
    set oDir  $aarg(-ofdir)
    set oFileName $aarg(-ofname)
    set oFile $oDir/$oFileName
    lappend auto_path  $iFPath
    
    package require GW_WRP
  
    set ifh [open $iFPath/namespace_gw.tcl r]    
    set ofh [open $oFile w+]
    fconfigure $ofh -translation binary
    set str [read $ifh]
    puts $ofh $str
    close $ifh 

    set l [info commands ::gw::helper*]
    puts $ofh "
#-----------------------------------------------------
#  Helper Procedures
#-----------------------------------------------------"
    foreach p $l {
      if {[string first "helper_parray" $p] >= 0} {
        puts $ofh "proc $p {arr {sort_opt -dict} {mode 0}} {
  [string trim [info body $p]]
}"
      } else {
        puts $ofh "proc $p {[info args $p]} {"      
        puts $ofh "  [string trim [info body $p]]"
        puts $ofh "}"
      }
    }
    
    set l [info commands ::gw::wca_*]
    puts $ofh "
#-----------------------------------------------------
#  CA Procedures
#-----------------------------------------------------"    
    foreach p $l {
      puts $ofh "proc $p {[info args $p]} {"
      puts $ofh "  [string trim [info body $p]]"
      puts $ofh "}"
    }
    set l [info commands ::gw::wcap_*]
    puts $ofh "
#-----------------------------------------------------
#  CA Platform Procedures
#-----------------------------------------------------"    
    foreach p $l {
      puts $ofh "proc $p {[info args $p]} {"
      puts $ofh "  [string trim [info body $p]]"
      puts $ofh "}"
    }
    set l [info commands ::gw::wcacp_*]
    puts $ofh "
#-----------------------------------------------------
#  CA Control Panel Procedures
#-----------------------------------------------------"    
    foreach p $l {
      puts $ofh "proc $p {[info args $p]} {"
      puts $ofh "  [string trim [info body $p]]"
      puts $ofh "}"
    }   
    
    flush $ofh
    close $ofh
    
    cd $oDir
    pkg_mkIndex $oDir $oFileName
    
    set fd [open $oDir/scripts.txt w+]
    fconfigure $fd -translation binary
    puts $fd "$oFileName"
    puts $fd "pkgIndex.tcl"
    flush $fd
    close $fd
}

proc ::gw_utils::utils_script_split {args} {
    global env   
    set aarg(-odir) $env(HOME)/gw
    set aarg(-ifile) {D:\ITEST\ITEST_WORKSPACE\g3_generic\lib\gws\SC_COMMAND_LIB.tcl}
    if {[catch {array set aarg $args} err]} {
      puts "Input parameters error: $err"
      return -1
    }
    
    set oDir  $aarg(-odir)
    set iFile $aarg(-ifile)
    #cd $oDir
    if {[catch {source $iFile} err]} {
      error "$err"
    }
    set oFile $oDir/namespace_gw.tcl
    set ifd [open $iFile r]
    set str [read $ifd]
    close $ifd
    regexp -indices "namespace export .*?(\})" $str _ idx_l 
    set idx [lindex $idx_l 0]
    if {$idx < 0 } {error "Failed to find end of namespace block"}
    set ofd [open $oFile w+]
    fconfigure $ofd -translation binary
    puts $ofd [string range $str 0 $idx]
    #-----------------------------------------------------
    #  Log Procedures
    #-----------------------------------------------------"    
    foreach prc [info commands ::gw::log_*] {
        puts $ofd "proc $prc {[info args $prc]} {"
        puts $ofd "  [string trim [info body $prc]]"
        puts $ofd "}"
    }
    flush $ofd
    close $ofd
    #-----------------------------------------------------
    # Procedures
    #-----------------------------------------------------
    
    set prc_l [info commands ::gw::helper_*]
    set prc_l "$prc_l [info commands ::gw::wca_*]"
    set prc_l "$prc_l [info commands ::gw::wcap_*]"   
    set prc_l "$prc_l [info commands ::gw::wcacp_*]"
    foreach prc $prc_l {
      set oFileName [string range $prc 6 end]
      set oFile $oDir/$oFileName.tcl
      set ofd [open $oFile w+]
      fconfigure $ofd -translation binary
      puts $ofd "package provide GW_WRP 1.0"
      if {[string first "helper_parray" $prc]>=0} {
        puts $ofd "proc $prc {arr {sort_opt -dict} {mode 0}} {"
        puts $ofd "  [string trim [info body $prc]]"
        puts $ofd "}"
      } else {
        puts $ofd "proc $prc {[info args $prc]} {"
        puts $ofd "  [string trim [info body $prc]]"
        puts $ofd "}"     
      }
      flush $ofd
      close $ofd
    }
    
    #---------------------------------------
    # Package index and script list
    #---------------------------------------  
    cd $oDir
    pkg_mkIndex $oDir *.tcl
    set fd [open $oDir/scripts.txt w+]
    fconfigure $fd -translation binary
    puts $fd "namespace_gw.tcl"
    puts $fd "pkgIndex.tcl"
    puts $fd "ts_001.tcl"
    foreach prc $prc_l {
      puts $fd "[string range $prc 6 end].tcl"
    }
    flush $fd
    close $fd
}
proc gw_utils:utils_dos2unix {args} {
  //tr -d \"\\r\" <src >dest 
  // cat <src_file> |tr -d {\\r} > dest_file
}