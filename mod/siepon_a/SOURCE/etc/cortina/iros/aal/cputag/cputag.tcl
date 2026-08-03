source /etc/cortina/iros/qa/iros_lib.tcl

proc g3_cputag_cfg {args} {
  global ga
  array set a {
    cpu_tag_cfg_sel "0"
    cpu_tag_tx_en "0"
    cpu_tag_rx_en "0"
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

  set r [ca_ni_cpu_tag_cfg_create]

  g3 $r.cpu_tag_cfg_sel=$a(cpu_tag_cfg_sel)
  g3 $r.cpu_tag_tx_en=$a(cpu_tag_tx_en)
  g3 $r.cpu_tag_rx_en=$a(cpu_tag_rx_en)
  #g3 show $r

  return $r
}

proc g3_cputag_port_id {args} {
  global ga
  array set a {
    port_id_0 "0"
    port_id_1 "0"
    port_id_2 "0"
    port_id_3 "0"
    port_id_4 "0"
    port_id_5 "0"
    port_id_6 "0"
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

  set r [ca_ni_glb_cpu_tag_port_id_create]

  g3 $r.port_id_0=$a(port_id_0)
  g3 $r.port_id_1=$a(port_id_1)
  g3 $r.port_id_2=$a(port_id_2)
  g3 $r.port_id_3=$a(port_id_3)
  g3 $r.port_id_4=$a(port_id_4)
  g3 $r.port_id_5=$a(port_id_5)
  g3 $r.port_id_6=$a(port_id_6)
  #g3 show $r

  return $r
}

proc g3_cputag_port_msk {args} {
  global ga
  array set a {
    port_msk_0 "0"
    port_msk_1 "0"
    port_msk_2 "0"
    port_msk_3 "0"
    port_msk_4 "0"
    port_msk_5 "0"
    port_msk_6 "0"
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

  set r [ca_ni_glb_cpu_tag_port_mk_create]

  g3 $r.port_msk_0=$a(port_msk_0)
  g3 $r.port_msk_1=$a(port_msk_1)
  g3 $r.port_msk_2=$a(port_msk_2)
  g3 $r.port_msk_3=$a(port_msk_3)
  g3 $r.port_msk_4=$a(port_msk_4)
  g3 $r.port_msk_5=$a(port_msk_5)
  g3 $r.port_msk_6=$a(port_msk_6)
  #g3 show $r

  return $r
}

proc g3_cputag_hdra {args} {
  global ga
  array set a {
    cos "0"
    ldpid "0"
    lspid "0"
    pkt_size "0"
    fe_bypass "0"
    hdr_type "0"
    mcgid "0"
    drop_code "0"
    rx_pkt_type "0"
    no_drop "0"
    mirror "0"
    mark "0"
    pol_en "0"
    pol_id "0"
    pol_grp_id "0"
    deep_q "0"
    cpu_flg "0"
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

  set r [ca_ni_cpu_tag_hdra_create]

  g3 $r.cos=$a(cos)
  g3 $r.ldpid=$a(ldpid)
  g3 $r.lspid=$a(lspid)
  g3 $r.pkt_size=$a(pkt_size)
  g3 $r.fe_bypass=$a(fe_bypass)
  g3 $r.hdr_type=$a(hdr_type)
  g3 $r.mcgid=$a(mcgid)
  g3 $r.drop_code=$a(drop_code)
  g3 $r.rx_pkt_type=$a(rx_pkt_type)
  g3 $r.no_drop=$a(no_drop)
  g3 $r.mirror=$a(mirror)
  g3 $r.mark=$a(mark)
  g3 $r.pol_en=$a(pol_en)
  g3 $r.pol_id=$a(pol_id)
  g3 $r.pol_grp_id=$a(pol_grp_id)
  g3 $r.deep_q=$a(deep_q)
  g3 $r.cpu_flg=$a(cpu_flg)
  
  #g3 show $r
  
  return $r
}

