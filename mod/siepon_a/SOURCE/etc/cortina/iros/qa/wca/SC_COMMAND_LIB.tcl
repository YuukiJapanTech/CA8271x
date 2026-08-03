package provide GW_WRP 1.0
#----------------------------------------------
#  @author   Tao.Chen@cortina-access.com 
#  @version  20200426_17:10
#  @comment: Supress returning zero value cls mask;Fix flow_key_type issue
#-----------------------------------------------
namespace eval ::gw:: {
  variable gwenv 
  variable CA_CONSTANT_T
  array set CA_CONSTANT_T ""
  array set RPT_LEVEL_NUM ""
  array set RPT_LEVEL_NAME ""
  set gwenv(LOG_VERBOSE) 1
  set gwenv(LOG_TIME)    1
  set gwenv(LOG_API)     1
  set gwenv(REPORT_LEVEL) 2
  set gwenv(DETECT_UNKNOWN_PARAM) 0
  
  variable CA_RES_OK 0
  variable CA_RES_NOK -1
  variable CA_DATA_FREE_ENABLED 1
  
  set RPT_LEVEL_NUM(DEBUG) 0
  set RPT_LEVEL_NUM(ITFBGN) 1
  set RPT_LEVEL_NUM(ITFEND) 1
  set RPT_LEVEL_NUM(INFO)  1
  set RPT_LEVEL_NUM(WARNING) 2
  set RPT_LEVEL_NUM(ERROR) 3
  set RPT_LEVEL_NUM(FATAL) 4
  set RPT_LEVEL_NUM(SILENT) 5

  set GPON_ONU_VERSION_ID_LEN 14
  set GPON_ONU_PASSWORD_LEN  12
  set GPON_ONU_SERIAL_NUMBER_LEN 8
  set GPON_ONU_ID_STR_LEN   24
  
  
  variable CA_TUNNEL_MAX_LIMIT 64
  variable L2TPv3_COOKIE_SIZE 8
  variable CA_PORT_VLAN_TAG_MAX 2
  variable MAX_ENC_KEY_LEN  8 
  variable MAX_AUTH_KEY_LEN   8
  variable CA_PPTP_KEY_LEN_MAX 16
  variable CA_MC_EGRESS_ACTION_RESERVED  32
  variable CA_MAX_L2_MC_MEMBER      64
  variable LINK_AGGREGATION_GROUP_MEMBER_PORTS_MAX_COUNT 16
  
  array set CA_CONSTANT_T {
      "MAX_ENC_KEY_LEN"   8 
      "MAX_AUTH_KEY_LEN"  8
      "CA_MAX_VPN_OFFLOAD_TUNNEL_LEVELS" 4
      "CA_QUEUE_COUNT"  8
      "CA_PORT_VLAN_TAG_MAX" 2
  }  
  
  #enum definitions
  array set INPUT_PARAM_INIT_TYPE_T {
    "NONE,0" -
    "SYS_CURRENT,1" -
    "SYS_DEFAULT,2" -
  }
  array set CA_PORT_TYPE_ENUM {
    "GPON,0x1"     "GPON 0x1"
    "EPON,0x2"     "EPON 0x2"
    "ETHERNET,0x3" "ETHERNET 0x3"
    "CPU,0x4"      "CPU 0x4"
    "SUBPORT,0x5"  "SUBPORT 0x5"
    "OFFLOAD,0x6"  "OFFLOAD 0x6"
    "L2RP,0x7"     "L2RP 0x7"
    "TRUNK,0x8"    "TRUNK 0x8"
    "OMCC,0x9"     "OMCC 0x9"
    "L3,0xa"       "L3 0xa"
    "VUNI,0xb"     "VUNI 0xb"  
  }
  array set CA_ENABLE_STATUS_T {
    "ENABLE,1" -
    "DISABLE,0" -
  }
  array set CA_ETH_PORT_LINK_STATUS_T {
    "UP,1"   -
    "DOWN,0" -
  }
  array set CA_ETH_PORT_SPEED_T {
    "INVALID,0"  "INVALID 0"
    "10M,1"      "10M 1"
    "100M,2"     "100M 2"
    "1G,3"       "1G 3"
    "2.5G,4"      -
    "10G,5"       -
    "5G,6"        -
    "AUTO,7"      -
  }
  array set CA_ETH_PORT_DUPLEX_T {
    "HALF,0" -
    "FULL,1" -
    "AUTO,2" -
  }
  array set CA_ETH_PORT_MDIX_T {
    "MDI,0" -
    "MDIX,1" -
    "AUTO,2" -
  }
  array set CA_VLAN_TAG_ACTION_T {
    "NOP,0"   -
    "PUSH,1"  -
    "POP,2"   -
    "SWAP,3"  -
    "INVALID,4294967295" -
  }
  variable CA_PORT_STP_STATE_ENUM
  array set CA_PORT_STP_STATE_ENUM {
    "DISABLED,0"    -
    "BLOCKING,1"    -
    "LEARNING,2"    -
    "FORWARDING,3"  -
  }
  variable CA_PORT_LOOPBACK_MODE_T
  array set CA_PORT_LOOPBACK_MODE_T {
    "NONE,0" -
    "MAC_LOCAL,1" -
    "MAC_REMOTE,2" -
    "PHY_LOCAL,3" -
  }
  array set CA_PORT_DIRECTION_ENCRYPTION_T {
    "TX,0" -
    "RX,1" -
    "BI,2" -
  }
  array set CA_PORT_ENCRYPTION_MODE_T {
    "DISABLE,0" -
    "AES_CTR,1" -
    "AES_CFB,2" -
    "MACSEC,3" -
    "SW_CTC_CHURNING,4" -
    "HW_CTC_CHURNING,5" -
  }
  array set CA_INGRESS_PORT_TYPE_T {
    "WAN,0" -
    "LAN,1" -
  }
  array set CA_VLAN_TPID_TYPE_T {
    "CVLAN,0" -
    "SVLAN,1" -
  }
  array set CA_L2_MAC_TABLE_FULL_POLICY_T {
    "CA_L2_MAC_FULL_FWD_NO_LEARN,0"  "Forward without learning"
    "CA_L2_MAC_FULL_DROP,1"      "drop"
    "CA_L2_MAC_FULL_FWD_LRU,2"   "replace the Least Recent Used entry"
  }
  array set CA_L2_VLAN_ACTION_DIRECTION_T {
    "LAN2WAN,0"  -
    "WAN2LAN,1"  -
  }
  array set CA_VLAN_TAG_PRIORITY_SOURCE_T {
    "NEW_PRI,0"   -
    "INNER_PRI,1"   -
    "OUTER_PRI,2"   -
    "DSCP_TO_8021P_TABLE,3"   -
    "8021P_REMARK_TABLE,4"   -
  }
  array set CA_VLAN_TPID_SOURCE_T {
    "LOCAL,0"   -
    "INNER_TAG,1"   -
    "OUTER_TAG,2"   -
  }
  array set CA_PKT_TYPE_T {
    "BPDU,0"   -
    "DOT1X,1"   -
    "IGMP,2"   -
    "ARP,3"   -
    "OAM,4"   -
    "OMCI,5"   -
    "PLOAM,6"   -
    "MPCP,7"   -
    "DHCP,8"   -
    "DHCPV6,9"   -
    "PPPOE_DIS,10"   -
    "PPPOE_SES,11"   -
    "IROS_HELLO,12"   -
    "ICMP,13"   -
    "ICMPV6_MLD,14"   -
    "ICMPV6_NDP,15"   -
    "CFM,16"   -
    "L2_PTP_TSYNC,17"   -
    "L4_PTP_TSYNC,18"   -
    "HTTP_GET,19"   -
    "HTTP_PUT,20"   -
    "HTTP_HEAD,21"   -
    "HTTP_POST,22"   -
    "HTTP_OPTIONS,23"   -
    "HTTP_DELETE,24"   -
    "HTTP_TRACE,25"   -
    "HTTP_CONNECT,26"   -
    "HTTP_UNLINK,27"   -
    "HTTP_PATCH,28"   -
    "DNS,29"   -
    "RIP,30"   -
    "SSDP,31"   -
    "CONTROL_ALL,32"   -
    "MIRROR,33"   -
    "LOOPBACK,34"   -
    "1AS,35"   -
    "MYMAC,36"   -
    "SNAP,37"   -
    "LLC,38"   -
    "USER_DEFINED,39" -
    "OTHERS,40"   -
    "MAX,41"   -
  }
  array set CA_VLAN_NEW_VLAN_SOURCE_T {
    "LOCAL,0"   -
    "FDB,1"     -
  }
  array set CA_L2_FLOODING_TYPE_T {
    "MC,0" -
    "BC,1" -
    "UUC,2" -
  }
  array set CA_L3_INTF_TYPE_T {
    "BCAST,1" -
    "P2P,2"   -
    "TUNNEL,3" -
    "CPU,4"  -
    "LB,5"  -
  }
  array set CA_CLASSIFIER_HANDLE_TYPE_T {
    "FLOW_ID,0" -
    "GEM_INDEX,1" - 
    "LLID_COS,2" -
  }
  array set CA_IPV6_EXT_HEADER_T {
    "HOP_BY_HOP,0" -
    "ROUTING,1" -
    "FRAGMENT,2" -
    "DESTINATION,3," -
    "AUTHENTICATION,4" -
    "ESP,5" -
  }
  array set CA_CLASSIFIER_KEY_OFFSET_START_T {
    "L2,0" -
    "L3,1" -
    "L4,2" -
  }
  array set CA_CLASSIFIER_ACTION_DEST_FE_T {
    "NONE,0" -
    "L3FE,1" -
    "L2FE,2" -
  }
  array set CA_CLASSIFIER_FORWARD_FLAG_T {
    "DENY,0" -
    "FE,1" -
    "INTERFACE,2" -
    "PORT,3" -
    "TUNNEL,4" -
  }
  array set CA_CLASSIFIER_VLAN_ACTION_T {
    "NOP,0" -
    "PUSH,1" -
    "POP,2" -
    "SWAP,3" -
    "SET,4" -
  }
  array set CA_L2TP_TUNNEL_ENCAP_TYPE_T {
    "IP,1" -
    "UDP,0" -
  }
  array set CA_QUEUE_SCHEDULE_MODE_T {
    "SP,0" -
    "DWRR,1" -
    "DRR,2" -
    "WRR,3" -
    "RR,4" -
    "SPRR,5" -
  }
  variable CA_L2_LEARNING_MODE_T 
  array set CA_L2_LEARNING_MODE_T {
    "HARDWARE,2"      "HARDWARE 2"
    "SOFTWARE,1"      "SOFTWARE 1"
    "DISABLE,0"     "DISABLE 0"    
  }   
  variable CA_L2_AGING_MODE_T 
  array set CA_L2_AGING_MODE_T {
    "HARDWARE,0"      "HARDWARE 0"
    "SOFTWARE,1"      "SOFTWARE 1"
  } 
  variable CA_L2_MAC_LIMIT_TYPE_T 
  array set CA_L2_MAC_LIMIT_TYPE_T {
    "PORT,0"      "PORT 0"
    "VLAN,1"      "VLAN 1"
    "SYSTEM,2"    "SYSTEM 2"
    "DISABLE,3"   "DISABLE 3"
  }
  variable CA_VLAN_LEARNING_MODE_T 
  array set CA_VLAN_LEARNING_MODE_T {
    "DIS,2"      "DIS 2"
    "SVL,1"      "SVL 1"
    "IVL,0"     "IVL 0"    
  }    
  variable CA_L2_ADDR_OP_FLAGS_T 
  array set CA_L2_ADDR_OP_FLAGS_T {
    "STATIC,0"      "STATIC 0"
    "DYNAMIC,1"      "DYNAMIC 1"
    "BOTH,2"    "BOTH 2"
    "OLDEST_DYNAMIC,3"   "OLDEST_DYNAMIC 3"
  }      
  variable CA_FLOW_VLAN_ACTION_T
  array set CA_FLOW_VLAN_ACTION_T {
    "PUSH,0" "PUSH 0"
    "POP,1"  "POP 1"
    "SWAP,2" "SWAP 2"
    "SET,3"  "SET 3"
  
  }
  array set CA_EPON_PORT_LASER_POLARITY_T {
    "ACTIVE_LO,0" -
    "ACTIVE_HI,1" -
  }
  array set CA_EPON_PORT_LASER_MODE_T {
    "BURST,0" -
    "ON,1" -
    "OFF,2" -
  }
  array set CA_EPON_PORT_SPEED_T {
    "1G,0" -
    "1G_10G,1" -
    "XG,2" -
  }
  array set CA_EPON_MPCP_REPORT_MODE_T {
    "2QS_8Q,0" -
    "1QS_8Q,1" -
    "1QS_1Q,2" -
    "2QS_1Q,3" -
    "4QS_1Q,4" -
  }
  variable CA_GPON_PORT_GEM_PORT_DIRECTION_T
  array set CA_GPON_PORT_GEM_PORT_DIRECTION_T {
    UP,0    0
    DOWN,1  1
    BI,2    2
  }
  variable CA_POLICER_MODE_T
  array set CA_POLICER_MODE_T {
    DISABLE,0 "DISABLE 0"
    SRTCM,1   "SRTCM 1"
    TRTCM,2   "TRTCM 2"
    TRTCMS,3  "TRTCMS 3"
    TRTCMS_COUPLED,4 "TRTCMS_COUPLED 4"
    RATE_ONLY,5  "RATE_ONLY 5"
  }
  variable CA_GPON_PORT_TCONT_QUEUE_SCHEDULER_MODE_T 
  array set CA_GPON_PORT_TCONT_QUEUE_SCHEDULER_MODE_T {
    SP,0      0
    WRR,1     1
    SP_WRR,2  2
  }
  variable CA_GPON_PORT_TIMER_TYPE_T 
  array set CA_GPON_PORT_TIMER_TYPE_T {
    TOZ,1        1
    TO1,2        2
    TO2,3        3
    TO3,4        4
    TO4,5        5
    TO5,6        6
    CPI,7        7
    TK4,8          8
    TK5,9          9
  } 
  variable CA_GPON_PORT_LASER_MODE_T 
  array set CA_GPON_PORT_LASER_MODE_T {
    BURST,0 "BURST 0"
    ON,1  "ON 1"
  } 
  variable CA_GPON_PORT_LASER_POLARITY_T 
  array set CA_GPON_PORT_LASER_POLARITY_T {
    LO,0 "BURST 0"
    HI,1  "ON 1"
  }   
  variable CA_NGP2_ONU_ACT_STATE_T 
  array set CA_NGP2_ONU_ACT_STATE_T {
    O1_1,0              0
    O1_2,1        1
    O2_3,2        2
    O4,3        3
    O5_1,4        4
    O5_2,5        5
    O6,6        6
    O7,7        7
    O8_1,8          8
    O8_2,9          9
    O9,10               10
  }    
  
  variable CA_GPON_PORT_TCONT_QUEUE_SCHEDULER_MODE_T 
  array set CA_GPON_PORT_TCONT_QUEUE_SCHEDULER_MODE_T {
    SP,0              0
    WRR,1        1
    SP_WRR,2        2
  }      
  
  variable CA_TUNNEL_TYPE_T
  array set    CA_TUNNEL_TYPE_T {
    INVALID,0 0
    PPPOE,1   1
    L2TP,2    2
    IPSEC,3   3
    PPTP,4    4
    4IN4,5    5
    DSLITE,6  6
    6RD,7     7
    6IN6,8    8
    MAPE,9    9
    MAPT,10   10
    MACSEC,11 11
    SRV6_ENDDX2,12 12
  }
  variable CA_TUNNEL_DIRECTION_T
  array set CA_TUNNEL_DIRECTION_T {
    OUTBOUND,0    0
    INBOUND,1     1
  }
  array set CA_IPSEC_SPD_ENCRYPT_T {
    ENCRYPT,0     -
    DECRYPT,1     -
  }
  array set CA_PPTP_DIRECTION_T {
    UPSTREAM,0    0
    DOWNSTREAM,1  1
  }
  variable CA_IPSEC_SA_PROTO_T 
  array set CA_IPSEC_SA_PROTO_T {
    ESP,0  0
    AH,1   1
    MAX,2  2
  }
  variable CA_IPSEC_POLICY_ACTION_T
  array set CA_IPSEC_POLICY_ACTION_T {
    IPSEC,1    1
    DISCARD,2  2
    BYPASS,3   3
  }
  variable CA_IPSEC_CIPH_ALG_T
  array set CA_IPSEC_CIPH_ALG_T {
    NULL,0   0
    DES,1    1
    AES,2    2
  }
  variable CA_IPSEC_CIPH_MODE_T {
    ECB,0 0
    CBC,1 1
    CTR,2 2
    CCM,3 3
    GCM,5 5
    OFB,7 7
    CFB,8 8  
  }
  variable CA_IPSEC_HASH_ALG_T
  array set CA_IPSEC_HASH_ALG_T {
    NULL,0   0
    MD5,1    1
    SHA1,2   2
  }
  variable CA_PPTP_CRYPTO_TYPE_T
  array set CA_PPTP_CRYPTO_TYPE_T {
    INVALID,-1 -1
    NONE,0   0
    MPPE40,1   1
    MPPE128,2  2
  }
  variable CA_MCAST_ADDRESSING_MODE_T
  array set CA_MCAST_ADDRESSING_MODE_T {
    MAC,1   1
    IP,2   2
  }  
  
  variable CA_R_CODE_T
  array set CA_R_CODE_T {
    CA_E_PARAM  2
    CA_E_EXISTS 14
  }
  array set CA_QOS_MAP_MODE_T {
    "DOT1P,0" -
    "DSCP_TC,1" - 
    "CLASSIFIER,2" -
  }
  array set CA_1P_MAP_MODE_T {
    "DOT1P,0" -
    "DSCP_TC,1" - 
    "CLASSIFIER,2" -
  }
  array set CA_DSCP_MAP_MODE_T {
    "DSCP_TC,1" - 
    "CLASSIFIER,2" - 
  }
  namespace export wca_* wcap_* wcacp_* helper_*
}     

#--------------------------------------------------
# spec init
#--------------------------------------------------
proc gw::rename_ca_data_free {{new_name "orig_ca_data_free"}} {
    if {[llength [info commands ::orig_ca_data_free] ] == 0} {
        puts ".rename original command 'ca_data_free' to '$new_name'"
        eval "
          rename ::ca_data_free ::orig_ca_data_free
          proc ::ca_data_free {handle} {
            global errorInfo
            if {\[info exists gw::CA_DATA_FREE_ENABLED\] && \$gw::CA_DATA_FREE_ENABLED} {
                if {\[catch {orig_ca_data_free \$handle} err\]} {
                   puts \"Failed to free data \$handle. \\n\$err. \\n\$errorInfo\"
                }
            }
          } 
        "
    }
}
proc gw::enable_ca_data_free {} {
  variable CA_DATA_FREE_ENABLED 
  puts "enable ca_data_free by setting gw::CA_DATA_FREE_ENABLED to 1"
  set CA_DATA_FREE_ENABLED 1
}
proc gw::disable_ca_data_free {} {
  variable CA_DATA_FREE_ENABLED 
  puts "disable ca_data_free by setting gw::CA_DATA_FREE_ENABLED to 0"
  set CA_DATA_FREE_ENABLED 0
}
#-----------------------------------------------------------
# Log procedures
#-----------------------------------------------------------
  proc ::gw::timestamp {} {
    variable gwenv
    return $gwenv(TIMESTAMP)
  }
  proc ::gw::log_write_file {fnm txt} {
    set ifnm ::gw::log_write_file
    if {[file exists $fnm] == 0} {
      set mod "w+"
    } else {
      set mod "a+"
    }
    #set fd [open $fnm a+]
    if {[catch {open $fnm $mod} fd]} {
      puts "$ifnm: $fd.[gen_utils_get_error_info]"
      catch {close $fd}
      return 1
    }
   
    puts $fd "$txt"
   
    flush $fd  
    close $fd  
    return 0
  }
  proc ::gw::log_level_set {level} {
      variable gwenv      
      set xlevel DEBUG
      switch -exact -- "[string toupper $level]" {
        0     -
        "DEBUG"   { set xlevel 0}
        1    -
        "INFO"    { set xlevel 1}
        2    -
        "WARNING" { set xlevel 2}
        3    -
        "ERROR"   { set xlevel 3}
        4    -
        "FATAL"   { set xlevel 4}
        5    -
        "NONE"    -
        "SILENT"  { set xlevel 5}
        default   { set xlevel DEBUG}    
      }   
      set gwenv(REPORT_LEVEL) $xlevel
  }
  proc ::gw::log_check_level {tag} {
    variable gwenv
    variable RPT_LEVEL_NUM
    upvar 1 $tag mytag
    
    set def_level $gwenv(REPORT_LEVEL)

    set mytag [string toupper $mytag]
    set ilevel $RPT_LEVEL_NUM($mytag)

    if {[expr $ilevel - $def_level] >= 0 } {return 0} else {return 1}
  }
  proc ::gw::log {args} {
    set itfnm gw::log
    variable gwenv
    set spliter "|"
    set tag_len 6
    
    if {$gwenv(REPORT_LEVEL) >= 5} { return 0}
    set mytag ""
    set tag_idx [lsearch $args "-tag"]
    if {$tag_idx == -1 } {
      set mytag INFO
    } else {
      set mytag [string toupper [lindex $args [expr $tag_idx + 1] ] ]
      set args "[lrange $args 0 [expr $tag_idx -1]] [lrange $args [expr $tag_idx + 2] end]"
    }
    if {$mytag == "" } {
      set mytag "INFO"
    } 
    #-------------------------
    # check report level
    #-------------------------
    if {[log_check_level mytag]} {return 1}    
   
    set curlevel [info level]
 
    set pproc [lindex [info level [expr $curlevel -1]] 0]
    if {$pproc == "$itfnm"} {set pproc TCLSHELL}  
 
    set curtime [format %.3f [expr [clock milliseconds] / 1000.0] ]

    set str ""    
    set tot_len [llength $args]
    if {$tot_len == 0 } {    
      set str ""
    } else {    
      set args [string trim $args]
      set log_idx [lsearch $args "-msg"]  
      if {$log_idx == -1} {
        set log_idx "end"
      } else {
        incr log_idx
      }
      set str [lindex $args $log_idx]
    }
    if {[info exists gwenv(LOG_API)] && $gwenv(LOG_API)} {
      set str "${pproc}${spliter}$str"
    }  
    set str "[format %-${tag_len}s $mytag]${spliter}$str"   
    set no_time_str $str 
    if {[info exists gwenv(LOG_TIME)] && $gwenv(LOG_TIME)} {set str "*$curtime $str"} 
    if {[info exists gwenv(LOG_VERBOSE)] && 
      ([string toupper $gwenv(LOG_VERBOSE)] == "TRUE" || $gwenv(LOG_VERBOSE) == 1) } {
      #puts "$no_time_str"
      puts "$str"
    }
   
  #  return [::gw::log_write_file $fnm $str]  
  }

#-----------------------------------------------------
#  Helper Procedures
#-----------------------------------------------------
proc ::gw::helper_update_scfg_file {args}  {
  global errorInfo
  if {[regexp {\s+(-h|-help)\s+} $args] || [llength $args] == 0} {
    puts "Usage:  updateScfg -type ?type? -scfg_id ?scfg_id? -value ?value?"
    return 999
  }
  if {[catch {array set aIn $args} err]} {
    puts $err
    return 1
  }
  set varType $aIn(-type)
  set varName $aIn(-scfg_id)
  set varValue $aIn(-value)
  set defScfgFile /config/default_scfg.txt
  set specScfgFile /config/scfg.txt
  set tFile $defScfgFile
  if { [file exists $specScfgFile]} {
    set tFile $specScfgFile
  }
  
  set res [catch {exec grep $varName $tFile} err]
  if {$res == 0 } { ;#ID found
    set res [catch {exec sed -i "s/$varName.*$/$varName = $varValue;/g" $tFile} err]
  }  else {
    set res [catch {exec echo "$varType        $varName = $varValue;" >> $tFile} err]
  }
  if {$res} {
    puts "$err. ... $errorInfo"      
  }
  return $res
}
proc ::gw::helper_h2s {args} {
      set aIn(-nocase) yes
      array set aIn $args
      set table $aIn(-table)
      variable $table
      set res 0
      if {[info exists aIn(-out)] == 0} {
        set aIn(-out) aOut
      }
      upvar $aIn(-out) aOut
      catch {array unset aOut} err
      set aOut(-target) unknown 
      set source [string toupper $aIn(-source)]
      set l [lindex [array names $aIn(-table) "$source,*"] 0]
      if {[string length $l ] } {
        set target [lindex [split $l ,] 1]
      } else {
        set target $aIn(-source)
        log -tag debug -msg "Can not find system value in table $table for $aIn(-source), reset to $aIn(-source)"
       # set res -1
      }
      set aOut(-target) $target
      return $res
}
proc ::gw::helper_s2h {args} {
      set aIn(-nocase) yes
      array set aIn $args
      variable $aIn(-table)      
      #parray aIn
      
      set res 0
      if {[info exists aIn(-out)] == 0} {
        set aIn(-out) aOut
      }
      upvar $aIn(-out) aOut
      catch {array unset aOut} err
      set aOut(-target) unknown                
      set l [lindex [array names $aIn(-table) "*,$aIn(-source)"] 0]
      if {[string length $l ] } {
        set target [lindex [split $l ,] 0]
        log -tag debug -msg "target name of value $aIn(-source): $target"
      } else {
        set target $aIn(-source)
        log -tag warning -msg "Can not find human sym value for $aIn(-source), restore to input value $aIn(-source)"
      }
      set aOut(-target) $target
      #parray aOut
      return $res  
} 
proc ::gw::helper_intf_params_declare  {args} {
  set v_l ""
  if {[catch {array set aIn $args} err] } {
    log -tag error -msg "Input parameter list error: $err. Input list: $args"
  }
  if {$aIn(-itf) == "ca_nat_entry" } {
    set v_l {xlate_flags src_ip_addr src_l4_port dst_ip_addr dst_l4_port ip_proto 
      new_src_ip_addr new_src_l4_port new_dst_ip_addr new_dst_l4_port aging_timer nexthop_id}
  }
  if {[llength $v_l ] == 0} {
    log -tag error -msg "No parameter is declared. Assure provide correct interface name"
  }
  return $v_l
}
proc ::gw::helper_ca_l2_mcast_iterator_entry_parse {args} {
  variable CA_MC_EGRESS_ACTION_RESERVED
  set CA_MC_EGRESS_ACTION_RESERVED 4
  set res 0
  set ifnm helper_ca_l2_mcast_iterator_entry_parse
  log -tag itfbgn -ifnm $ifnm -msg $args
  set v_out_mc_entry_key_l [helper_probe_struct_members -struct ca_l2_mcast_entry]
  set v_out_mc_group_members_key_l {mcg_id member_count}
  set v_out_mc_member_key_l [helper_probe_struct_members -struct ca_l2_mcast_member]
  set v_out_mc_egress_action_mask_key_l [helper_probe_struct_members -struct ca_mcast_egress_action_mask]
  array set aIn $args
  set pt $aIn(-ref)
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut

  set aOut(-members) ""
  
  set pent [ca_l2_mcast_iterator_entry_get_mc_entry $pt]  
  set pmems [ca_l2_mcast_iterator_entry_get_members $pt]  
  foreach var $v_out_mc_entry_key_l {
      if {$var == "group_mac_addr" } {
        set pmac [ca_l2_mcast_entry_get_group_mac_addr $pent]
        set mac_l ""
        for {set i 0} {$i < 6} {incr i} {
          lappend mac_l [format "%02x" [ca_mac_addr_get $pmac $i] ]
        }
        set aOut(-group_mac_addr) [join $mac_l :]
      } elseif {$var == "src_ip_address" || $var == "group_ip_addr" } {
        set pip [ca_l2_mcast_entry_get_$var $pent]
        catch {array unset aTmp} ignore
        set res [eval helper_ca_ip_address_entry_parse -ref $pip -out aTmp]
        if {$res} {
          log -tag error -msg "Failed to parse IP address struct by helper_ca_ip_address_entry_parse"
          break
        }
        set aOut(-$var) $aTmp(-ip_addr)        
      } else {
        set aOut(-$var) [ca_l2_mcast_entry_get_$var $pent]
      }
  }
  if {$res == 0 } {
    set aOut(-member_count) [ca_l2_mcast_group_members_get_member_count $pmems]
    set aOut(-member_mcg_id) [ca_l2_mcast_group_members_get_mcg_id $pmems]   
    for {set i 0 } {$i < $aOut(-member_count)} {incr i } {
      set ent_l ""
      set pm [ca_l2_mcast_group_members_get_member $pmems $i]
      foreach var $v_out_mc_member_key_l {        
        if {$var == "new_mac_da" || $var == "new_mac_sa" } {
          set pmac [ca_l2_mcast_member_get_$var $pm]
          set mac_l ""
          for {set jj 0} {$jj < 6} {incr jj} {
            lappend mac_l [format "%02x" [ca_mac_addr_get $pmac $jj] ]
          }
          lappend ent_l "-$var" [join $mac_l :]         
        } elseif {$var == "action_mask" } {
          set pmask [ca_l2_mcast_member_get_action_mask $pm]
          foreach var $v_out_mc_egress_action_mask_key_l {
            lappend ent_l "-mask_$var" [ca_mcast_egress_action_mask_get_$var $pmask]
          }
        } elseif {$var == "reserved" } {
          set rsv_l ""
          for {set xx 0 } {$xx < $CA_MC_EGRESS_ACTION_RESERVED } {incr xx} {
            lappend rsv_l [format "0x%02x" [ca_l2_mcast_member_get_reserved $pm $xx]]
          }
          lappend ent_l -reserved [join $rsv_l ,]
        } elseif {$var == "member_port" } {
          lappend ent_l -$var [format "0x%05x" [ca_l2_mcast_member_get_$var $pm]]
        }  else {
          lappend ent_l -$var [ca_l2_mcast_member_get_$var $pm]
        }      
      }
      #set aMembers($aOut(-mcg_id)/$i) $ent_l
      lappend ent_l -mcg_id $aOut(-mcg_id)
      lappend aOut(-members) $aOut(-mcg_id)/$i $ent_l
    }    
  }  
  #parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::helper_intf_and_var_declare {args} {
  array set aIn $args
  set ifnm $aIn(-ifnm)
  if {[string first "ca_l3_intf" $ifnm] >= 0} {
  #  set v_mask_l [helper_probe_struct_members -struct ca_l3_intf_mask ]
  #  set v_key_l [helper_probe_struct_members -struct ca_l3_intf ]    
    array set CA_L3_INTF_T {
      type         "L3 intf type, must be specified for ca_l3_intf_add"
      intf_id      ""
      port_id      "port intf is bound to"
      mac_addr     "SRC MAC address to use on Intf"
      outer_vid    ""
      outer_tpid   ""
      inner_vid    ""
      inner_tpid   ""
      tunnel_id    ""
      mtu          ""
      ip_addr      ""
      nat_enable   ""    
    }
    array set CA_L3_INTF_MASK_T {
      port_id   "port intf is bound to"
      mac_addr  "SRC MAC address to use on Intf"
      outer_vid  ""
      outer_tpid ""
      inner_vid  ""
      inner_tpid ""
      tunnel_id   "used with ca_l3_intf_update to enable/disable NAT"
      mtu        ""
      ip_addr    "must be specified when calling l3_intf_add"
      nat_enable ""      
    }     
    if {[is_struct_field -struct ca_l3_intf -member egress_inner_dot1p]} {
        array set CA_L3_INTF_T {
            egress_inner_dot1p "Not supported by G3"
            egress_outer_dot1p ""      
        }
        array set CA_L3_INTF_MASK_T {      
            egress_inner_dot1p "remark inner tag with specified dot 1P value"
            egress_outer_dot1p ""      
        }     
    }
    if {[is_struct_field -struct ca_l3_intf -member sub_port_id]} {
        array set CA_L3_INTF_T {      
             sub_port_id ""      
        }     
    }    
    if {[is_struct_field -struct ca_l3_intf_mask -member sub_port_id]} {
        array set CA_L3_INTF_MASK_T {      
             sub_port_id ""      
        }     
    }    
    set l [array names CA_L3_INTF_T]
    uplevel 1 [list set v_intf_key_l $l]
    uplevel 1 [list set v_mask_key_l [array names CA_L3_INTF_MASK_T]]
    foreach nm [array names CA_L3_INTF_MASK_T] {
      lappend l mask_$nm
    }
    uplevel 1 [list set v_key_l $l]
  };#End for ca_l3_intf
}
proc ::gw::helper_ca_l3_mcast_iterator_entry_parse {args} {
  variable CA_MC_EGRESS_ACTION_RESERVED
  set CA_MC_EGRESS_ACTION_RESERVED 4
  set res 0
  set v_out_mc_entry_key_l [helper_probe_struct_members -struct ca_l3_mcast_entry]
  set v_out_mc_group_members_key_l {mcg_id member_count}
  set v_out_mc_member_key_l [helper_probe_struct_members -struct ca_l3_mcast_member]
  set v_out_mc_egress_action_mask_key_l [helper_probe_struct_members -struct ca_mcast_egress_action_mask]  
  array set aIn $args
  set pt $aIn(-ref)
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut

  array set aMembers ""
  set aOut(-members) ""
  
  set pent [ca_l3_mcast_iterator_entry_get_mc_entry $pt]
  set pmems [ca_l3_mcast_iterator_entry_get_members $pt]   
  #ca_l3_mcast_group_members_dump $pmems
  foreach var $v_out_mc_entry_key_l {
      if {$var == "src_ip_address" || $var == "group_ip_addr"} {
        set pip [ca_l3_mcast_entry_get_$var $pent]
        set res [eval helper_ca_ip_address_entry_parse -ref $pip -out aTmp]
        if {$res} {break}
        set aOut(-$var) $aTmp(-ip_addr)        
      } else {
        set aOut(-$var) [ca_l3_mcast_entry_get_$var $pent]
      }
  }
  if {$res == 0 } {
    set aOut(-member_count) [ca_l3_mcast_group_members_get_member_count $pmems]
    set aOut(-group_member_mcg_id) [ca_l3_mcast_group_members_get_mcg_id $pmems]   
    for {set i 0 } {$i < $aOut(-member_count)} {incr i } {
      set ent_l ""
      set pm [ca_l3_mcast_group_members_get_member $pmems $i]
      foreach var $v_out_mc_member_key_l {        
        if {$var == "new_mac_da" } {
          set pmac [ca_l3_mcast_member_get_new_mac_da $pm]
          set mac_l ""
          for {set jj 0} {$jj < 6} {incr jj} {
            lappend mac_l [format "%02x" [ca_mac_addr_get $pmac $jj] ]
          }
          lappend ent_l "-new_mac_da" [join $mac_l :]         
        } elseif {$var == "action_mask" } {
          set pmask [ca_l3_mcast_member_get_action_mask $pm]
          foreach var $v_out_mc_egress_action_mask_key_l {
            lappend ent_l "-mask_$var" [ca_mcast_egress_action_mask_get_$var $pmask]
          }
        } elseif {$var == "reserved" } {
          set rsv_l ""
          for {set xx 0 } {$xx < $CA_MC_EGRESS_ACTION_RESERVED } {incr xx} {
            lappend rsv_l [format "0x%0x" [ca_l3_mcast_member_get_reserved $pm $xx]]
          }
          lappend ent_l -reserved [join $rsv_l ,]
        }  elseif {$var == "member_intf" } {
          lappend ent_l -$var [format "0x%04x" [ca_l3_mcast_member_get_$var $pm]]
        }  else {
          lappend ent_l -$var [ca_l3_mcast_member_get_$var $pm]
        }        
      }
      #set aMembers($aOut(-mcg_id)/$i) $ent_l
      lappend ent_l -mcg_id $aOut(-mcg_id)
      lappend aOut(-members) $aOut(-mcg_id)/$i $ent_l
    }    
  }  
  return $res  
}
proc ::gw::helper_ca_ip_address_entry_config {args} {
  set ifnm helper_ca_ip_address_entry_config
  log -tag itfbgn -msg $args
  set res 0
  set aIn(-ref) "dontcare"
  if {[catch {array set aIn $args} err]} {
    log -tag error -msg "Invalid arguments. $err"
    set res -1
    return $res
  }
  set pip $aIn(-ref)   
  set type "ipv4"
  if {$res == 0 } {
    set cmd {ca_ip_address_get_ip_addr $pip}
    if {[catch $cmd err]} {
      log -tag error -msg "Failed to invoke command {$cmd}. $err"
      set res -1
    } else {
      set pl3ip $err
    }
  }
  if {$res} {
    return $res
  }
  # for format: ip/len
  set addr_len 0
  set ip_l [split $aIn(-ip_addr) /]
  set ip_addr [lindex $ip_l 0]
  set addr_len [lindex $ip_l 1]
  if {[string first "." $ip_addr ] >= 0} {
    #ipv4    
    array set aRes ""
    helper_convert_ipv4_addr_dot2hex -ipv4_addr $ip_addr -out aRes
    set cmd "ca_l3_ip_addr_set_ipv4_addr $pl3ip $aRes(-ipv4_addr_hex)"
    set res [helper_cmd_exec -cmd $cmd]
  }  else {
    #ipv6
    set type "ipv6"
    array set aRes ""
    helper_ipv6_addr_trim -ipv6_addr $ip_addr -out aRes
    set ipv6_l $aRes(-ipv6_addr_l)
    for {set i 0 } {$i < 8} { incr i 2 } {
      set v "0x[format %04s [lindex $ipv6_l $i]][format %04s [lindex $ipv6_l [expr $i + 1]]]"
      set cmd "ca_l3_ip_addr_set_ipv6_addr $pl3ip $v [expr $i / 2]"
      set res [helper_cmd_exec -cmd $cmd]
      if {$res} {break}
    }
  }
  if {$addr_len == ""} {
    if {$type == "ipv4" } {
      set addr_len 32
    } else {
      set addr_len 128
    }   
  }  
  if {$res == 0 } {
    set cmd "ca_ip_address_set_addr_len $pip $addr_len "
    set res [helper_cmd_exec -cmd $cmd]
  }
  if {$type == "ipv4" } {
    set afi 0
  } else {
    set afi 1
  }
  if {$res == 0 } {
    set cmd "ca_ip_address_set_afi $pip $afi"
    set res [helper_cmd_exec -cmd $cmd]
  }  
  #ca_ip_address_dump $pip
  
  log -tag itfend
  return $res
}
proc ::gw::helper_ca_mac_addr_set {args} {
  set ifnm helper_ca_mac_addr_set
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {mac_addr ref}
  if {[catch {array set aIn $args} err]} {
    log -tag error -msg "Invalid arguments. $err"
    set res -1
    return $res
  }  
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  catch {array unset aOut}
  set aOut(-ref) $aIn(-ref)
    
  set pt $aIn(-ref)
  if {$pt == "dotcare"} {
    set cmd "ca_mac_addr_create 0 0 0 0 0 0 "
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
    if {$res == 0} {
      set pt $aTmp(-err)
      set aOut(-ref) $pt
    }
  }
  if {$res == 0 } {
    set mac_l [split $aIn(-mac_addr) :]
    set new_mac_l ""
    foreach e $mac_l {
      lappend new_mac_l 0x$e
    }
    set cmd "ca_mac_addr_set $pt $new_mac_l"
    set res [helper_cmd_exec -cmd $cmd]
  }
  
  log -tag itfend -msg $args 
  return $res
}
proc ::gw::helper_ca_mac_addr_parse {args} {
  
}
proc ::gw::helper_cmd_exec {args} {
  global errorInfo
  set ifnm helper_cmd_exec 
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-cmd) ""
  set aIn(-check_return_value) 0
  if {[catch {array set aIn $args} err]} {
    log -tag error -msg "Invalid arguments. $err"
    set res -1
    return $res
  } 
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aCmdExecRes
  }
  upvar $aIn(-out) aOut
  set aCmdExecRes(-err) ""
  set aCmdExecRes(-res) 0
  
  set err ""      
  
  set cmd $aIn(-cmd)  
  if {[catch $cmd err]} {
    set errMsg "$err. $errorInfo"
    log -tag error -msg "\nfailed to invoke $cmd. \n...$err\n...$errorInfo"
    set res -1
  } elseif {$aIn(-check_return_value)} {
    set res $err
    if {$res} {
      log -tag error -msg "Failed to invoke command {$cmd}. Return value is $res instead of 0"
    }
  }
  set aOut(-err) $err  
  log -tag itfend
  return $res
}
proc ::gw::helper_ca_port_vlan_tag_max_get {} {
  return 2
}
proc ::gw::helper_ca_l3_route_entry_config {args} {
  set ifnm helper_ca_l3_route_engry_config
  set res 0
  set v_key_l {prefix nexthop_id}
  if {[catch {array set aIn $args} err]} {
    log -tag error -msg "Invalid arguments. $err"
    set res -1
    return $res
  } 
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  catch {array unset aOut}
  if {[info exists aIn(-ref)] 
    && [string compare [string tolower $aIn(-ref)] "dontcare"]} {
    set aOut(-ref) $aIn(-ref)
    set pt $aIn(-ref)    
  } else {  
    set cmd "ca_l3_route_create "
    set res [helper_cmd_exec -cmd $cmd  -out aTmp]
    if {$res == 0} {
      set pt $aTmp(-err)
      set aOut(-ref) $pt
    }  
  }
  if {$res == 0 } {
    if {[info exists aIn(-prefix)] 
      && [string compare [string tolower $aIn(-prefix)] "dontcare"] } {
      set pip [ca_l3_route_get_prefix $pt]
      set res [eval helper_ca_ip_address_entry_config "-ref $pip -ip_addr $aIn(-prefix)"]
    }
    set aOut(-ref) $pt
  }
  if {$res == 0 } {
    if {[info exists aIn(-nexthop_id)] 
      && [string compare [string tolower $aIn(-nexthop_id)] "dontcare"] } {
      set cmd "ca_l3_route_set_nexthop_id $pt $aIn(-nexthop_id)"
      set res [helper_cmd_exec -cmd $cmd]
    }
  }
  return $res
}
proc ::gw::helper_values_compare {args} {
  set res 0
  array set aIn $args
  array set aExp $aIn(-exp)
  array set aRtn $aIn(-rtn)
  if {[info exists aIn(-params)]} {
    set param_l $aIn(-params)
  } elseif {[info exists aIn(-param_l)]} {
    set param_l $aIn(-param_l)
  }
  foreach param $param_l {
    if {[string equal $aExp(-$param) "DONTCARE"]} {continue}
    if {[string equal $aExp(-$param) $aRtn(-$param) ]} {
      log -tag debug -msg "Get value of parameter {$param} is same as expected: $param=$aRtn(-$param)"
    } else {
      log -tag error -msg "Get value of parameter {$param} is $aRtn(-$param), not same as expected $aExp(-$param)"
      set res 1
    }
  }  
  return $res
}
proc ::gw::helper_ca_l3_intf_entry_parse {args} {
  set ifnm helper_ca_l3_intf_entry_parse
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {ref}
  helper_intf_and_var_declare -ifnm ca_l3_intf
  set v_key_l ""
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  array set aIn $args 
  helper_output_declare aIn
  helper_output_init aOut   
  foreach var "$v_intf_key_l" {
    set aOut(-$var) unknown
  }
  foreach var "$v_mask_key_l" {  
    set aOut(-mask_$var) unknown
  }
  array set aTmp ""  
  set pt $ref
  set pmask [ca_l3_intf_get_mask $pt]
  if {$res == 0 } {
       #ca_l3_intf_dump $pt
        foreach var $v_intf_key_l {
          if {$var == "ip_addr" } {
            set pip [ca_l3_intf_get_ip_addr $pt]            
            set res [eval helper_ca_ip_address_entry_parse -ref $pip -out aOut]
            continue
          }          
          if {$var == "mac_addr" } {
            set pmac [ca_l3_intf_get_mac_addr $pt]
            set mac_l ""
            for {set i 0 } {$i < 6} {incr i} {
              lappend mac_l [format %02x [ca_mac_addr_get $pmac $i]]
            }
            set aOut(-mac_addr) [join $mac_l :]
            continue 
          }          
          set aOut(-$var) [ca_l3_intf_get_$var $pt]      
          if {$var == "type"} {
            helper_s2h -table CA_L3_INTF_TYPE_T -source $aOut(-$var) -out aTmp
            set aOut(-type_v) $aTmp(-target)
          }  
          if {$var == "outer_tpid" || $var == "inner_tpid" || $var == "port_id"} {
            set aOut(-$var) [format "0x%0x" $aOut(-$var)]
          }  
        }  
  }
  if {$res == 0 } {
    #read mask
    foreach var $v_mask_key_l   {
      set aOut(-mask_$var) [ca_l3_intf_mask_get_$var $pmask]
    }    
  } 
  log -tag itfend
  return $res  
}
proc ::gw::helper_ca_l3_intf_entry_config {args} {
  set ifnm helper_ca_l3_intf_engry_config
  log -tag itfbgn -msg $args
  set res 0
  
#  set v_mask_l {mask_port_id mask_mac_addr mask_outer_tpid mask_outer_vid mask_inner_tpid mask_inner_vid mask_ mask_mtu mask_ip_addr mask_nat_enable  }
#  set v_intf_key_l {type intf_id port_id outer_tpid outer_vid inner_tpid inner_vid tunnel_id mtu  nat_enable }
  
  helper_intf_and_var_declare -ifnm ca_l3_intf
  
  if {[catch {array set aIn $args} err]} {
    log -tag error -msg "Invalid arguments. $err"
    set res -1
    return $res
  }
  #parray aIn
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  catch {array unset aOut} err
  set aOut(-ref) unknown  
   
  #create the data entry
  if {[info exists aIn(-ref)]} {
    set pt $aIn(-ref)
    set aOut(-ref) $pt
  } else {
    set cmd "ca_l3_intf_create "
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
    if {$res == 0 } {
      set pt $aTmp(-err)
      set aOut(-ref) $pt
    }
  }
  set pmask [ca_l3_intf_get_mask $pt]
  foreach key $v_intf_key_l { 
    if {$res} {break}
    if {[info exists aIn(-$key)] == 0 ||  
      [string compare [string tolower $aIn(-$key)] "dontcare"] == 0 } { 
      continue
    }      
    if {$key == "ip_addr" } {
      set set_mask_flag 0
      #handle ip address 
      set pip [ca_l3_intf_get_ip_addr $pt]
      set res [eval helper_ca_ip_address_entry_config "-ref $pip -ip_addr $aIn(-ip_addr)" -out aTmp]   
      set set_mask_flag 1
    } elseif {$key == "mac_addr"} {
      set cmd "ca_l3_intf_get_mac_addr $pt"
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
      if {$res == 0 } {
        set pmac $aTmp(-err)    
        set mac_l [split $aIn(-mac_addr) ":" ]
        set new_mac_l ""
        foreach e $mac_l {
          lappend new_mac_l 0x$e
        }
        set cmd "ca_mac_addr_set $pmac $new_mac_l"
        set res [helper_cmd_exec -cmd $cmd -out aTmp]
      }    
    } else {
      set val   $aIn(-$key)
      if {$key == "type"} {
        helper_h2s -table CA_L3_INTF_TYPE_T -source $val -out aTmp
        set val $aTmp(-target)
      }
      set cmd "ca_l3_intf_set_$key $pt $val"
      set res [helper_cmd_exec -cmd $cmd -out aTmp]    
    }
    #if {$key == "intf_id" || $key == "type" } {continue}
    if {$res || [lsearch $v_mask_key_l $key] < 0  || 
      ([info exists aIn(-mask_$key)] && [string compare -nocase $aIn(-mask_$key) "dontcare"])} {
      continue
    }
    set aIn(-mask_$key) 1
  }

  foreach key $v_mask_key_l {
    set var mask_$key
    if {$res } {break}  
    if {[info exists aIn(-$var)] 
      && [string compare [string tolower $aIn(-$var)] "dontcare" ]} {
      set cmd "ca_l3_intf_mask_set_$key $pmask $aIn(-$var)"
      set res [helper_cmd_exec -cmd $cmd ]
    }     
  }
  if {$::gw::gwenv(REPORT_LEVEL) <= 1} {
    parray aIn
    parray aOut
    puts "---dump content of struct ca_l3_intf:"
    ca_l3_intf_dump $pt
  }  
  set aOut(-ref) $pt
  return $res  
}
proc ::gw::helper_constant_value_get {args} {
  # to be finished...
  variable CA_CONSTANT_T  
  array set aIn $args
  set name $aIn(-param)
  if {[info exists CA_CONSTANT_T($name)]} {
    return $CA_CONSTANT_T($name)
  } else {
    log -tag warning -msg "No constant value found for $name"
    return unknown
  }
}
proc ::gw::helper_print_status_enum_name {status} {
  array set CA_STATUS_NAME_MAP_T {
    0x0 CA_E_OK 
    0x1 CA_E_RESOURCE 
    0x2 CA_E_PARAM 
    0x3 CA_E_NOT_FOUND 
    0x4 CA_E_CONFLICT 
    0x5 CA_E_TIMEOUT 
    0x6 CA_E_INTERNAL 
    0x7 CA_E_NOT_SUPPORT 
    0x8 CA_E_CONFIG 
    0x9 CA_E_UNAVAIL 
    0xa CA_E_MEMORY 
    0xb CA_E_BUSY 
 
    0xc CA_E_FULL 
    0xd CA_E_EMPTY 
    0xe CA_E_EXISTS 
    0xf CA_E_DEV 
    0x10 CA_E_PORT 
    0x11 CA_E_LLID 
    0x12 CA_E_VLAN 
 
    0x13 CA_E_INIT
    0x14 CA_E_INTF
    0x15 CA_E_NEXTHOP
    0x16 CA_E_ROUTE 
    0x17 CA_E_DB_CHANGED
    0x18 CA_E_INACTIVE
    0x19 CA_E_ALREADY_SET  
  }
  set hs [format 0x%x $status]
  if {[info exists CA_STATUS_NAME_MAP_T($hs)]} {
    puts "Return Value : $status - $CA_STATUS_NAME_MAP_T($hs)"
  } else {
    puts "Status : $status -> UNKNOWN"
  }
}
proc ::gw::helper_output_init {out_arr {var_list ""}} {
  upvar $out_arr aOut
  foreach var $var_list {
    set aOut(-$var) unknown
  }
}
proc ::gw::helper_output_declare {inArr {localOutArr aOut}} {
  #Replace following block:
  # array set aIn $args  
  # if {[info exists aIn(-out)] == 0} {
  #   set aIn(-out) aOut
  # }
  # upvar $aIn(-out) aOut
  # catch {array unset aOut} err

  if {[uplevel info exists ${inArr}(-out)] == 0} {
    uplevel set ${inArr}(-out) $localOutArr
  }
  uplevel upvar $[set inArr](-out) $localOutArr
  catch {uplevel array unset $localOutArr} err
  uplevel [list array set $localOutArr ""]
}
proc ::gw::helper_struct_config {args} {
  set ifnm helper_struct_config
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {key_l arg_arr ref struct}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    log -tag error -msg "Mandatory parameters forgetten"
    return $res
  }  
  set aIn(-key_l) ""
  set aIn(-arg_arr) ""
  set aIn(-ref) ""
  set aIn(-struct) ""
  if {[catch {array set aIn $args} err]} {
    log -tag error -msg "Invalid arguments. $err"
    set res -1
    return $res
  }   
  set v_key_l $aIn(-key_l)
  set pt $aIn(-ref)
  set st $aIn(-struct)
  upvar $aIn(-arg_arr) aKey
  foreach var $v_key_l {
    if {[info exists aKey(-$var)] 
      && [string compare [string tolower $aKey(-$var)] "dontcare"]} {
      set cmd "${st}_set_${var} $pt $aKey(-$var)"
      set res [helper_cmd_exec -cmd $cmd -check_return_value 0]
      if {$res} {break}
    }
  }
  log -tag itfend
  return $res
}
proc ::gw::is_struct_field {args} {
  array set aIn $args
  set struct $aIn(-struct)
  set member $aIn(-member)
  return [llength [info commands ${struct}_set_${member}]]
}
proc ::gw::is_unspec_var {arr param } {
    upvar $arr aIn
    if {[info exists aIn(-$param)] == 0 || [string equal -nocase $aIn(-$param)  "dontcare"]} {
        return 1
    }
    return 0
}
proc ::gw::helper_mac_set {pt mac} {
      set mac_l [split $mac :]
      set new_mac_l ""
      foreach elm $mac_l {
        lappend new_mac_l 0x$elm
      }
      set cmd "ca_mac_addr_set $pt $new_mac_l"      
      return [helper_cmd_exec -cmd $cmd ]
}
proc ::gw::helper_convert_ipv4_addr_hex2dot {args} {
  set res 0
  array set aIn $args 
  if {[info exists aIn(-out)] == 0 } {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  set aOut(-ipv4_addr) unknown  
  set aOut(-ipv4_addr_l) unknown
  
  set ipv4 $aIn(-ipv4_addr_hex)
  
  if {[string first "0x" [string tolower $ipv4] ] == -1 } {
    set ipv4 "0x$ipv4"
  }
  set ipv4_addr_l ""
  for {set i 3 } {$i >=0 } {incr i -1 } {
    set v [expr ($ipv4 >> (8 * $i)) & 0xff]
    lappend ipv4_addr_l $v
  }
  set aOut(-ipv4_addr) [join $ipv4_addr_l "." ]
  set aOut(-ipv4_addr_l) $ipv4_addr_l
  #parray aOut
  return $res
}
proc ::gw::helper_expand_list {args} {
  #Example:
  # {1,2,3 * 4, 6-9,10,12}
  # here:
  #   the spiltor is ","
  #   "*" is repeat operator, means to repeat data "3" by 4 times
  #   "-" is increas operator, means including elements whose value in the specific range
  #  
  set ifnm helper_expand_list
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {set}
  set v_key_l {splitor incr_operator repeat_operator}
  set aIn(-splitor) ","
  set aIn(-range_operator) "-"
  set aIn(-repeat_operator) "*"
  array set aIn $args
  if {[info exists aIn(-out)]} {
    upvar $aIn(-out) aRtn
  } else {
    upvar aRtn aRtn
  }
 
  set sp $aIn(-splitor)
  set iop $aIn(-range_operator) 
  set rop $aIn(-repeat_operator)
  set set $aIn(-set)
  set aRtn(-l) ""
  set l [split $set $sp]
  
  set new_l ""
  foreach e $l {
    if {[string first $iop $e] >= 0} {
      set e_l [split $e $iop]
      set v [lindex $e_l 0]
      set c [lindex $e_l end]
      set step 1
      if {$v > $c} { 
        for {set i $v } {$i >= $c} {incr i -1} {
          lappend new_l $v
          incr v
        }
      } else {
        for {set i $v } {$i <= $c} {incr i} {
          lappend new_l $v
          incr v
        }      
      }
    } elseif {[string first $rop $e] >= 0} {
      set e_l [split $e $rop]
      set v [lindex $e_l 0]
      set c [lindex $e_l end]
      set new_l $new_l[string repeat " $v" $c]
    } else {
      lappend new_l $e
    }
  }
  set aRtn(-l) $new_l
  log -tag itfend
  return $res
}
proc ::gw::helper_ipv6_addr_trim {args} {
  array set aIn $args
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  set aOut(-ipv6_l) unknown
    
  set ipv6 $aIn(-ipv6_addr)
  
  
  set idx [string first "::" $ipv6]
  if {$idx == -1 } {
    set s1 $ipv6
    set s2 ""
  } else {
    set s1 [string range $ipv6 0 [expr $idx - 1] ]
    set s2 [string range $ipv6 [expr $idx + 2] end]
  }
  set s1_l [split $s1 :]
  set s2_l [split $s2 :]
  set s0_cnt [expr 8 - [llength $s1_l] - [llength $s2_l]]
  set s0_str [string repeat 0 $s0_cnt]
  set s0_l [split $s0_str ""]
  
  
  set aOut(-ipv6_addr_l) [string trim "$s1_l $s0_l $s2_l"]
  set aOut(-ipv6_omit) [llength $s0_l]
  #parray aOut
}
proc ::gw::helper_iterate {args} {
    global errorInfo
    variable gwenv
    set ifnm helper_iterate
    set res 0
    log -tag itfbgn -ifnm $ifnm -msg $args
    set m_key_l {device_id iterate_func data_type  }
    set v_key_l {parse_func cpi uint32_size data_size exp_args earg0 earg1 auto_release}
    set res [helper_m_args_check -args $args -m_key_l $m_key_l]
    if {$res} {
      return $res
    }
    set aIn(-iterator_pointer) NULL
    set aIn(-cpi) 1
    set aIn(-uint32_size) 384
    set aIn(-data_size) 1536
    set aIn(-auto_release) 1
    set aIn(-exp_args) dontcare
    set aIn(-parse_func) dontcare
    set aIn(-earg0) ""
    set aIn(-iterate_seq) 0
  
    array set aIn $args
    if {[info exists aIn(-out)] == 0} {
      set aIn(-out) aOut
    }
    upvar $aIn(-out) aOut
    catch {array unset aOut} err
    array set aOut "" 
    
    set p $aIn(-iterator_pointer)
    set cpi $aIn(-cpi) 
    set usize $aIn(-uint32_size)
    set dsize $aIn(-data_size)
    set auto_release $aIn(-auto_release)
    set parse_func $aIn(-parse_func)
    set exp_args $aIn(-exp_args)
    set earg0 $aIn(-earg0)
  
    if {[string toupper $parse_func] == "DONTCARE" } {
      set auto_release 0
    }   
    set data_pointer_l ""
    set idx 0   
    set pd "NULL"
    if {$p == "NULL"} {
      #First time call, declare the iterator structure
      #set prev_handle NULL
      set cmd "ca_iterator_create"
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
      if {$res == 0 } {
        set p $aTmp(-err)
        #malloc the entry_data, or else it's nil(NULL)
        set cmd "ca_uint32_array_create 0 $usize"
        set res [helper_cmd_exec -cmd $cmd -out aTmp]           
      }
      if {$res == 0} {
        set pd $aTmp(-err) 
        set cmd "ca_iterator_set_entry_data  $p $pd"
        set res [helper_cmd_exec -cmd $cmd -out aTmp]        
      }  
    }
    if {$res == 0 } {
      set pd [ca_iterator_get_entry_data $p]
      set prev_handle [ca_iterator_get_prev_handle $p]
    }
    if {$res == 0} {
      set cmd "ca_iterator_set_entry_count $p $cpi"
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
    }
    if {$res == 0 } {
      set cmd "ca_iterator_set_user_buffer_size $p $dsize"
      set res [helper_cmd_exec -cmd $cmd -out aTmp]  
    } 
  
    set err 0
    if {$res == 0} {
      if {$gwenv(REPORT_LEVEL) <= 1 } {
        puts "debug: struct content before iterate:"
        ca_iterator_dump $p
      }
      set cmd "$iterate_func $device_id $earg0 $p" 
      log -tag debug -msg "to execute command: { $cmd }"
      if {[catch $cmd err]} {
        set res -1
        log -tag error -msg "Failed to perform command {$cmd}. \nError Information: $err\n$errorInfo"
      } else {     
        set res $err 
         if {$err == 9 } {
          #Table empty or end of table
          log -tag info -msg "Return code=9. No more entry in table"
        } elseif {$err ne 0} {
          log -tag error -msg "Iterate command returns code $err instead of 0"
        }
      }      
      if {$gwenv(REPORT_LEVEL) <= 1 } {  
        puts "debug: struct content after iterate:"    
        ca_iterator_dump $p
      }
    }   
    if {$res == 0} {
      set entry_count [ca_iterator_get_entry_count $p]
      if {$entry_count == 0 } {
        set res -1
        log -tag error -msg "Iterate command returns ok but with entry count=0"         
      }
    }
    if { $res == 0} {
      set npd [ca_iterator_get_entry_data $p]
      set i [string first _p_unsigned_int $npd]
      set npd [string replace $npd $i end "_p_${data_type}"]
      set pre_data_type [string range $data_type 0 end-2]

      for {set i 0 } {$i < $entry_count} {incr i; incr idx} {    
        catch {array unset aTmp } ignore
        array set aTmp ""
        set npdx [${pre_data_type}_array_get $npd $i]     
        if {[string toupper $parse_func] == "DONTCARE" } {
          lappend data_pointer_l $npdx
        } else {
          set res [eval $parse_func -ref $npdx -exp_args $exp_args -out aTmp]
          if {$res} {
            log -tag warning -msg "Data struct parse function $parse_func returns $res"
            break
          }     
          set aOut($idx) [array get aTmp] 
        }
      }
    }
    if {$res == 0} {
        set current_prev_handle [ca_iterator_get_prev_handle $p]
        #puts "prev_handle = $current_prev_handle"
        if {$current_prev_handle == $prev_handle} {
            #the pointer is not changed
            set res -1
            log -tag error -msg "The prev_handle(=$prev_handle) is same in consequent iterate operations"
        }
        if {$current_prev_handle == "NULL" } {
            set res -1
            log -tag error -msg "Return code is E_OK, but the returned prev_handle is NULL"
        }
    }
    if {[string toupper $parse_func] == "DONTCARE"  } {
       set aOut(-element_data_pointers) $data_pointer_l
    }
    set aOut(-iterator_pointer) $p
    set aOut(-iterator_data_pointer) $pd
    
    if {$auto_release} {
      if {[string compare $p "NULL"] } {
        catch {ca_data_free $p} err
      }
      if {[string compare $pd "NULL"] } {
        catch {ca_data_free $pd} err
      }
    }     
    if {$gwenv(REPORT_LEVEL) == 0 } {  
      parray aOut
    }
    log -tag itfend 
    return $res
}
proc ::gw::helper_ca_tunnel_cfg_entry_params_declare {args} { 
  array set aIn $args
  uplevel 1  [list set v_com_key_l {dest_addr src_addr parent_l3_intf_id type}]     
  uplevel 1  [list set v_pppoe_com_key_l {version_type code protocol mac_da pppoe_session_id}]  
  uplevel 1  [list set v_l2tp_com_key_l {version len tunnel_id dest_l4_port src_l4_port session_id \
    encap_type l2_specific_len l2_specific_type sequence_number\
    send_seq calc_udp_csum cookie_len cookie offset l2tp_src_mac\
    peer_l2tp_src_mac}]  
  uplevel 1  [list set v_ipsec_com_key_l {sa_id_encrypt sa_id_decrypt}   ] 
  
  uplevel 1 [list set v_pptp_com_key_l {sa_id_outbound sa_id_inbound}  ]
  
  set v_dslite_key_l { dsl_ipmc_to_l2fe dsl_ttl_keep_outer dsl_dscp_keep_outer \
    dsl_ecn_keep_outer dsl_ecn_check_enable rebuild_mc_mac mc_flag mc_mac mc_drop\
    validation_check_failed_dest_port egress_tc_value egress_hoplimit_value egress_flow_label_value \
    dsl_ipmc_illegal_check_en   dsl_ipmc_addr_prefix_check_en   \
    dsl_ipmc_addr_consistency_check_en dsl_reverse_path_check_en} 
  uplevel 1 [list set v_dslite_com_key_l $v_dslite_key_l]

  uplevel 1 [list set v_6rd_com_key_l {ipv6_6rd_prefix six_rd_v4_mask_len six_rd_ipda_from_v6 \
    six_rd_v6_prefix_len six_rd_ingress_check_en six_rd_ipsa_match six_rd_ipmc_illegal_check_en \
    six_rd_ttl_keep_outer six_rd_dscp_keep_outer six_rd_ecn_keep_outer six_rd_ecn_check_enable \
    ce_ce_allowed mc_drop validation_check_failed_dest_port \
    rebuild_mc_mac mc_mac egress_tos_value egress_ttl_value \
    egress_identification_start  egress_identification_end}]
     
  uplevel 1 [list set v_mape_com_key_l {map_type ipv6_prefix ipv4_prefix ea_bit_length \
    psid_offset psid_length psid_id validation_check_failed_dest_port\
    egress_tc_copied_from_ipv4_tos egress_tc_value egress_hoplimit_value egress_flow_label_value}]
    
  uplevel 1 [list set v_srv6_enddx2_com_key_l  { direction port_id vlan ip_da } ] 
 
  uplevel 1 [list set v_4in4_com_key_l {}]
  uplevel 1 [list set v_6in6_com_key_l {}]
}
proc ::gw::helper_ca_tunnel_cu_usage {args} {  
  variable CA_TUNNEL_TYPE_T
  if {[lsearch -regexp $args {^\-h|\-\-help$}] == -1 } {return}
  helper_ca_tunnel_cfg_entry_params_declare
  set idx [lsearch $args {\-type}]
  if {$idx >= 0 } {
    incr idx
    set type [lindex $args  $idx]
    helper_s2h -table CA_TUNNEL_TYPE_T -source $type -out aH
    set type_l $aH(-target)
  } else {
    set type_l ""
    set types [array names  CA_TUNNEL_TYPE_T]
    foreach type $types {
      lappend type_l [lindex [split $type ,] 0]
    }
  }
  set docStr "* Input Parameters:\n"
  append docStr "  Common Parameters:  $v_com_key_l \n"
  foreach type $type_l {
    if {$type == "PPOE"} {
      append docStr "  For PPOE: $v_pppoe_com_key_l\n"
    }
    if {$type == "L2TP"} {
      append docStr "  For L2TP: \n"
      foreach key  $v_l2tp_com_key_l {
        append docStr "    $key\n"
      }      
    }
    if {$type == "IPSEC"} {
      append docStr "  For IPSEC: $v_ipsec_com_key_l\n"
    }    
    if {$type == "PPTP"} {
      append docStr "  For PPTP: $v_pptp_com_key_l\n"
    }   
    if {$type == "DSLITE"} {
      append docStr "  For DSLITE: \n"
      foreach key  $v_dslite_com_key_l {
        append docStr "    $key\n"
      }
    }  
    if {$type == "6RD"} {
      append docStr "  For 6RD: \n"
      foreach key  $v_6rd_com_key_l {
        append docStr "    $key\n"
      }      
    }  
    if {$type == "MAPE"} {
      append docStr "  For MAP-E: \n"
      foreach key  $v_mape_com_key_l {
        append docStr "    $key\n"
      }      
    }     
    if {$type == "4IN4"} {
      append docStr "  For 4IN4: $v_4in4_com_key_l\n"
    }
    if {$type == "6IN6"} {
      append docStr "  For 6IN6:\n"
      foreach key  $v_6in6_com_key_l {
        append docStr "    $key\n"
      }
    }  
     if {$type == "SRV6_ENDDX2"} {
      append docStr "  For SRV6_ENDDX2:\n"
      foreach key  $v_srv6_enddx2_com_key_l {
        append docStr "    $key\n"
      }
    }                    
  }  
  puts $docStr
}
proc ::gw::helper_ca_tunnel_cfg_entry_parse {args} {
  set ifnm helper_ca_tunnel_cfg_entry_parse
  set res 0
  variable CA_PORT_VLAN_TAG_MAX 
  variable L2TPv3_COOKIE_SIZE  
  variable CA_TUNNEL_TYPE_T
  log -tag itfbgn -msg $args
  set m_key_l {ref}  
  helper_ca_tunnel_cfg_entry_params_declare     
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }    
  array set aIn $args  
  set pt $aIn(-ref)
  helper_output_declare aIn
  helper_output_init aOut  $v_com_key_l

  if {$res == 0 } {
    #Read common fields in ca_tunnel_cfg_t
    foreach var "dest_addr src_addr" {
      set pip [ca_tunnel_cfg_get_$var $pt]
      set res [helper_ca_ip_address_entry_parse -ref $pip -out aTmp]
      set aOut(-$var) $aTmp(-ip_addr)
    }
    set aOut(-parent_l3_intf_id) [ca_tunnel_cfg_get_parent_l3_intf_id $pt]
    set pUnion   [ca_tunnel_cfg_get_tunnel $pt]
    set type [ca_tunnel_cfg_get_type $pt]
    set aOut(-type) $type  
    helper_s2h -source $type -table CA_TUNNEL_TYPE_T -out aType
    set aOut(-type_v) $aType(-target)   
  }
  if {$res == 0 } {      
    if {$type == 0 } {
      #Invalid      
    } elseif {$type == 1 } {
      #Read PPPoE if any    
      set pEntry   [ca_tunnel_cfg_union_get_pppoe $pUnion]
      foreach var $v_pppoe_com_key_l {
        if {$var == "mac_da" } {
          set pDMac [ca_pppoe_tunnel_cfg_get_mac_da $pEntry]
          set mac_l ""
          for {set i 0 } {$i < 6} {incr i} {
            lappend mac_l [format %02x [ca_mac_addr_get $pDMac $i]]
          }
          set aOut(-mac_da) [join $mac_l :]
        } else {
          set aOut(-$var) [ca_pppoe_tunnel_cfg_get_$var $pEntry]
        }
      } 
    } elseif {$type == 2} {;#l2tp 
      set pEntry [ca_tunnel_cfg_union_get_l2tp $pUnion]
      foreach var $v_l2tp_com_key_l  {
        if {$var == "l2tp_src_mac" || $var == "peer_l2tp_src_mac" }  {
          set pSMac [ca_l2tp_tunnel_cfg_get_$var $pEntry]          
          set mac_l ""
          for {set i 0 } {$i < 6} {incr i} {
            lappend mac_l [format %02x [ca_mac_addr_get $pSMac $i]]
          }
          set aOut(-$var) [join $mac_l :]      
        } elseif {$var == "cookie"} {
          set len [ca_l2tp_tunnel_cfg_get_cookie_len $pEntry]
          set l "" 
          for {set idx 0 } {$idx <$len} {incr idx} { 
            lappend l [ ca_l2tp_tunnel_cfg_get_cookie $pEntry $idx]
          }
          set aOut(-$var) [join $l ","]
        } else {
          set aOut(-$var) [ca_l2tp_tunnel_cfg_get_$var $pEntry]
        }
      }
      
    } elseif {$type == 3} {;#ipsec
      set pEntry [ca_tunnel_cfg_union_get_ipsec $pUnion]
      foreach var $v_ipsec_com_key_l  {
        set aOut(-$var) [ca_ipsec_tunnel_cfg_get_$var $pEntry]
      }      
    }  elseif {$type == 4 } {;#pptp
      set pEntry [ca_tunnel_cfg_union_get_pptp $pUnion]
      foreach var $v_pptp_com_key_l  {
        set aOut(-$var) [ca_pptp_tunnel_cfg_get_$var $pEntry]
      }       
    } elseif {$type == 6 } {;#dslite
      helper_ca_tunnel_cfg_entry_params_declare 
      set pEntry [ca_tunnel_cfg_union_get_dslite $pUnion]
      foreach var $v_dslite_com_key_l  {
        if {$var == "mc_mac" } {
          set pMac [ca_dslite_config_get_mc_mac $pEntry]
           set mac_l ""
          for {set i 0 } {$i < 6} {incr i} {
            lappend mac_l [format %02x [ca_mac_addr_get $pMac $i]]
          }
          set aOut(-mc_mac) [join $mac_l :]                
        } else {
          set aOut(-$var) [ca_dslite_config_get_$var $pEntry]
        }
      }
      set aOut(-validation_check_failed_dest_port) [format 0x%x $aOut(-validation_check_failed_dest_port)]     
    } elseif {$type == 7 } {;#6rd IPv6 Rapid Deployment RFC5569 , similar as 6to4(RFC3056)
      set pEntry [ca_tunnel_cfg_union_get_six_rd $pUnion]
      foreach var $v_6rd_com_key_l  {
        if {$var == "mc_mac" } {
          set pMac [ca_6rd_config_get_mc_mac $pEntry]
          set mac_l ""
          for {set i 0 } {$i < 6} {incr i} {
            lappend mac_l [format %02x [ca_mac_addr_get $pMac $i]]
          }
          set aOut(-mc_mac) [join $mac_l :]  
        } elseif {$var == "ipv6_6rd_prefix"} {
          set pip [ca_6rd_config_get_ipv6_6rd_prefix $pEntry]
          set res [eval helper_ca_ip_address_entry_parse -ref $pip -out aTmp] 
          if {$res == 0 } {
            set aOut(-ipv6_6rd_prefix) $aTmp(-ip_addr)
          }
        } else {              
          set aOut(-$var) [ca_6rd_config_get_$var $pEntry]
        }
        if {$var == "validation_check_failed_dest_port"} {
          set aOut(-$var) [format 0x%x $aOut(-$var)]
        }
      }             
    } elseif {$type == 9 || $type == 10 } {
      set pEntry [ca_tunnel_cfg_union_get_map $pUnion]
      foreach var $v_mape_com_key_l {
        if {$var == "ipv6_prefix" || $var == "ipv4_prefix"} {
          set pip [ca_map_config_get_$var $pEntry]          
          set res [eval helper_ca_ip_address_entry_parse -ref $pip -out aTmp] 
          if {$res == 0 } {
            set aOut(-$var) $aTmp(-ip_addr)
          }          
        } else  {
          set aOut(-$var) [ca_map_config_get_$var $pEntry]
        } 
      }                  
    }  elseif {$type == 12 } { #srv6_enddx2
      set pEntry [ca_tunnel_cfg_union_get_srv6_enddx2 $pUnion]
      foreach var $v_srv6_enddx2_com_key_l {
        if {$var == "ip_da"} {
          set pip [ca_srv6_enddx2_tunnel_config_get_$var $pEntry]          
          set res [eval helper_ca_ip_address_entry_parse -ref $pip -out aTmp] 
          if {$res == 0 } {
            set aOut(-$var) $aTmp(-ip_addr)
          }          
        } else  {
          set aOut(-$var) [ca_srv6_enddx2_tunnel_config_get_$var $pEntry]
          if {$var == "port_id"} {set aOut(-port_id) [format "0x%05x" $aOut(-port_id)]}
          if {$var == "direction"} {
             helper_s2h -table CA_TUNNEL_DIRECTION_T -source $aOut(-direction) -out aDir
             set aOut(-direction_v) $aDir(-target)
          }
        } 
      }                  
    } else {
      log -tag error -msg "Unsupported/Invalid tunnel type getten: $type"
      set res -1
    }    
  }      
  log -tag itfend
  return $res
}
proc ::gw::helper_ca_tunnel_cfg_entry_config {args} {
  set ifnm helper_ca_tunnel_cfg_entry_config
  set res 0
  log -tag itfbgn -msg $args
  variable CA_TUNNEL_TYPE_T
  variable CA_PORT_VLAN_TAG_MAX 
  variable L2TPv3_COOKIE_SIZE  
  #ca_tunnel_cfg_t:
  #ca_tunnel_type_t type
  #ca_ip_address_t     dest_addr
  #ca_ip_address_t    src_addr
  #ca_intf_id_t      parent_l3_intf_id
  #ca_tunnel_cfg_union_t  tunnel

  set m_key_l {type}
  helper_ca_tunnel_cfg_entry_params_declare    
  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l DONTCARE]
  if {$res} {
    return $res
  }    
  set aIn(-ref) "dontcare"
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  
  set aOut(-ref) $aIn(-ref) 
  set ctype    [string toupper $type]  
  helper_h2s -source $ctype -table CA_TUNNEL_TYPE_T -out aRes
  set aIn(-type) $aRes(-target)   
  helper_s2h -source $ctype -table CA_TUNNEL_TYPE_T -out aRes
  set type_v $aRes(-target) 
   
  if {[string tolower $aIn(-ref)] == "dontcare"} {    
    set cmd {ca_tunnel_cfg_create}
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
    if {$res == 0 } {
      set pt $aTmp(-err)
      set aOut(-ref) $pt
    }
  } else { 
     set pt $aIn(-ref)   
  }
  
  if {$res == 0 } {
    set pUnion   [ca_tunnel_cfg_get_tunnel $pt]
  }
  #Configure tunnel common fields
  foreach var $v_com_key_l { 
    if {$res} {break} 
    if {[info exists aIn(-$var)] == 0 || ([string compare [string tolower $aIn(-$var) ]  "dontcare"] == 0)} {
      continue
    }
    if {$var == "dest_addr" || $var == "src_addr"} {
      set pip [ca_tunnel_cfg_get_$var $pt]
      set res [eval helper_ca_ip_address_entry_config -ref $pip -ip_addr $aIn(-$var)]
      continue
    }
    set cmd "ca_tunnel_cfg_set_$var $pt $aIn(-$var)"
    set res [helper_cmd_exec -cmd $cmd ]
  }

  if {$res == 0 && $type_v == "PPPOE"} {    
    #Configure PPPoE
    set pEntry     [ca_tunnel_cfg_union_get_pppoe $pUnion]
    set pDMac     [ca_pppoe_tunnel_cfg_get_mac_da $pEntry]

    foreach var $v_pppoe_com_key_l {
      if {$res} {break}
      if {[info exists aIn(-$var)] == 0 
        || ([string compare [string tolower $aIn(-$var) ]  "dontcare"] == 0)} {
        continue
      }      
      if {$var == "mac_da" } {
        set res [helper_ca_mac_addr_set -ref $pDMac -mac_addr $aIn(-mac_da)]
        if {$res} {break}
      } else {
        set cmd "ca_pppoe_tunnel_cfg_set_$var $pEntry $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {break}
      }
    }  
  }
  
  if {$res == 0 && $type_v == "L2TP" } {
    #configure L2TP
    set pEntry     [ca_tunnel_cfg_union_get_l2tp $pUnion]
    set pl2tp_src_mac      [ca_l2tp_tunnel_cfg_get_l2tp_src_mac $pEntry]
    set ppeer_l2tp_src_mac      [ca_l2tp_tunnel_cfg_get_peer_l2tp_src_mac $pEntry]
    if {[info exists aIn(-encap_type)] } {
      helper_h2s -table CA_L2TP_TUNNEL_ENCAP_TYPE_T -source $aIn(-encap_type) -out aH
      set aIn(-encap_type) $aH(-target)
    } 
    foreach var $v_l2tp_com_key_l {
      if {[info exists aIn(-$var)] == 0 || [string compare [string tolower $aIn(-$var) ]  "dontcare"] == 0} {
        continue
      } 
      if {$res} {break}
      if {$var == "l2tp_src_mac" || $var == "peer_l2tp_src_mac" } {
        set res [helper_ca_mac_addr_set -ref [set p$var] -mac_addr $aIn(-$var)] 
      } elseif {$var == "cookie"} {
        helper_expand_list -set $aIn(-port_encap_tag) -out aTmp
        set v_l $aTmp(-l)
        set len [llength $v_l]
        if {[info exists aIn(-cookie_len)] 
            && [string compare [string tolower $aIn(-$cookie_len) ]  "dontcare"]} {
          if{$len > $aIn(-cookie_len) } {set len $aIn(-cookie_len)}
        } 
        if {$len > $L2TPv3_COOKIE_SIZE} {
          set len $L2TPv3_COOKIE_SIZE
        }
        for {set idx 0 } {$idx < $len} {incr i} {
          set cmd [list ca_l2tp_tunnel_cfg_set_cookie $pEntry [lindex $v_l $idx] $idx]
          set res [helper_cmd_exec -cmd $cmd]
          if {$res} {break}
        }
      } else {
        set cmd "ca_l2tp_tunnel_cfg_set_$var $pEntry $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd ]
      }
    }         
  } 
  
  if {$res == 0 && $type_v == "IPSEC" } {
    #Configure IPSEC
    set pEntry   [ca_tunnel_cfg_union_get_ipsec $pUnion]      
    foreach var $v_ipsec_com_key_l {
      if {$res} {break}
      if {[info exists aIn(-$var)] == 0 
        || [string compare [string tolower $aIn(-$var) ]  "dontcare"] == 0} {
        continue
      } 
      set cmd "ca_ipsec_tunnel_cfg_set_$var $pEntry $aIn(-$var)"
      set res [helper_cmd_exec -cmd $cmd]
    }
  }
  
  if {$res == 0 && $type_v == "PPTP"} {
    #Configure PPTP
    set pEntry [ca_tunnel_cfg_union_get_pptp $pUnion]
    foreach var $v_pptp_com_key_l {
     if {[info exists aIn(-$var)] == 0 
        || [string compare [string tolower $aIn(-$var)] "dontcare"] == 0 } {
      continue
     }
     if {$res} {break}
     set cmd "ca_pptp_tunnel_cfg_set_$var $pEntry $aIn(-$var)"
     set res [helper_cmd_exec -cmd $cmd ]
    }            
  }
  
  if {$res == 0 && $type_v == "DSLITE" } {
    #Configure DSLite
    #walkaround for member name not changed according to sdk api doc in time
    #auto-detect new var names
    helper_ca_tunnel_cfg_entry_params_declare 
    set pEntry   [ca_tunnel_cfg_union_get_dslite $pUnion]      
    foreach var $v_dslite_com_key_l {
      if {$res} {break}
      if {[info exists aIn(-$var)] == 0 
          || [string compare [string tolower $aIn(-$var) ]  "dontcare"] == 0} {
          continue
        } 
        if {$var == "mc_mac"} {
          set pmac [ca_dslite_config_get_mc_mac $pEntry]
          set res [helper_ca_mac_addr_set -ref $pmac -mac_addr $aIn(-mc_mac)]  
      } else {
          set cmd "ca_dslite_config_set_$var $pEntry $aIn(-$var)"
          set res [helper_cmd_exec -cmd $cmd]
      }
    }
  }
  if {$res == 0 && ($type_v == "MAPE" || $type_v == "MAPT") } {
    #Configure MAPE or MAPT
    set pEntry [ca_tunnel_cfg_union_get_map $pUnion]
    foreach var $v_mape_com_key_l {
      if {[info exists aIn(-$var)] == 0 
        || [string compare [string tolower $aIn(-$var)] "dontcare"] == 0 } {
        continue
      }
      if {$res} {break}
      if {$var == "ipv6_prefix" || $var == "ipv4_prefix"} {
        set pip [ca_map_config_get_$var $pEntry]
        set res [eval helper_ca_ip_address_entry_config -ref $pip -ip_addr $aIn(-$var)]
      } else  {
        set cmd "ca_map_config_set_$var $pEntry $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd]
      } 
    }            
  }     
  if {$res == 0 && $type_v == "6RD" } {
    #Configure 6rd
    set pEntry   [ca_tunnel_cfg_union_get_six_rd $pUnion]      
    foreach var $v_6rd_com_key_l {
      if {$res} {break}
      if {[info exists aIn(-$var)] == 0 
          || [string compare [string tolower $aIn(-$var) ]  "dontcare"] == 0} {
          continue
      } 
      if {$var == "mc_mac"} {
        set pmac [ca_6rd_config_get_mc_mac $pEntry]
        set res [helper_ca_mac_addr_set -ref $pmac -mac_addr $aIn(-mc_mac)]  
      } elseif {$var == "ipv6_6rd_prefix"} {
        set pip [ca_6rd_config_get_ipv6_6rd_prefix $pEntry]
        set res [eval helper_ca_ip_address_entry_config -ref $pip -ip_addr $aIn(-ipv6_6rd_prefix)]
      } else  {
        set cmd "ca_6rd_config_set_$var $pEntry $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd]
      }
    }
  }
  if {$res == 0 && ($type_v == "SRV6_ENDDX2") } {
    #Configure SRV6 ENDDX2
    set pEntry [ca_tunnel_cfg_union_get_srv6_enddx2 $pUnion]
    foreach var $v_srv6_enddx2_com_key_l {
      if {[info exists aIn(-$var)] == 0
        || [string compare [string tolower $aIn(-$var)] "dontcare"] == 0 } {
        continue
      }
      if {$res} {break}
      set val $aIn(-$var)
      if {$var == "ip_da"} {
        set pip [ca_srv6_enddx2_tunnel_config_get_$var $pEntry]
        set res [eval helper_ca_ip_address_entry_config -ref $pip -ip_addr $val]
      } else  {
        if {$var == "direction"} {
          helper_h2s -table CA_TUNNEL_DIRECTION_T -source $val -out aDir
          set val $aDir(-target)
        }
        set cmd "ca_srv6_enddx2_tunnel_config_set_$var $pEntry $val"
        set res [helper_cmd_exec -cmd $cmd]
      } 
    }            
  }     
  log -tag itfend
  return $res
}
proc ::gw::helper_parray {arr {sort_opt -dict} {mode 0} {columns DONTCARE}} {
  global errorInfo
  upvar $arr x
  if {[array size x] <= 0} {return}
  set idx_l  [array names x]

  if {[string tolower $sort_opt] == "dontcare"} {
    
  } else {
    set idx_l [eval lsort [list $sort_opt $idx_l]]
  }
    if {$mode == 0 } {
      foreach idx $idx_l {
        puts "\[[string trimleft $idx -] = $x($idx)\]"
      }
    } elseif {[expr $mode & 1 ]} {
      if {[string toupper $columns] ne "DONTCARE"} {
      set colNames $columns
    } else {
      if {[catch {array set aRow $x([lindex $idx_l 0])} err]} {
         puts "$err.\n $errorInfo"
         return
      }
      set colNames [lsort [array names aRow]]
    }
     foreach nm "idx $colNames" {
       set aMaxLen($nm) [string length [string trimleft $nm "-" ] ]
     }
     foreach idx $idx_l {
       if {[catch {array set aRow $x($idx)} err]} {
         puts "$err.\n $errorInfo"
         return
       }
       foreach nm $colNames {
         if {[string length $aRow($nm)] > $aMaxLen($nm)} {
           set aMaxLen($nm) [string length $aRow($nm)]
         }
       }
       if {[string length [string trimleft $idx "-"] ] > $aMaxLen(idx)} {
         set aMaxLen(idx) [string length [string trimleft $idx "-"]]
       }
     }
     set totLen 0
     
     puts ""
     foreach nm "idx $colNames" {
       puts -nonewline  [format "%-$aMaxLen($nm)s  " [string trimleft $nm "-"]]
       set totLen [expr $aMaxLen($nm) + $totLen + 2]
     }
     puts ""
     puts [string repeat "-" $totLen]
     foreach idx $idx_l {
         array set aRow $x($idx)
         puts -nonewline [format "%-$aMaxLen(idx)s  " [string trimleft $idx "-" ] ]
         foreach nm $colNames {
           puts -nonewline [format "%-$aMaxLen($nm)s  " $aRow($nm)]
         }
         puts ""
     }
     puts [string repeat "-" $totLen]
  }
}
proc ::gw::helper_m_args_check {args} {
  #If input v_key_l is DONTCARE, then skip unknown parameter checking
  variable gwenv
  global errorInfo
  set ifnm helper_m_args_check
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-args) ""
  set aIn(-m_key_l) ""
  set aIn(-v_key_l) ""
  if {[catch {array set aIn $args} err]} {
    log -tag error -msg "Invalid arguments. $err"
    set res -1
    return $res
  } 
  set m_key_l $aIn(-m_key_l)
  set v_key_l $aIn(-v_key_l)
  if {$m_key_l == "" } {
    if {[uplevel info exists m_key_l]} {
      unset m_key_l
      upvar m_key_l m_key_l
    } 
  }
  if {$v_key_l == "" } {
    if {[uplevel info exists v_key_l]} {
      unset v_key_l
      upvar v_key_l v_key_l
    }  
  }   
  set exp_args "dev_id device_id"
  #print all arugments
  set fn [info level -1]
  if {[lsearch -exact $aIn(-args) "-h"] >= 0 || [lsearch -exact $aIn(-args) "--help"] >= 0} {
    set fn [lindex [info level -1] 0 ]
    set ind "    "
    puts "Input parameters of procedure $fn: "
    puts "  * Mandatory parameters: "
    for {set i 0} {$i < [llength $m_key_l]} {incr i} {
      set mv [lindex $m_key_l $i]
      if {$mv == "device_id" || $mv == "dev_id" } {continue}
      puts "$ind$mv"
    }    
    puts ""
    set len [llength $v_key_l]
    puts "  * Optional parameters:"
    for {set i 0 } {$i < $len} {incr i } {
      puts "$ind[lindex $v_key_l $i]"
    }
    puts ""      

    if {[uplevel info exists docStr]} {
        upvar docStr  docs
        puts "$docs"
        puts ""
    }
    return 9999
  }  
  if {[catch {array set aArgs $aIn(-args)} err]} {
    set res -1
    log -tag error -msg "Unexpected error, input parameter list issue. $err\n$errorInfo"
  }
  
  foreach para $m_key_l {
      if {[info exists aArgs(-$para)] == 0 || [string trim [string toupper $aArgs(-$para)]] == "DONTCARE"} {
        if {$para == "device_id"} {
          log -tag info -msg "device_id = 0"
          set cmd [list uplevel 1 set device_id 0]
        } else {
          log -tag error -msg "Mandatory parameter $para is not provided"
          set res -1
          set cmd "uplevel 1 set $para unknown"
        }
      } else {
        set cmd [list uplevel 1 set $para \{$aArgs(-$para)\}]
      }    
      if {[catch $cmd err]} {
        log -tag error -msg "Failed to execute command {$cmd}. $err"
        set res -1
      }
  }

  if {([info exists gwenv(DETECT_UNKNOWN_PARAM)] && $gwenv(DETECT_UNKNOWN_PARAM)) 
      && [string toupper $v_key_l] ne "DONTCARE"} {
    #Check unknown input parameters (excluding in optional/mandatory list)
    set legal_key_l "out print_res device_id dev_id"  
    set legal_key_l "$legal_key_l $m_key_l $v_key_l"
    set input_args [array names aArgs]
    foreach arg $input_args {
      set iarg [string trimleft $arg "-"]
      if {[lsearch $legal_key_l $iarg] < 0 } {
        log -tag warning -msg "Unknown input argument: {... $arg $aArgs($arg)}"
      } 
    }
  }

  log -tag itfend
  return $res
}
proc ::gw::helper_convert_ipv4_addr_dot2hex {args} {
  array set aIn $args 
  set res 0
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  set aOut(-hex) unknown  
  set aOut(-ipv4_addr_l) unknown
  
  set ipv4 $aIn(-ipv4_addr)
  set ipv4_addr_l [split $ipv4 "."]
  
  set hex 0
  foreach v $ipv4_addr_l {
    set hex [expr ($hex << 8) + $v]
  }
  set aOut(-ipv4_addr_hex) [format "0x%08x" $hex]
  set aOut(-ipv4_addr_l) $ipv4_addr_l
  #parray aOut
  return $res
}
proc ::gw::helper_result_check {-exp_res exp_res -act_res act_res} {
  set res 0
    set exp_res [string toupper $exp_res]
    if {$exp_res == "DONTCARE"} {
        return $act_res
    }
    if { (($exp_res == "TEST_OK" || $exp_res == 0) && $act_res) ||  
      (($exp_res == "TEST_NOK" || $exp_res) && $act_res == 0)} {
        log -tag error -msg "Actual result {$actual_res} is not same as expected $exp_res"
    set res -1
    }
  return $res
}
proc ::gw::helper_probe_struct_members {args} {
  #can only support flat struct now, meas all members are normal types
  set ifnm helper_probe_struct_members
  log -tag itfbgn -msg $args
  
  set aIn(-exclude_list) ""
  array set aIn $args
  set sn $aIn(-struct)
  set exclude_l [string trim $aIn(-exclude_list)]
  set members ""
  set match_str ${sn}_get_
  set cmd_l [info commands ${match_str}*]
  if {[llength $cmd_l] == 0 } {
    log -tag warning -msg "No member probed for struct $sn by { info commands }"
  } else {
    set start [string length $match_str]
    foreach cmd $cmd_l {
      set mem_name [string range $cmd $start end] 
      if {[llength $exclude_l] > 0 && [lsearch $exclude_l $mem_name] >=0 } {continue}
      lappend members $mem_name     
    }
  } 
  log -tag itfend -msg "Found [llength $members] members: $members"
  return $members 
}
proc ::gw::helper_ca_ip_address_entry_parse {args} {
  set res 0
  set ifnm helper_ca_ip_address_entry_parse
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  array set aIn $args
  set pip $aIn(-ref)
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  set aOut(-afi) unknown
  set aOut(-addr_len) unknown
  set aOut(-ip_addr) unknown
   
  set afi [ca_ip_address_get_afi $pip]
  set addr_len [ca_ip_address_get_addr_len $pip]
  set pl3ip [ca_ip_address_get_ip_addr $pip]
  if {$afi == 0 } {
    #ipv4              
    set ipv4_addr [format %x [ca_l3_ip_addr_get_ipv4_addr $pl3ip]]
    helper_convert_ipv4_addr_hex2dot -ipv4_addr_hex $ipv4_addr -out aTmp
    set aOut(-ip_addr) $aTmp(-ipv4_addr)
  } else {
     set ipv6_addr_l ""
    for {set i 0 } {$i <=3 } {incr i  } {
         set ipv6_addr [ca_l3_ip_addr_get_ipv6_addr $pl3ip $i]
      #set ent [ca_uint32_get $ipv6_addr]
      set ent $ipv6_addr
    
      #set rr [format %08x $ent]
      #puts "---- $ent --- $rr"
      set ent1 [format %04x [expr $ent & 0x0000ffff]]
      set ent0 [format %04x [expr ($ent >> 16) & 0x0000ffff]]
      #puts "xxxx $ent0 $ent1"
      lappend ipv6_addr_l $ent0 $ent1
    }
    set aOut(-ip_addr) [join $ipv6_addr_l :]
  }
  set aOut(-addr_len) $addr_len  
  set aOut(-afi) $afi
  set aOut(-ip_addr) $aOut(-ip_addr)/$addr_len
  log -tag itfend    
  return $res
}
proc ::gw::helper_ca_vlan_key_entry_set {args} {
  set ifnm helper_ca_vlan_key_entry_set
  set res 0
  log -tag itfbgn -msg $args
  helper_ca_vlan_action_params_declare 
  #From litt -> big, must keep sequence here same as ca_vlan_key_type_t(the input parameter key_type)
  set type_name_l {outer_pbits inner_pbits outer_tpid inner_tpid outer_dei inner_dei outer_vid inner_vid} 
  #set type_name_l {inner_vid outer_vid inner_dei outer_dei inner_tpid outer_tpid inner_pbits outer_pbits}
  set prefix "sel_"
  array set aIn $args
  set pkey $aIn(-pkey)
  array set aKey ""
  if {$res == 0} {
    foreach var $v_key_entry_l {
      if {[info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        set cmd "ca_vlan_key_entry_set_$var $pkey $aIn(-$var)"
        set aKey(-${prefix}$var) 1
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {break}
      } 
    }
  }   
  
  #handle input specific key mask
  set ptype [ca_vlan_key_entry_get_key_type $pkey]    
  if {$res == 0 && 
      [info exists aIn(-key_type)] && 
      [string compare [string tolower $aIn(-key_type)] "dontcare"]} {
    set type $aIn(-key_type)
    set type_bit_l ""
    for {set i 0 } {$i < 8} {incr i} {
        set key [lindex $type_name_l $i]
        set bit [expr ($type >> $i) & 0x1]
        set aKey(-${prefix}$key) $bit
    }
  }
  #set per bit with input sel_* value. Higher priority than key_type
  if {$res == 0 } {
    foreach key $type_name_l {
      if {[info exists aIn(-${prefix}$key)] && [string tolower $aIn(-${prefix}$key)] ne "dontcare"} {
        set aKey(-${prefix}$key) [expr $aIn(-${prefix}$key) & 0x1]
      }
    }
  }
  if {$res == 0 } {
    foreach key $type_name_l {
      if {[info exists aKey(-${prefix}$key)]} {
        set cmd "ca_vlan_key_type_set_$key $ptype $aKey(-${prefix}$key)"
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {break}
      }
    }
  }  
  log -tag itfend
  return $res 
}
proc ::gw::helper_ca_vlan_action_entry_set {args} {
  set ifnm helper_ca_vlan_action_entry_set
  set res 0
  log -tag itfbgn -msg $args
  helper_ca_vlan_action_params_declare 
  set aIn(-new_inner_pri) 0xffffffff
  set aIn(-new_outer_pri) 0xffffffff
  set aIn(-new_inner_tpid_index) 0xffffffff  
  set aIn(-new_outer_tpid_index) 0xffffffff  
  array set aIn $args
  set paction $aIn(-paction)  
  if {$res == 0} {
    foreach var $v_action_l {
      if {[info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        set val $aIn(-$var)
        if {$var eq "inner_vlan_cmd" || $var eq "outer_vlan_cmd"} {
          helper_h2s -table CA_VLAN_TAG_ACTION_T -source $val -out aH
          set val $aH(-target)
        } elseif {$var eq "new_inner_pri_src" || $var eq "new_outer_pri_src" } {
          helper_h2s -table CA_VLAN_TAG_PRIORITY_SOURCE_T -source $val -out aH
          set val $aH(-target)
        } elseif {$var eq "new_inner_tpid_src" || $var eq "new_outer_tpid_src"} {
          helper_h2s -table CA_VLAN_TPID_SOURCE_T -source $val -out aH
          set val $aH(-target)          
        } elseif {$var eq "new_inner_vlan_src" || $var eq "new_outer_vlan_src"} {
          helper_h2s -table CA_VLAN_NEW_VLAN_SOURCE_T -source $val -out aH
          set val $aH(-target)          
        }
        set cmd "ca_vlan_action_set_$var $paction $val"
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {break}
      } 
    }
  }
  log -tag itfend
  return $res   
}
proc ::gw::helper_ca_vlan_key_entry_get {args} {
  set ifnm helper_ca_vlan_key_entry_get
  set res 0
  log -tag itfbgn -msg $args
  helper_ca_vlan_action_params_declare
  set type_name_l {outer_pbits inner_pbits outer_tpid inner_tpid outer_dei inner_dei outer_vid inner_vid}   
  set v_key_l "key_type  $v_key_entry_l $v_action_l"  
  set prefix "sel_"
  array set aIn $args
  set pkey $aIn(-pkey)
  upvar $aIn(-out) aOut
  foreach key $v_key_entry_l {
    set aOut(-$key)  "unknown"
  }
  foreach key $type_name_l {
    set aOut(-${prefix}$key) "unknown"
  }
 
  if {$res == 0} {
    foreach key $v_key_entry_l {
        set aOut(-$key) [ca_vlan_key_entry_get_$key $pkey]
    }
  }   
  if {$res == 0 } {
    set ptype [ca_vlan_key_entry_get_key_type $pkey]  
    set key_type 0
    for {set i 0 } {$i < [llength $type_name_l]} {incr i } {
      set key [lindex $type_name_l $i]
      set aOut(-${prefix}$key) [ ca_vlan_key_type_get_$key $ptype]
      set key_type [expr $key_type + ($aOut(-${prefix}$key) << $i)]
      #puts "$aOut(-${prefix}$key) -> key_type=$key_type"
    }
    set aOut(-key_type) $key_type  
  }
  
  log -tag itfend
  return $res 
}
proc ::gw::helper_ca_vlan_action_params_declare {} {
  set v_key_type_l  {outer_pbits inner_pbits outer_tpid inner_tpid outer_dei inner_dei outer_vid inner_vid} 
  uplevel 1  [list set prev_key_type key_type]
  uplevel 1 [list set v_key_type_l  $v_key_type_l ] 
  uplevel 1 [list set v_key_entry_l {inner_vid outer_vid inner_pbits outer_pbits  inner_tpid outer_tpid inner_dei outer_dei}]
  uplevel 1 [list  set v_action_l {inner_vlan_cmd new_inner_vlan new_inner_vlan_src new_inner_pri_src 
               new_inner_pri new_inner_tpid_src new_inner_tpid_index
               outer_vlan_cmd new_outer_vlan_src new_outer_vlan
               new_outer_pri_src new_outer_pri new_outer_tpid_src
               new_outer_tpid_index flow_id}]
  set prefix "sel_"
  set tl ""
  foreach key $v_key_type_l {
    lappend tl ${prefix}$key
  }      
  uplevel 1 [list set v_key_type_sel_l  $tl]   
  #set v_key_l "key_type  $v_key_entry_l $v_action_l"               
}

proc ::gw::helper_sys_cfg_get {args} {
    set ifnm helper_sys_cfg_get
    set res 0
    log -tag itfbgn -ifnm $ifnm -msg "$args"
    set m_key_l {}
    set v_key_l {print_res}
    set res [helper_m_args_check -args $args -m_key_l $m_key_l]
    if {$res} {return $res}
    set aIn(-print_res) 0
    array set aIn $args
    if {[info exists aIn(-out)] == 0} {
      set aIn(-out) aOut
    }
    set print_res $aIn(-print_res)
    upvar $aIn(-out) aOut
    catch {array unset aOut} err
    array set aOut ""
    helper_output_init aOut [list wan_ports lan_ports lan_port_cnt node_name aarch asic_name pon_mode pon_mac_mode oam_mode]
    set aOut(-is_100m_lan)   false
    set aOut(-l3_lan_ports)  0xa0019
    set aOut(-l3_wan_ports)  0xa0007
    # get node name, lan port ports, and wan ports
    if {[catch {exec uname -n} node_name]} {
        log -tag error -msg "Failed to run {exec uname -n}. $node_name"
        set res 1
    } else {
        set aOut(-node_name) $node_name
        if {[string first "g3hgu-eng" $node_name] >= 0 } {
            set aOut(-wan_ports)  0x10007
            set aOut(-lan_ports) [list 0x30000 0x30001 0x30002 0x30003]
            set aOut(-lan_port_cnt) 4
            set aOut(-aarch)  G3HGU
            set aOut(-asic_name) hgu  ;#ca-network-engine/aal-gen1/get_asic_name
        } elseif {[string first "g3-eng" $node_name] >= 0} {
            set aOut(-wan_ports)  0x30007
            set aOut(-lan_ports) [list 0x30000 0x30001 0x30002 0x30003]
            set aOut(-lan_port_cnt) 4  
            set aOut(-aarch) G3   
            set aOut(-asic_name) g3      
        }  elseif {[string first "venus-eng" $node_name] >= 0 } {
            set aOut(-wan_ports)  0x30007
            set aOut(-lan_ports) [list 0x30000 0x30001 0x30002 0x30003 0x30006]
            set aOut(-lan_port_cnt) 5  
            set aOut(-aarch) VENUS   ;#venus-fpga:tbd
            set aOut(-asic_name) venus
        } elseif {[string first "g3-fpga" $node_name] >= 0 } {
            set aOut(-wan_ports)  0x30007
            set aOut(-lan_ports) [list 0x30000 0x30001 0x30002 0x30003]
            set aOut(-lan_port_cnt) 4
            set aOut(-is_100m_lan)  true  
            set aOut(-aarch) G3_FPGA       
            set aOut(-asic_name) g3   
        } elseif {[string first "g3lite" $node_name] >= 0 } {
            set aOut(-wan_ports)  0x30007
            set aOut(-lan_ports) [list 0x30000 0x30001 0x30002 0x30003]
            set aOut(-lan_port_cnt) 4
            set aOut(-is_100m_lan)  true  
            set aOut(-aarch) G3LITE   
            set aOut(-asic_name) g3lite       
        } elseif  {[string first "saturn-sfu-eng" $node_name] >= 0 } {
            set aOut(-wan_ports)  0x20007
            set aOut(-lan_ports) [list 0x30003 0x30004]
            set aOut(-lan_port_cnt) 2     
            set aOut(-aarch) SATURN_SFU       
            set aOut(-asic_name) saturn
        }  elseif  {[string first "saturn-sfpplus-eng" $node_name] >= 0 } {
            set aOut(-wan_ports)  0x10007
            set aOut(-lan_ports) [list 0x30006]
            set aOut(-lan_port_cnt) 1    
            set aOut(-aarch) SATURN_SFP_PLUS     
            set aOut(-asic_name) sfpplus   
        }  else {
            log -tag error -msg "Unknown system type $node_name"
            set res 1
        }
    }
    
    #Get pon and pon mac mode
    set res  [wca_scfg_read  -scfg_id PON_MAC_MODE -len 1 -out aScfg -print_res 0]
    if {$res ne 0} {
        log -tag warning -msg "Failed to get PON MODE startup config"
        set aOut(-pon_mac_mode) unknown
    } else {
        set mode $aScfg(-data)    
        log -tag info -msg "PON MAC value in scfg is $mode"       
        if {$mode <= 2 || $mode == 8} {
            set aOut(-pon_mode) EPON
        } elseif {$mode > 2 && $mode < 6} {
            set aOut(-pon_mode) GPON
        } elseif {$mode == 7 } {
            set aOut(-pon_mode) ETHERNET
        } 
        # VENUS EPON/GPON, uplink port=0x20007
        #if {$aOut(-aarch) == "VENUS" } {
            if {$aOut(-pon_mode) == "EPON" } {
                set aOut(-wan_ports) 0x20007
            } elseif {$aOut(-pon_mode) == "GPON" } {
                set aOut(-wan_ports) 0x10007
            }
        #}
        
        if {$mode == 0 } {
           set aOut(-pon_mac_mode) EPON_1G
        } elseif {$mode == 1} {
            set aOut(-pon_mac_mode) EPON_D10G            
        } elseif {$mode == 2} {
            set aOut(-pon_mac_mode) EPON_BI10G            
        } elseif {$mode == 3} {
            set aOut(-pon_mac_mode) GPON           
        } elseif {$mode == 4} {
             set aOut(-pon_mac_mode) XGPON1           
        } elseif {$mode == 5} {
             set aOut(-pon_mac_mode) XGSPON            
        } elseif {$mode == 6} {
            set aOut(-pon_mac_mode) XGPON2            
        } elseif {$mode == 8 } {
            set aOut(-pon_mac_mode) TURBO_EPON
        }
    }
    
    #oam mode    
    set res  [wca_scfg_read  -scfg_id OAM_MODE -len 1 -out aScfg -print_res 0]
    if {$res ne 0} {
        log -tag warning -msg "Failed to get OAM MODE scfg value"
        set aOut(-oam_mode) unknown
    } else {
        set mode $aScfg(-data)    
        log -tag info -msg "EXT OAM MODE value in scfg is $mode" 
        if {$mode == 1 } {
            set aOut(-oam_mode) DPOE
        } elseif {$mode == 2 } {
            set aOut(-oam_mode) KT
        } else {
            #should be 0, and treat other value as CTC too
            set aOut(-oam_mode) CTC
        }
    }        
 
    #Hardcode values , refer to ca_plat/inc/ca_type.h
    #set aOut(-ca_port_id_cpu0) 16 ;
    #set aOut(-ca_port_id_cpu7) 23 ;  
    #set aOut(-ca_port_id_l3_wan) 24 ;#0x18
    #set aOut(-ca_port_id_l3_lan) 25 ;#0x19
    #set aOut(-ca_port_id_deepq0) 0
    #set aOut(-ca_port_id_deepq1) 1
    #set aOut(-ca_port_id_deepq2) 2
    #set aOut(-ca_port_id_deepq3) 3    
    #set aOut(-ca_port_id_deepq4) 4
    
    #customer bit
    set res [wca_scfg_read  -scfg_id CFG_ID_CUSTOMER_BIT -len 4 -reversed 1 -prepend_rtn_data_0x 0 -join_str "" -out aScfg -print_res 0]
    if {$res == 0 } {
        set aOut(-customer_bit) 0x$aScfg(-data)
    }
    if {$print_res} {
        helper_parray aOut 
    }
    log -tag itfend
    return $res
}

proc ::gw::helper_tables_cleanup {args} {
  set ifnm helper_tables_cleanup
  set docStr "
  Usage: 
      $ifnm \[-device_id <device_id>\] \[-e <tab list>\]
  Optional Parameters:
      -e: a list specifies which tables not to be cleared
  Tables to cleanup:
      l2_mcast_member 
      l3_route 
      l2_addr 
      l2_mac_filter 
      ipsec_sa 
      l2_vlan
      l3_intf
      l3_nexthop
      l3_mcast_group 
      l3_mcast_member 
      flow 
      nat_entry 
      classifier_rule  
      tunnel 
      l2_mcast_group 
      l2_vlan_ingress_action  
      l2_vlan_egress_action 
      us_rate_manager"
  set res 0
  set reserr 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  #set m_key_l {device_id }
  set v_key_l {device_id targets}
  set res [helper_m_args_check -args $args ]
  if {$res} {
    return $res
  }
  set device_id 0
  set aIn(-e)  ""
  if {[catch {array set aIn $args} err]} {
    set res 1
    log -tag error -msg "Failed to parse input value. $err"
    return $res
  }
  set excluding $aIn(-e)
  
  set ports "0x30000 0x30001 0x30002 0x30003"
  set product "unknown"
  set res [helper_sys_cfg_get -out aSysCfg]
  if {$res eq 0 }  {
    set product $aSysCfg(-node_name)
    set ports " $aSysCfg(-lan_ports) $aSysCfg(-wan_ports)"
  } else {
    if {[info exists aSysCfg(-node_name)]} {
      set product $aSysCfg(-node_name)
    }
    if {[info exists aSysCfg(-lan_ports)]  && ($aSysCfg(-lan_ports) ne "unknown")} {
      set ports $aSysCfg(-lan_ports)
    }
    if {[info exists aSysCfg(-wan_ports)]  && ($aSysCfg(-wan_ports) ne "unknown")} {
      set ports "$ports $aSysCfg(-wan_ports)"
    } else {
      lappend ports 0x10007 0x20007 0x30007
    }
  } 
  log -tag debug -msg "product: $product. ports: $ports"  
  
  if {[lsearch $excluding l2_mcast_member] == -1}  {
    log -tag info -msg "Invoke wca_l2_mcast_member_delete_all"
    set res [wca_l2_mcast_member_delete_all -device_id $device_id ]
    if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_l2_mcast_member_delete_all"}
  }

  if {[lsearch $excluding l2_addr] == -1}  {  
    log -tag info -msg "Invoke wca_l2_addr_delete_all with flag 0~3 respectively"
    foreach flag {2 0 1 3} { 
      set res [wca_l2_addr_delete_all -device_id $device_id -flag $flag]
      if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_l2_addr_delete_all with flag $fag"}
    }
  }
  if {[lsearch $excluding l2_mac_filter] == -1}  {  
    log -tag info -msg "Invoke wca_l2_mac_filter_delete_all"
    set res [wca_l2_mac_filter_delete_all -device_id $device_id]
    if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_l2_mac_filter_delete_all"}
  }
  if {[lsearch $excluding l2_vlan] == -1}  {     
    log -tag info -msg "Invoke wca_l2_vlan_delete_all"
    set res [wca_l2_vlan_delete_all -device_id $device_id]
    if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_l2_vlan_delete_all"}
  } 

  if {[lsearch $excluding classifier_rule] == -1}  {   
    log -tag info -msg "Invoke wca_classifier_rule_delete_all"
    set res [wca_classifier_rule_delete_all -device_id $device_id]
    if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_classifier_rule_delete_all"}
  }
  if {[lsearch $excluding l2_mcast_group] == -1}  {     
    log -tag info -msg "Invoke wca_l2_mcast_group_delete_all"
    set res [wca_l2_mcast_group_delete_all -device_id $device_id]
    if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_l2_mcast_group_delete_all"}
  }  
  if {[lsearch $excluding flow] == -1}  {  
    if  {[string first "saturn-sfu" $product] < 0 } {
      log -tag warning -msg "product is not saturn, flow is not supported. ignore flow table"
    } else {
      log -tag info -msg "Invoke wca_flow_delete_all"
      set res [wca_flow_delete_all -device_id $device_id]
      if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_flow_delete_all"}
    }
  }
  if {[lsearch $excluding l2_vlan_ingress_action] == -1}  {     
    log -tag info -msg "Invoke wca_l2_vlan_ingress_action_delete_all"
    foreach port $ports {
      log -tag info -msg "Delete all l2_vlan_ingress_action entries on port $port"
      set res [wca_l2_vlan_ingress_action_delete_all -device_id $device_id -port_id $port]
      if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_l2_vlan_ingress_action_delete_all on port $port"}
    }
  }
  if {[lsearch $excluding l2_vlan_egress_action] == -1}  {     
    log -tag info -msg "Invoke wca_l2_vlan_egress_action_delete_all"
    foreach port $ports {
      log -tag info -msg "Delete all l2_vlan_egress_action entries on port $port"
      set res [wca_l2_vlan_egress_action_delete_all -device_id $device_id -port_id $port]
      if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_l2_vlan_egress_action_delete_all on port $port"}
    }
  }
  set res [wca_mcast_config_get -out aMc -print_res 0]
  if {$res} {
    set reserr 1;log -tag error -msg "Failed to invoke wca_mcast_config_get"
  } else {
    if {$aMc(-mode) ne 2} {
      log -tag warning -msg "Current MCAST mode is not IP. l3_mcast_group_delete_all is not supported"
    }
    if {[lsearch $excluding l3_mcast_group] == -1}  {      
      log -tag info -msg "Invoke wca_l3_mcast_group_delete_all"    
      set res [wca_l3_mcast_group_delete_all -device_id $device_id]
      if {$res == 7} {
        log -tag warning -msg "wca_l3_mcast_group_delete_all returns 7 - NOT SUPPORTED"
      } elseif {$res } {     
        set reserr 1;
        log -tag error -msg "Failed to invoke wca_l3_mcast_group_delete_all, returns $res"
      }
    }  
    if {[lsearch $excluding l3_mcast_member] == -1}  {        
      log -tag info -msg "Invoke wca_l3_mcast_member_delete_all"
      set res [wca_l3_mcast_member_delete_all -device_id $device_id]
      if {$res == 7} {
        log -tag warning -msg "wca_l3_mcast_member_delete_all returns 7 - NOT SUPPORTED"
      } elseif {$res} {
        set reserr 1;
        log -tag error -msg "Failed to invoke wca_l3_mcast_member_delete_all, returns $res"
      }
    }
  }
  
  #  tables only support on G3, G3HGU
  if {($product eq "g3-eng") || ($product eq "g3hgu-eng") || ($product eq "venus-eng")} {
    if {[lsearch $excluding tunnel] == -1}  {    
      log -tag info -msg "Invoke wca_tunnel_delete_all"
      set res [wca_tunnel_delete_all -device_id $device_id]
      if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_tunnel_delete_all"}
    }
    if {[lsearch $excluding l3_route] == -1}  {  
      log -tag info -msg "Invoke wca_l3_route_delete_all"
      set res [wca_l3_route_delete_all -device_id $device_id]
      if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_l3_route_delete_all"}
    }  
    if {[lsearch $excluding l3_intf] == -1}  {      
      log -tag info -msg "Invoke wca_l3_intf_delete_all"
      set res [wca_l3_intf_delete_all -device_id $device_id]
      if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_l3_intf_delete_all"}
    } 
    if {[lsearch $excluding l3_nexthop] == -1}  {      
      log -tag info -msg "Invoke wca_l3_nexthop_delete_all"
      set res [wca_l3_nexthop_delete_all -device_id $device_id]
      if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_l3_nexthop_delete_all"}
    }  
    if {[lsearch $excluding nat_entry] == -1}  {   
      log -tag info -msg "Invoke wca_nat_entry_delete_all"
      set res [wca_nat_entry_delete_all -device_id $device_id]
      if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_nat_entry_delete_all"}
    }
    if {[lsearch $excluding ipsec_sa] == -1}  {   
      log -tag info -msg "Invoke wca_ipsec_sa_delete_all"
      set res [wca_ipsec_sa_delete_all -device_id $device_id]
      if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_ipsec_sa_delete_all"}
    }  
    if {[lsearch $excluding us_rate_manager] == -1}  {     
      log -tag info -msg "Invoke wca_us_rate_manager_delete_all"
      set res [wca_us_rate_manager_delete_all -device_id $device_id]
      if {$res} {set reserr 1;log -tag error -msg "Failed to invoke wca_us_rate_manager_delete_all"}
    }          
  }
  log -tag itfend    
  return $reserr
}
proc ::gw::helper_ca_boolean_create {{value 0}} {
  return [ca_uint32_create $value]
}
proc ::gw::helper_ca_boolean_get {handle} {
  return [ca_uint32_get $handle]
}
proc ::gw::helper_data_free {handles} {
  foreach handle $handles {
    catch {ca_data_free $handle} err
  }
}
#---------------------------------------------------
#END OF HELPER MODULE
#--------------------------------------------------

#-----------------------------------------------------
#  WRAPs for CA Procedures
#-----------------------------------------------------

#---------------------------------
# Section: Device management
#--------------------------------
proc ::gw::wca_reset {args} {
  set docStr "mode: 0 - cold(default), 1 - warm, 2 - datapath"
  set ifnm wca_reset
  set res 0
  log -tag itfbgn -msg "$args"
  set m_key_l {device_id }
  set v_key_l {mode}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-mode) 0  
  array set aIn $args
  set mode $aIn(-mode)
  set cmd "ca_reset $device_id  $mode"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  helper_print_status_enum_name $res;return $res
}
proc ::gw::wca_info_get {args} {
  #model names: CORTINA-(G3 HGU G3Lite FPPLUS SFU VENUS)
  set ifnm wca_info_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id}
  set o_key_l {hardware_model_name hardware_revision hardware_date api_version}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $o_key_l
  set aTmp(-err) ""
  set cmd {ca_info_create}
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  set handle $aTmp(-err)

  if {$res == 0 } {
    set cmd [list ca_info_get $device_id $handle ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  if {$res == 0 } {
    set nm_l ""
    for {set i 0} {$i < 16} {incr i} {
      set val [ca_info_get_hardware_model_name $handle $i]
      if {$val eq 0 } {break}
      lappend nm_l [format %c $val]
    }
    set aOut(-hardware_model_name) [join $nm_l ""]
    set nm_l ""
    for {set i 0 } {$i < 4} {incr i} {
      lappend nm_l [ca_info_get_hardware_revision $handle $i]
    }
    set aOut(-hardware_revision) [join $nm_l .]
    set mm [ca_info_get_hardware_date $handle 0]
    set dd [ca_info_get_hardware_date $handle 1]
    set yyyy "[ca_info_get_hardware_date $handle 2][ca_info_get_hardware_date $handle 3]"
    set aOut(-hardware_date) $mm/$dd/$yyyy
    set aOut(-api_version) "[ca_info_get_api_version $handle 0].[ca_info_get_api_version $handle 1]"
  }
  helper_parray aOut
  catch {ca_data_free $handle} err
  log -tag itfend
  helper_print_status_enum_name $res;return $res
}

proc ::gw::wca_scfg_read {args} {
  set ifnm wca_scfg_read
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set docStr "Usage: 
    ca-iros-> $ifnm -scfg_id CFG_ID_PON_MAC_MODE ?-len 1? ?-prepend_rtn_data_0x 1? ?-join_str joinStr?  -out aRtv
    ca-iros-> parray aRtv
    
    Parameters: 
    * len: data length in bytes(uint8). Default is 1
    * type: first column in startup configuration file, such as CHAR-ARRAY.
    * prepend_rtn_data_0x: 1/0 whether or not add prefix '0x' to each hex value. Default is 1
    * join_str: string/chars used to connect every hex data. Default is one space char. For example
              with parameters '-len 6 -prepend_rtn_data_0x 0 -join_str :' to return MAC address
              as aa:bb:cc:dd:ee:ff
    * convert_to_char: convert every byte to ASCII char
    * reversed: 0 or 1. read in reversed sequence
    return data as element '-data' in specified array by -out paramter, or default array 
    aOut. To use the returned data, just refer it as \$aOut(-data) for example."
  set m_key_l {device_id scfg_id}
  set v_key_l {len prepend_rtn_data_0x print_res out}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-len) 1
  set aIn(-print_res) 1
  set aIn(-prepend_rtn_data_0x) 1
  set aIn(-convert_to_char)   0
  set aIn(-join_str) " "
  set aIn(-reversed)  0
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  data
  set len $aIn(-len)
  if {$aIn(-prepend_rtn_data_0x) } {
    set rtnDataFmt "0x%02x"
  } else {
    set rtnDataFmt "%02x"
  }
  set joinStr $aIn(-join_str)
  if {[string toupper $joinStr] eq  "DONTCARE" } {
    set joinStr " "
  }   
  if {[string first CFG_ID_  $scfg_id] < 0} {
    set scfg_id CFG_ID_$scfg_id
  }
  set convert2Char $aIn(-convert_to_char)
  set reversed $aIn(-reversed)
 
  set aTmp(-err) ""
  set pbuf ""
  set cmd [list ca_uint8_array_create 0 $len]
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  if {$res eq 0 } { 
    set pbuf $aTmp(-err)
  }
  if {$res == 0 } {
    set cmd [list ca_scfg_read $device_id $scfg_id $len $pbuf ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  if {$res == 0 } {
     set hex_l ""
     if {$reversed} {
       for {set i [expr $len -1] } {$i >= 0}  {incr i -1} {
         set byte [format "$rtnDataFmt" [ca_uint8_array_get $pbuf $i] ]   
         if {$convert2Char} {
           set byte [format %c $byte]
         } 
         lappend hex_l $byte
       }      
     } else {
       for {set i 0} {$i < $len}  {incr i} {
         set byte    [format "$rtnDataFmt" [ca_uint8_array_get $pbuf $i] ]   
         if {$convert2Char} {
           set byte [format %c $byte]
         } 
         lappend hex_l $byte
       } 
     }
     set aOut(-data) [join $hex_l $joinStr]
  } else {
    log -tag error -msg "Assure correct vlaue of parameter 'len' is provided"
  }
  catch {ca_data_free $pbuf} err  
  if {$aIn(-print_res)} { 
    helper_parray aOut
    puts "$scfg_id = $aOut(-data)"
  }
  log -tag itfend
  return $res  
}
#---------------------------------
# Section: Event Handling
#---------------------------------
#---------------------------------
# Section: Port Management - Common Configuration
#---------------------------------
proc ::gw::wca_port_enable_set {args} {
  set ifnm wca_port_enable_set
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set res 0
  set m_key_l {device_id port_id enable }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_port_enable_set $device_id $port_id $enable"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]

  log -tag itfend
  return $res
}
proc ::gw::wca_port_enable_get {args} {
  set ifnm wca_port_enable_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut enable
  
  set aTmp(-err) ""
  set pt [helper_ca_boolean_create]
  set cmd [list ca_port_enable_get $device_id $port_id $pt]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  if {$res == 0 } {
    set aOut(-enable) [helper_ca_boolean_get $pt]
  }
  helper_data_free $pt
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_max_frame_size_set {args} {
  set ifnm wca_port_max_frame_size_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id}
  set v_key_l {size include_tag}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set res [wca_port_max_frame_size_get -port_id $port_id -out aTmp -print_res 0]
  if {$res} {
    return $res
  }
  array set aIn $args
  foreach key $v_key_l {
    if {[info exists aIn(-$key)] == 0 || [string toupper $aIn(-$key)] == "DONTCARE" } {
      set aIn(-$key) $aTmp(-$key)
    }
  }
 
  set size $aIn(-size)
  set include_tag $aIn(-include_tag)
  set cmd "ca_port_max_frame_size_set $device_id $port_id $size $include_tag"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_port_max_frame_size_get {args} {
  set ifnm wca_port_max_frame_size_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut  [list size include_tag]
  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -check_return_value 0 -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -check_return_value 0 -out aTmp]
  }
  if {$res == 0 } {
    set ptag $aTmp(-err)  
    set cmd [list ca_port_max_frame_size_get $device_id $port_id $pt $ptag]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set cmd "ca_uint32_get $pt"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-size) $aTmp(-err)
    set aOut(-include_tag) [ca_uint32_get $ptag]
  }
  
  catch {ca_data_free $pt} err  
  if {$aIn(-print_res)} {
    helper_parray aOut
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_port_ipg_set {args} {
  set ifnm wca_port_ipg_set
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id ipg }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_port_ipg_set $device_id $port_id $ipg"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]

  log -tag itfend
  return $res
}
proc ::gw::wca_port_ipg_get {args} {
  set ifnm wca_port_ipg_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut  ipg
  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_port_ipg_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set cmd "ca_uint32_get $pt"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-ipg) $aTmp(-err)
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_pvid_vlan_set {args} {
  set ifnm wca_port_pvid_vlan_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id vid }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_port_pvid_vlan_set $device_id $port_id $vid"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_port_pvid_vlan_get {args} {
  set ifnm wca_port_pvid_vlan_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut vid
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_port_pvid_vlan_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-vid) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_pvid_dot1p_set {args} {
  set ifnm wca_port_pvid_dot1p_set  
  set docStr "Usage: $ifnm -port_id <port_id> -priority <priority>"
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id priority}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_port_pvid_dot1p_set $device_id $port_id $priority"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_port_pvid_dot1p_get {args} {
  set ifnm wca_port_pvid_dot1p_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut  priority
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_port_pvid_dot1p_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-priority) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_pvid_tpid_set {args} {
  set ifnm wca_port_pvid_tpid_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id tpid_index }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_port_pvid_tpid_set $device_id $port_id $tpid_index"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_port_pvid_tpid_get {args} {
  set ifnm wca_port_pvid_tpid_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut  tpid_index
  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_port_pvid_tpid_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-tpid_index) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_untagged_priority_set {args} {
  set ifnm wca_port_untagged_priority_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id priority }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_port_untagged_priority_set $device_id $port_id $priority"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_port_untagged_priority_get {args} {
  set ifnm wca_port_untagged_priority_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut priority
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_port_untagged_priority_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-priority) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_stp_state_set {args} {
  set ifnm wca_port_stp_state_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id stp_state }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_h2s -table CA_PORT_STP_STATE_ENUM -source [string toupper $stp_state] -out aTmp
  set stp_state $aTmp(-target)
  set cmd "ca_port_stp_state_set $device_id $port_id $stp_state"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]  
  log -tag itfend
  return $res
}
proc ::gw::wca_port_stp_state_get {args} {
  set ifnm wca_port_stp_state_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut [list stp_state stp_state_v]
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_port_stp_state_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set stp_state [ca_uint32_get $pt]
    helper_s2h -table CA_PORT_STP_STATE_ENUM -source $stp_state -out aTmp
    set aOut(-stp_state) $stp_state
    set aOut(-stp_state_v) $aTmp(-target)
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_isolation_set {args} {
  set ifnm wca_port_isolation_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id port_count dst_ports}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set dst_ports [lsort [split $aIn(-dst_ports) ,]]
  if {$port_count > [llength $dst_ports]} {
    set port_count [llength $dst_ports]
  }
  array set aTmp ""
  set cmd "ca_uint32_array_create 0 32"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  if {$res == 0 } {
    set h_ports $aTmp(-err)    
    for {set i 0 } {$i < $port_count} {incr i} {
      set port [lindex $dst_ports $i]
      set cmd [list ca_uint32_array_set $h_ports $port $i]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 0]
      if {$res} {break}
    }
  }
  if {$res == 0 } {
    set cmd [list ca_port_isolation_set $device_id $port_id ${port_count} ${h_ports}]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $h_ports} 
  log -tag itfend
  return $res
}
proc ::gw::wca_port_isolation_get {args} {
  set ifnm wca_port_isolation_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut [list port_count dst_ports]
  
  set aTmp(-err) ""
  set cmd {ca_uint32_array_create 0 32}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set hp $aTmp(-err)
    set aTmp(-err) ""
    set cmd {ca_uint8_create 0 }
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_port_isolation_get $device_id $port_id $pt $hp]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0} { 
    set aOut(-port_count) [ca_uint8_get $pt]
    set dst_ports ""
    for {set i 0 } {$i < $aOut(-port_count)} {incr i } {
      lappend dst_ports [format 0x%05x [ca_uint32_array_get $hp $i]]
    }
    set aOut(-dst_ports) [join [lsort $dst_ports] ,]
  }    
  catch {ca_data_free $dp } err
  catch {ca_data_free $hp} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_discard_control_set {args} {
  set ifnm wca_port_discard_control_set
  set res 0
  set aIn(-data_init) 1
  log -tag itfbgn -msg $args
  set aIn(-data_init) 0
  set m_key_l {device_id port_id }
  set v_key_l {drop_untag drop_priority_tag drop_multiple_tag drop_single_tag}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  array set aIn $args

  set data_init $aIn(-data_init)
  set aTmp(-err) ""
  set cmd {ca_port_discard_control_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set handle $aTmp(-err)
    if {$data_init == 1} {
      set cmd [list ca_port_discard_control_get $device_id $port_id $handle ]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp] 
    }
  }
  if {$res == 0 } {
    set res [helper_struct_config -key_l $v_key_l -ref $handle -struct ca_port_discard_control -arg_arr aIn]
  }
  if {$res == 0} {
    set cmd [list ca_port_discard_control_set $device_id $port_id $handle]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $handle} err
  log -tag itfend
  return $res
}
proc ::gw::wca_port_discard_control_get {args} {
  set ifnm wca_port_discard_control_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id}
  set v_out_key_l {drop_untag drop_priority_tag drop_multiple_tag drop_single_tag}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut  $v_out_key_l
  set cmd {ca_port_discard_control_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set hp $aTmp(-err)
    set cmd [list ca_port_discard_control_get $device_id $port_id $hp ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp] 
  }
  if {$res == 0 } {
      foreach var $v_out_key_l {
        set aOut(-$var) [ca_port_discard_control_get_$var $hp]
      }
  }  
  catch {ca_data_free $hp}  err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_station_move_set {args} {
  set ifnm wca_port_station_move_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id enable }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_port_station_move_set $device_id $port_id $enable"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_port_station_move_get {args} {
  set ifnm wca_port_station_move_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
   helper_output_declare aIn
  helper_output_init aOut  enable
  set aTmp(-err) ""
  set pt [helper_ca_boolean_create]
  set cmd [list ca_port_station_move_get $device_id $port_id $pt]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  
  if {$res == 0 } {
    set aOut(-enable) [helper_ca_boolean_get $pt]
  }
  helper_data_free $pt
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_loopback_set {args} {
  set ifnm wca_port_loopback_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id loopback }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_h2s -table CA_PORT_LOOPBACK_MODE_T -source $loopback -out aTmp
  set loopback $aTmp(-target)
  set cmd "ca_port_loopback_set $device_id $port_id $loopback"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]

  log -tag itfend
  return $res
}
proc ::gw::wca_port_loopback_get {args} {
  set ifnm wca_port_loopback_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  loopback
  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_port_loopback_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-loopback) [ca_uint32_get $pt]
    helper_s2h -table CA_PORT_LOOPBACK_MODE_T -source $aOut(-loopback) -out aTmp
    set aOut(-loopback_v) $aTmp(-target)
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_link_aggregation_group_create {args} {
  set docStr "member_ports format: 1,2,3,..."
  set ifnm wca_port_link_aggregation_group_create
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id lag_group_id member_port_count member_ports }
  helper_clz_key_mask_members_declare
  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l [lsort $vClz(in_param_l)] ]
  if {$res} { return $res  }  
 
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  [list lag_group_id]  
  if {[string first , $member_ports] >=0 } {set member_ports [lsort [split $member_ports ,]]}
  if {$member_port_count > [llength $member_ports]} {
    set member_port_count [llength $member_ports]
  }
  set cmd "ca_uint32_array_create 0 $member_port_count"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set h_ports $aTmp(-err)
    for {set i 0 } {$i < $member_port_count} {incr i} {
      set cmd "ca_uint32_array_set $h_ports [lindex $member_ports $i] $i"
      set res [helper_cmd_exec -cmd $cmd ]
      if {$res} {
        break
      }
    } 
  }
  if {$res == 0 } {
    set cmd "ca_classifier_key_mask_create"
    set res  [helper_cmd_exec -cmd $cmd -out aTmp ]
  }
  if {$res == 0 } {
    set p_key_mask $aTmp(-err)
    set res [helper_clz_key_mask_set -p_key_mask $p_key_mask -kargs [array get aIn]]
  }
  #debug:
  ca_classifier_key_mask_dump $p_key_mask  
  if {$res == 0} {   
    set cmd [list ca_port_link_aggregation_group_create $device_id $lag_group_id $member_port_count $h_ports $p_key_mask]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $h_ports} err
  catch {ca_data_free $p_key_mask} err
  set aOut(-lag_group_id) $lag_group_id
  helper_parray aOut
  log -tag itfend
  return $res
}

proc ::gw::wca_port_link_aggregation_group_get {args} {
  variable LINK_AGGREGATION_GROUP_MEMBER_PORTS_MAX_COUNT
  set ifnm wca_port_link_aggregation_group_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id lag_group_id}
  set v_key_l {out}
  helper_clz_key_mask_members_declare
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
 
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut  "$vClz(in_param_l) member_ports member_port_count"
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint8_create 0 } -out aTmp]
  set hc $aTmp(-err)
  set aTmp(-err) ""
  if {$res == 0 } {
    set cmd [list ca_uint32_array_create 0 $LINK_AGGREGATION_GROUP_MEMBER_PORTS_MAX_COUNT]
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
    set hp $aTmp(-err)
  }
  if {$res == 0 } {
    set cmd "ca_classifier_key_mask_create"
    set res  [helper_cmd_exec -cmd $cmd -out aTmp ]
  }
  if {$res == 0 } {
    set p_key_mask $aTmp(-err)   
  }  
  if {$res == 0 } {    
    set cmd [list ca_port_link_aggregation_group_get $device_id $lag_group_id $hc $hp $p_key_mask]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-member_port_count) [ca_uint8_get $hc]
    set member_ports ""
    for {set i 0 } {$i < $aOut(-member_port_count)} {incr i } {
      lappend member_ports [format 0x%05x [ca_uint32_array_get $hp $i]]
    }
    set aOut(-member_ports) [join [lsort $member_ports] ,]      
  }  
  if {$res == 0 } {
      array set aKeyMask {}
      set res [helper_classifier_key_mask_parse -p_key_mask $p_key_mask -out aKeyMask]
      array set aOut [array get aKeyMask]
  }
  #debug:
  ca_classifier_key_mask_dump $p_key_mask  
  catch {ca_data_free $hc} err
  catch {ca_data_free $hp} err
  catch {ca_data_free $p_key_mask} err   
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_link_aggregation_group_delete {args} {
  set ifnm wca_port_link_aggregation_group_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id lag_group_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_port_link_aggregation_group_delete $device_id $lag_group_id ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_port_link_aggregation_group_update {args} {
  variable LINK_AGGREGATION_GROUP_MEMBER_PORTS_MAX_COUNT
  set docStr "member_ports format: 1,2,3,..."
  set ifnm wca_port_link_aggregation_group_update
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id lag_group_id }

  helper_clz_key_mask_members_declare
  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l [lsort $vClz(in_param_l)] ]
  if {$res} { return $res  }  
  set aIn(-member_port_count) "dontcare"
  set aIn(-member_ports) "dontcare"
  array set aIn $args
  set member_ports $aIn(-member_ports)
  set member_port_count $aIn(-member_port_count)
  
  set res [helper_cmd_exec -cmd {ca_uint8_create 0 } -out aTmp]
  if {$res == 0 } {
    set hc $aTmp(-err)
  }
  if {$res == 0 } {
    set cmd "ca_uint32_array_create 0 $LINK_AGGREGATION_GROUP_MEMBER_PORTS_MAX_COUNT"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
 
  if {$res == 0 } {
    set h_ports $aTmp(-err)  
    set cmd "ca_classifier_key_mask_create"
    set res  [helper_cmd_exec -cmd $cmd -out aTmp ]
  }
  if {$res == 0 } {     
    set p_key_mask $aTmp(-err)  
    #Get system current configuration and use it to initialize fields at first  
    set cmd [list ca_port_link_aggregation_group_get $device_id $lag_group_id $hc $h_ports $p_key_mask]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }  
  if {$res == 0 } {
      set res [helper_clz_key_mask_set -p_key_mask $p_key_mask -kargs [array get aIn]]
  }
  #debug:
  ca_classifier_key_mask_dump $p_key_mask  
  if {$res == 0} {   
    set cmd [list ca_port_link_aggregation_group_update $device_id $lag_group_id $member_port_count $h_ports $p_key_mask]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $hc} err
  catch {ca_data_free $h_ports} err
  catch {ca_data_free $p_key_mask} err
  log -tag itfend
  return $res
}
proc ::gw::wca_port_encryption_mode_set {args} {
  set ifnm wca_port_encryption_mode_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id direction mode}
  set v_key_l {}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_h2s -table CA_PORT_DIRECTION_ENCRYPTION_T -source $direction -out aTmp
  set direction $aTmp(-target)
  helper_h2s -table CA_PORT_ENCRYPTION_MODE_T -source $mode -out aTmp
  set mode $aTmp(-target)
  if {$res == 0 } {
    set cmd [list ca_port_encryption_mode_set $device_id $port_id $direction $mode]
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_port_encryption_mode_get {args} {
  set ifnm wca_port_encryption_mode_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id}
  set v_key_l {out}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut  [list direction direction_v mode mode_v]
  set aTmp(-err) ""  
  
  set cmd "ca_uint32_create 0 "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set d $aTmp(-err)
    set cmd "ca_uint32_create 0"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set m $aTmp(-err)
  }
  if {$res == 0 } {
    set cmd [list ca_port_encryption_mode_get $device_id $port_id $d $m]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-direction) [ca_uint32_get $d]
    set aOut(-mode) [ca_uint32_get $m]
    helper_s2h -table CA_PORT_DIRECTION_ENCRYPTION_T -source $aOut(-direction) -out aTmp
    set aOut(-direction_v) $aTmp(-target)
    helper_s2h -table CA_PORT_ENCRYPTION_MODE_T -source $aOut(-mode) -out aTmp
    set aOut(-mode_v) $aTmp(-target)    
  }
  catch {ca_data_free $d} err
  catch {ca_data_free $m} err
  log -tag itfend
  helper_parray aOut
  return $res
}
proc ::gw::wca_port_encryption_enable_set {args} {
  set docStr " direction: RX(0),TX(1),BI(2)"
  set ifnm wca_port_encryption_enable_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id direction enable}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1 
  array set aIn $args 
  set data_init $aIn(-data_init)
  helper_h2s -table CA_PORT_DIRECTION_ENCRYPTION_T -source [string toupper $direction] -out aTmp
  set direction $aTmp(-target)
  if {$res == 0 } {
    set cmd [list ca_port_encryption_enable_set $device_id $port_id $direction $enable]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  log -tag itfend
  return $res
}
proc ::gw::wca_port_encryption_enable_get {args} {
  set ifnm wca_port_encryption_enable_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut "direction direction_v enable"  
  set aTmp(-err) ""  
  
  set cmd "ca_uint32_create 0 "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set d $aTmp(-err)
    set cmd "ca_uint32_create 0"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set m $aTmp(-err)
  }
  if {$res == 0 } {
    set cmd [list ca_port_encryption_enable_get $device_id $port_id $d $m]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-direction) [ca_uint32_get $d]
    set aOut(-enable) [ca_uint32_get $m]
    helper_s2h -table CA_PORT_DIRECTION_ENCRYPTION_T -source $aOut(-direction) -out aTmp
    set aOut(-direction_v) $aTmp(-target) 
  }
  catch {ca_data_free $d} err
  catch {ca_data_free $m} err
  log -tag itfend
  helper_parray aOut
  return $res
}
proc ::gw::wca_port_mirror_enable_set {args} {
  set ifnm wca_port_mirror_enable_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  }
  set v_okey_l {enable source_port destination_port mirror_port }
  set v_msk_l {mirror_source_port mirror_dest_port}
  set v_key_l $v_okey_l
  foreach msk $v_msk_l {lappend v_key_l mask_$msk}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  foreach key $v_msk_l {
    set aMsk(-$key) "DONTCARE"
  }
  array set aIn $args 
  set data_init $aIn(-data_init)
  set cmd "ca_port_mirror_config_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pm $aTmp(-err)
    set mm  [ ca_port_mirror_config_get_mask $pm] ;#ca_port_mirror_mask_t
  } 
  if {$res == 0 && $data_init == 1} {
    #get configure from system at first
    set cmd [list ca_port_mirror_enable_get $device_id $pm]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
    #ca_port_mirror_config_dump $pm
    
#    foreach msk $v_msk_l {
#      set aMsk(-$msk) [ca_port_mirror_mask_get_$msk $mm] ;#save mask values in system
#    }
  }
  if {$res == 0} {
    foreach var $v_okey_l {
      if {[info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        set cmd "ca_port_mirror_config_set_$var $pm $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {break}
        if {$var == "source_port"} {set aMsk(-mirror_source_port) 1} ;#set mask to 1 when value is set
        if {$var == "destination_port"} {set aMsk(-mirror_dest_port) 1}        
      } 
    }
  }
  foreach msk $v_msk_l {
    if {$res} {break}
    if {[info exists aIn(-mask_$msk)] && 
      [string compare [string tolower $aIn(-mask_$msk)] "dontcare"]} {
      set aMsk(-$msk) $aIn(-mask_$msk);#if mask is specified, use it then
    }
    if {[string compare [string tolower $aMsk(-$msk)] "dontcare"]} {
      set cmd "ca_port_mirror_mask_set_$msk $mm $aMsk(-$msk)"
      set res [helper_cmd_exec -cmd $cmd]
    }
  } 
  if {$res == 0 } {
    set cmd [list ca_port_mirror_enable_set $device_id $pm]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  catch {ca_data_free $pm} err
  log -tag itfend
  return $res
}
proc ::gw::wca_port_mirror_enable_get {args} {
  set ifnm wca_port_mirror_enable_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  }
  set v_okey_l {enable source_port destination_port mirror_port}
  set v_msk_l {mirror_source_port mirror_dest_port}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut "$v_okey_l $v_msk_l"  
  set cmd "ca_port_mirror_config_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pm $aTmp(-err)
    set mm  [ ca_port_mirror_config_get_mask $pm] ;#ca_port_mirror_mask_t
  }  
  if {$res == 0 } {
    #get configure from system at first
    set cmd [list ca_port_mirror_enable_get $device_id $pm]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }    
  if {$res == 0 } {
    foreach var $v_okey_l {
      set aOut(-$var) [ca_port_mirror_config_get_$var $pm]      
      if {[string first "_port" $var]>=0} {
        set aOut(-$var) [format "0x%05x" $aOut(-$var)]
      }
    }
    foreach var $v_msk_l {
      set aOut(-mask_$var) [ca_port_mirror_mask_get_$var $mm]
      if {$aOut(-mask_$var)} {
        set aOut(-mask_${var}_v) "ENABLE"
      } else {
        set aOut(-mask_${var}_v) "DISABLE"
      } 
    }
  }
  catch {ca_data_free $pm} err
  log -tag itfend
  helper_parray aOut
  return $res
}
#---------------------------------
#Section: Port Management - CPU Port Management
#---------------------------------
proc ::gw::wca_special_packet_get {args} {
  set ifnm wca_special_packet_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id source_port special_packet_type}
  set o_key_l {enable dest_port priority}
  set o_cls_handle_key_l {flow_id gem_index llid_cos_index}
  set o_spo_key_l { forward_original enable_sa_learning do_not_drop }
  set o_spo_mask_key_l {user_defined_type forward_original enable_sa_learning do_not_drop action_handle}
  set o_udsp_key_l {ether_type mac_da mac_da_mask}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args 
  helper_h2s -table CA_PKT_TYPE_T -source $special_packet_type -out aH
  set special_packet_type $aH(-target)  
  helper_output_declare aIn
  helper_output_init aOut
  foreach key "$o_key_l $o_cls_handle_key_l action_handle " {
    set aOut(-$key) unknown
  }
  foreach key "$o_spo_mask_key_l" {
    set aOut(-mask_$key) unknown
  }
  foreach key $o_udsp_key_l {
    set aOut(-udsp_$key) unknown
    set aOut(-udsp_mask_$key) unknown
  }
  set print_res $aIn(-print_res)
  set aTmp(-err) ""
  set p_enable [helper_ca_boolean_create]
  set cmd {ca_uint8_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set p_priority $aTmp(-err) 
  }
  if {$res == 0 } {
    set cmd {ca_uint32_create 0 }
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }  
  if {$res == 0 } {
    set p_dest_port $aTmp(-err)  
    set cmd "ca_special_packet_option_create"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {    
    set p_options $aTmp(-err)
    set cmd [list ca_special_packet_get $device_id $source_port $special_packet_type $p_enable $p_dest_port $p_priority $p_options]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    #ca_classifier_handle_dump $action_handle
    set aOut(-dest_port) [format 0x%0x [ca_uint32_get $p_dest_port]]
    set aOut(-enable)  [helper_ca_boolean_get $p_enable]
    set aOut(-priority)  [ca_uint8_get $p_priority]
    
    #parse options
    set p_cls_handle [ca_special_packet_option_get_action_handle $p_options]
    set p_udsp [ca_special_packet_option_get_user_defined_special_packet $p_options]
    set p_udsp_mask [ca_user_defined_special_packet_get_mask $p_udsp]    
    set p_spo_mask [ca_special_packet_option_get_mask $p_options]
    foreach var $o_cls_handle_key_l {
      set aOut(-$var) [ca_classifier_handle_get_$var $p_cls_handle]
    }
    set aOut(-action_handle) $aOut(-flow_id)
    foreach key $o_spo_key_l {
      set aOut(-$key) [ca_special_packet_option_get_$key $p_options]
    }
    foreach var $o_spo_mask_key_l {
      set aOut(-mask_$var) [ca_special_packet_option_mask_get_$var $p_spo_mask]
    }
    foreach var $o_udsp_key_l {
      if {$var == "mac_da" || $var == "mac_da_mask" } {
        set mac_l ""
        set p_mac [ca_user_defined_special_packet_get_$var $p_udsp]
        for {set i 0 } {$i < 6} {incr i} {
          lappend mac_l [format %02x [ca_mac_addr_get $p_mac $i] ]
        }
        set aOut(-udsp_$var) [join $mac_l :]
      } else {      
        set aOut(-udsp_$var) [ca_user_defined_special_packet_get_$var $p_udsp]
      }
      set aOut(-udsp_mask_$var) [ca_user_defined_special_packet_mask_get_$var $p_udsp_mask]
    }
  }
  helper_s2h -table CA_PKT_TYPE_T -source $special_packet_type -out aH
  set aOut(-special_packet_type) $special_packet_type
  set aOut(-special_packet_type_v) $aH(-target)  
  set aOut(-source_port) [format 0x%05x $source_port]
  helper_data_free [list $p_enable $p_dest_port $p_priority $p_options] 
  if {$print_res} {
    helper_parray aOut
  }
  log -tag itfend
  helper_print_status_enum_name $res
  return $res
}
proc ::gw::wca_special_packet_set {args} {
  variable gwenv
  variable CA_PKT_TYPE_T
  set docStr "
    Usage : wca_special_packet_set  -source_port 0x30000 -enable 1 -priority 1 -special_packet_type bpdu -action_handle 0xf08 -mask_action_handle 1 -udsp_ether_type 0x9100 -udsp_mask_eth_type 1
    * prefix 'udsp' (User Defined Special Packet) : represents member of ca_special_packet_option_t.user_defined_special_packet(struct ca_user_defined_special_packet_t)
    * prefix 'udsp_mask' : means member of user defined packet mask, this value can be set automatically
    * special_packet_type : can be one of:  [regsub  -all {,} [array names CA_PKT_TYPE_T] {=}]
    * flow_id/gem_index/llid_cos_index/action_handle : currently to give value by any one is ok
  "
  set ifnm wca_special_packet_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id source_port special_packet_type }
  set o_key_l {enable dest_port priority}
  set o_cls_handle_key_l {flow_id gem_index llid_cos_index}
  set o_spo_key_l { forward_original enable_sa_learning do_not_drop}
  set o_spo_mask_key_l {user_defined_type forward_original enable_sa_learning do_not_drop action_handle}
  set o_udsp_key_l {ether_type mac_da mac_da_mask}
  #set o_udsp_mask_key_l {ether_type mac_da mac_da_mask} 
  set v_key_l "$o_key_l $o_cls_handle_key_l action_handle $o_spo_key_l"
  foreach key $o_spo_mask_key_l {
    lappend v_key_l mask_$key
  }
  foreach key $o_udsp_key_l {
    lappend v_key_l udsp_$key
    lappend v_key_l udsp_mask_$key
  }
  set aIn(-data_init) 1  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_h2s -table CA_PKT_TYPE_T -source $special_packet_type -out aH
  set special_packet_type $aH(-target)
  
  set p_enable [helper_ca_boolean_create]
  set cmd {ca_uint8_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set p_priority $aTmp(-err) 
  }
  if {$res == 0 } {
    set cmd {ca_uint32_create 0 }
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }  
  if {$res == 0 } {
    set p_dest_port $aTmp(-err)  
    set cmd "ca_special_packet_option_create"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {    
    set p_options $aTmp(-err)
    set p_cls_handle [ca_special_packet_option_get_action_handle $p_options]
    set p_udsp [ca_special_packet_option_get_user_defined_special_packet $p_options]
    set p_udsp_mask [ca_user_defined_special_packet_get_mask $p_udsp]    
    set p_spo_mask [ca_special_packet_option_get_mask $p_options]    
    #Init struct by system values
    set cmd [list ca_special_packet_get $device_id $source_port $special_packet_type $p_enable $p_dest_port $p_priority $p_options]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    foreach key  $o_key_l {
      if {[info exists aIn(-$key)] == 0 || [string tolower $aIn(-$key)] == "dontcare"} {
        if {$key == "dest_port"} {
          set aIn(-$key) [ca_uint32_get $p_dest_port]
        } elseif {$key eq "enable" } {
          set aIn(-$key) [helper_ca_boolean_get $p_enable]
        } else {
          set aIn(-$key) [ca_uint8_get [set p_$key]]
        }
        log -tag info -msg "Use system value $aIn(-$key) for $key"
      }
      set $key $aIn(-$key)
    }
  }  
  #----------------
  #1. action_handle
  #-----------------
  set mask_flag 0
  if {$res == 0 } {
    #configure key_handle
    foreach key $o_cls_handle_key_l {
      if {[info exists aIn(-$key)] == 0 || [string tolower $aIn(-$key)] == "dontcare"} {continue}
      set cmd "ca_classifier_handle_set_$key $p_cls_handle $aIn(-$key)"
      set res [helper_cmd_exec -cmd $cmd ]
      if {$res} {
        log -tag error -msg "Failed to exec $cmd"   
        break
      }
      set mask_flag 1
    }    
  }
  if {$res == 0 && $mask_flag == 0 
    && ([info exists aIn(-action_handle)] && [string tolower $aIn(-action_handle)] ne "dontcare") } {
    #If none of action_handle field specified, then try to use legacy parameter action_handle
    set cmd "ca_classifier_handle_set_flow_id $p_cls_handle $aIn(-action_handle)"
    set res [helper_cmd_exec -cmd $cmd ]
    set mask_flag 1
    if {$res} {
      log -tag error -msg "Failed to exec $cmd"   
    }
  }
  if {$res == 0 } {
    if {$mask_flag && 
        ( ([info exists aIn(-action_handle)] == 0) || ([string tolower $aIn(-action_handle)] eq "dontcare") ) } {
      set aIn(-mask_action_handle) 1
    }
  }
  #-------------------
  #2. normal option field
  #--------------------
  if {$res == 0 } {
    foreach key $o_spo_key_l {
      if {[info exists aIn(-$key)] == 0 || [string tolower $aIn(-$key)] == "dontcare"} {
          continue
      }
      set cmd "ca_special_packet_option_set_$key $p_options $aIn(-$key)"
      set res [helper_cmd_exec -cmd $cmd ]
      if {$res} {
        log -tag error -msg "Failed to exec $cmd"
        break
      } 
      if {[info exists aIn(-mask_$key)] == 0 || [string tolower $aIn(-mask_$key)] == "dontcare"} {
        set aIn(-mask_$key) 1
      }
    }
  }
  #--------------------------
  #3. user defined special packet
  #--------------------------
  set mask_flag 0
  if {$res == 0 } {
    foreach key $o_udsp_key_l {
      set ikey udsp_$key
      set ikey_mask udsp_mask_$key
      if {[info exists aIn(-$ikey)] == 0 || [string tolower $aIn(-$ikey)] == "dontcare"} {continue}       
      if {[info exists aIn(-$ikey_mask)] == 0 || [string tolower $aIn(-$ikey_mask)] == "dontcare"} {
        set aIn(-$ikey_mask) 1
      }      
      if {$key == "mac_da" || $key == "mac_da_mask" } {
        set mac_l  ""
        foreach ent [split $aIn(-$ikey) :] {
          lappend mac_l 0x$ent
        }
        set p_mac [ca_user_defined_special_packet_get_$key $p_udsp]
        set cmd "ca_mac_addr_set $p_mac $mac_l"
      } else {      
        set cmd "ca_user_defined_special_packet_set_$key $p_udsp $aIn(-$ikey)"
      }
      set res [helper_cmd_exec -cmd $cmd]
      if {$res} {
        log -tag error -msg "Failed to exec $cmd"
        break
      }  
      set mask_flag 1   
    }
  }
  if {$res == 0 } {
    foreach key $o_udsp_key_l {
      set ikey udsp_mask_$key
      if {[info exists aIn(-$ikey)] == 0 || [string tolower $aIn(-$ikey)] == "dontcare"} {continue}       
      set cmd "ca_user_defined_special_packet_mask_set_$key $p_udsp_mask $aIn(-$ikey)"
      set res [helper_cmd_exec -cmd $cmd]
      if {$res} {
        log -tag error -msg "Failed to exec $cmd"
        break
      }  
      set mask_flag 1
    }
  }  
  if {$mask_flag && 
    ([info exists aIn(-mask_user_defined_type)] == 0 || 
      [string tolower $aIn(-mask_user_defined_type)] == "dontcare") } {
    set aIn(-mask_user_defined_type) 1
  }
  #-----------------------
  #4. options mask
  #-----------------------
  if {$res == 0 } {
    foreach key $o_spo_mask_key_l {
      set ikey  mask_$key
      if {[info exists aIn(-$ikey)] == 0 || [string tolower $aIn(-$ikey)] == "dontcare"} {
        continue
      }
      set cmd "ca_special_packet_option_mask_set_$key $p_spo_mask $aIn(-$ikey)"
      set res [helper_cmd_exec -cmd $cmd ]
      if {$res} {
        log -tag error -msg "Failed to exec $cmd"
        break
      }      
    }
  }  
  if { $gwenv(REPORT_LEVEL) < 2} {
    parray aIn
    puts "----options dump---"
    ca_special_packet_option_dump $p_options
  }
  if {$res == 0 } {
    set cmd "ca_special_packet_set $device_id $source_port $special_packet_type $enable $dest_port $priority $p_options"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  helper_data_free [list $p_enable $p_dest_port $p_priority $p_options]
  log -tag itfend -res $res
  helper_print_status_enum_name $res  
  return $res
}
#---------------------------------
#Section: Port Management - Ethernet Port Management
#---------------------------------
proc ::gw::wca_eth_port_pause_set {args} {
  set ifnm wca_eth_port_pause_set
  set res 0
  log -tag itfbgn -msg "$args"
  set m_key_l {device_id port_id  }
  set v_key_l {pfc_enable pause_rx pause_tx}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1 
  foreach key $v_key_l {
    set aIn(-$key) dontcare
  }
  array set aIn $args  
  set res [wca_eth_port_pause_get -device_id $device_id -port_id $port_id -out aTmp -print_res 0]
  if {$res == 0 } {
    foreach key $v_key_l {
      set $key $aTmp(-$key)
    }
  }
  foreach key $v_key_l {
    if {[string tolower $aIn(-$key)] == "dontcare"} {continue}
    set $key $aIn(-$key)
  } 
  set cmd "ca_eth_port_pause_set $device_id $port_id $pfc_enable $pause_rx $pause_tx"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_pause_get {args} {
  set ifnm wca_eth_port_pause_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut [list pfc_enable pause_tx pause_rx]
  
  foreach var [list rx tx pfc] {
    set $var [helper_ca_boolean_create]
  }
  if {$res == 0 } {    
    set cmd [list ca_eth_port_pause_get $device_id $port_id $pfc $rx $tx]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-pfc_enable) [helper_ca_boolean_get $pfc]
    set aOut(-pause_tx) [helper_ca_boolean_get $tx]
    set aOut(-pause_rx) [helper_ca_boolean_get $rx]
  } 
  helper_data_free [list $rx $tx $pfc]
  if {$aIn(-print_res)} { helper_parray aOut}
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_pause_quanta_set {args} {
  set ifnm wca_eth_port_pause_quanta_set
  set res 0
  log -tag itfbgn -msg "$args"
  set m_key_l {device_id port_id  }
  set v_key_l {pause_quanta}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1  
  foreach key $v_key_l {
    set aIn(-$key) dontcare
  }
  array set aIn $args  
  #Initialize value as system current value
  set res [wca_eth_port_pause_quanta_get -device_id $device_id -port_id $port_id -out aTmp]
  if {$res == 0 } {
    foreach key $v_key_l {
      set $key $aTmp(-$key)
    }
  }
  #Replace with input value if it is available
  foreach key $v_key_l {
    if {[string tolower $aIn(-$key)] == "dontcare"} {continue}
    set $key $aIn(-$key)
  } 
  set cmd "ca_eth_port_pause_quanta_set $device_id $port_id $pause_quanta"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_pause_quanta_get {args} {
  set ifnm wca_eth_port_pause_quanta_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut [list pause_quanta]
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint16_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
  }  
  if {$res == 0 } {    
    set cmd [list ca_eth_port_pause_quanta_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-pause_quanta) [ca_uint16_get $pt]
  }  
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_link_scan_set {args} {
  set ifnm wca_eth_port_link_scan_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id enable }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  set cmd "ca_eth_port_link_scan_set $device_id $port_id $enable"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_link_scan_get {args} {
  set ifnm wca_eth_port_link_scan_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut [list enable]    
  set pt [helper_ca_boolean_create]
  set cmd [list ca_eth_port_link_scan_get $device_id $port_id $pt]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  
  if {$res == 0 } {
    set aOut(-enable) [helper_ca_boolean_get $pt]
  }
  helper_data_free $pt
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_link_status_get {args} {
  set ifnm wca_eth_port_link_status_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut [list status]   
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_eth_port_link_status_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-status) [ca_uint32_get $pt]
    helper_s2h -table CA_ETH_PORT_LINK_STATUS_T -source $aOut(-status) -out aTmp
    set aOut(-status_v) $aTmp(-target)
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_stats_get {args} {
  set docStr "
    read_clear: default is 1."
  set ifnm wca_eth_port_stat_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id }
  set v_key_l {read_clear}
  set s_l   [helper_probe_struct_members -struct ca_eth_port_stats]
  set p_s_l [helper_probe_struct_members -struct ca_phy_stats]
  set idx [lsearch $s_l phy_stats ]
  if {$idx >=0 } { set s_l "[lrange $s_l 0 $idx-1] [lrange $s_l $idx+1 end]"}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-read_clear) 1
  array set aIn $args    
  foreach key {read_clear} {
    set $key $aIn(-$key)
    if {[string toupper $aIn(-$key)] == "DONTCARE"} {
      set $key 1
    }  
  }  
  helper_output_declare aIn
  helper_output_init aOut "$s_l $p_s_l"     
  set aOut(-read_clear) $read_clear
  set aTmp(-err) ""
  set cmd "ca_eth_port_stats_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_eth_port_stats_get $device_id $port_id $read_clear $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    foreach var $s_l {
      set aOut(-$var) [ca_eth_port_stats_get_$var $pt]
    }
    set ppt [ca_eth_port_stats_get_phy_stats $pt]
    foreach var $p_s_l {
      set aOut(-$var) [ca_phy_stats_get_$var $ppt]
    }
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut 
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_autoneg_set {args} {
  set ifnm wca_eth_port_autoneg_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id enable }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  
  set cmd "ca_eth_port_autoneg_set $device_id $port_id $enable"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_autoneg_get {args} {
  set ifnm wca_eth_port_autoneg_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut [list enable]   
  
  set pt [helper_ca_boolean_create]
  set cmd [list ca_eth_port_autoneg_get $device_id $port_id $pt]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  if {$res == 0 } {
    set aOut(-enable) [helper_ca_boolean_get $pt]
  }
  helper_data_free $pt
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_speed_set {args} {
  set docStr "value of speed can be one of:
      INVALID(0),10M(1),100M(2),1G(3),2.5G(4),10G(5),5G(6),AUTO(7)"
  set ifnm wca_eth_port_speed_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id speed }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_h2s -source [string toupper $speed] -table CA_ETH_PORT_SPEED_T -out aTmp
  set speed $aTmp(-target)
  set cmd "ca_eth_port_speed_set $device_id $port_id $speed"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]

  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_speed_get {args} {
  set ifnm wca_eth_port_speed_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  variable CA_ETH_PORT_SPEED_T
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut [list speed speed_v]   
  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_eth_port_speed_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-speed) [ca_uint32_get $pt]
    helper_s2h -source $aOut(-speed) -table CA_ETH_PORT_SPEED_T -out aTmp
    set aOut(-speed_v) $aTmp(-target)
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_duplex_set {args} {
  set docStr "value of duplex can be one of:
      HALF(0),FULL(1), AUTO(2)"
  set ifnm wca_eth_port_duplex_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id duplex }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_h2s -table CA_ETH_PORT_DUPLEX_T -source $duplex -out aTmp
  set duplex $aTmp(-target)
  set cmd "ca_eth_port_duplex_set $device_id $port_id $duplex"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_duplex_get {args} {
  set ifnm wca_eth_port_duplex_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut [list duplex duplex_v]   
  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_eth_port_duplex_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-duplex) [ca_uint32_get $pt]
    helper_s2h -table CA_ETH_PORT_DUPLEX_T -source $aOut(-duplex) -out aTmp
    set aOut(-duplex_v) $aTmp(-target)
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_eee_enable_set {args} {
  set ifnm wca_eth_port_eee_enable_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id enable }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set cmd "ca_eth_port_eee_enable_set $device_id $port_id $enable"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}

proc ::gw::wca_eth_port_eee_enable_get {args} {
  set ifnm wca_eth_port_eee_enable_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut [list enable]   
  
  set pt [helper_ca_boolean_create]
  set cmd [list ca_eth_port_eee_enable_get $device_id $port_id $pt]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  if {$res == 0 } {
    set aOut(-enable) [helper_ca_boolean_get $pt]
  }
  helper_data_free $pt
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_phy_autoneg_set {args} {
  set ifnm wca_eth_port_phy_autoneg_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id enable }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd "ca_eth_port_phy_autoneg_set $device_id $port_id $enable"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_phy_autoneg_get {args} {
  set ifnm wca_eth_port_phy_autoneg_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut [list enable]   
  
  set pt [helper_ca_boolean_create]
  set cmd [list ca_eth_port_phy_autoneg_get $device_id $port_id $pt]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]

  if {$res == 0 } {
    set aOut(-enable) [helper_ca_boolean_get $pt]
  }
  helper_data_free $pt
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_phy_advert_set {args} {
  set ifnm wca_eth_port_phy_advert_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id}
  set v_key_l   [helper_probe_struct_members -struct ca_eth_port_ability]
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  array set aIn $args  
  
  set data_init $aIn(-data_init)
  set aTmp(-err) ""
  set cmd {ca_eth_port_ability_create}
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  if {$res == 0 } {  
    set handle $aTmp(-err)
    if {$data_init == 1 } {
      set cmd [list ca_eth_port_phy_advert_get $device_id $port_id $handle ]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    }
  }  
  if {$res == 0 } {
    foreach var $v_key_l {      
      if {[info exists aIn(-$var)] == 0 || 
        [string compare -nocase $aIn(-$var) "dontcare"] == 0 } {
        continue 
      }
      set cmd "ca_eth_port_ability_set_$var $handle $aIn(-$var)" 
      set res [helper_cmd_exec -cmd $cmd ]
      if {$res} { break}     
    }   
  }
  if {$res == 0 } {
    set cmd [list ca_eth_port_phy_advert_set $device_id $port_id $handle]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $handle} err
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_phy_advert_get {args} {
  set ifnm wca_eth_port_phy_advert_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id}
  set v_o_key_l   [helper_probe_struct_members -struct ca_eth_port_ability]  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aTmp(-err) ""
  set cmd {ca_eth_port_ability_create}
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  set handle $aTmp(-err)

  if {$res == 0 } {
    set cmd [list ca_eth_port_phy_advert_get $device_id $port_id $handle ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  if {$res == 0 } {
     foreach var $v_o_key_l {
        set aOut(-$var) [ca_eth_port_ability_get_$var $handle]
      }           
  }
  helper_parray aOut
  catch {ca_data_free $handle} err
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_phy_advert_remote_get {args} {
  set ifnm wca_eth_port_phy_advert_remote_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id}
  set v_o_key_l   [helper_probe_struct_members -struct ca_eth_port_ability]    
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aTmp(-err) ""
  set cmd {ca_eth_port_ability_create}
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  set handle $aTmp(-err)

  if {$res == 0 } {
    set cmd [list ca_eth_port_phy_advert_remote_get $device_id $port_id $handle ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  if {$res == 0 } {
     foreach var $v_key_l {
        set aOut(-$var) [ca_eth_port_ability_get_$var $handle]
      }           
  }
  helper_parray aOut
  catch {ca_data_free $handle} err
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_phy_speed_set {args} {
  set ifnm wca_eth_port_phy_speed_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id speed }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_h2s -source [string toupper $speed] -table CA_ETH_PORT_SPEED_T -out aTmp
  set speed $aTmp(-target)
  set cmd "ca_eth_port_phy_speed_set $device_id $port_id $speed"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]

  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_phy_speed_get {args} {
  set ifnm wca_eth_port_phy_speed_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  variable CA_ETH_PORT_SPEED_T
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut [list speed speed_v]  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_eth_port_phy_speed_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-speed) [ca_uint32_get $pt]
    array set aTmp ""
    helper_s2h -source $aOut(-speed) -table CA_ETH_PORT_SPEED_T -out aTmp
    set aOut(-speed_v) $aTmp(-target)
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_phy_duplex_set {args} {
  set docStr "duplex value can be one of:
      HALF(0),FULL(1),AUTO(2)"
  set ifnm wca_eth_port_phy_duplex_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id duplex }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_h2s -table CA_ETH_PORT_DUPLEX_T -source $duplex -out aTmp
  set duplex $aTmp(-target)  
  set cmd "ca_eth_port_phy_duplex_set $device_id $port_id $duplex"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_phy_duplex_get {args} {
  set ifnm wca_eth_port_phy_duplex_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  [list duplex duplex_v]  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_eth_port_phy_duplex_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-duplex) [ca_uint32_get $pt]
    helper_s2h -table CA_ETH_PORT_DUPLEX_T -source $aOut(-duplex) -out aTmp
    set aOut(-duplex_v) $aTmp(-target)      
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_phy_mdix_set {args} {
  set docStr "value of mode can be one of:
      MDI(0),MDIX(1),AUTO(2)"
  set ifnm wca_eth_port_phy_mdix_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id mode}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_h2s -table CA_ETH_PORT_MDIX_T -source $mode -out aTmp
  set mode $aTmp(-target)
  set cmd "ca_eth_port_phy_mdix_set $device_id $port_id $mode"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]

  log -tag itfend
  return $res
}
proc ::gw::wca_eth_port_phy_mdix_get {args} {
  set ifnm wca_eth_port_phy_mdix_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  "mode mode_v"  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_eth_port_phy_mdix_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-mode) [ca_uint32_get $pt]
    helper_s2h -table CA_ETH_PORT_MDIX_T -source $aOut(-mode) -out aTmp
    set aOut(-mode_v) $aTmp(-target)
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
#-------------------------------------------
#Section: Port Management - EPON Port Management
#-------------------------------------------
proc ::gw::wca_epon_port_laser_polarity_set {args} {
  set docStr "polarity: ACTIVE_LO(0), ACTIVE_HI(1)"
  set ifnm wca_epon_port_laser_polarity_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tx_polarity rx_polarity}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_h2s -table CA_EPON_PORT_LASER_POLARITY_T -source $tx_polarity -out aH
  set tx_polarity $aH(-target)
  helper_h2s -table CA_EPON_PORT_LASER_POLARITY_T -source $rx_polarity -out aH
  set rx_polarity $aH(-target)  
  set cmd [list ca_epon_port_laser_polarity_set $device_id $port_id $tx_polarity $rx_polarity ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1] 
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_laser_polarity_get {args} {
  set ifnm wca_epon_port_laser_polarity_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  {tx_polarity rx_polarity}
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pTx $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pRx $aTmp(-err)  
  }

  if {$res == 0} {
    set cmd [list ca_epon_port_laser_polarity_get $device_id $port_id $pTx $pRx]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
    if {$res == 0} {
      set aOut(-tx_polarity) [ca_uint32_get $pTx]
      set aOut(-rx_polarity) [ca_uint32_get $pRx] 
    }
  }  
  helper_s2h -table CA_EPON_PORT_LASER_POLARITY_T -source $aOut(-tx_polarity) -out aH
  set aOut(-tx_polarity_v) $aH(-target)
  helper_s2h -table CA_EPON_PORT_LASER_POLARITY_T -source $aOut(-rx_polarity) -out aH
  set aOut(-rx_polarity_v) $aH(-target)  
  foreach var {pTx pRx} {
    catch {ca_data_free [set $var]} err
  }
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_laser_mode_set {args} {
  set docStr "mode: BURST(0), ON(1), OFF(2)"
  set ifnm wca_epon_port_laser_mode_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id mode}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_h2s -table CA_EPON_PORT_LASER_MODE_T -source $mode -out aH
  set mode $aH(-target)
  set cmd [list ca_epon_port_laser_mode_set $device_id $port_id $mode ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_laser_mode_get {args} {
  set ifnm wca_epon_port_laser_mode_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  [list mode mode_v]
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set p $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_epon_port_laser_mode_get $device_id $port_id $p]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
    if {$res == 0} {
      set aOut(-mode) [ca_uint32_get $p]
      helper_s2h -table CA_EPON_PORT_LASER_MODE_T -source $aOut(-mode) -out aH
      set aOut(-mode_v) $aH(-target)
    }
  }    
  catch {ca_data_free $p} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_fec_enable_set {args} {
  set ifnm wca_epon_port_fec_enable_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tx_enable rx_enable}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_epon_port_fec_enable_set $device_id $port_id $tx_enable $rx_enable ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_fec_enable_get {args} {
  set ifnm wca_epon_port_fec_enable_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  {tx_enable rx_enable}
  set pTx [helper_ca_boolean_create]
  set pRx [helper_ca_boolean_create] 
  if {$res == 0} {
    set cmd [list ca_epon_port_fec_enable_get $device_id $port_id $pTx $pRx]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }
  if {$res == 0} {       
    set aOut(-tx_enable) [helper_ca_boolean_get $pTx]
    set aOut(-rx_enable) [helper_ca_boolean_get $pRx] 
  }  
  helper_data_free [list $pTx $pRx]
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_llid_encryption_active_key_index_set {args} {
  set ifnm wca_epon_llid_encryption_active_key_index_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id llid  active_key_index }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  if {$res == 0 } {
    set cmd [list ca_epon_llid_encryption_active_key_index_set $device_id $port_id $llid $active_key_index]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  #helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_llid_encryption_active_key_index_get {args} {
  set ifnm wca_epon_llid_encryption_active_key_index_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id port_id llid}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  {active_key_index}
  if {$res == 0 } {
      set cmd "ca_uint8_create 0"  
      set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  }
  if {$res == 0} {
    set pt $aTmp(-err)
  }
 
  if {$res == 0} {
    set cmd [list ca_epon_llid_encryption_active_key_index_get $device_id $port_id $llid  $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]

  }  
  if {$res == 0} {     
    set aOut(-active_key_index) [ca_uint8_get $pt]
  }  
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_llid_encryption_key_get {args} {
  set ifnm wca_epon_llid_encryption_key_get
  set res 0
  set EPON_PORT_ENCRYPTION_KEY_LENGTH 16
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id llid  key_index}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  {key}
  if {$res == 0 } {
      set cmd "ca_epon_port_encryption_key_create"  
      set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  }
  if {$res == 0} {
    set pt $aTmp(-err)
  }
 
  if {$res == 0} {
    set cmd [list ca_epon_llid_encryption_key_get $device_id $port_id $llid  $key_index $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]

  }    
  if {$res == 0} {
      set key_value_l ""
      for {set i 0 } {$i < $EPON_PORT_ENCRYPTION_KEY_LENGTH} {incr i } {
          lappend key_value_l [ca_epon_port_encryption_key_get_data $pt $i]
      }
      set aOut(-key) [join $key_value_l ,]
  }    
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_llid_encryption_key_set {args} {
  #Format of key:
  # something likes -key {0,1,2* 4,/*2 ,7}
  #  "m * n" means to repeat value "m" by n times
  #  value / means key of this field should be skipped, not to set
  set ifnm wca_epon_llid_encryption_key_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id llid  key_index key}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args

  set aTmp(-err) ""
  set key_l [split $aIn(-key) ","]
  set a_key_l ""
  foreach key $key_l {
      set key [string trim $key]
      if {[string first "*" $key] >= 1} {
          set exp_l [split $key "*"]
          if {[llength $exp_l] == 2} {
              set value [string trim [lindex $exp_l 0]]
              set times [string trim [lindex $exp_l 1]]
              for {set i 0 } {$i < $times} {incr i} {
                  lappend a_key_l $value
              }
          } else {
              set res -1
              log -tag error -msg "data format is wrong in key list: $key"
          }
      } else {
          lappend a_key_l $key
      }
  }
  if {$res == 0 } {
      set cmd "ca_epon_port_encryption_key_create"  
      set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  }
  if {$res == 0} {
    set pt $aTmp(-err)
    set count [llength $a_key_l]
    if {$count > 15} {set count 15}
    for {set i 0 } {$i < $count && $res == 0} {incr i} {
        set value [string trim [lindex $a_key_l $i]]
        if {$value == "/" || $value == ""} {continue}
        set cmd "ca_epon_port_encryption_key_set_data $pt $value $i"
        set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
    }
  } 
  if {$res == 0 } {
    set cmd [list ca_epon_llid_encryption_key_set $device_id $port_id $llid $key_index $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_llid_traffic_enable_set {args} {
  set ifnm wca_epon_llid_traffic_enable_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id llid upstream downstream}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_epon_llid_traffic_enable_set $device_id $port_id $llid $upstream $downstream ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_llid_traffic_enable_get {args} {
  set ifnm wca_epon_llid_traffic_enable_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id llid}
  set v_out_key_l {upstream downstream}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_out_key_l
  set pUS [helper_ca_boolean_create]
  set pDS [helper_ca_boolean_create]
  if {$res == 0} {
    set cmd [list ca_epon_llid_traffic_enable_get $device_id $port_id $llid $pUS $pDS]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }   
  if {$res == 0} {       
    set aOut(-upstream) [helper_ca_boolean_get $pUS]
    set aOut(-downstream) [helper_ca_boolean_get $pDS] 
  }    
  foreach var {pUS pDS} {
    catch {ca_data_free [set $var]} err
  }
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_speed_set {args} {
  set ifnm wca_epon_port_speed_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id speed}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_h2s -table CA_EPON_PORT_SPEED_T -source $speed -out aH
  set speed $aH(-target)
  set cmd [list ca_epon_port_speed_set $device_id $port_id $speed ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_speed_get {args} {
  set ifnm wca_epon_port_speed_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  [list speed speed_v]
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set p $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_epon_port_speed_get $device_id $port_id $p]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }    
  if {$res == 0} {
    set aOut(-speed) [ca_uint32_get $p]
    helper_s2h -table CA_EPON_PORT_SPEED_T -source $aOut(-speed) -out aH
    set aOut(-speed_v) $aH(-target)
  }    
  catch {ca_data_free $p} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_discard_control_set {args} {
  set ifnm wca_epon_port_discard_control_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id }
  set v_key_l {mpcp_crc32_drop mpcp_crc8_drop mpcp_extention_drop}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  array set aIn $args
  set data_init $aIn(-data_init)
  set aTmp(-err) ""
  set cmd {ca_epon_port_discard_control_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set handle $aTmp(-err)
    if {$data_init == 1} {
      set cmd "ca_epon_port_discard_control_get $device_id $port_id $handle"
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    }
  }
  if {$res == 0 } {  
    set res [helper_struct_config -key_l $v_key_l -ref $handle -struct ca_epon_port_discard_control -arg_arr aIn]
  }
  if {$res == 0} {
    set cmd [list ca_epon_port_discard_control_set $device_id $port_id $handle]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }

  catch {ca_data_free $handle} err
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_discard_control_get {args} {
  set ifnm wca_epon_port_discard_control_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set v_o_key_l  [helper_probe_struct_members -struct ca_epon_port_discard_control]
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set cmd {ca_epon_port_discard_control_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pR $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_epon_port_discard_control_get $device_id $port_id $pR]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }  
  if {$res == 0} {
    foreach key $v_o_key_l {
      set aOut(-$key) [ca_epon_port_discard_control_get_$key $pR]
    }
  }  
  catch {ca_data_free $pR} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_status_get {args} {
  set ifnm wca_gpon_port_status_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id}
  set v_o_key_l [helper_probe_struct_members -struct ca_epon_port_status]
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set cmd {ca_epon_port_status_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pR $aTmp(-err)
  } 
  if {$res == 0} {
    set cmd [list ca_epon_port_status_get $device_id $port_id $pR]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }  
  if {$res == 0} {
    foreach key $v_o_key_l {
      set aOut(-$key) [ca_epon_port_status_get_$key $pR]
    }
  }  
  catch {ca_data_free $pR} err
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_epon_port_stats_get {args} {
  set docStr "    read_clear: default value is 1"
  set ifnm wca_epon_port_stats_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id port_id }
  set v_key_l {read_clear}
  if {[llength [info commands ca_epon_port_stat_create]]} {
    set v_o_key_l [helper_probe_struct_members -struct ca_epon_port_stat]   
  } else {
    set v_o_key_l [helper_probe_struct_members -struct ca_epon_port_stats]
  }   
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-read_clear) 1
  array set aIn $args
  foreach key {read_clear} {
    set $key $aIn(-$key)
    if {[string toupper $aIn(-$key)] == "DONTCARE"} {
      set $key 1
    }  
  }  
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aOut(-read_clear) $read_clear    
  set cmd {ca_epon_port_stats_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pR $aTmp(-err)
  } 
  if {$res == 0} {
    set cmd [list ca_epon_port_stats_get $device_id $port_id $read_clear $pR]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }  
  if {$res == 0} {
    foreach key $v_o_key_l {
      set aOut(-$key) [ca_epon_port_stats_get_$key $pR]
    }
  }  
  catch {ca_data_free $pR} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_fec_stats_get {args} {
  set docStr "    read_clear: default value is 1"
  set ifnm wca_epon_port_fec_stats_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id }
  set v_key_l {read_clear}  
  set v_o_key_l [helper_probe_struct_members -struct ca_epon_port_fec_stats]
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-read_clear) 1
  array set aIn $args
  set read_clear $aIn(-read_clear)
  if {[string toupper $read_clear ] == "DONTCARE"} {
    set read_clear 1
  }  
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aOut(-read_clear) $read_clear
  set cmd {ca_epon_port_fec_stats_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pR $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_epon_port_fec_stats_get $device_id $port_id $read_clear $pR]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }  
  if {$res == 0} {
    foreach key $v_o_key_l {
      set aOut(-$key) [ca_epon_port_fec_stats_get_$key $pR]
    }
  }  
  catch {ca_data_free $pR} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_port_link_status_get {args} {
  set ifnm wca_epon_port_link_status_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  {link}
  set pt [helper_ca_boolean_create]
  if {$res == 0} {
    set cmd [list ca_epon_port_link_status_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }    
  if {$res == 0} { 
    set aOut(-link) [helper_ca_boolean_get $pt]
  }    
  helper_data_free $pt
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_registration_set {args} {
  set ifnm wca_epon_mpcp_registration_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id llid enable}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_epon_mpcp_registration_set $device_id $port_id $llid $enable ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_registration_get {args} {
  set ifnm wca_epon_mpcp_registration_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id port_id llid}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  {enable}
  set pt [helper_ca_boolean_create]
  set cmd [list ca_epon_mpcp_registration_get $device_id $port_id $llid $pt]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  if {$res == 0} {
    set aOut(-enable) [helper_ca_boolean_get $pt]
  } 
  helper_data_free $pt
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_pending_grants_set {args} {
  set ifnm wca_epon_mpcp_pending_grants
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id pending_grants}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_epon_mpcp_pending_grants_set $device_id $port_id $pending_grants]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_pending_grants_get {args} {
  set ifnm wca_epon_mpcp_pending_grants_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  {pending_grants}
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set p $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_epon_mpcp_pending_grants_get $device_id $port_id $p]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }  
  if {$res == 0} {
    set aOut(-pending_grants) [ca_uint32_get $p]
  }  
  catch {ca_data_free $p} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_timer_set {args} {
  set docStr "MPCP timer in unit of 0.1ms(0x01f4~0x3fff)"
  set ifnm wca_epon_mpcp_timer_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id mpcp_timer deregistration}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_epon_mpcp_timer_set $device_id $port_id $mpcp_timer $deregistration ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_timer_get {args} {
  set ifnm wca_epon_mpcp_timer_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id port_id}
  set v_o_key_l {mpcp_timer deregistration}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set pDereg [helper_ca_boolean_create]
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pTimer $aTmp(-err)
  } 
  if {$res == 0} {
    set cmd [list ca_epon_mpcp_timer_get $device_id $port_id $pTimer $pDereg]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ] 
  }  
  if {$res == 0} {
    set aOut(-mpcp_timer) [ca_uint32_get $pTimer]
    set aOut(-deregistration) [helper_ca_boolean_get $pDereg] 
  }  
  helper_data_free [list $pTimer $pDereg]
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_gate_timer_set {args} {
  set docStr "MPCP timer in unit of 0.1ms(0x01f4~0x3fff)"
  set ifnm wca_epon_mpcp_gate_timer_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id gate_timer deregistration}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_epon_mpcp_gate_timer_set $device_id $port_id $gate_timer $deregistration ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_gate_timer_get {args} {
  set ifnm wca_epon_mpcp_gate_timer_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set v_o_key_l {gate_timer deregistration}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pTx $aTmp(-err)
    set cmd {ca_uint32_create 0}
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  }
  if {$res == 0} {
    set pRx $aTmp(-err)  
  }
  if {$res == 0} {
    set cmd [list ca_epon_mpcp_gate_timer_get $device_id $port_id $pTx $pRx]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]

  }    
  if {$res == 0} {
    set aOut(-gate_timer) [ca_uint32_get $pTx]
    set aOut(-deregistration) [ca_uint32_get $pRx] 
  }    
  foreach var {pTx pRx} {
    catch {ca_data_free [set $var]} err
  }
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_timestamp_drift_set {args} {
  set docStr "threshold: timestamp drift monitor in unit of TQ(8,16,32,63)"
  set ifnm wca_epon_mpcp_timestamp_drift_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id threshold deregistration}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_epon_mpcp_timestamp_drift_set $device_id $port_id $threshold $deregistration ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_timestamp_drift_get {args} {
  set ifnm wca_epon_mpcp_timestamp_drift_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set v_o_key_l {threshold deregistration}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set pDereg [helper_ca_boolean_create]
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pThreshold $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_epon_mpcp_timestamp_drift_get $device_id $port_id $pThreshold $pDereg]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }       
  if {$res == 0} {
    set aOut(-threshold) [ca_uint32_get $pThreshold]
    set aOut(-deregistration) [helper_ca_boolean_get $pDereg] 
  }
  helper_data_free [list $pThreshold $pDereg]
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_keep_silence_set {args} {
  set ifnm wca_epon_mpcp_keep_silence_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id llid silence_enable silence_time}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_epon_mpcp_keep_silence_set $device_id $port_id $llid $silence_enable $silence_time ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_keep_silence_get {args} {
  set ifnm wca_epon_mpcp_keep_silence_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id llid}
  set v_o_key_l {silence_enable silence_time}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set pEnable [helper_ca_boolean_create]
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pTime $aTmp(-err)
  } 
  if {$res == 0} {
    set cmd [list ca_epon_mpcp_keep_silence_get $device_id $port_id $llid $pEnable $pTime]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
    if {$res == 0} {    
      set aOut(-silence_enable) [helper_ca_boolean_get $pEnable]
      set aOut(-silence_time) [ca_uint32_get $pTime] 
    }
  }    
  helper_data_free [list $pEnable $pTime]
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_queue_set_thresholds_set {args} {
  set ifnm wca_epon_queue_set_thresholds_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id llid threshold1 threshold2 threshold3 threshold4}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_epon_queue_set_thresholds_set $device_id $port_id $llid  $threshold1 $threshold2 $threshold3 $threshold4 ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_queue_set_thresholds_get {args} {
  set ifnm wca_epon_queue_set_thresholds_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id llid}
  set v_o_key_l {threshold1 threshold2 threshold3 threshold4}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
 
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pT1 $aTmp(-err)
    set cmd {ca_uint32_create 0}
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  }
  if {$res == 0} {
    set pT2 $aTmp(-err)
    set cmd {ca_uint32_create 0}
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  }
  if {$res == 0} {
    set pT3 $aTmp(-err)
    set cmd {ca_uint32_create 0}
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  }  
  if {$res == 0} {
    set pT4 $aTmp(-err)  
  }
  if {$res == 0} {
    set cmd [list ca_epon_queue_set_thresholds_get $device_id $port_id $llid $pT1 $pT2 $pT3 $pT4]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]

  }    
  if {$res == 0} {    
    set aOut(-threshold1) [ca_uint32_get $pT1]
    set aOut(-threshold2) [ca_uint32_get $pT2]
    set aOut(-threshold3) [ca_uint32_get $pT3] 
    set aOut(-threshold4) [ca_uint32_get $pT4]           
  }    
  for {set i 1} {$i <=4} {incr i} {
    catch {ca_data_free [set pT$i]} err
  }
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_info_get {args} {
  set ifnm wca_epon_mpcp_info_get
  set res 0
  set AAL_EPON_LLID_INDEX_MAX 63
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set v_o_key_l [helper_probe_struct_members -struct ca_epon_mpcp_info]  
  set idx [lsearch -exact   $v_o_key_l "llid"]
  set v_o_key_l "[lrange $v_o_key_l 0 $idx-1] [lrange $v_o_key_l $idx+1 end]"
  set llid_info_key_l [helper_probe_struct_members -struct ca_epon_llid_info]   
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set cmd {ca_epon_mpcp_info_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  } 
  if {$res == 0} {
    set cmd [list ca_epon_mpcp_info_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }    
  if {$res == 0} {
    foreach key $v_o_key_l {
      if {$key == "llid"} {continue}
      set aOut(-$key) [ca_epon_mpcp_info_get_$key $pt]
    }
    for {set i 0 } {$i <= $AAL_EPON_LLID_INDEX_MAX} {incr i} {
      set pl [ca_epon_mpcp_info_get_llid $pt $i] 
      if {$pl == "NULL"} {break}
      set l ""
      foreach var $llid_info_key_l {
        lappend l "$var=[ca_epon_llid_info_get_$var $pl]"
      }
      set aOut(-llid_info_$i) [join $l "/"]
    }
    set aOut(-llid_info_count) $i
  }
  helper_s2h -table CA_EPON_MPCP_REPORT_MODE_T -source $aOut(-report_mode) -out aH
  set aOut(-report_mode_v) $aH(-target)
 
  catch {ca_data_free $pR} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_report_mode_set {args} {
  set ifnm wca_epon_mpcp_report_mode_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id report_mode}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_h2s -table CA_EPON_MPCP_REPORT_MODE_T -source $report_mode -out aH
  set report_mode $aH(-target)
  set cmd [list ca_epon_mpcp_report_mode_set $device_id $port_id $report_mode ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1] 
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_mpcp_registration_status_get {args} {
  set ifnm wca_epon_mpcp_registration_status_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id llid}
  set v_out_key_l [helper_probe_struct_members -struct ca_epon_mpcp_registration_status]  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_out_key_l
  set cmd {ca_epon_mpcp_registration_status_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pR $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_epon_mpcp_registration_status_get $device_id $port_id $llid $pR]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }  
  if {$res == 0} {
    foreach key $v_out_key_l {
        if {$key == "olt_mac_addr"} {
            set pmac [ca_epon_mpcp_registration_status_get_$key $pR]
            set mac_l ""
            for {set i 0  } {$i < 6} {incr i} {
              lappend mac_l [format %02x [ca_mac_addr_get $pmac $i]]
            }
            set aOut(-olt_mac_addr) [join $mac_l :]
        } else {
            set aOut(-$key) [ca_epon_mpcp_registration_status_get_$key $pR]
        }
    }
  }  
  catch {ca_data_free $pR} err
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name $res
  return $res
}
proc ::gw::wca_epon_mpcp_stats_get {args} {
  set docStr "    read_clear: default value is 1"
  set ifnm wca_epon_mpcp_stats_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id port_id llid}
  set v_o_key_l [helper_probe_struct_members -struct ca_epon_mpcp_stats]
  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l "read_clear"]
  if {$res} {
    return $res
  }
  set aIn(-read_clear) 1
  array set aIn $args
  set read_clear $aIn(-read_clear)  
  if {[string toupper $read_clear ] == "DONTCARE"} {
    set read_clear 1
  }  
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aOut(-read_clear) $read_clear
  set cmd {ca_epon_mpcp_stats_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pR $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_epon_mpcp_stats_get $device_id $port_id $llid $read_clear $pR]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }  
  if {$res == 0} {
    foreach key $v_o_key_l {   
          if {$key == "rx_grant_frames_drops"} {
              set l ""
              for {set i 0 } {$i < 8} {incr i} {
                lappend l [ca_epon_mpcp_stats_get_$key $pR $i]
              }
              set aOut(-$key) [join $l ,]
              continue
          }    
          set aOut(-$key) [ca_epon_mpcp_stats_get_$key $pR]
    }
  }  
  catch {ca_data_free $pR} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_llid_stats_get {args} {
  set docStr "    read_clear: default value is 1"
  set ifnm wca_epon_llid_stats_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id llid_instance }
  set v_out_key_l  [helper_probe_struct_members -struct ca_epon_llid_stats]  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l "read_clear"]
  if {$res} {
    return $res
  }
  set aIn(-read_clear) 1
  array set aIn $args
  foreach key {read_clear} {
    set $key $aIn(-$key)
    if {[string toupper $aIn(-$key)] == "DONTCARE"} {
      set $key 1
    }  
  }  
  helper_output_declare aIn
  helper_output_init aOut  $v_out_key_l
  set aOut(-read_clear) $read_clear  
  set cmd {ca_epon_llid_stats_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pR $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_epon_llid_stats_get $device_id $port_id $llid_instance $read_clear $pR]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
 
  }  
  if {$res == 0} {
      foreach key $v_out_key_l {
          set aOut(-$key) [ca_epon_llid_stats_get_$key $pR]
      }
  }  
  catch {ca_data_free $pR} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_lods_ignore_set {args} {
  set ifnm wca_epon_lods_ignore_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id enable duration}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_epon_lods_ignore_set $device_id $port_id $enable $duration ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1] 
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_lods_ignore_get {args} {
  set ifnm wca_epon_lods_ignore_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set v_out_key_l {enable duration}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_out_key_l
  
  set pEnable [helper_ca_boolean_create]
  set cmd {ca_uint8_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pDuration $aTmp(-err)
  } 
  if {$res == 0} {
    set cmd [list ca_epon_lods_ignore_get $device_id $port_id $pEnable $pDuration]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]

  }  
  if {$res == 0} {
     set aOut(-enable) [helper_ca_boolean_get $pEnable]
     set aOut(-duration) [ca_uint8_get $pDuration] 
  }  
  helper_data_free [list $pEnable $pDuration]
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_llid_loopback_enable_set {args} {
  set ifnm wca_epon_llid_loopback_enable_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id llid enable}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_epon_llid_loopback_enable_set $device_id $port_id $llid $enable ]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1] 
  log -tag itfend
  return $res
}
proc ::gw::wca_epon_llid_loopback_enable_get {args} {
  set ifnm wca_epon_llid_loopback_enable_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id llid}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  {enable}
  set pEnable [helper_ca_boolean_create]
  if {$res == 0} {
    set cmd [list ca_epon_llid_loopback_enable_get $device_id $port_id $llid $pEnable]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
  }  
  if {$res == 0} {
     set aOut(-enable) [helper_ca_boolean_get $pEnable]
  }  
  helper_data_free [list $pEnable]
  helper_parray aOut
  log -tag itfend
  return $res
}
#-----------------------------------
# END OF EPON
#-----------------------------------
#------------------------------------------
#Section: Port Management - GPON Port Management
#------------------------------------------
proc ::gw::wca_gpon_onu_set {args} {
  set ifnm wca_gpon_onu_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }
  set v_key_l {battery_backup admin_state}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 0
  array set aIn $args
  
  set data_init $aIn(-data_init)
  array set aOut ""
  if {$data_init == 1} {
    set res [wca_gpon_onu_get -device_id $device_id -out aOut]
    if {$res == 0 } {
      foreach var $v_key_l {
        set $var $aOut(-$var)
      }
    }
  } else {
    foreach var $v_key_l {
      set $var 0
    }
  }
  if {$res == 0 } {
    foreach var $v_key_l {
      if {[info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} {        
          set $var $aIn(-$var)
      }
    }
  }  
  set cmd "ca_gpon_onu_set $device_id $battery_backup $admin_state"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_gpon_onu_get {args} {
  variable GPON_ONU_VERSION_ID_LEN  
  variable GPON_ONU_PASSWORD_LEN   
  variable GPON_ONU_SERIAL_NUMBER_LEN  
  variable GPON_ONU_ID_STR_LEN    
  set ifnm wca_gpon_onu_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }
  set v_o_key_l {vendor_id version serial_number traffic_mgmt_option \
      battery_backup admin_state logical_onu_id password}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set p_battery_backup [helper_ca_boolean_create]
  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set p_vendor_id $aTmp(-err)
    set cmd "ca_uint8_array_create 0 $GPON_ONU_VERSION_ID_LEN"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]      
  }
  if {$res == 0 } {
    set p_version $aTmp(-err)
    set cmd "ca_uint8_array_create 0 $GPON_ONU_SERIAL_NUMBER_LEN"
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  }
  if {$res == 0 } {
    set p_serial_number $aTmp(-err)
    set cmd "ca_uint8_create 0"
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  }
  if {$res == 0 } {
    set p_traffic_mgmt_option $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  } 
  if {$res == 0 } {
    set p_admin_state $aTmp(-err)
    set cmd "ca_uint8_array_create 0 $GPON_ONU_ID_STR_LEN"
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  }
  if {$res == 0 } {
    set p_logical_onu_id $aTmp(-err)
    set cmd "ca_uint8_array_create 0 $GPON_ONU_PASSWORD_LEN"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]     
  }
  if {$res == 0 } {
    set p_password $aTmp(-err)
    set cmd "ca_gpon_onu_get $device_id $p_vendor_id  $p_version $p_serial_number \
       $p_traffic_mgmt_option  $p_battery_backup $p_admin_state $p_logical_onu_id $p_password"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set vdid [format %08x [ca_uint32_get $p_vendor_id]]
    #set vdid_l [split $vdid ""]
    set lvd ""
    for {set i 0 } {$i < 4} {incr i } {
      lappend lvd [format %c 0x[string range $vdid [expr $i * 2] [expr $i * 2 +1] ] ]
    }
    set aOut(-vendor_id) [join $lvd ""]
    set aOut(-traffic_mgmt_option) [ca_uint8_get $p_traffic_mgmt_option]
    set aOut(-battery_backup) [helper_ca_boolean_get $p_battery_backup]
    set aOut(-admin_state)    [ca_uint8_get $p_admin_state]
    set l ""
    set version_l ""
    for {set idx 0 } {$idx < $GPON_ONU_VERSION_ID_LEN} {incr idx} {
      lappend version_l [format 0x%02x [ca_uint8_array_get $p_version $idx]]
      lappend l [format %c [ca_uint8_array_get $p_version $idx]]
    }
    set aOut(-version) [string trim [join $l ""]]
    log -tag debug -msg "version data list: $version_l"
    set ll ""
    set lh ""
    for {set idx 0} {$idx < $GPON_ONU_SERIAL_NUMBER_LEN} {incr idx} {
          if {$idx < 4} {  
            lappend ll [format %c [ca_uint8_array_get $p_serial_number $idx]]
            
           } else {
            lappend lh [format %0x [ca_uint8_array_get $p_serial_number $idx]]       
         }
    }
    set aOut(-serial_number) [join $ll ""].[join $lh ""]
    set aOut(-vssn)    [join $lh ""]
    #set aOut(-vendor_id)   [join $ll ""]
    set l "" 
    for  {set idx 0} {$idx < $GPON_ONU_ID_STR_LEN} {incr idx} {
      lappend l [format %c [ca_uint8_array_get $p_logical_onu_id $idx]]
    }
    set aOut(-logical_onu_id) [join $l ""]
    
    set l "" 
    for  {set idx 0} {$idx < $GPON_ONU_PASSWORD_LEN} {incr idx} {
      lappend l [format %c [ca_uint8_array_get $p_password $idx]]
    }
    set aOut(-password) [join $l ""]        
  }
  foreach var $v_o_key_l {
    catch {ca_data_free [set p_$var]} err
  }
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_status_get {args} {
  set ifnm wca_gpon_port_status_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id}
  set v_o_key_l {opt_rx_los opt_mod_abs opt_tx_sd opt_tx_fault}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set res -1
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_sf_threshold_set {args} {
  set ifnm wca_gpon_port_sf_threshold_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id threshold}
  set v_key_l {}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args   
  set cmd "ca_gpon_port_sf_threshold_set $device_id $port_id $threshold"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_gpon_port_sf_threshold_get {args} {
  set ifnm wca_gpon_port_sf_threshold_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {threshold}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set p_threshold $aTmp(-err)
  } 
  if {$res == 0 } {
    set cmd "ca_gpon_port_sf_threshold_get $device_id $port_id  $p_threshold"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-threshold) [ca_uint32_get $p_threshold]
    
  }
  catch {ca_data_free $p_sf_threshold} err
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_sd_threshold_set {args} {
  set ifnm wca_gpon_port_sd_threshold_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id threshold}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_gpon_port_sd_threshold_set $device_id $port_id $threshold"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_gpon_port_sd_threshold_get {args} {
  set ifnm wca_gpon_port_sd_threshold_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {threshold}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l

  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set p_threshold $aTmp(-err)
  } 
  if {$res == 0 } {
    set cmd "ca_gpon_port_sd_threshold_get $device_id $port_id  $p_threshold"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-threshold) [ca_uint32_get $p_threshold]    
  }
  catch {ca_data_free $p_sf_threshold} err
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_laser_mode_set {args} {
  variable CA_GPON_PORT_LASER_MODE_T
  set ifnm wca_gpon_port_laser_mode_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id mode}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set mode [string toupper $mode]
  helper_h2s -table CA_GPON_PORT_LASER_MODE_T -source $mode -out aH
  set mode $aH(-target)
  
  set cmd "ca_gpon_port_laser_mode_set $device_id $port_id $mode"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_gpon_port_laser_mode_get {args} {
  variable CA_GPON_PORT_LASER_MODE_T
  set ifnm wca_gpon_port_laser_mode_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {mode}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set print_res $aIn(-print_res)

  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
  } 
  if {$res == 0 } {
    set cmd "ca_gpon_port_laser_mode_get $device_id $port_id  $pt"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-mode) [ca_uint32_get $pt]
    helper_s2h -table CA_GPON_PORT_LASER_MODE_T -source $aOut(-mode) -out aH
    set  aOut(-mode_v)  $aH(-target)
  }
  catch {ca_data_free $pt} err  
  if {$print_res} {
    helper_parray aOut
  }
  log -tag itfend
  return $res  
} 
proc ::gw::wca_gpon_port_laser_polarity_set {args} {
  variable CA_GPON_PORT_LASER_POLARITY_T
  #tx, rx: LO or HI
  set ifnm wca_gpon_port_laser_polarity_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id } 
  set v_key_l {tx_polarity rx_polarity}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  array set aIn $args 
  set data_init $aIn(-data_init) 

  foreach var $v_key_l {
    if {[info exists aIn(-$var)] == 0 || [string trim [string toupper $aIn(-$var)]] == "DONTCARE"} {
      set data_init 1
    } 
  }  
  if {$data_init == 1} {
    set res [wca_gpon_port_laser_polarity_get -device_id $device_id -port_id $port_id -out aSysCfg -print_res 0]
    if {$res == 0 } {
      foreach var $v_key_l {
        if {[info exists aIn(-$var)] == 0 || [string trim [string toupper $aIn(-$var)]] == "DONTCARE"} {
          set $var $aSysCfg(-$var)
        } else {
          set $var $aIn(-$var)
        }
      }
    }
  } 
  helper_h2s -table CA_GPON_PORT_LASER_POLARITY_T -source $tx_polarity -out aTmp
  set tx_polarity $aTmp(-target)
  helper_h2s -table CA_GPON_PORT_LASER_POLARITY_T -source $rx_polarity -out aTmp
  set rx_polarity $aTmp(-target) 
  if {$res == 0 } {
    set cmd "ca_gpon_port_laser_polarity_set $device_id $port_id $tx_polarity $rx_polarity"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_gpon_port_laser_polarity_get {args} {
  variable CA_GPON_PORT_LASER_POLARITY_T
  set ifnm wca_gpon_port_laser_polarity_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {rx_polarity tx_polarity}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l

  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set tx_polarity $aTmp(-err)
    set cmd "ca_uint32_create 0 "
    set res [helper_cmd_exec -cmd $cmd -out aTmp]   
  }
  if {$res == 0 } {
    set rx_polarity $aTmp(-err)
  } 
  if {$res == 0 } {
    set cmd "ca_gpon_port_laser_polarity_get $device_id $port_id  $tx_polarity $rx_polarity"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set tx [ca_uint32_get $tx_polarity]
    set rx [ca_uint32_get $rx_polarity]
    set aOut(-tx_polarity) $tx
    set aOut(-rx_polarity) $rx
    helper_s2h -source $tx -table CA_GPON_PORT_LASER_POLARITY_T -out aTmp
    set aOut(-tx_polarity_v) $aTmp(-target)
    helper_s2h -source $rx -table CA_GPON_PORT_LASER_POLARITY_T -out aTmp
    set aOut(-rx_polarity_v) $aTmp(-target)   
  }
  catch {ca_data_free $pt} err
  
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_timer_set {args} {
  variable CA_GPON_PORT_TIMER_TYPE_T
  set ifnm wca_gpon_port_timer_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id timer_type timer_msec}
  set v_key_l {}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set timer_type [string toupper $timer_type]
  helper_h2s -source $timer_type -table CA_GPON_PORT_TIMER_TYPE_T -out aRes
  set timer_type $aRes(-target)
  set cmd "ca_gpon_port_timer_set $device_id $port_id $timer_type $timer_msec"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_gpon_port_timer_get {args} {
  variable CA_GPON_PORT_TIMER_TYPE_T
  set ifnm wca_gpon_port_timer_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id timer_type}
  set v_o_key_l { timer_msec}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set timer_type [string toupper $timer_type]
  helper_h2s -source $timer_type -table CA_GPON_PORT_TIMER_TYPE_T -out aRes
  set timer_type $aRes(-target)
  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  } 
  if {$res == 0 } {
    set ptime $aTmp(-err)
    set cmd "ca_gpon_port_timer_get $device_id $port_id  $timer_type $ptime"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {    
    set aOut(-timer_msec) [ca_uint32_get $ptime]
  }
  catch {ca_data_free $ptime} err  
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_sync_threshold_set {args} {
  set ifnm wca_gpon_port_sync_threshold_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id }
  set v_key_l {sync_threshold miss_sync_threshold}
  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  array set aIn $args 
  set data_init $aIn(-data_init) 
  foreach var $v_key_l {
    if {[info exists aIn(-$var)] == 0 || [string trim [string toupper $aIn(-$var)]] == "DONTCARE"} {
      set data_init 1
    } 
  }  
  if {$data_init == 1} {
    set res [wca_gpon_port_sync_threshold_get -device_id $device_id -port_id $port_id -out aSysCfg -print_res 0]
    if {$res == 0 } {
      foreach var $v_key_l {
        if {[info exists aIn(-$var)] == 0 || [string trim [string toupper $aIn(-$var)]] == "DONTCARE"} {
          set $var $aSysCfg(-$var)
        } else {
          set $var $aIn(-$var)
        }
      }
    }
  }   
  
  if {$res == 0 } {
    set cmd "ca_gpon_port_sync_threshold_set $device_id $port_id $sync_threshold $miss_sync_threshold"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_gpon_port_sync_threshold_get {args} {
  set ifnm wca_gpon_port_sync_threshold_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {sync_threshold miss_sync_threshold}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  
  set print_res $aIn(-print_res) 
  
  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set p_sync $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  } 
  if {$res == 0 } {
    set p_miss $aTmp(-err)
    set cmd "ca_gpon_port_sync_threshold_get $device_id $port_id  $p_sync $p_miss"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-sync_threshold) [ca_uint32_get $p_sync]
    set aOut(-miss_sync_threshold) [ca_uint32_get $p_miss]
  }
  catch {ca_data_free $p_sync} err
  catch {ca_data_free $p_miss } err
  if {$print_res} {
    helper_parray aOut
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_aes_enable_set {args} {
  set ifnm wca_gpon_port_aes_enable_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id aes_enable}
  set v_key_l {}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd "ca_gpon_port_aes_enable_set $device_id $port_id $aes_enable"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_gpon_port_aes_enable_get {args} {
  set ifnm wca_gpon_port_aes_enable_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {aes_enable}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l

  set pt [helper_ca_boolean_create] 
  if {$res == 0 } {
    set cmd "ca_gpon_port_aes_enable_get $device_id $port_id  $pt"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-aes_enable) [helper_ca_boolean_get $pt]    
  }
  helper_data_free $pt
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_aes_key_set {args} {
  set ifnm wca_gpon_port_aes_key_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id effective_key_length aes_key}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]  
  if {$res} {
    return $res
  }  
  
  array set aIn $args
  set data_init $aIn(-data_init) 
  
  set cmd "ca_uint8_array_create 0 16"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  
  set lst [split $aes_key " "]
  set data_len $effective_key_length
  if {$data_len > [llength $lst]} {
    set data_len [llength $lst]
  }
  if {$res == 0 } {
    for {set i 0 } {$i < $data_len} {incr i } {
      set hv [format "0x%02x" [lindex $lst $i]]
      set cmd "ca_uint8_array_set $pt $hv $i"
      set res [helper_cmd_exec -cmd $cmd]
      if {$res} {break}
    }
  } 
  if {$res == 0 } {     
    set cmd [list ca_gpon_port_aes_key_set $device_id $port_id $effective_key_length $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res                     
}
proc ::gw::wca_gpon_port_aes_key_get {args} {
  set ifnm wca_gpon_port_aes_key_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id key_idx}
  set v_o_key_l {key_active effective_key_length aes_key}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set pactive [helper_ca_boolean_create]
  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint8_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set plen $aTmp(-err)
    set cmd "ca_uint8_array_create 0 16"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  } 
  if {$res == 0 } {
    set pkey $aTmp(-err)
    set cmd "ca_gpon_port_aes_key_get $device_id $port_id  $key_idx $pactive $plen $pkey"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-key_active) [helper_ca_boolean_get $pactive]
    set aOut(-effective_key_length) [ca_uint8_get $plen]
    set l ""
    for {set i 0 } {$i< $aOut(-effective_key_length) && $i < 16} {incr i} {
      lappend l [format "0x%02x" [ca_uint8_array_get $pkey $i]]
    }
    set aOut(-aes_key) [join $l " "]
  }
  helper_data_free [list $pactive $plen $pkey ] 
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_fec_enable_set {args} {
  set ifnm wca_gpon_port_fec_enable_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id fec_encoder_enable fec_decoder_enable}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd "ca_gpon_port_fec_enable_set $device_id $port_id $fec_encoder_enable $fec_decoder_enable"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_gpon_port_fec_enable_get {args} {
  set ifnm wca_gpon_port_fec_enable_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {fec_encoder_enable fec_decoder_enable}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l

  set pe [helper_ca_boolean_create]
  set pd [helper_ca_boolean_create]
  set cmd "ca_gpon_port_fec_enable_get $device_id $port_id  $pe $pd"
  set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  
  if {$res == 0 } {
    set aOut(-fec_encoder_enable) [helper_ca_boolean_get $pe]
    set aOut(-fec_decoder_enable) [helper_ca_boolean_get $pd]
  }
  helper_data_free [list $pe $pd ]
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_fec_stats_get {args} {
  return [eval wca_gpon_port_fec_stat_get $args]
}
proc ::gw::wca_gpon_port_fec_stat_get {args} {
  set docStr "    read_clear: default value is 1"
  set ifnm wca_gpon_port_fec_stat_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id }
  set v_key_l {read_clear}
  set v_o_key_l {corrected_bytes corrected_codewords \
        uncorrectable_codewords total_codewords}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-read_clear) 1
  array set aIn $args
  set read_clear $aIn(-read_clear)  
  if {[string toupper $read_clear ] == "DONTCARE"} {
    set read_clear 1
  }
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set cmd {ca_gpon_port_fec_stats_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  set aOut(-read_clear) $read_clear 
  if {$res == 0} {
    set cmd [list ca_gpon_port_fec_stats_get $device_id $port_id $read_clear $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]

  }  
  if {$res == 0} {
    foreach key $v_o_key_l {
      set aOut(-$key) [ca_gpon_port_fec_stats_get_$key $pt]
    }
  }  
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_gpon_port_onu_state_get {args} {
  variable CA_NGP2_ONU_ACT_STATE_T
  set ifnm wca_gpon_port_onu_state_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {onu_state}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
  } 
  if {$res == 0 } {
    set cmd "ca_gpon_port_onu_state_get $device_id $port_id  $pt"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-onu_state) [ca_uint32_get $pt]
    set l [lindex [array names CA_NGP2_ONU_ACT_STATE_T "*,$aOut(-onu_state)"] 0]
    if {[string length $l ] } {
      set aOut(-onu_state_v) [lindex [split $l ,] 0]
    }     
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_onu_id_get {args} {
  set ifnm wca_gpon_port_onu_id_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {onu_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
  }
 
  if {$res == 0 } {
    set cmd "ca_gpon_port_onu_id_get $device_id $port_id  $pt"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-onu_id) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err
  
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_onu_eqd_get {args} {
  set ifnm wca_gpon_port_onu_eqd_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {onu_eqd}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
  } 
  if {$res == 0 } {
    set cmd "ca_gpon_port_onu_eqd_get $device_id $port_id  $pt"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-onu_eqd) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_capability_get {args} {
  variable CA_NGP2_ONU_ACT_STATE_T
  set ifnm wca_gpon_port_capability_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {max_tcont_number max_gem_number max_queue_number queues_per_tcont}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_gpon_port_capability_create "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
  } 
  if {$res == 0 } {
    set cmd "ca_gpon_port_capability_get $device_id $port_id  $pt"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    foreach var $v_o_key_l {
      set aOut(-$var) [ca_gpon_port_capability_get_$var $pt]
    }  
  }
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_gem_port_add {args} {
 set ifnm wca_gpon_port_gem_port_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id }
  set v_o_key_l {gem_port_id tcont_id direction up_queue \
      dn_queue aes_state aes_key_ring }
  set v_plc_l {mode pps cir cbs pir pbs}
  set v_out_key_l {gem_index}
  set v_key_l $v_o_key_l
  foreach v $v_plc_l {
    lappend v_key_l "up_$v"
  }
  foreach v $v_plc_l {
    lappend v_key_l "dn_$v"
  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]  
  if {$res} {
    return $res
  }  
  
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_out_key_l

  set cmd "ca_gpon_port_gem_port_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set plc_up [ca_gpon_port_gem_port_get_up_traffic_descriptor $pt]
    set plc_dn [ca_gpon_port_gem_port_get_dn_traffic_descriptor $pt]  
    foreach var $v_o_key_l {
      if {[info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        set cmd "ca_gpon_port_gem_port_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {break}
      } 
    }
  } 
  if {$res == 0 } {
    foreach pre "up dn" {
      set tmp_pt [set plc_$pre]
      foreach v $v_plc_l {
        set var ${pre}_$v
        if {[info exists aIn(-$var)] && 
          [string compare [string tolower $aIn(-$var)] "dontcare"]} {
          set cmd "ca_policer_set_$v ${tmp_pt} $aIn(-$var)"
          set res [helper_cmd_exec -cmd $cmd]
          if {$res} {break}
        }
      }
      if {$res} {break}
    }
  }
  if {$res == 0 } {
    #after 200
    set cmd [list ca_gpon_port_gem_port_add $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  if {$res == 0 } {
    set aOut(-gem_index) [format "0x%04x" [ca_gpon_port_gem_port_get_gem_index $pt]]
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_parray aOut
  return $res                     
}

proc ::gw::wca_gpon_port_gem_port_delete {args} {
 set ifnm wca_gpon_port_gem_port_delete
  set res 0
  log -tag itfbgn -msg $args
 
  set m_key_l {device_id port_id gem_index}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]  
  if {$res } {
  return $res
  }
   
  if {$res == 0 } {
    #after 200
    set cmd [list ca_gpon_port_gem_port_delete $device_id $port_id $gem_index]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err

  log -tag itfend
  return $res                     
}

proc ::gw::wca_gpon_port_gem_port_get {args} {
  variable CA_POLICER_MODE_T
  variable CA_GPON_PORT_GEM_PORT_DIRECTION_T
  set ifnm wca_gpon_port_gem_port_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id gem_index}
  #gem_index dn_queue -> downstream_queue
  set v_o_key_l { gem_port_id gem_index tcont_id direction up_queue up_traffic_descriptor\
      dn_queue dn_traffic_descriptor aes_state aes_key_ring }
  set v_plc_l {mode pps cir cbs pir pbs}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  foreach var $v_plc_l {
    set aOut(-up_$var) unknown
    set aOut(-dn_$var) unknown
  }
  set aTmp(-err) ""
 
  set res [helper_cmd_exec -cmd {ca_gpon_port_gem_port_create } -out aTmp]  
  if {$res == 0 } {
    set pt $aTmp(-err)
    if {[info exists aIn(-gem_index)] && 
        [string compare [string tolower $aIn(-gem_index)] "dontcare"]} {
        set cmd "ca_gpon_port_gem_port_set_gem_index $pt $aIn(-gem_index)"
      set res [helper_cmd_exec -cmd $cmd]
    }
  }
  
  if {$res == 0 } {     
    set cmd [list ca_gpon_port_gem_port_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  
  if {$res == 0 } {
    set plc_up [ca_gpon_port_gem_port_get_up_traffic_descriptor $pt]
    set plc_dn [ca_gpon_port_gem_port_get_dn_traffic_descriptor $pt]
    foreach var "gem_port_id $v_o_key_l" {
      set aOut(-$var) [ca_gpon_port_gem_port_get_$var $pt]
    }
    foreach var $v_plc_l {
      set aOut(-up_$var) [ca_policer_get_$var $plc_up]
      set aOut(-dn_$var) [ca_policer_get_$var $plc_dn]
    }
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_gem_port_set {args} {
 set ifnm wca_gpon_port_gem_port_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id gem_index}
  set v_o_key_l {flow_id gem_port_id tcont_id direction up_queue \
      dn_queue aes_state aes_key_ring }
  set v_plc_l {mode pps cir cbs pir pbs}
 
  set v_key_l $v_o_key_l
  foreach v $v_plc_l {
    lappend v_key_l "up_$v"
  }
  foreach v $v_plc_l {
    lappend v_key_l "dn_$v"
  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]  
  if {$res} {
    return $res
  }  
  
  array set aIn $args
  
  set data_init $aIn(-data_init) 
      
  set cmd "ca_gpon_port_gem_port_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err) 
    set plc_up [ca_gpon_port_gem_port_get_up_traffic_descriptor $pt]
    set plc_dn [ca_gpon_port_gem_port_get_dn_traffic_descriptor $pt]
    if {[info exists aIn(-gem_index)] && 
        [string compare [string tolower $aIn(-gem_index)] "dontcare"]} {
        set cmd "ca_gpon_port_gem_port_set_gem_index $pt $aIn(-gem_index)"
      set res [helper_cmd_exec -cmd $cmd]
    }
  }
  if {$res == 0  && $data_init == 1} {     
    set cmd [list ca_gpon_port_gem_port_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    set sys_gem_index [ca_gpon_port_gem_port_get_gem_index $pt]
    if {[expr $aIn(-gem_index) - $sys_gem_index] } {
      log -tag error -msg "The retrieved gem_index($sys_gem_index) 
        is not same as input($aIn(-gem_index)"
    } 
  }
  if {$res == 0 } {
    foreach var $v_o_key_l {
      if {[info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        set cmd "ca_gpon_port_gem_port_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {break}
      } 
    }
  } 
  if {$res == 0 } {
    foreach pre "up dn" {
      set tmp_pt [set plc_$pre]
      foreach v $v_plc_l {
        set var ${pre}_$v
        if {[info exists aIn(-$var)] && 
          [string compare [string tolower $aIn(-$var)] "dontcare"]} {
          set cmd "ca_policer_set_$v $tmp_pt $aIn(-$var)"
          set res [helper_cmd_exec -cmd $cmd]
          if {$res} {break}
        }
      }
      if {$res} {break}
    }
  }
  if {$res == 0 } {
    set cmd [list ca_gpon_port_gem_port_set $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res                     
}
proc ::gw::wca_gpon_port_omci_port_id_get {args} {
  set ifnm wca_gpon_port_omci_port_id_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id}
  set v_o_key_l {omci_port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
  }
 
  if {$res == 0 } {
    set cmd "ca_gpon_port_omci_port_id_get $device_id $port_id  $pt"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-omci_port_id) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err
  
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_gem_stats_get {args} {
  set docStr "    read_clear: default value is 1"
  set ifnm wca_gpon_port_gem_stats_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id port_id  gem_port_index}
  set v_o_key_l [helper_probe_struct_members -struct ca_gpon_port_gem_stats ]
  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l {read_clear}]
  if {$res} {
    return $res
  }
  set aIn(-read_clear) 1
  array set aIn $args
  set read_clear $aIn(-read_clear)
  if {[string toupper $read_clear] == "DONTCARE"} {
    set $read_clear 1
  }  
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set cmd {ca_gpon_port_gem_stats_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  set aOut(-read_clear) $read_clear
  if {$res == 0} {
    set cmd [list ca_gpon_port_gem_stats_get $device_id $port_id $read_clear $gem_port_index $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
    if {$res == 0} {
      foreach key $v_o_key_l {
          set aOut(-$key) [ca_gpon_port_gem_stats_get_$key $pt]
      }
    }
  }    
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res      

}

proc ::gw::wca_gpon_port_tcont_get {args} {
  set ifnm wca_gpon_port_tcont_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id alloc_id}
  set v_o_key_l {tcont_id tcont_enable}
  set v_sch_l {mode sp_queue_num weight_queue}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  "$v_o_key_l $v_sch_l"

  set tcont_enable [helper_ca_boolean_create]
  set cmd "ca_uint32_create 0"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]  
  if {$res == 0 } {
    set tcont_id $aTmp(-err)
    set cmd "ca_gpon_port_tcont_scheduler_create"
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  }
  if {$res == 0 } {
    set  pt $aTmp(-err)  
    set cmd "ca_gpon_port_tcont_get $device_id $port_id $alloc_id  $tcont_id $tcont_enable $pt"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-tcont_enable) [helper_ca_boolean_get $tcont_enable]
    set aOut(-tcont_id) [ca_uint32_get $tcont_id]
    foreach var $v_sch_l {
      if {$var == "weight_queue" } {
        set q_l ""
        for {set idx 0 } {$idx < 8} {incr idx} {
          lappend q_l  [ca_gpon_port_tcont_scheduler_get_weight_queue $pt $idx]
        }
        set aOut(-weight_queue) [join $q_l ,] 
      } else {
        set aOut(-$var) [ca_gpon_port_tcont_scheduler_get_$var $pt]
      }
    }
  }
  helper_data_free [list $tcont_enable $tcont_id $pt]
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_tcont_set {args} {
  set ifnm wca_gpon_port_tcont_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id alloc_id}
  set v_o_key_l {tcont_id tcont_enable}
  set v_sch_l {mode sp_queue_num weight_queue}
 
  set v_key_l "$v_o_key_l $v_sch_l"
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]  
  if {$res} {
    return $res
  }    
  set aIn(-tcont_enable) "dontcare"
  set aIn(-tcont_id) "dontcare"
  array set aIn $args
  set data_init $aIn(-data_init)
  
  set tcont_enable $aIn(-tcont_enable)
  set tcont_id $aIn(-tcont_id)
  set p_tcont_enable [helper_ca_boolean_create]
  set cmd "ca_gpon_port_tcont_scheduler_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd "ca_uint32_create 0"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]      
  }
  if {$res == 0 } {
     set p_tcont_id $aTmp(-err)
  }
  if {$res == 0 && $data_init == 1} {
    #init with data read from system
    set cmd "ca_gpon_port_tcont_get $device_id $port_id $alloc_id  $p_tcont_id $p_tcont_enable $pt"
    set res [helper_cmd_exec -cmd $cmd]
    if {$res == 0 } {
      set tcont_enable [helper_ca_boolean_get $p_tcont_enable]
      set tcont_id [ca_uint32_get $p_tcont_id] 
    }
  }     
  helper_data_free [list $p_tcont_enable  $p_tcont_id ]
  
  if {$res == 0 } {
      foreach var $v_o_key_l {
           if {[info exists aIn(-$var)] && [string compare [string tolower $aIn(-$var)] "dontcare"]} {
               set $var $aIn(-$var)
           }
      }
  }
  if {$res == 0 } { 
    foreach var $v_sch_l {
      if {[info exists aIn(-$var)] == 0 ||
        [string equal [string tolower $aIn(-$var)] "dontcare"]} { 
        continue
      }  
      if {$var == "weight_queue"} {
        helper_expand_list -set $aIn(-weight_queue) -out aTmp
        parray aTmp
        set q_l $aTmp(-l)
        set len [llength $q_l]
        if {$len > 8} {
          set len 8
        }
        for {set idx 0 } {$idx < $len} {incr idx } {
          set cmd [list ca_gpon_port_tcont_scheduler_set_weight_queue $pt [lindex $q_l $idx] $idx]
          set res [helper_cmd_exec -cmd $cmd]
          if {$res} {break}
        }
      } else {
        set cmd "ca_gpon_port_tcont_scheduler_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd ]
      }
      if {$res} {break}       
    }   
  }
 
  if {$res == 0 } {     
    set cmd [list ca_gpon_port_tcont_set $device_id $port_id $alloc_id $tcont_id $tcont_enable $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }

  catch {ca_data_free $pt} err
  log -tag itfend
  return $res                     
}
proc ::gw::wca_gpon_port_upstream_queue_get {args} {
  set ifnm wca_gpon_port_upstream_queue_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id queue_id}
  set v_o_key_l {queue_enable tcont_id scheduler_id weight prio}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  "$v_o_key_l "
  set aTmp(-err) ""
  set queue_enable [helper_ca_boolean_create]

  set cmd "ca_uint32_create 0"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]     
  if {$res == 0 } {
    set tcont_id $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  }
  if {$res == 0 } {
    set scheduler_id $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  }
  if {$res == 0 } {
    set weight $aTmp(-err)
    set cmd "ca_uint8_create 0"
    set res [helper_cmd_exec -cmd $cmd -out aTmp] 
  } 
  if {$res == 0 } {
    set prio $aTmp(-err)
    set cmd "ca_gpon_port_upstream_queue_get $device_id $port_id $queue_id $queue_enable $tcont_id $scheduler_id $weight $prio"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-queue_enable) [helper_ca_boolean_get $queue_enable]
    set aOut(-tcont_id)     [ca_uint32_get $tcont_id]
    set aOut(-scheduler_id)    [ca_uint32_get $scheduler_id]
    set aOut(-weight)     [ca_uint32_get $weight]
    set aOut(-prio)       [ca_uint8_get $prio]
  }
  helper_data_free [list $queue_enable $tcont_id $scheduler_id $weight $prio]
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_upstream_queue_set {args} {
 set ifnm wca_gpon_port_upstream_queue_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id queue_id}
  set v_key_l {queue_enable tcont_id scheduler_id weight prio}
 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]  
  if {$res} {   return $res }  
  foreach var $v_key_l {
    set $var 0
  }
  array set aIn $args
  if {$res == 0 } {
    if {$aIn(-data_init) == 1 } {
      set res [wca_gpon_port_upstream_queue_get -device_id $device_id -port_id $port_id -queue_id $queue_id -out aTmp]
      foreach var $v_key_l {
        set $var $aTmp(-$var)
      } 
    }
  }
  foreach var $v_key_l {
    if {[info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} { 
        set $var $aIn(-$var)
    }  
  }
 
  if {$res == 0 } {
    set cmd [list ca_gpon_port_upstream_queue_set $device_id $port_id $queue_id $queue_enable $tcont_id $scheduler_id $weight $prio]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res                     
}
proc ::gw::wca_gpon_port_upstream_scheduler_set {args} {
  variable CA_GPON_PORT_TCONT_QUEUE_SCHEDULER_MODE_T
  set ifnm wca_gpon_port_upstream_scheduler_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id scheduler_id tcont_id policy pri_weight}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]  
  if {$res} {   return $res }  
  
  array set aIn $args
 
  set l [lindex [array names CA_GPON_PORT_TCONT_QUEUE_SCHEDULER_MODE_T "[string toupper ${policy}],*"] 0]
  if {[string length $l ] } {
    set policy [lindex [split $l ,] 1]
  }  

  if {$res == 0 } {
    set cmd [list ca_gpon_port_upstream_scheduler_set $device_id $port_id $scheduler_id $tcont_id $policy $pri_weight]
     set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res                     
}
proc ::gw::wca_gpon_port_upstream_scheduler_get {args} {
  variable CA_GPON_PORT_TCONT_QUEUE_SCHEDULER_MODE_T
  set ifnm wca_gpon_port_upstream_scheduler_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args" 
  set m_key_l {device_id port_id scheduler_id}
  set v_o_key_l {tcont_id policy pri_weight}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aTmp(-err) ""
  if {$res == 0 } {   
      set cmd "ca_uint32_create 0 "
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set ptcont $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]   
  }
  if {$res == 0 } {
    set pplocy $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]   
  }
   
  if {$res == 0 } {
    set ppri $aTmp(-err)
    set cmd "ca_gpon_port_upstream_scheduler_get $device_id $port_id  $scheduler_id $ptcont $pplocy $ppri"
    set res [helper_cmd_exec -cmd $cmd -out aTmp -check_return_value 1] 
  }
  if {$res == 0 } {
    set aOut(-tcont_id) [ca_uint32_get $ptcont]
    set aOut(-policy) [ca_uint32_get $pplocy]
    set l [lindex [array names CA_GPON_PORT_TCONT_QUEUE_SCHEDULER_MODE_T "*,$aOut(-policy)"] 0]
    if {[string length $l ] } {
      set aOut(-policy) [lindex [split $l ,] 0]
    }   
    set aOut(-pri_weight) [ca_uint32_get $ppri]  
  }
  catch {ca_data_free $ptcont} err
  catch {ca_data_free $pplocy} err
  catch {ca_data_free $ppri} err 
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_gpon_port_dying_gasp_set {args} {
  set ifnm wca_gpon_port_dying_gasp_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd "ca_gpon_port_dying_gasp_set $device_id $port_id "
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
#-----------------------------------
# END OF GPON
#-----------------------------------
#---------------------------------------------------------
#Section: L2 Management
#---------------------------------------------------------
#-------------------------------------------
#Section: L2 Management - L2 Address Management
#-------------------------------------------
proc ::gw::wca_l2_learning_control_set {args} {
  set ifnm wca_l2_learning_control_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id}
  set v_key_l [helper_probe_struct_members -struct ca_l2_learning_control ]
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  array set aIn $args
  set aTmp(-err) ""
  set data_init $aIn(-data_init)
  set cmd {ca_l2_learning_control_create}
  set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  if {$res == 0 } {
    set handle $aTmp(-err)
    if {$aIn(-data_init) == 1 } {
      set cmd [list ca_l2_learning_control_get $device_id $port_id $handle]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    }
  }
  foreach var $v_key_l {
      if {$res == 0 && [info exists aIn(-$var)] && 
        [string compare -nocase $aIn(-$var) "dontcare"] } {
        set cmd "ca_l2_learning_control_set_$var $handle $aIn(-$var)" 
        set res [helper_cmd_exec -cmd $cmd ]
        if {$res} {
          break
        }
      }
  }
  if {$res == 0 } {
    set cmd [list ca_l2_learning_control_set $device_id $port_id $handle]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $handle} err
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_learning_control_get {args} {
  set ifnm wca_l2_learning_control_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set v_o_key_l [helper_probe_struct_members -struct ca_l2_learning_control ]
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_l2_learning_control_create} -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_l2_learning_control_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    foreach var $v_o_key_l {
      set aOut(-$var) [ca_l2_learning_control_get_$var $pt]
    }
  }
  helper_s2h -source $aOut(-sa_mac_table_full_policy) -table CA_L2_MAC_TABLE_FULL_POLICY_T -out aX
  set aOut(-sa_mac_table_full_policy_v) $aX(-target)
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_learning_mode_set {args} {
  set ifnm wca_l2_learning_mode_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id mode }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args 
  helper_h2s -source [string toupper $mode] -table CA_L2_LEARNING_MODE_T -out aX
  set mode $aX(-target)
  set cmd "ca_l2_learning_mode_set $device_id $mode"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_learning_mode_get {args} {
  set ifnm wca_l2_learning_mode_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id} 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut [list mode mode_v]  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_l2_learning_mode_get $device_id  $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-mode) [ca_uint32_get $pt]
    helper_s2h -source $aOut(-mode) -table CA_L2_LEARNING_MODE_T -out aX
    set aOut(-mode_v) $aX(-target)
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_aging_mode_set {args} {
  set ifnm wca_l2_aging_mode_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id mode }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  helper_h2s -source [string toupper $mode] -table CA_L2_AGING_MODE_T -out aX
  set mode $aX(-target)
  set cmd "ca_l2_aging_mode_set $device_id $mode"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]

  log -tag itfend
  return $res
}
proc ::gw::wca_l2_aging_mode_get {args} {
  set ifnm wca_l2_aging_mode_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut [list mode mode_v]  
  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_l2_aging_mode_get $device_id  $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-mode) [ca_uint32_get $pt]
    helper_s2h -source [string toupper $aOut(-mode)] -table CA_L2_AGING_MODE_T -out aX
    set aOut(-mode_v) $aX(-target)
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_mac_limit_set {args} {
  set ifnm wca_l2_mac_limit_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id type data number}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_h2s -source [string toupper $type] -table CA_L2_MAC_LIMIT_TYPE_T -out aX
  set type $aX(-target)
  set cmd "ca_l2_mac_limit_set $device_id $type $data $number"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]

  log -tag itfend
  return $res
}
proc ::gw::wca_l2_mac_limit_get {args} {
  set ifnm wca_l2_mac_limit_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id type data}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} { 
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut "number" 
  helper_h2s -source [string toupper $type] -table CA_L2_MAC_LIMIT_TYPE_T -out aX
  set type $aX(-target) 
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd "ca_uint32_create $data"  -out aTmp]
  if {$res == 0 } {
    set pdata $aTmp(-err)
     set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]    
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_l2_mac_limit_get $device_id  $type $data  $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-number) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err
  catch {ca_data_free $pdata} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_aging_time_get {args} {
  set ifnm wca_l2_aging_time_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut [list time]  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_l2_aging_time_get $device_id  $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    set aOut(-time) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_aging_time_set {args} {
  set ifnm wca_l2_aging_time_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id time}
  set v_key_l {}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd "ca_l2_aging_time_set $device_id $time"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_l2_addr_add {args} {
  set ifnm wca_l2_addr_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id mac}
  set v_key_l {fwd_vid vid dot1p static_flag sa_permit da_permit port_id mc_group_id aging_timer}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-vid) 0
  set aIn(-port_id) 0xffffffff
  set aIn(-mc_group_id) 0xffffffff
  array set aIn $args
  
  foreach var {port_id mc_group_id} {
    if {[string equal [string tolower $aIn(-$var)] "dontcare"]} {
      log -tag warning -msg "Value of $var will be set to CA_UINT32_INVALID(0xffffffff)"
      set aIn(-$var) 0xffffffff
    }
  } 
  set aTmp(-err) ""
 
  set mac_l ""
  foreach m [split $mac :] {
    lappend mac_l "0x$m"
  }  
  set cmd "ca_mac_addr_create $mac_l"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pmac $aTmp(-err)
    set aIn(-mac_addr) $pmac  
    set cmd {ca_l2_addr_entry_create}  
    set res  [helper_cmd_exec -cmd $cmd -out aTmp] 
  }    
  if {$res == 0 } {
    set pt $aTmp(-err)
    foreach var "mac_addr $v_key_l" {
      if {[info exists aIn(-$var)] && 
        [string compare -nocase $aIn(-$var) "dontcare"] } {
        set cmd "ca_l2_addr_entry_set_$var $pt $aIn(-$var)" 
        set res [helper_cmd_exec -cmd $cmd ]
        if {$res} {
          break
        }
      }
    }  
  }
  if {$res == 0 } {
    set cmd [list ca_l2_addr_add $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  catch {ca_data_free $pmac} err
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_addr_get {args} {
  set ifnm wca_l2_addr_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  #Note: Here the "mac" argument is indeed the "mac_addr" which is defined in CA API spec.
  set m_key_l {device_id mac vid}
  set v_o_key_l {fwd_vid vid dot1p static_flag sa_permit da_permit port_id mc_group_id aging_timer}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_o_key_l

  set aTmp(-err) ""
  set mac_l ""
  foreach m [split $mac :] {
    lappend mac_l "0x$m"
  }  
  set cmd "ca_mac_addr_create $mac_l"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pmac $aTmp(-err)
  
    set cmd {ca_l2_addr_entry_create}  
    set res  [helper_cmd_exec -cmd $cmd -out aTmp] 
  }
 
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_l2_addr_get $device_id $pmac $vid $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    foreach var $v_o_key_l {
      set aOut(-$var) [ca_l2_addr_entry_get_$var $pt]
    }  
    set aOut(-mc_group_id) [format "0x%08x" $aOut(-mc_group_id)]
    set aOut(-port_id) [format "0x%05x" $aOut(-port_id)]
  }

  catch {ca_data_free $pt} err
  catch {ca_data_free $pmac} err
  if {$aIn(-print_res) } {
    helper_parray aOut
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_addr_get_all {args} {
  set docStr "cpi: entry count to retrieve every iteration
      kt_spec_static: To retrieve entries in a specific software array of KT Saturn ONU
      include_re: include mac address matching regex
      exclude_re: exclude mac addr matching regex"
  global errorInfo
  set ifnm wca_l2_addr_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l {cpi kt_spec_static include_re exclude_re}
  set v_out_key_l {mac_addr fwd_vid vid dot1p static_flag sa_permit da_permit port_id mc_group_id aging_timer}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-cpi) 13
  set aIn(-print_res) 1
  set aIn(-kt_spec_static) 0
  set aIn(-include_re) DONTCARE
  set aIn(-exclude_re) DONTCARE
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  
  set cpi $aIn(-cpi)
  set kt_spec_static $aIn(-kt_spec_static)
  set include_re $aIn(-include_re)
  set exclude_re $aIn(-exclude_re)
  set print_res $aIn(-print_res)
  set aTmp(-iterator_pointer) NULL    
  if {$res == 0 && $kt_spec_static} {
      # For KT specific static table, 1 entry per iteration, and must set static_flag as input param with value =0x10
      set usize 80
      set dsize 256
      set cpi 1
      set cmd "ca_iterator_create"
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
      if {$res == 0 } {
        set p $aTmp(-err)
        #malloc the entry_data, or else it's nil(NULL)
        set cmd "ca_uint32_array_create 0 $usize"
        set res [helper_cmd_exec -cmd $cmd -out aTmp]           
      }
      if {$res == 0} {
        set pd $aTmp(-err) 
        set cmd "ca_iterator_set_entry_data  $p $pd"
        set res [helper_cmd_exec -cmd $cmd -out aTmp]        
      } 
      if {$res == 0 } { 
        set aTmp(-iterator_pointer) $p
        set i [string first _p_unsigned_int $pd]
        set pent [string replace $pd $i end "_p_ca_l2_addr_entry_t"]
        #ca_l2_addr_entry_set_static_flag $pent 0x10    
      }
  }
  set idx 0
  for {set max 0} {$max < 10000 && $res == 0} {incr max} {
    if {$kt_spec_static} {
      ca_l2_addr_entry_set_static_flag $pent 0x10  
    }
    set res [helper_iterate -device_id $device_id \
      -data_type ca_l2_addr_entry_t\
      -iterate_func ca_l2_addr_iterate \
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]
            
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    } 
    foreach npdx $aTmp(-element_data_pointers) {
      set ent_l ""
      foreach var $v_out_key_l {        
        if {$var == "mac_addr" } {
          set mac_l ""
          set pmac [ca_l2_addr_entry_get_mac_addr  $npdx]
          for {set mac_idx 0 } {$mac_idx < 6} {incr mac_idx } {
            lappend mac_l [format %02x [ca_mac_addr_get $pmac $mac_idx]]
          }
          set mac [join $mac_l :]
#          if {[string toupper $exclude_re] ne "DONTCARE"} {
#            if {[regexp $exclude_re $mac]}  {continue}
#         }
#          if {[string toupper $include_re] ne "DONTCARE" } {
#            if {[regexp $include_re $mac] == 0} {continue}
#          }
          lappend ent_l -mac $mac
        } elseif {$var == "port_id" } {
          lappend ent_l -port_id [format "0x%05x" [ca_l2_addr_entry_get_port_id $npdx]]
        }  elseif {$var == "mc_group_id" } {
          lappend ent_l -mc_group_id [format "0x%08x" [ca_l2_addr_entry_get_mc_group_id $npdx]]
        } else {
          lappend ent_l -$var [ca_l2_addr_entry_get_$var $npdx]
        }
      }
      if {[string toupper $exclude_re] ne "DONTCARE" && [regexp $exclude_re $mac]} {
          log -tag info -msg "exclude mac $mac in result list due to match exclude_re $exclude_re"
          continue
      }
      if {[string toupper $include_re] ne "DONTCARE"  && [regexp $include_re $mac] == 0} {
          log -tag info -msg "exclude mac $mac in result list due to mismatch include_re $include_re"
          continue
      }      
      set aOut($idx) $ent_l    
      incr idx
    }
  }
  if {$max >= 10000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  }   
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {$print_res} {
    puts "\nTotal Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_l2_addr_delete {args} {
  set ifnm wca_l2_addr_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id mac vid}
  set v_key_l {fwd_vid dot1p static_flag sa_permit da_permit port_id mc_group_id aging_timer}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args

  set aTmp(-err) ""
  set mac_l ""
  foreach m [split $mac :] {
    lappend mac_l "0x$m"
  }  
  set cmd "ca_mac_addr_create $mac_l"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  set pmac $aTmp(-err)
  
  if {$res == 0 } {
    set cmd {ca_l2_addr_entry_create}  
    set res [expr $res || [helper_cmd_exec -cmd $cmd -out aTmp] ]
  }
  if {$res == 0 } { 
    set pt $aTmp(-err)
  }
  if {$res == 0 } {
    set cmd "ca_l2_addr_entry_set_mac_addr $pt $pmac"  
    set res [expr $res || [helper_cmd_exec -cmd $cmd ] ]
  }
  if {$res == 0 } {
    set cmd "ca_l2_addr_entry_set_vid $pt $vid"  
    set res [expr $res || [helper_cmd_exec -cmd $cmd ] ]
  } 
  if {$res == 0 } {
    foreach var "$v_key_l" {
      if {[info exists aIn(-$var)] && 
        [string compare -nocase $aIn(-$var) "dontcare"] } {
        set cmd "ca_l2_addr_entry_set_$var $pt $aIn(-$var)" 
        set res [helper_cmd_exec -cmd $cmd ]
        if {$res} {
          break
        }
      }
    }  
  }
  if {$res == 0 } {
    set cmd [list ca_l2_addr_delete $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  catch {ca_data_free $pmac} err
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_addr_delete_by_port {args} {
  set ifnm wca_l2_addr_delete_by_port
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id flag}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_l2_addr_delete_by_port $device_id $port_id $flag]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_l2_addr_delete_by_mac {args} {
  set ifnm wca_l2_addr_delete_by_mac
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id mac flag}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aTmp(-err) ""
  set mac_l ""
  foreach m [split $mac :] {
    lappend mac_l "0x$m"
  }  
  set cmd "ca_mac_addr_create $mac_l"  
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pmac $aTmp(-err)
    set cmd [list ca_l2_addr_delete_by_mac $device_id $pmac $flag]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    catch {ca_data_free $pmac} err
  }
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_l2_addr_delete_by_vlan {args} {
  set ifnm wca_l2_addr_delete_by_vlan
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id vid flag}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd [list ca_l2_addr_delete_by_vlan $device_id $vid $flag]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_l2_addr_delete_all {args} {
  set ifnm wca_l2_addr_delete_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }
  set v_key_l  {fag}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-flag) 2
  array set aIn $args
  set flag $aIn(-flag)
  if {[string toupper $flag] eq "DONTCARE"} {
    set flag 2
  }
  helper_h2s -source [string toupper $flag] -table CA_L2_ADDR_OP_FLAGS_T -out aX
  set flag $aX(-target)  
  set cmd [list ca_l2_addr_delete_all $device_id $flag]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_l2_mac_filter_default_set {args} {
  set ifnm wca_l2_mac_filter_default_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id drop_flag}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  array set aIn $args
  set cmd [list ca_l2_mac_filter_default_set $device_id $port_id $drop_flag]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_l2_mac_filter_default_get {args} {
  set ifnm wca_l2_mac_filter_default_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut drop_flag

  set aTmp(-err) ""
  set pt [helper_ca_boolean_create]
  if {$res == 0 } {
    set cmd [list ca_l2_mac_filter_default_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-drop_flag) [helper_ca_boolean_get $pt]
  }
  helper_data_free $pt
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_mac_filter_add {args} {
  set ifnm wca_l2_mac_filter_add
  set res 0
  log -tag itfbgn -msg $args
  if {[regexp "\-h" $args]} {
    set res [wca_l2_mac_filter_cmd -h]
  } else {
    set res [eval wca_l2_mac_filter_cmd   -operation "add"  $args]
  }
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_l2_mac_filter_delete {args} {
  set ifnm wca_l2_mac_filter_delete
  set res 0
  log -tag itfbgn -msg $args
  set res [eval wca_l2_mac_filter_cmd   -operation "delete" $args]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_l2_mac_filter_cmd {args} {
  set ifnm wca_l2_mac_filter_cmd
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id }
  set v_key_l {mask mac mac_flag vid drop_flag}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-operation) add
  array set aIn $args
  set operation $aIn(-operation)
  set aTmp(-err) ""
  if {[info exists aIn(-mac)]} {
    set mac_l [split $aIn(-mac) :]
    set n_mac_l ""
    foreach mac $mac_l {
      lappend n_mac_l 0x$mac
    }
    set cmd "ca_mac_addr_create  $n_mac_l"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
    set pmac $aTmp(-err)
    set aIn(-mac) $pmac
  }    
  set cmd {ca_l2_mac_filter_entry_create}
  set res [expr $res || [helper_cmd_exec -cmd $cmd -out aTmp] ]
  if {$res == 0 } {
    set pt $aTmp(-err)
    foreach var "$v_key_l" {
      if {[info exists aIn(-$var)] && 
          [string compare -nocase $aIn(-$var) "dontcare"]} {
        set cmd "ca_l2_mac_filter_entry_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd ]
        if {$res} {
          break
        }
      }
    }
  }
  if {$res == 0 } {
    set cmd [list ca_l2_mac_filter_$operation $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  catch {ca_data_free $pmac} err  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_mac_filter_delete_all {args} {
  set ifnm wca_l2_mac_filter_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set v_key_l {port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-port_id) "DONTCARE"
  array set aIn $args
  set port_id [string toupper $aIn(-port_id)]
  if {$port_id == "DONTCARE" } {
    set res [wca_l2_mac_filter_get_all -device_id $device_id -out aTmp -print_res 0]
    if {$res == 0 } {
      set lst ""
      foreach idx [array names aTmp] {
        catch {array unset aItem}
        array set aItem $aTmp($idx)
        if {[lsearch $lst $aItem(-port_id)] == -1} {
          lappend lst $aItem(-port_id)
        }
      }
      set port_id $lst
    }
  } else {
    set port_id [split $port_id ","]
  }
  foreach port_id $port_id {
    if {$res} {break}
    log -tag info -msg "Try to remove all l2 mac_filter on port $port_id"
    set cmd [list ca_l2_mac_filter_delete_all $device_id $port_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_l2_mac_filter_get_all {args} {
  global errorInfo
  variable gwenv
  set ifnm wca_l2_mac_filter_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id}
  set v_key_l {cpi print_res}
  set v_out_key_l {mask mac mac_flag vid drop_flag}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-cpi) 2
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  
  set cpi $aIn(-cpi)
  set print_res $aIn(-print_res)
  set aTmp(-iterator_pointer) NULL    
  set idx 0
  for {set max 0} {$max < 2000 && $res == 0} {incr max} {
    set res [helper_iterate -device_id $device_id \
      -data_type ca_l2_mac_filter_entry_iterator_t\
      -iterate_func ca_l2_mac_filter_iterate \
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]            
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    }
    foreach npdx $aTmp(-element_data_pointers) {
      set l2_l ""
      lappend l2_l -port_id [format 0x%05x [ca_l2_mac_filter_entry_iterator_get_port_id $npdx]]
      set npdx [ca_l2_mac_filter_entry_iterator_get_mac_filter $npdx]
      foreach var $v_out_key_l {
        if {$var == "mac" } {
          set mac_l ""
          set pmac [ca_l2_mac_filter_entry_get_mac  $npdx]
          for {set i 0 } {$i < 6} {incr i } {
            lappend mac_l [format %02x [ca_mac_addr_get $pmac $i]]
          }
          lappend l2_l -mac [join $mac_l :]
          continue
        }
        lappend l2_l -$var [ca_l2_mac_filter_entry_get_$var $npdx]
      }
      set aOut($idx) $l2_l 
      incr idx
    }
  }
  if {$max >= 2000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  }   
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    log -tag warning -msg $err
  }  
  
  if {$print_res} {
    puts "\nTotal Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  }
  log -tag itfend
  return $res    
}
proc ::gw::wca_l2_addr_aged_event_get {args} {
  set ifnm wca_l2_addr_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  #Note: Here the "mac" argument is indeed the "mac_addr" which is defined in CA API spec.
  set m_key_l {device_id }
  set v_o_key_l {mac vid fwd_vid vid dot1p static_flag sa_permit da_permit port_id mc_group_id aging_timer}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  if {$res == 0 } {  
    set cmd {ca_l2_addr_entry_create}  
    set res  [helper_cmd_exec -cmd $cmd -out aTmp] 
  } 
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_l2_addr_aged_event_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    foreach var $v_o_key_l {
      set aOut(-$var) [ca_l2_addr_entry_get_$var $pt]
    }
  }
  if {$res == 0 } {
    set aOut(-mc_group_id) [format "0x%08x" $aOut(-mc_group_id)]
    set aOut(-port_id) [format "0x%05x" $aOut(-port_id)]
  }
  catch {ca_data_free $pt} err

  if {$aIn(-print_res) } {
    helper_parray aOut
  }
  log -tag itfend
  return $res
}
#-------------------------------------------
#Section: L2 Management - VLAN Management
#-------------------------------------------
proc ::gw::wca_l2_vlan_learning_shared_set {args} {
  set docStr "mode can be one of IVL(0) or SVL(1)"
  set ifnm wca_l2_vlan_learning_shared_set  
  set res 0  
  set m_key_l {device_id mode}
  log -tag itfbgn -msg $args 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_h2s -source $mode -table CA_VLAN_LEARNING_MODE_T -out aX
  set mode $aX(-target)
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_learning_shared_set $device_id $mode ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_learning_shared_get {args} {
  set ifnm wca_l2_vlan_learning_shared_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut  [list mode mode_v]
  set aTmp(-err) ""
  set cmd "ca_uint32_create 0"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)  
    set cmd [list ca_l2_vlan_learning_shared_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 0 ]
  }
  if {$res == 0} {
    set aOut(-mode) [ca_uint32_get $pt]
    helper_s2h -source $aOut(-mode) -table CA_VLAN_LEARNING_MODE_T -out aX
    set aOut(-mode_v) $aX(-target)
  }
  catch {ca_data_free $pt}
  helper_parray aOut
  log -tag itfend
  return $res
}

proc ::gw::wca_l2_vlan_port_control_get {args} {
  set ifnm wca_l2_vlan_port_control_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id}
  set v_o_key_l [helper_probe_struct_members -struct ca_vlan_port_control]
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set print_res $aIn(-print_res)
  
  set aTmp(-err) ""
  set cmd {ca_vlan_port_control_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd [list ca_l2_vlan_port_control_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0} {
    foreach var $v_o_key_l {
       set aOut(-$var) [ca_vlan_port_control_get_$var $pt]
     }
  }
  helper_s2h -table CA_VLAN_TPID_TYPE_T -source $aOut(-outer_tpid) -out aTmp
  set aOut(-outer_tpid_v) $aTmp(-target)
  helper_s2h -table CA_VLAN_TPID_TYPE_T -source $aOut(-inner_tpid) -out aTmp
  set aOut(-inner_tpid_v) $aTmp(-target) 
  catch {ca_data_free $pt} err
 
  if {$print_res} {
    helper_parray aOut
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_port_control_set {args} {
  set docStr "dut_type and port_type: are used when data_int=2"
  set ifnm wca_l2_vlan_port_control_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id}
  # to change membership_check_enable to ingress_xxx later
  set v_key_l [helper_probe_struct_members -struct ca_vlan_port_control] 
 
  # add two params: dut_type(g3, g3lite) , port_type(lan, wan)
  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l "$v_key_l port_type dut_type data_init"]
  if {$res} {
    return $res
  }  
  set aIn(-dut_type) g3
  set aIn(-port_type) lan
  array set aIn $args
  set data_init $aIn(-data_init)
  set port_type [string tolower $aIn(-port_type)]
  set dut_type  [string tolower $aIn(-dut_type)]
 
  if {[info exists aIn(-outer_tpid)]} {
    helper_h2s -table CA_VLAN_TPID_TYPE_T -source $aIn(-outer_tpid) -out aTmp
    set aIn(-outer_tpid) $aTmp(-target)
  }
  if {[info exists aIn(-inner_tpid)]} {
    helper_h2s -table CA_VLAN_TPID_TYPE_T -source $aIn(-inner_tpid) -out aTmp
    set aIn(-inner_tpid) $aTmp(-target)
  }  
  set aTmp(-err) ""
  set cmd {ca_vlan_port_control_create}
  set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    #Initialize structure with system current data
    if {$data_init == 1} {
        set res [wca_l2_vlan_port_control_get -device_id $device_id -port_id $port_id -out aTmp -print_res 0]
        if {$res == 0 } {
            set res [helper_struct_config -struct ca_vlan_port_control -key_l $v_key_l -ref $pt -arg_arr aTmp]
        }
    } elseif {$data_init == 2} {
      #Using default values
      set aDef(-default_tag) 0
      set aDef(-default_tag_add) 0
      set aDef(-drop_unknown_vlan) 0
      set aDef(-egress_vlan_action_enable)  1
      set aDef(-ingress_vlan_action_enable)  1
      set aDef(-inner_tpid)  0
      set aDef(-ingress_membership_check_enable)  1
      set aDef(-egress_membership_check_enable)  1
      set aDef(-outer_tpid) 0      
      if {$port_type == "lan"} {
      } else {
          if {$dut_type == "g3" || $dut_type == "venus"} {             
              set aDef(-drop_unknown_vlan) 1  
              set aDef(-default_tag) 1
          } else {             
              set aDef(-drop_unknown_vlan) 1
              set aDef(-membership_check_enable) 0
              set aDef(-outer_tpid) 1           
          }
      }      
      parray aDef
      set res [helper_struct_config -struct ca_vlan_port_control -key_l $v_key_l -ref $pt -arg_arr aDef]
    }
  }
  if {$res == 0 } {    
    set res [helper_struct_config -struct ca_vlan_port_control -key_l $v_key_l -ref $pt -arg_arr aIn]
  }
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_port_control_set $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res  
}
proc ::gw::wca_l2_vlan_tpid_get {args} {
  set ifnm wca_l2_vlan_tpid_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id }
  set v_o_key_l {inner_tpid inner_number outer_tpid outer_number}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  if {$res == 0} {
    set pInCnt $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  }
  if {$res == 0} {
    set pOutCnt $aTmp(-err)
    set cmd {ca_uint32_array_create 0 6}
    set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  }
  if {$res == 0} {
    set pIn $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  } 
  if {$res == 0} {
    set pOut $aTmp(-err)         
    set cmd [list ca_l2_vlan_tpid_get $device_id $pIn $pInCnt $pOut $pOutCnt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0} {
      set aOut(-inner_number) [ca_uint32_get $pInCnt]
       set aOut(-outer_number) [ca_uint32_get $pOutCnt] 
       set l ""
       for {set i 0 } {$i < $aOut(-inner_number)} {incr i } {
         lappend l [format "0x%x" [ca_uint32_array_get $pIn $i]]
       }
       set l [join $l ","]
       set aOut(-inner_tpid) $l
       set l ""
       for {set i 0 } {$i < $aOut(-outer_number)} {incr i } {
         lappend l [format "0x%x" [ca_uint32_array_get $pOut $i]]
       }
       set l [join $l ","]
       set aOut(-outer_tpid) $l   
  }
  catch {ca_data_free $pIn } err
  catch {ca_data_free $pInCnt } err
  catch {ca_data_free $pOut } err
  catch {ca_data_free $pOutCnt} err

  if {$aIn(-print_res)} {
    helper_parray aOut
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_tpid_set {args} {
  set ifnm wca_l2_vlan_tpid_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id}
  set v_key_l {inner_tpid inner_number outer_tpid outer_number}  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  
  set aIn(-inner_tpid) ""
  set aIn(-outer_tpid) "" 
  set res [wca_l2_vlan_tpid_get -device_id $device_id -out aSysCfg -print_res 0]
  if {$res eq 0 } {
    foreach var $v_key_l {
      set aIn(-$var) $aSysCfg(-$var)
    }
  }
  array set aIn $args

  set aTmp(-err) ""
  set inner_tpid_l [split $aIn(-inner_tpid) ","] 
  set outer_tpid_l [split $aIn(-outer_tpid) ","] 
  
  set innerCnt $aIn(-inner_number)
  if {$innerCnt > [llength $inner_tpid_l]} {
    set innerCnt [llength $inner_tpid_l]
  }
  set outerCnt $aIn(-outer_number)
  if {$outerCnt > [llength $outer_tpid_l]} {
    set outerCnt [llength $outer_tpid_l)]
  }  
  set cmd "ca_uint32_array_create 0 $innerCnt"  
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  if {$res == 0} {
    set pInner $aTmp(-err)
    for {set i 0 } {$i < $innerCnt} {incr i} {
      set cmd [list ca_uint32_array_set $pInner  [lindex $inner_tpid_l $i] $i ]
      set res [helper_cmd_exec -cmd $cmd ]
      if {$res} {break}
    }    
  }
  if {$res == 0 } {
    set cmd "ca_uint32_array_create 0 $outerCnt"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }    
  if {$res == 0} {
    set pOuter $aTmp(-err)
    for {set i 0 } {$i < $outerCnt} {incr i} {
        set cmd [list ca_uint32_array_set $pOuter  [lindex $outer_tpid_l $i] $i ]
        set res [helper_cmd_exec -cmd $cmd ]
        if {$res} {break}
    }        
  }
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_tpid_set $device_id $pInner $innerCnt $pOuter $outerCnt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pInner} err
  catch {ca_data_free $pOuter} err
  wca_l2_vlan_tpid_get -device_id $device_id -out aSysCfg -print_res 1
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_outer_tpid_add {args} {
  set ifnm wca_l2_vlan_outer_tpid_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}  
  set res [eval helper_l2_vlan_io_tpid_action $args -io outer -action add ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_outer_tpid_delete {args} {
  set ifnm wca_l2_vlan_outer_tpid_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}
  set res [eval helper_l2_vlan_io_tpid_action $args -io outer -action delete ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_outer_tpid_list {args} {
  set ifnm wca_l2_vlan_outer_tpid_list
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut 
  set res [eval helper_l2_vlan_io_tpid_list $args -io outer -out aOut]
  helper_parray aOut
  log -tag itfend
  return $res 
}
proc ::gw::wca_l2_vlan_inner_tpid_add {args} {
  set ifnm wca_l2_vlan_inner_tpid_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}  
  set res [eval helper_l2_vlan_io_tpid_action $args -io inner -action add ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_inner_tpid_delete {args} {
  set ifnm wca_l2_vlan_inner_tpid_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}
  set res [eval helper_l2_vlan_io_tpid_action $args -io inner -action delete ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_inner_tpid_list {args} {
  set ifnm wca_l2_vlan_inner_tpid_list
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut 
  set res [eval helper_l2_vlan_io_tpid_list $args -io inner -out aOut]
  helper_parray aOut
  log -tag itfend
  return $res 
}
proc ::gw::helper_l2_vlan_io_tpid_action {args} {
  #io: inner/ounter
  #action: add/delete
  set ifnm helper_l2_vlan_io_tpid_action
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id io action tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_${io}_tpid_${action} $device_id $port_id $tpid_sel ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::helper_l2_vlan_io_tpid_list {args} {
  set ifnm helper_l2_vlan_io_tpid_list
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id io}  
  set o_key_l {tpid tpid_number}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $o_key_l
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pCnt $aTmp(-err)
    set cmd {ca_uint32_array_create 0 5} ;#risk: if maximum cnt changed to value > 5?
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pEnt $aTmp(-err)
    set cmd [list ca_l2_vlan_${io}_tpid_list $device_id $port_id $pEnt $pCnt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  if {$res == 0} {
    set aOut(-tpid_number) [ca_uint32_get $pCnt]
     set l ""
     for {set i 0 } {$i < $aOut(-tpid_number)} {incr i } {
       lappend l [format "%04x" [ca_uint32_array_get $pEnt $i]]
     }
     set aOut(-tpid) $l
  }
  helper_data_free [list $pEnt $pCnt]
  log -tag itfend
  return $res
}

#---- svlan/cvlan tpid spec commands ----
proc ::gw::wca_l2_vlan_sc_tpid_get {args} {
  set ifnm wca_l2_vlan_sc_tpid_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id }
  set v_o_key_l {svlan_tpid svlan_tpid_number cvlan_tpid cvlan_tpid_number}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  if {$res == 0} {
    set psCnt $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  }
  if {$res == 0} {
    set pcCnt $aTmp(-err)
    set cmd {ca_uint32_array_create 0 6}
    set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  }
  if {$res == 0} {
    set pS $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -check_return_value 0 -out aTmp]
  } 
  if {$res == 0} {
    set pC $aTmp(-err)         
    set cmd [list ca_l2_vlan_sc_tpid_get $device_id $pS $psCnt $pC $pcCnt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0} {
      set aOut(-svlan_tpid_number) [ca_uint32_get $psCnt]
      set aOut(-cvlan_tpid_number) [ca_uint32_get $pcCnt] 
      set l ""
      for {set i 0 } {$i < $aOut(-svlan_tpid_number)} {incr i } {
         lappend l [format "0x%x" [ca_uint32_array_get $pS $i]]
      }
      set l [join $l ","]
      set aOut(-svlan_tpid) $l
      set l ""
      for {set i 0 } {$i < $aOut(-cvlan_tpid_number)} {incr i } {
         lappend l [format "0x%x" [ca_uint32_array_get $pC $i]]
      }
      set l [join $l ","]
      set aOut(-cvlan_tpid) $l   
  }
  foreach p [list $pS $psCnt $pC $pcCnt] {catch {ca_data_free $p} err}

  if {$aIn(-print_res)} {
    helper_parray aOut
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_sc_tpid_set {args} {
  set ifnm wca_l2_vlan_sc_tpid_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id}
  set v_key_l {svlan_tpid svlan_tpid_number cvlan_tpid cvlan_tpid_number}  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  
  set aIn(-svlan_tpid) ""
  set aIn(-cvlan_tpid) "" 
  set res [wca_l2_vlan_sc_tpid_get -device_id $device_id -out aSysCfg -print_res 0]
  if {$res == 0 } {
    foreach var $v_key_l {
      set aIn(-$var) $aSysCfg(-$var)
    }
  }
  array set aIn $args

  set aTmp(-err) ""
  set svlan_tpid_l [split $aIn(-svlan_tpid) ","] 
  set cvlan_tpid_l [split $aIn(-cvlan_tpid) ","] 
  
  if {[info exists aIn(-svlan_tpid_number)] == 0 
      || [string toupper $aIn(-svlan_tpid_number)] == "DONTCARE"} {
    set sCnt [llength $svlan_tpid_l]
  } else {
    set sCnt $aIn(-svlan_tpid_number)
  }
  if {$sCnt > [llength $svlan_tpid_l]} {
    set sCnt [llength $svlan_tpid_l]
  }
  if {[info exists aIn(-cvlan_tpid_number)] == 0 
      || [string toupper $aIn(-cvlan_tpid_number)] == "DONTCARE"} {
    set cCnt [llength $cvlan_tpid_l]
  } else {
    set cCnt $aIn(-cvlan_tpid_number)
  }
  if {$cCnt > [llength $cvlan_tpid_l]} {
    set cCnt [llength $cvlan_tpid_l)]
  }  
  set cmd "ca_uint32_array_create 0 $sCnt"  
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  if {$res == 0} {
    set pS $aTmp(-err)
    for {set i 0 } {$i < $sCnt} {incr i} {
      set cmd [list ca_uint32_array_set $pS  [lindex $svlan_tpid_l $i] $i ]
      set res [helper_cmd_exec -cmd $cmd ]
      if {$res} {break}
    }    
  }
  if {$res == 0 } {
    set cmd "ca_uint32_array_create 0 $cCnt"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }    
  if {$res == 0} {
    set pC $aTmp(-err)
    for {set i 0 } {$i < $cCnt} {incr i} {
        set cmd [list ca_uint32_array_set $pC  [lindex $cvlan_tpid_l $i] $i ]
        set res [helper_cmd_exec -cmd $cmd ]
        if {$res} {break}
    }        
  }
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_sc_tpid_set $device_id $pS $sCnt $pC $cCnt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pS} err
  catch {ca_data_free $pC} err
  wca_l2_vlan_sc_tpid_get -device_id $device_id -out aSysCfg -print_res 1
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_outer_svlan_tpid_add {args} {
  set ifnm wca_l2_vlan_outer_svlan_tpid_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}  
  set res [eval helper_l2_vlan_io_tpid_action $args -io outer_svlan -action add ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_outer_svlan_tpid_delete {args} {
  set ifnm wca_l2_vlan_outer_svlan_tpid_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}  
  set res [eval helper_l2_vlan_io_tpid_action $args -io outer_svlan -action delete ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_inner_svlan_tpid_add {args} {
  set ifnm wca_l2_vlan_inner_svlan_tpid_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}  
  set res [eval helper_l2_vlan_io_tpid_action $args -io inner_svlan -action add ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_inner_svlan_tpid_delete {args} {
  set ifnm wca_l2_vlan_inner_svlan_tpid_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}  
  set res [eval helper_l2_vlan_io_tpid_action $args -io inner_svlan -action delete ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_svlan_tpid_list {args} {
  set ifnm wca_l2_vlan_svlan_tpid_list
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut 
  set res [eval helper_l2_vlan_sc_tpid_get_all $args -sc svlan -out aOut]
  helper_parray aOut
  log -tag itfend
  return $res 
}
proc ::gw::wca_l2_vlan_outer_cvlan_tpid_add {args} {
  set ifnm wca_l2_vlan_outer_cvlan_tpid_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}  
  set res [eval helper_l2_vlan_io_tpid_action $args -io outer_cvlan -action add ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_outer_cvlan_tpid_delete {args} {
  set ifnm wca_l2_vlan_outer_cvlan_tpid_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}  
  set res [eval helper_l2_vlan_io_tpid_action $args -io outer_cvlan -action delete ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_inner_cvlan_tpid_add {args} {
  set ifnm wca_l2_vlan_inner_cvlan_tpid_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}  
  set res [eval helper_l2_vlan_io_tpid_action $args -io inner_cvlan -action add ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_inner_cvlan_tpid_delete {args} {
  set ifnm wca_l2_vlan_inner_cvlan_tpid_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tpid_sel}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}  
  set res [eval helper_l2_vlan_io_tpid_action $args -io inner_cvlan -action delete ]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_cvlan_tpid_list {args} {
  set ifnm wca_l2_vlan_cvlan_tpid_list
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut 
  set res [eval helper_l2_vlan_sc_tpid_get_all $args -sc cvlan -out aOut]
  helper_parray aOut
  log -tag itfend
  return $res 
}

proc ::gw::helper_l2_vlan_sc_tpid_get_all {args} {
  set ifnm helper_l2_vlan_sc_tpid_get_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id sc}  
  set o_key_l {outer_tpid outer_tpid_number inner_tpid inner_tpid_number}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $o_key_l
  set cmd {ca_uint32_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pOuterCnt $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pInnerCnt $aTmp(-err)
    set cmd {ca_uint32_array_create 0 5} ;#risk: if maximum cnt changed to value > 5?
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }  
  if {$res == 0} {
    set pOuterEnt $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  if {$res == 0} {
    set pInnerEnt $aTmp(-err)
    set cmd [list ca_l2_vlan_${sc}_tpid_list $device_id $port_id $pOuterEnt $pOuterCnt $pInnerEnt $pInnerCnt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  if {$res == 0} {
    set aOut(-outer_tpid_number) [ca_uint32_get $pOuterCnt]
    set l ""
    for {set i 0 } {$i < $aOut(-outer_tpid_number)} {incr i } {
      lappend l [format "%04x" [ca_uint32_array_get $pOuterEnt $i]]
    }
    set aOut(-outer_tpid) $l
    set aOut(-inner_tpid_number) [ca_uint32_get $pInnerCnt]
    set l ""
    for {set i 0 } {$i < $aOut(-inner_tpid_number)} {incr i } {
      lappend l [format "%04x" [ca_uint32_array_get $pInnerEnt $i]]
    }
    set aOut(-inner_tpid) $l     
  }
  helper_data_free [list $pEnt $pCnt]
  log -tag itfend
  return $res
}
#----end of spec svlan/cvlan 

proc ::gw::wca_l2_vlan_create {args} {
  set docStr "Support create multi vlans. vid can be as:
      1-200: to add 200 vlans to system from 1 to 200
      1,8,9-11: to add vlan 1,8,9,10,11 to system"
  set ifnm wca_l2_vlan_create
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id vid}
   set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_expand_list -set $vid -out aTmp
  set vid_l $aTmp(-l)
  foreach vid $vid_l {
    if {$res == 0 } {
      set cmd [list ca_l2_vlan_create $device_id $vid ]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    } else {
      break
    }
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_delete {args} {
  set ifnm wca_l2_vlan_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id vid}
   set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_expand_list -set $vid -out aTmp
  set vid_l $aTmp(-l)
  foreach vid $vid_l {
    if {$res == 0 } {
      set cmd [list ca_l2_vlan_delete $device_id $vid ]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    } else {break}
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_delete_all {args} {
  set ifnm wca_l2_vlan_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_delete_all $device_id ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_port_set {args} {
  set docStr "Support multi vlans.Eg, can specify vid as 1-20, or, '1,2,7-9,22'"
  set ifnm wca_l2_vlan_port_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id vid  }
  set v_key_l {member_count  untagged_count  member_ports untagged_ports}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-member_count) DONTCARE
  set aIn(-untagged_count) DONTCARE
  set aIn(-member_ports) ""
  set aIn(-untagged_ports) ""
  #set res [wca_l2_vlan_port_get -device_id $device_id -vid $vid  -out aIn]
  array set aIn $args
  
  set member_ports [split $aIn(-member_ports) ,]
  set untagged_ports  [split $aIn(-untagged_ports) ,]
  set mCnt [string toupper $aIn(-member_count)]
  set uCnt [string toupper $aIn(-untagged_count)]
  if {$mCnt == "DONTCARE"} {set mCnt [llength $member_ports]}
  if {$uCnt == "DONTCARE"} {set uCnt [llength $untagged_ports]}
  if {$mCnt > [llength $member_ports]} {
    set mCnt [llength $member_ports]
  } 
  if {$uCnt > [llength $untagged_ports]} {
    set uCnt [llength $untagged_ports]
  }   
  helper_expand_list -set $vid -out aTmp
  set vid_l $aTmp(-l)
  if {$res == 0 } {
      set cmd "ca_uint32_array_create 0 $mCnt"  
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }     
  if {$res == 0} {
    set pM $aTmp(-err)
    set cmd "ca_uint32_array_create 0 $uCnt"  
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  } 
  if {$res == 0 } {
    set pU $aTmp(-err)
  }
  for {set i 0 } {$i < $mCnt && $res == 0} {incr i} {
    set cmd "ca_uint32_array_set $pM  [lindex $member_ports $i] $i "
    set res [helper_cmd_exec -cmd $cmd]
  }
  for {set i 0 } {$i < $uCnt && $res == 0 } {incr i} {
    set cmd "ca_uint32_array_set $pU [lindex $untagged_ports $i] $i"
    set res [helper_cmd_exec -cmd $cmd]
  } 
  if {$res == 0 } {
    foreach vid $vid_l {
      set cmd [list ca_l2_vlan_port_set $device_id $vid $mCnt $pM $uCnt $pU]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
      if {$res} {
        log -tag warning -msg "Failed to configure vlan port for vlan $vid"
        break
      }
    }
  }
  helper_data_free [list $pM $pU]
  log -tag itfend
  return $res      
}
proc ::gw::wca_l2_vlan_port_get {args} {
  set ifnm wca_l2_vlan_port_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id vid}
  set o_key_l {member_count member_ports untagged_count untagged_ports}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set mCnt 16
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $o_key_l
  set cmd {ca_uint8_create 0}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pMCnt $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pUCnt $aTmp(-err)  
  }
  set cmd "ca_uint32_array_create 0 $mCnt"  
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pM $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pU $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_l2_vlan_port_get $device_id $vid $pMCnt $pM $pUCnt $pU]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
    if {$res == 0} {
       set aOut(-member_count) [ca_uint8_get $pMCnt]
       set aOut(-untagged_count) [ca_uint8_get $pUCnt] 
       set l ""
       for {set i 0 } {$i < $aOut(-member_count)} {incr i } {
         lappend l  [format "0x%05x"  [ca_uint32_array_get $pM $i]]
       }
       set aOut(-member_ports) [join $l  ","]
       set l ""
       for {set i 0 } {$i < $aOut(-untagged_count)} {incr i } {
         lappend l  [format "0x%05x" [ca_uint32_array_get $pU $i]]
       }    
       set aOut(-untagged_ports) [join $l ","]
    }
  }    
  helper_data_free [list $pM $pU $pMCnt $pUCnt]
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_get_all {args} {
  set docStr "cpi - count per iteration"
  global errorInfo
  variable gwenv
  set ifnm wca_l2_vlan_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l {cpi get_empty_vlan}
  set v_ret_key_l {vid member_count member_ports untagged_count untagged_ports }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  
  set aIn(-cpi) 2
  set aIn(-get_empty_vlan) 1
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut 
  set cpi $aIn(-cpi) 
  set print_res $aIn(-print_res)
  set get_empty_vlan $aIn(-get_empty_vlan)
  set aTmp(-iterator_pointer) NULL    
  set idx 0
  set known_vlan_list ""
  for {set max 0} {$max < 10000 && $res == 0} {incr max} {
    set res [helper_iterate -device_id $device_id \
      -data_type ca_vlan_iterate_entry_t\
      -iterate_func ca_l2_vlan_iterate \
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]            
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    }
    foreach npdx $aTmp(-element_data_pointers) {
      catch {array unset aTmp0 } ignore
      array set aTmp0 ""
      #ca_vlan_iterate_entry_dump $npdx
      set aTmp0(-read_by) ITR
      set aTmp0(-vid)   [ca_vlan_iterate_entry_get_vid $npdx]
      lappend known_vlan_list $aTmp0(-vid)
      set aTmp0(-member_count)  [ca_vlan_iterate_entry_get_member_count $npdx]
      #puts "count=$aTmp0(-member_count)"
      set aTmp0(-untagged_count)  [ca_vlan_iterate_entry_get_untagged_count $npdx]
      set port_l ""
      for {set x 0 } {$x < $aTmp0(-member_count)} {incr x} {
        lappend port_l [format 0x%05x [ca_vlan_iterate_entry_get_member_ports $npdx $x]]
      }
      set aTmp0(-member_ports) [join $port_l ,]
      if {[llength $port_l] == 0 } {
        set aTmp0(-member_ports) NA
      }   
      set port_l ""
      for {set x 0 } {$x < $aTmp0(-untagged_count)} {incr x} {
        lappend port_l [format 0x%05x [ca_vlan_iterate_entry_get_untagged_ports $npdx $x]]
      }
      set aTmp0(-untagged_ports) [join $port_l ,]   
      if {[llength $port_l] == 0 } {
        set aTmp0(-untagged_ports) NA
      }    
      set aOut($idx) [array get aTmp0] 
      incr idx
    }
  }
  if {$max >= 10000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  }   
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    log -tag warning -msg $err
  }
  #Walk around for vlan without port, namely vlan is only created by ca_l2_vlan_create by not assigned port
  if {$get_empty_vlan } {
    for {set i 0 } {$i < 4096 } {incr i } {
      if {[lsearch $known_vlan_list $i] >= 0 } {
        continue
      }
      set retc [ca_l2_vlan_create 0 $i ]      
      if {$retc == 14} {
        lappend known_vlan_lst $i
        set aOut($idx) [list -vid $i -member_count 0 -member_ports NA -untagged_count 0 -untagged_ports NA -read_by TRY]
        incr idx
      }
      if {$retc == 0 } {
        set retc [ca_l2_vlan_delete 0 $i]
        if {$retc} {
          log -tag error -msg "Failed to remove temporary vlan $i"
          set res -1
        }
      }
    }
  }  
  if {$print_res} {
    puts "\nTotal L2 VLAN Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  } 
  log -tag itfend
  return $res 
}
proc ::gw::wca_l2_vlan_ingress_action_add {args} {
  set docStr "
  key_type is used to specify which key entry field to be used.Per bit for one field of key
      entry. You can specify all meaningful fields by key_type, or to specify specific bit by sel_*. 
      later one has higher priority.And for handy, you can ignore parameter key_type and sel_*, the
      script will set key_type bit for you automatically according to your input key type fields
  inner/outer_vlan_cmd can be one of: NOP(0),PUSH(1),POP(2),SWAP(3)
  "
  set ifnm wca_l2_vlan_ingress_action_add
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id }
  helper_ca_vlan_action_params_declare

  set v_key_l  "key_type $v_key_type_sel_l $v_key_entry_l $v_action_l"
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
 # set aIn(-new_inner_pri) 0xffffffff
 # set aIn(-new_outer_pri) 0xffffffff  
  array set aIn $args
  set cmd "ca_vlan_key_entry_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pkey $aTmp(-err)
    set res [eval helper_ca_vlan_key_entry_set -pkey $pkey [array get aIn]]     
  } 
  set cmd "ca_vlan_action_create"
  if {$res == 0 } {
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pt $aTmp(-err)
    set res [eval helper_ca_vlan_action_entry_set -paction $pt [array get aIn]]
  }
  if {$res == 0 } {
    #after 200
    set cmd [list ca_l2_vlan_ingress_action_add $device_id $port_id $pkey $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err

  log -tag itfend
  return $res                     
}
proc ::gw::wca_l2_vlan_ingress_action_delete {args} {
  set docStr "
  key_type is used to specify which key entry field to be used.Per bit for one field of key
      entry. You can specify all meaningful fields by key_type, or to specify specific bit by sel_*. 
      later one has higher priority.And for handy, you can ignore parameter key_type and sel_*, the
      script will set key_type bit for you automatically according to your input key type fields
  "
  set ifnm wca_l2_vlan_ingress_action_delete
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id}
  helper_ca_vlan_action_params_declare
  set v_key_l  "key_type $v_key_type_sel_l $v_key_entry_l"
  set res [helper_m_args_check -args $args -m_key_l $m_key_l ]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_vlan_key_entry_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pkey $aTmp(-err)
    set res [eval helper_ca_vlan_key_entry_set -pkey $pkey $args] 
  } 
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_ingress_action_delete $device_id $port_id $pkey]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
 
  log -tag itfend
  return $res      
}
proc ::gw::wca_l2_vlan_ingress_action_delete_all {args} {
  set ifnm wca_l2_vlan_ingress_action_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_ingress_action_delete_all $device_id $port_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_ingress_action_get {args} {
  set ifnm wca_l2_vlan_ingress_action_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id }
  helper_ca_vlan_action_params_declare
  set v_key_l  "key_type $v_key_type_sel_l $v_key_entry_l"
  set res [helper_m_args_check -args $args -m_key_l $m_key_l ]
  if {$res} {
    return $res
  }
  array set aIn $args 
  helper_output_declare aIn
  helper_output_init aOut  "$v_key_l $v_action_l"
  set cmd "ca_vlan_key_entry_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pkey $aTmp(-err)
    set res [eval helper_ca_vlan_key_entry_set -pkey $pkey $args] 

  }   
  set cmd "ca_vlan_action_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)  
    set cmd [list ca_l2_vlan_ingress_action_get $device_id $port_id $pkey $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
     foreach var $v_action_l {
       set aOut(-$var) [ca_vlan_action_get_$var $pt]
       if {$var == "inner_vlan_cmd" || $var == "outer_vlan_cmd"} {
         helper_s2h -table CA_VLAN_TAG_ACTION_T -source $aOut(-$var) -out aH
         set aOut(-${var}_v) $aH(-target)
       }  elseif {$var eq "new_inner_pri_src" || $var eq "new_outer_pri_src" } {
          helper_s2h -table CA_VLAN_TAG_PRIORITY_SOURCE_T -source $aOut(-$var) -out aH
          set aOut(-${var}_v) $aH(-target)
       } elseif {$var eq "new_inner_tpid_src" || $var eq "new_outer_tpid_src"} {
          helper_s2h -table CA_VLAN_TPID_SOURCE_T -source $aOut(-$var)  -out aH
          set aOut(-${var}_v) $aH(-target)         
       } elseif {$var eq "new_inner_vlan_src" || $var eq "new_outer_vlan_src"} {
          helper_s2h -table CA_VLAN_NEW_VLAN_SOURCE_T -source $aOut(-$var)  -out aH
          set aOut(-${var}_v) $aH(-target)          
       }
     }
     set res [helper_ca_vlan_key_entry_get -pkey $pkey -out aOut]
  }    
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res        
}
proc ::gw::wca_l2_vlan_ingress_action_get_all {args} {
  global errorInfo
  set ifnm wca_l2_vlan_ingress_action_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set v_key_l {cpi}
  helper_ca_vlan_action_params_declare  
  set v_com_ret_key_l $v_key_entry_l
  set v_ret_key_l $v_action_l 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-cpi) 5
  set aIn(-exp_args) DONTCARE
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut 
  set cpi $aIn(-cpi)    
  set exp_args $aIn(-exp_args)   
  set idx 0
  foreach port_id $port_id {
    if {$res} {break}
    set aTmp(-iterator_pointer) NULL      
    for {set  max 0} {$max < 10000 && $res == 0 } {incr max} { 
      set res [helper_iterate -device_id $device_id \
        -data_type ca_vlan_action_iterate_entry_t\
        -iterate_func ca_l2_vlan_ingress_action_iterate\
        -parse_func DONTCARE -cpi $cpi \
        -auto_release 0  -earg0 $port_id \
        -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]
      if {$res } {
        if {$res == 9 } {set res 0}
        break
      } 
      foreach npdx $aTmp(-element_data_pointers) {
        catch {array unset aVars} ignore
        set aVars(-port_id) $port_id
        set vnpdx [ca_vlan_action_iterate_entry_get_key $npdx]
        set res [helper_ca_vlan_key_entry_get -pkey $vnpdx -out aKeyEnt]
        
        if {$res} {break}
        if {[string compare [string toupper $exp_args] "DONTCARE"] == 0 } {
            array set aVars [array get aKeyEnt]
        } else {
            foreach var [array names aKeyEnt] {
              if {[lsearch $exp_args $var] < 0 } {continue}
                set aVars(-$var)  $aKeyEnt(-$var)
            } 
        }
        set vnpdx [ca_vlan_action_iterate_entry_get_action $npdx ]      
        foreach var $v_ret_key_l { 
          if {[string compare [string toupper $exp_args] "DONTCARE"] 
            && [lsearch $exp_args $var] < 0 } {continue}
          set aVars(-$var) [ca_vlan_action_get_$var $vnpdx]
          if {$var == "inner_vlan_cmd" || $var == "outer_vlan_cmd"} {
            helper_s2h -table CA_VLAN_TAG_ACTION_T -source $aVars(-$var) -out aH
            set aVars(-${var}_v) $aH(-target)
          }  elseif {$var eq "new_inner_pri_src" || $var eq "new_outer_pri_src" } {
            helper_s2h -table CA_VLAN_TAG_PRIORITY_SOURCE_T -source $aVars(-$var) -out aH
            set aVars(-${var}_v) $aH(-target)
          } elseif {$var eq "new_inner_tpid_src" || $var eq "new_outer_tpid_src"} {
            helper_s2h -table CA_VLAN_TPID_SOURCE_T -source $aVars(-$var)  -out aH
            set aVars(-${var}_v) $aH(-target)         
          } elseif {$var eq "new_inner_vlan_src" || $var eq "new_outer_vlan_src"} {
            helper_s2h -table CA_VLAN_NEW_VLAN_SOURCE_T -source $aVars(-$var)  -out aH
            set aVars(-${var}_v) $aH(-target)          
          }   
        }
        set aOut($idx) [array get aVars]
        incr idx
      }
    } ;#end of for
    if {$max > 10000 } {
      log -tag warning -msg "Seems infinit loop occurs"
    }
    if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
      log -tag warning -msg $err
    }
    if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
      log -tag warning -msg $err
    } 
  };#foreach port 
  if {$aIn(-print_res)} {
    puts "\nTotal L2 VLAN Ingress Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_l2_vlan_ingress_default_action_set {args} {
  set docStr "For optional parameters, means of different prefixes:
    u_  : untag
    s_  : single tag
    d_  : double tag"
  # input: -device_id xx -port_id xx -u_action_inner_vlan xxx ...
  set ifnm wca_l2_vlan_ingress_default_action_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id}
  helper_ca_vlan_action_params_declare
  set v_action_key_l $v_action_l
  set v_spec_default_key_l {inner_vlan_cmd new_inner_pri new_inner_tpid_index \
          outer_vlan_cmd new_outer_pri new_outer_tpid_index}
  set cat_l {u s d}
  set v_key_l ""
  foreach pre $cat_l {
    foreach var $v_action_key_l {
      lappend v_key_l ${pre}_$var
    } 
    foreach var $v_spec_default_key_l {
      set aIn(${pre}_$var) 0xFFFFFFFF
    }
  }   
  set res [helper_m_args_check -args $args ]
  if {$res} {
    return $res
  }
  array set aIn $args
  
  set data_init $aIn(-data_init)
  
  set aTmp(-err) ""
  set cmd "ca_vlan_action_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pDF $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }  
  if {$res == 0} {
    set pU $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pS $aTmp(-err)  
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pD $aTmp(-err)
  }
  #Initialize structures with system current data
  if {$res == 0 } {
    if {$data_init == 1} {
      set cmd [list ca_l2_vlan_ingress_default_action_get $device_id $port_id  $pU $pS $pD]
      if {[catch $cmd err]} {
        log -tag error -msg "Failed to invoke $cmd. $err"
        set res -1
      }  else {
        set res $err
        if {$res} {
          log -tag error -msg "Failed to invoke command {$cmd}. Return value is $res instead of 0"
        }  
      }  
    }
  }
  if {$res == 0 } {
    foreach pre $cat_l pt { pU pS pD} {   
      foreach var $v_action_key_l {
        if {[info exists aIn(-${pre}_$var)] && 
          [string compare [string tolower $aIn(-${pre}_$var)] "dontcare"]} {
          set val $aIn(-${pre}_$var)
          if {$var eq "inner_vlan_cmd" || $var eq "outer_vlan_cmd"} {
            helper_h2s -table CA_VLAN_TAG_ACTION_T -source $val -out aH
            set val $aH(-target)
          } elseif {$var eq "new_inner_pri_src" || $var eq "new_outer_pri_src" } {
            helper_h2s -table CA_VLAN_TAG_PRIORITY_SOURCE_T -source $val -out aH
            set val $aH(-target)
          } elseif {$var eq "new_inner_tpid_src" || $var eq "new_outer_tpid_src"} {
            helper_h2s -table CA_VLAN_TPID_SOURCE_T -source $val -out aH
            set val $aH(-target)          
          } elseif {$var eq "new_inner_vlan_src" || $var eq "new_outer_vlan_src"} {
            helper_h2s -table CA_VLAN_NEW_VLAN_SOURCE_T -source $val -out aH
            set val $aH(-target)          
          }          
          set cmd "ca_vlan_action_set_$var [set $pt] $val"
          set res [helper_cmd_exec -cmd $cmd]
          if {$res} {break}
        } 
      }
    }
  }
  if {$res == 0 } {   
    set cmd [list ca_l2_vlan_ingress_default_action_set $device_id $port_id  $pU $pS $pD]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  foreach pt {pDF pU pS pD} {
    catch {ca_data_free [set $pt]} err
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_ingress_default_action_get {args} {
  set ifnm wca_l2_vlan_ingress_default_action_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id }
  helper_ca_vlan_action_params_declare
  set v_action_key_l $v_action_l
  set cat_l {u s d}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut 
  foreach pre $cat_l {
    foreach var $v_action_key_l {
      set aOut(-${pre}_$var) unknown
    } 
  }
  set cmd "ca_vlan_action_create"  
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pDF $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }  
  if {$res == 0} {
    set pU $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pS $aTmp(-err)  
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pD $aTmp(-err)
  }
  if {$res == 0 } {  
    set cmd [list ca_l2_vlan_ingress_default_action_get $device_id $port_id  $pU $pS $pD]
    if {[catch $cmd err]} {
      log -tag error -msg "Failed to invoke $cmd. $err"
      set res -1
    }  else {
      set res $err
      if {$res} {
        log -tag error -msg "Failed to invoke command {$cmd}. Return value is $res instead of 0"
      } else {
        foreach pre $cat_l pt {pU pS pD} {        
          foreach var $v_action_key_l {
             set aOut(-${pre}_$var) [ca_vlan_action_get_$var [set $pt] ]
             #if {$var == "inner_vlan_cmd" || $var == "outer_vlan_cmd"} {
             #  helper_s2h -table CA_VLAN_TAG_ACTION_T -source $aOut(-${pre}_${var}) -out aTmp
             #  set aOut(-${pre}_${var}_v) $aTmp(-target)
             #}
             if {$var == "inner_vlan_cmd" || $var == "outer_vlan_cmd"} {
               helper_s2h -table CA_VLAN_TAG_ACTION_T -source $aOut(-${pre}_${var}) -out aH
               set aOut(-${pre}_${var}_v) $aH(-target)
             }  elseif {$var eq "new_inner_pri_src" || $var eq "new_outer_pri_src" } {
               helper_s2h -table CA_VLAN_TAG_PRIORITY_SOURCE_T -source $aOut(-${pre}_${var}) -out aH
               set aOut(-${pre}_${var}_v) $aH(-target)
             } elseif {$var eq "new_inner_tpid_src" || $var eq "new_outer_tpid_src"} {
               helper_s2h -table CA_VLAN_TPID_SOURCE_T -source $aOut(-${pre}_${var})  -out aH
               set aOut(-${pre}_${var}_v) $aH(-target)         
             } elseif {$var eq "new_inner_vlan_src" || $var eq "new_outer_vlan_src"} {
               helper_s2h -table CA_VLAN_NEW_VLAN_SOURCE_T -source $aOut(-${pre}_${var})  -out aH
               set aOut(-${pre}_${var}_v) $aH(-target)          
             }
           }         
         }
      }
    } 
  }
  foreach pt {pDF pU pS pD } {   
    catch {ca_data_free [set $pt]} err
  }
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_egress_action_add {args} {
  set docStr "
  key_type is used to specify which key entry field to be used.Per bit for one field of key
      entry. You can specify all meaningful fields by key_type, or to specify specific bit by 'sel_*'. 
      later one has higher priority.And for handy, you can ignore parameter key_type and 'sel_*', the
      script will set key_type bit for you automatically according to your input key type fields
  inner/outer_vlan_cmd can be one of: NOP(0),PUSH(1),POP(2),SWAP(3)
  "
  set ifnm wca_l2_vlan_egress_action_add
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id }
  helper_ca_vlan_action_params_declare
  set v_key_l  "key_type $v_key_type_sel_l $v_key_entry_l $v_action_l"
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
#  set aIn(-new_inner_pri) 0xffffffff
#  set aIn(-new_outer_pri) 0xffffffff
  array set aIn $args
  set cmd "ca_vlan_key_entry_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pkey $aTmp(-err)
    set res [eval helper_ca_vlan_key_entry_set -pkey $pkey [array get aIn]]
  } 
  set cmd "ca_vlan_action_create"
  if {$res == 0 } {
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pt $aTmp(-err)
    set res [eval helper_ca_vlan_action_entry_set -paction $pt [array get aIn]]
  }
  if {$res == 0 } {
    #after 200
    set cmd [list ca_l2_vlan_egress_action_add $device_id $port_id $pkey $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res                     
}
proc ::gw::wca_l2_vlan_egress_action_delete {args} {
  set ifnm wca_l2_vlan_egress_action_delete
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id}
  helper_ca_vlan_action_params_declare  
  set v_key_l  "key_type $v_key_type_sel_l $v_key_entry_l"
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_vlan_key_entry_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pkey $aTmp(-err)
    set res [eval helper_ca_vlan_key_entry_set -pkey $pkey $args] 
  } 
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_egress_action_delete $device_id $port_id $pkey]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res        
}
proc ::gw::wca_l2_vlan_egress_action_delete_all {args} {
  set ifnm wca_l2_vlan_egress_action_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_egress_action_delete_all $device_id $port_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res      
}
proc ::gw::wca_l2_vlan_egress_action_get {args} {
  set ifnm wca_l2_vlan_egress_action_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id }
  helper_ca_vlan_action_params_declare
  set v_key_l  "key_type $v_key_type_sel_l $v_key_entry_l"
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args 
  helper_output_declare aIn
  helper_output_init aOut  "$v_key_l $v_action_l"
  set cmd "ca_vlan_key_entry_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pkey $aTmp(-err)
    set res [eval helper_ca_vlan_key_entry_set -pkey $pkey $args] 
  }   
  set cmd "ca_vlan_action_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)  
    set cmd [list ca_l2_vlan_egress_action_get $device_id $port_id $pkey $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
      foreach var $v_action_l {
        set aOut(-$var) [ca_vlan_action_get_$var $pt]       
        if {$var == "inner_vlan_cmd" || $var == "outer_vlan_cmd"} {
          helper_s2h -table CA_VLAN_TAG_ACTION_T -source $aOut(-$var) -out aH
          set aOut(-${var}_v) $aH(-target)
        }  elseif {$var eq "new_inner_pri_src" || $var eq "new_outer_pri_src" } {
          helper_s2h -table CA_VLAN_TAG_PRIORITY_SOURCE_T -source $aOut(-$var) -out aH
          set aOut(-${var}_v) $aH(-target)
        } elseif {$var eq "new_inner_tpid_src" || $var eq "new_outer_tpid_src"} {
          helper_s2h -table CA_VLAN_TPID_SOURCE_T -source $aOut(-$var)  -out aH
          set aOut(-${var}_v) $aH(-target)         
        } elseif {$var eq "new_inner_vlan_src" || $var eq "new_outer_vlan_src"} {
          helper_s2h -table CA_VLAN_NEW_VLAN_SOURCE_T -source $aOut(-$var)  -out aH
          set aOut(-${var}_v) $aH(-target)          
        }                
      }
      set res [helper_ca_vlan_key_entry_get -pkey $pkey -out aOut]
  }    
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res        
}
proc ::gw::wca_l2_vlan_egress_action_get_all {args} {
  global errorInfo
  set ifnm wca_l2_vlan_egress_action_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id port_id}
  set v_key_l {cpi}
  helper_ca_vlan_action_params_declare  
  set v_com_ret_key_l $v_key_entry_l
  set v_ret_key_l $v_action_l 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-cpi) 5
  set aIn(-print_res) 1
  set aIn(-exp_args) DONTCARE
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut 
  set cpi $aIn(-cpi)  
  set print_res $aIn(-print_res)
  set exp_args $aIn(-exp_args)
 
  set idx 0
  foreach port_id $port_id {
    if {$res} {break}
    set aTmp(-iterator_pointer) NULL      
    for {set  max 0} {$max < 10000 && $res == 0 } {incr max} { 
      set res [helper_iterate -device_id $device_id \
        -data_type ca_vlan_action_iterate_entry_t\
        -iterate_func ca_l2_vlan_egress_action_iterate\
        -parse_func DONTCARE -cpi $cpi \
        -auto_release 0  -earg0 $port_id \
        -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]
      if {$res } {
        if {$res == 9 } {set res 0}
        break
      } 
      foreach npdx $aTmp(-element_data_pointers) {
        catch {array unset aVars} ignore
        set aVars(-port_id) $port_id
        set vnpdx [ca_vlan_action_iterate_entry_get_key $npdx]
        set res [helper_ca_vlan_key_entry_get -pkey $vnpdx -out aKeyEnt]
        if {$res} {break}
        if {[string compare [string toupper $exp_args] "DONTCARE"] == 0 } {
            array set aVars [array get aKeyEnt]
        } else {
            foreach var [array names aKeyEnt] {
              if {[lsearch $exp_args $var] < 0 } {continue}
                set aVars(-$var)  $aKeyEnt(-$var)
            } 
        }
        set vnpdx [ca_vlan_action_iterate_entry_get_action $npdx ]      
        foreach var $v_ret_key_l { 
          if {[string compare [string toupper $exp_args] "DONTCARE"] 
            && [lsearch $exp_args $var] < 0 } {continue}
          set aVars(-$var) [ca_vlan_action_get_$var $vnpdx]
          if {$var == "inner_vlan_cmd" || $var == "outer_vlan_cmd"} {
            helper_s2h -table CA_VLAN_TAG_ACTION_T -source $aVars(-$var) -out aH
            set aVars(-${var}_v) $aH(-target)
          } elseif {$var eq "new_inner_pri_src" || $var eq "new_outer_pri_src" } {
            helper_s2h -table CA_VLAN_TAG_PRIORITY_SOURCE_T -source $aVars(-$var) -out aH
            set aVars(-${var}_v) $aH(-target)
          } elseif {$var eq "new_inner_tpid_src" || $var eq "new_outer_tpid_src"} {
            helper_s2h -table CA_VLAN_TPID_SOURCE_T -source $aVars(-$var)  -out aH
            set aVars(-${var}_v) $aH(-target)         
          } elseif {$var eq "new_inner_vlan_src" || $var eq "new_outer_vlan_src"} {
            helper_s2h -table CA_VLAN_NEW_VLAN_SOURCE_T -source $aVars(-$var)  -out aH
            set aVars(-${var}_v) $aH(-target)          
          }                        
        }
        set aOut($idx) [array get aVars]
        incr idx
      }
    } ;#end of for
    if {$max > 10000 } {
      log -tag warning -msg "Seems infinit loop occurs"
    }
    if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
      log -tag warning -msg $err
    }
    if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
      log -tag warning -msg $err
    } 
  };#foreach port 
  if {$aIn(-print_res)} {
    puts "\nTotal L2 VLAN Egress Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_l2_vlan_egress_default_action_set {args} {
  set docStr "For optional parameters, means of different prefixes:
    df_ : default
    u_  : untag
    s_  : single tag
    d_  : double tag
    
    data_init: 1 (default) - Init data structure with current system configure
               2 - First initialize structure with system current configuration, then fill some fields with default values "
  # input: -device_id xx -port_id xx -u_inner_vlan xxx ...
  set ifnm wca_l2_vlan_egress_default_action_set
  set res 0
  set defaultEgressInvalid 0xFFFFFFFF 
  set defaultFlowId 65535  
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id port_id}
  helper_ca_vlan_action_params_declare
  set v_action_key_l $v_action_l
  set v_spec_default_key_l {inner_vlan_cmd new_inner_pri new_inner_tpid_index \
          outer_vlan_cmd new_outer_pri new_outer_tpid_index}
  set cat_l {df u s d}
  set v_key_l ""
  foreach pre $cat_l {
    foreach var $v_action_key_l {
      lappend v_key_l ${pre}_$var
    } 
    foreach var $v_spec_default_key_l {
      set aIn(${pre}_$var) $defaultEgressInvalid
    }
  } 

  set res [helper_m_args_check -args $args -v_key_l "$v_key_l data_init" ]
  if {$res} {
    return $res
  }
  
  array set aIn $args
  set data_init $aIn(-data_init)
  helper_h2s -table INPUT_PARAM_INIT_TYPE_T -source $data_init -out aH
  set data_init $aH(-target)
  set aTmp(-err) ""
  set cmd "ca_vlan_action_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pDF $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }  
  if {$res == 0} {
    set pU $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pS $aTmp(-err)  
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pD $aTmp(-err)
  }
 if {$res== 0 && ($data_init == 1 || $data_init == 2)} {
      set cmd [list ca_l2_vlan_egress_default_action_get $device_id $port_id $pDF $pU $pS $pD]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  if {$res == 0 && $data_init == 2} {
      foreach cat $cat_l pt { pU pS pD} { 
        foreach key {inner_pri inner_vlan_cmd outer_vlan_cmd inner_tpid_index outer_pri outer_tpid_index flow_id} {
          if {$cat == "df" && [string first "index" $key]>= 0} {
            continue
          }
          if {$key == "flow_id"} {
            set nkey $key
            set defVal $defaultFlowId
          } else  {
            set nkey new_$key
            set defVal $defaultEgressInvalid          
          }
          set cmd "ca_vlan_action_set_$nkey [set $pt] $defVal"
          set res [helper_cmd_exec -cmd $cmd]
          if {$res} {break}
        }  
      }
      ca_vlan_action_set_new_outer_tpid_src $pDF 2
      ca_vlan_action_set_new_outer_pri_src $pDF 2
      ca_vlan_action_set_new_inner_tpid_src $pDF 1
      ca_vlan_action_set_inner_vlan_cmd $pDF $defaultEgressInvalid   
  }  
  if {$res == 0 } {
    foreach pre $cat_l pt {pDF pU pS pD} {   
      foreach var $v_action_key_l {
        if {[info exists aIn(-${pre}_$var)] && 
          [string compare [string tolower $aIn(-${pre}_$var)] "dontcare"]} {
          set val $aIn(-${pre}_$var)
          if {$var eq "inner_vlan_cmd" || $var eq "outer_vlan_cmd"} {
            helper_h2s -table CA_VLAN_TAG_ACTION_T -source $val -out aH
            set val $aH(-target)
          } elseif {$var eq "new_inner_pri_src" || $var eq "new_outer_pri_src" } {
            helper_h2s -table CA_VLAN_TAG_PRIORITY_SOURCE_T -source $val -out aH
            set val $aH(-target)
          } elseif {$var eq "new_inner_tpid_src" || $var eq "new_outer_tpid_src"} {
            helper_h2s -table CA_VLAN_TPID_SOURCE_T -source $val -out aH
            set val $aH(-target)          
          } elseif {$var eq "new_inner_vlan_src" || $var eq "new_outer_vlan_src"} {
            helper_h2s -table CA_VLAN_NEW_VLAN_SOURCE_T -source $val -out aH
            set val $aH(-target)          
          }          
          set cmd "ca_vlan_action_set_$var [set $pt] $val"
          set res [helper_cmd_exec -cmd $cmd]
          if {$res} {break}
        } 
      }
    }
  }
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_egress_default_action_set $device_id $port_id $pDF $pU $pS $pD]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  foreach pt {pDF pU pS pD} {
    catch {ca_data_free [set $pt]} err
  }
  #wca_l2_vlan_egress_default_action_get -port_id $port_id
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_egress_default_action_get {args} {
  set ifnm wca_l2_vlan_egress_default_action_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id }  
  helper_ca_vlan_action_params_declare
  set v_action_key_l $v_action_l
  set cat_l {df u s d}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  
  foreach pre $cat_l {
    foreach var $v_action_key_l {
      set aOut(-${pre}_$var) unknown
    } 
  }
  set cmd "ca_vlan_action_create"  
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pDF $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }  
   if {$res == 0} {
    set pU $aTmp(-err)
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pS $aTmp(-err)  
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pD $aTmp(-err)
  }
  if {$res == 0 } {  
    set cmd [list ca_l2_vlan_egress_default_action_get $device_id $port_id $pDF $pU $pS $pD]
    if {[catch $cmd err]} {
      log -tag error -msg "Failed to invoke $cmd. $err"
      set res -1
    } else {
      set res $err
      if {$res} {
        log -tag error -msg "Failed to invoke command {$cmd}. Return value is $res instead of 0"
      } else {
        foreach pre $cat_l pt {pDF pU pS pD} {        
          foreach var $v_action_key_l {
             set aOut(-${pre}_$var) [ca_vlan_action_get_$var [set $pt] ]
             if {$var == "inner_vlan_cmd" || $var == "outer_vlan_cmd"} {
               helper_s2h -table CA_VLAN_TAG_ACTION_T -source $aOut(-${pre}_${var}) -out aH
               set aOut(-${pre}_${var}_v) $aH(-target)
             }  elseif {$var eq "new_inner_pri_src" || $var eq "new_outer_pri_src" } {
               helper_s2h -table CA_VLAN_TAG_PRIORITY_SOURCE_T -source $aOut(-${pre}_${var}) -out aH
               set aOut(-${pre}_${var}_v) $aH(-target)
             } elseif {$var eq "new_inner_tpid_src" || $var eq "new_outer_tpid_src"} {
               helper_s2h -table CA_VLAN_TPID_SOURCE_T -source $aOut(-${pre}_${var})  -out aH
               set aOut(-${pre}_${var}_v) $aH(-target)         
             } elseif {$var eq "new_inner_vlan_src" || $var eq "new_outer_vlan_src"} {
               helper_s2h -table CA_VLAN_NEW_VLAN_SOURCE_T -source $aOut(-${pre}_${var})  -out aH
               set aOut(-${pre}_${var}_v) $aH(-target)          
             }              
           }         
         }
      }
    } 
  }
  foreach pt {pDF pU pS pD } {   
    catch {ca_data_free [set $pt]} err
  }
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_flooding_domain_members_update {args} {
  set docStr "ingress_port_type: 0/WAN, 1/LAN"
  set ifnm wca_l2_vlan_flooding_domain_members_update
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id ingress_vid ingress_port_type member_count }
  set v_com_key_l {egress_vid egress_port}
  set v_key_l {members}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-members) "" 
  array set aIn $args  
  set count $aIn(-member_count)
  set vid   $aIn(-ingress_vid)
  set port_type $aIn(-ingress_port_type)
  helper_h2s -table CA_INGRESS_PORT_TYPE_T -source $port_type -out aH
  set port_type $aH(-target)
  set members $aIn(-members)
  set member_l  [split $aIn(-members) ","]
  if {$members == "dontcare"} {
    set members ""
    set count 0
  } else {
    if {[llength $member_l ] < $count } {
      set count [llength $member_l]
    }
  }
  set aIn(-member_count) $count
  
  set cmd "ca_flooding_port_array_create [expr $count + 1]"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set l $member_l
    for {set i 0 } {$i < $count} {incr i} {
        set npd [ca_flooding_port_array_get $pt $i]
        set v_l [split [lindex $l $i] "/"]
        set egress_vid [string trim [lindex $v_l 0]]
        set egress_port [string trim [lindex $v_l 1]]
        foreach var $v_com_key_l {
          set cmd [list ca_flooding_port_set_$var $npd [set $var]]
           set res [helper_cmd_exec -cmd $cmd ]
           if {$res} {
             log -tag error -msg ""
             return $res
           }
        }
    }  
  } 
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_flooding_domain_members_update $device_id $vid $port_type $count $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  return $res
}
proc ::gw::wca_l2_vlan_flooding_domain_members_delete {args} {
  set docStr "ingress_port_type: 0/WAN, 1/LAN"
  set ifnm wca_l2_vlan_flooding_domain_members_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id ingress_vid ingress_port_type  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  helper_h2s -table CA_INGRESS_PORT_TYPE_T -source $ingress_port_type -out aH
  set ingress_port_type $aH(-target)  
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_flooding_domain_members_delete $device_id $ingress_vid $ingress_port_type]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  return $res
}
proc ::gw::wca_l2_vlan_flooding_domain_members_get {args} {
  set docStr "ingress_port_type: 0/WAN, 1/LAN"
  set ifnm wca_l2_vlan_flooding_domain_members_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id ingress_vid ingress_port_type }
  set v_key_l {egress_vid egress_port}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  "member_count"  
  #set aOut(-member_count) 0
  set aOut(-members) ""
  set aOut(-members_hex) ""
  set vid   $aIn(-ingress_vid)
  set port_type $aIn(-ingress_port_type)
  helper_h2s -table CA_INGRESS_PORT_TYPE_T -source $port_type -out aH
  set port_type $aH(-target)
  set cmd "ca_flooding_port_array_create 128"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd "ca_uint8_create 0"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pcnt $aTmp(-err)
  }
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_flooding_domain_members_get $device_id $vid $port_type $pcnt $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
    set aOut(-member_count) [ca_uint8_get $pcnt]
    for {set i 0 } {$i < $aOut(-member_count) } {incr i } {
      set pm [ca_flooding_port_array_get $pt $i]
      set ev [ca_flooding_port_get_egress_vid $pm]
      set ep [ca_flooding_port_get_egress_port $pm]
      set ent $ev/$ep
      lappend aOut(-members) $ent
      lappend aOut(-members_hex) [format "0x%x" $ev]/[format "0x%x" $ep]
    }
    set aOut(-members) [join $aOut(-members) ,]
    set aOut(-members_hex) [join $aOut(-members_hex) ,]
  }    
  set aOut(-ingress_port_type) $port_type
  helper_s2h -table CA_INGRESS_PORT_TYPE_T -source $port_type -out aH  
  set aOut(-ingress_port_type_v) $aH(-target)
  set aOut(-vid) $vid
  
  catch {ca_data_free $pt} err
  helper_parray aOut  
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_flooding_domain_members_add {args} {
  set docStr "ingress_port_type: 0/WAN, 1/LAN"  
  set ifnm wca_l2_vlan_flooding_domain_members_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id ingress_vid ingress_port_type member_count }
  set v_key_l {members}
  set v_com_key_l {egress_vid egress_port }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-members) ""
 
  array set aIn $args
  
  set count $aIn(-member_count)
  set vid   $aIn(-ingress_vid)
  set port_type $aIn(-ingress_port_type)
  helper_h2s -table CA_INGRESS_PORT_TYPE_T -source $port_type -out aH
  set port_type $aH(-target)  
  set members $aIn(-members)
  set member_l [split $aIn(-members) ","]
  if {$members == "dontcare"} {
    set members ""
    set count 0
  } else {
    if {[llength $members ] < $count } {
      set count [llength $members]
    }
  }
  set aIn(-member_count) $count
  
  set cmd "ca_flooding_port_array_create [expr $count + 1]"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set l $member_l
    for {set i 0 } {$i < $count} {incr i} {
        set npd [ca_flooding_port_array_get $pt $i]
        set v_l [split [lindex $l $i] "/"]
        set egress_vid [string trim [lindex $v_l 0]]
        set egress_port [string trim [lindex $v_l 1]]
        foreach var $v_com_key_l {
          set cmd [list ca_flooding_port_set_$var $npd [set $var]]
           set res [helper_cmd_exec -cmd $cmd ]
           if {$res} {
             log -tag error -msg ""
             return $res
           }
        }
    }  
  }
 
  if {$res == 0 } {
    set cmd [list ca_l2_vlan_flooding_domain_members_add $device_id $vid $port_type $count $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_action_set {args} {
  set docStr "direction can be LAN2WAN(0) or WAN2LAN(1)"
  set ifnm wca_l2_vlan_action_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id  ingress_vid direction}
  helper_ca_vlan_action_params_declare
  set v_key_l $v_action_l 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_h2s -table CA_L2_VLAN_ACTION_DIRECTION_T -source $direction -out aTmp
  set direction $aTmp(-target)
  set cmd "ca_vlan_action_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set res [eval helper_ca_vlan_action_entry_set -paction $pt $args]
  }
  if {$res == 0 } {
    after 200
    set cmd [list ca_l2_vlan_action_set $device_id $ingress_vid $direction $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_vlan_action_get {args} {
  set docStr "direction can be LAN2WAN(0) or WAN2LAN(1)"
  set ifnm wca_l2_vlan_action_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id ingress_vid direction}
  helper_ca_vlan_action_params_declare
  set v_o_key_l $v_action_l    
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args 
  helper_h2s -table CA_L2_VLAN_ACTION_DIRECTION_T -source $direction -out aTmp
  set direction $aTmp(-target)  
  helper_output_declare aIn
  helper_output_init aOut  "$v_o_key_l"
  set cmd "ca_vlan_action_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)  
    set cmd [list ca_l2_vlan_action_get $device_id $ingress_vid $direction $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
      foreach var $v_o_key_l {
        set aOut(-$var) [ca_vlan_action_get_$var $pt]
        if {$var == "inner_vlan_cmd" || $var == "outer_vlan_cmd"} {
          helper_s2h -table CA_VLAN_TAG_ACTION_T -source $aOut(-$var) -out aH
          set aOut(-${var}_v) $aH(-target)
        } elseif {$var eq "new_inner_pri_src" || $var eq "new_outer_pri_src" } {
          helper_s2h -table CA_VLAN_TAG_PRIORITY_SOURCE_T -source $aOut(-$var) -out aH
          set aOut(-${var}_v) $aH(-target)
        } elseif {$var eq "new_inner_tpid_src" || $var eq "new_outer_tpid_src"} {
          helper_s2h -table CA_VLAN_TPID_SOURCE_T -source $aOut(-$var)  -out aH
          set aOut(-${var}_v) $aH(-target)         
        } elseif {$var eq "new_inner_vlan_src" || $var eq "new_outer_vlan_src"} {
          helper_s2h -table CA_VLAN_NEW_VLAN_SOURCE_T -source $aOut(-$var)  -out aH
          set aOut(-${var}_v) $aH(-target)          
        }                      
     }
  }    
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
#-------------------------------------------
#Section: L2 Management - L2 Flooding Traffic Rate Limit
#-------------------------------------------
proc ::gw::wca_l2_flooding_rate_set {args} {
  set docStr "ptype can be one of: MC(0),BC(1), or UUC(2)"
  set ifnm wca_l2_flooding_rate_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id ptype pps rate}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  array set aIn $args
  helper_h2s -table CA_L2_FLOODING_TYPE_T -source $ptype -out aTmp
  set ptype $aTmp(-target)
  if {$res == 0 } {
    set cmd [list ca_l2_flooding_rate_set $device_id $port_id $ptype $pps $rate]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_flooding_rate_get {args} {
  set docStr "ptype can be one of: MC(0),BC(1), or UUC(2)"
  set ifnm wca_l2_flooding_rate_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id  ptype  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  helper_h2s -table CA_L2_FLOODING_TYPE_T -source $ptype -out aTmp
  set ptype $aTmp(-target)  
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut  "rate pps"
  set pPps [helper_ca_boolean_create]
  set cmd "ca_uint32_create 0"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pRate $aTmp(-err) 
  } 
  if {$res == 0 } {
    set cmd [list ca_l2_flooding_rate_get $device_id $port_id $ptype $pPps $pRate]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
    set aOut(-rate) [ca_uint32_get $pRate]
    set aOut(-pps) [helper_ca_boolean_get $pPps]
  }  
  helper_data_free [list $pRate $pPps]
  helper_parray aOut
  log -tag itfend
  return $res
}
#-------------------------------------------
#Section: L2 Management - MACSec Data Path Configuration Functions
#-------------------------------------------
  # Not supported by G3
  
#---------------------------------------------------------
#Section: L3 Management
#---------------------------------------------------------
#-------------------------------------------
#Section: L3 Management - IP Interface management
#-------------------------------------------
proc ::gw::wca_l3_intf_cmd {args} {
  set ifnm wca_l3_intf_cmd
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  #common codes for "add" and "update" operation
  helper_intf_and_var_declare -ifnm ca_l3_intf_cmd
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  set aIn(-operation) add
  array set aIn $args  

  helper_output_declare aIn
  helper_output_init aOut  "intf_id"
  foreach dvar {tpid vid mask_tpid mask_vid} {    
    if {[info exists aIn(-$dvar)]} {
      set res -1
      log -tag error -msg "Deprecated parameter: $dvar"
    }
  }
  set operation $aIn(-operation) 
  set cmd "ca_l3_intf_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)  
    array set aTmp ""
  }
  if {$res == 0 && $operation == "update"} {
    set cmd [list ca_l3_intf_set_intf_id $pt $aIn(-intf_id)]
    set res [helper_cmd_exec -cmd $cmd]
    if {$res == 0} {
      set cmd [list ca_l3_intf_get $device_id $pt]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    }
  }
  if {$res == 0 } {
     set res [eval helper_ca_l3_intf_entry_config [array get aIn] -ref $pt -out aTmp]
  }  
  if {$res == 0 } {
    set cmd [list ca_l3_intf_$operation $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 && $operation == "add"} {
    set aOut(-intf_id) [ca_l3_intf_get_intf_id $pt]
  }
  helper_data_free $pt 
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_intf_add {args} {
    set docStr "type can be one of : BCAST(1),P2P(2),TUNNEL(3),CPU(4),LB(5)"
    set ifnm wca_l3_intf_add
    set res 0
    log -tag itfbgn -msg $args
    set m_key_l {device_id}
    helper_intf_and_var_declare -ifnm ca_l3_intf_add
 
    set res [helper_m_args_check -args $args -m_key_l $m_key_l]
    if {$res} {
        return $res
    }     
    array set aIn $args  
    helper_output_declare aIn
    helper_output_init aOut  "intf_id"
    set res [eval wca_l3_intf_cmd "-operation add -data_init 0 $args -out aOut" ]
    helper_parray aOut
    log -tag itfend
    if {$res} {
      helper_print_status_enum_name $res
    }
    return $res    
}
proc ::gw::wca_l3_intf_update {args} {
    set docStr "type can be one of : BCAST(1),P2P(2),TUNNEL(3),CPU(4),LB(5)"
    set ifnm wca_l3_intf_update
    set res 0
    log -tag itfbgn -msg $args
    set m_key_l {device_id intf_id}
    helper_intf_and_var_declare -ifnm ca_l3_intf_update   
    set res [helper_m_args_check -args $args -m_key_l $m_key_l]
    if {$res} {
        return $res
    }
    set res [eval wca_l3_intf_cmd "-operation update $args"]  
    log -tag itfend
    if {$res} {
      helper_print_status_enum_name $res
    }    
    return $res
}
proc ::gw::wca_l3_intf_delete_all {args} {
  global errorInfo
  set ifnm wca_l3_intf_delete_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  array set aTmp ""
  set res [wca_l3_intf_get_all -device_id $device_id -exp_args intf_id -out aTmp -print_res 0]
  if {$res == 0 || [array size aTmp] > 0} {
    set l [array names aTmp]
    foreach idx $l {
      log -tag debug -msg "To delete entry: $aTmp($idx)"
      array set aEnt $aTmp($idx)
      set tmp_res [eval wca_l3_intf_delete -device_id $device_id -intf_id $aEnt(-intf_id)]
      if {$tmp_res} {
        if {$res == 0 } {set res $tmp_res}
        break
      }
    }
  }
  log -tag itfend
  return $res  
}

proc ::gw::wca_l3_intf_get {args} {
  set ifnm wca_l3_intf_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id intf_id}
  helper_intf_and_var_declare -ifnm ca_l3_intf
  set v_key_l ""
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  array set aIn $args 
  helper_output_declare aIn
  helper_output_init aOut   
  foreach var "$v_intf_key_l" {
    set aOut(-$var) unknown
  }
  foreach var "$v_mask_key_l" {  
    set aOut(-mask_$var) unknown
  }
  array set aTmp ""
  set cmd {ca_l3_intf_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)  
    set cmd "ca_l3_intf_set_intf_id $pt $aIn(-intf_id)"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  } 

  if {$res == 0 } {
    set cmd [list ca_l3_intf_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    set res [helper_ca_l3_intf_entry_parse -ref $pt -out aOut]
  }  
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_l3_intf_delete {args} {
    set ifnm wca_l3_intf_delete
    set res 0
    log -tag itfbgn -msg $args
    set m_key_l {device_id intf_id}
    set res [helper_m_args_check -args $args -m_key_l $m_key_l]
    if {$res} {
        return $res
    }
    set cmd [list ca_l3_intf_delete $device_id $intf_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    log -tag itfend
    return $res      
}
proc ::gw::wca_l3_intf_get_all {args} {
  global errorInfo
  set ifnm wca_l3_intf_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  helper_intf_and_var_declare -ifnm ca_l3_intf
  set v_key_l ""
  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l exp_args]
  if {$res} {
    return $res
  }
  set aIn(-cpi) 5
  set aIn(-print_res) 1
  set aIn(-exp_args) DONTCARE
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut   
  set cpi $aIn(-cpi)
  set print_res $aIn(-print_res)
  set exp_args $aIn(-exp_args)
 
  set aTmp(-iterator_pointer) NULL    
  set idx 0
  for {set max 0} {$max < 10000 && $res == 0 } {incr max} {
     set res [helper_iterate -device_id $device_id \
      -data_type ca_l3_intf_t\
      -iterate_func ca_l3_intf_iterate \
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    }
    foreach npdx $aTmp(-element_data_pointers) {
      catch {array unset aOTmp} err
      array set aOTmp ""
      if {$res == 0 } {
        set res [helper_ca_l3_intf_entry_parse -ref $npdx -out aOTmp]
      }      
      set aOut($idx) [array get aOTmp]     
      if {[string compare -nocase $exp_args "dontcare"]} {
          set l ""
          foreach earg $exp_args {
              if {[info exists aOTmp(-$earg)]} {
                  lappend l -$earg $aOTmp(-$earg)
              }
          }
          set aOut($idx) $l
      }
      incr idx
    }
  }  
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    log -tag warning -msg $err
  }
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err ]} {
      log -tag warning -msg $err
  }
  if {$print_res} {
    puts "\nTotal Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  }
  log -tag itfend
  return $res   
}
proc ::gw::wca_l3_intf_stats_get {args} {
  set docStr "    read_clear: default value is 1"
  set ifnm wca_l3_intf_stats_get
  set res 0
  log -tag itfbgn -msg $args
 
  set m_key_l {device_id intf_id }
  set v_key_l {read_clear}
  set v_out_key_l [helper_probe_struct_members -struct ca_l3_intf_stats]
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  set aIn(-read_clear) 1
  array set aIn $args   
  foreach key { read_clear} {
    set $key $aIn(-$key)
    if {[string toupper $aIn(-$key)] == "DONTCARE"} {
      set $key 1
    }  
  }    
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l 
  set aOut(-read_clear) $read_clear
  set cmd {ca_l3_intf_stats_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {    
    set pt $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_l3_intf_stats_get $device_id $intf_id $read_clear $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      foreach var $v_out_key_l {
        set aOut(-$var) [ca_l3_intf_stats_get_$var $pt]
      }
    }  
  }  
  catch {ca_data_free $pt} err 
 
  helper_parray aOut 
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_intf_stats_clear {args} {
  set ifnm wca_l3_intf_stats_clear
  set res 0
  log -tag itfbgn -msg $args
 
  set m_key_l {device_id intf_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
 
  if {$res == 0} {
    set cmd [list ca_l3_intf_stats_clear $device_id $intf_id ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_intf_stats_clear_all {args} {
  set ifnm wca_l3_intf_stats_clear_all
  set res 0
  log -tag itfbgn -msg $args
 
  set m_key_l {device_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  
  if {$res == 0} {
    set cmd [list ca_l3_intf_stats_clear_all $device_id ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  log -tag itfend
  return $res
}
#-------------------------------------------
#Section: L3 Management - Route Table Management
#-------------------------------------------
proc ::gw::wca_l3_route_cmd {args} {
  set ifnm wca_l3_route_cmd
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  set v_key_l {prefix nexthop_id}
  set aIn(-data_init) 1
  set aIn(-operation) add
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args   
  set operation $aIn(-operation)
  array set aOut ""
  set res [eval helper_ca_l3_route_entry_config $args]
  if {$res == 0 } {
    set pt $aOut(-ref)
    set cmd [list ca_l3_route_$operation $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  catch {array unset aOut} err
  log -tag itfend
  if {$res} {
      helper_print_status_enum_name $res
  }  
  return $res
}
proc ::gw::wca_l3_route_get {args} {
  set ifnm wca_l3_route_get
  set res 0
  log -tag itfbgn -msg $args

  set m_key_l {device_id prefix}
  set v_com_key_l {prefix nexthop_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_com_key_l 
  array set aTmp ""
  set res [eval helper_ca_l3_route_entry_config $args -out aTmp]
  
  if {$res == 0} {
    set pt $aTmp(-ref)
  }
  if {$res == 0} {
    set cmd [list ca_l3_route_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0} {
      set pip [ca_l3_route_get_prefix $pt ]
        set res [helper_ca_ip_address_entry_parse -ref $pip -out aTmp]
        set aOut(-prefix) $aTmp(-ip_addr)        
      set aOut(-nexthop_id) [ca_l3_route_get_nexthop_id $pt ]
  
    }  
  }  
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_route_add {args} {
  log -tag itfbgn -msg "$args"
  set res 0  
  set res [eval wca_l3_route_cmd "-operation add $args"]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_route_get_all {args} {
  global errorInfo
  set ifnm wca_l3_route_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id}
  set v_key_l {cpi afi}
  set v_out_key_l {prefix nexthop_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-cpi) 2
  set aIn(-afi) DONTCARE
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut
  set cpi $aIn(-cpi)
  set print_res $aIn(-print_res)
  
  set afi_l $aIn(-afi)
  if {[string equal [string tolower $afi_l] "dontcare"]} {
    set afi_l {0 1}
  }   
  set idx 0
  foreach afi $afi_l {   
    log -tag info -msg "Walk through route table for afi $afi"
    set aTmp(-iterator_pointer) NULL
    for {set max 0 } {$max < 10000 && $res == 0} {incr max} {
      set res [helper_iterate -device_id $device_id \
          -data_type ca_l3_route_t\
          -iterate_func ca_l3_route_iterate \
          -parse_func DONTCARE -cpi $cpi \
          -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) \
          -earg0 $afi -out aTmp]
      if {$res == 9 } {
        set res 0
        break
      }
      foreach npdx $aTmp(-element_data_pointers) {
        if {$res} {break}
        catch {array unset aVars} err
        array set aVars ""     
        foreach var $v_out_key_l {
          set val [ca_l3_route_get_$var $npdx]
          if {$var == "prefix" } {
            set res [eval helper_ca_ip_address_entry_parse -ref $val -out aRtn]
            if {$res} {break}
            set aVars(-prefix) $aRtn(-ip_addr)
          } else {        
            set aVars(-$var) $val      
          }
        };#end foreach v_out_key_l
        set aVars(-afi) $afi
        set aOut($idx) [array get aVars]   
        incr idx 
      }
    };#end for-loop
    if {$max >= 10000 } {
      log -tag warning -msg "Seems infinit loop occurs"
    }
    if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
      log -tag warning -msg $err
    }
    if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
      log -tag warning -msg $err
    }  
  } ;#end of foreach-api  
  if {$print_res} {
    puts "\nTotal Route Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  } 
  log -tag itfend
  return $res  
}
proc ::gw::wca_l3_route_delete {args} {
  log -tag itfbgn -msg "$args"
  set res 0  
  set res [eval wca_l3_route_cmd "-operation delete $args"]  
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_route_delete_all {args} {
  global errorInfo
  set ifnm wca_l3_route_delete_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id}
  set v_key_l {afi}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-afi) DONTCARE
  array set aIn $args
    
  array set aOut ""
  set res [wca_l3_route_get_all -device_id $device_id -afi $aIn(-afi) -out aOut -print_res 0]
  if {$res == 0 || [array size aOut] > 0 } {
    set l [array names aOut]
    foreach idx $l {
      catch {array unset aTmp} err
      set cfg $aOut($idx)
      log -tag debug -msg "To delete route entry: $cfg"
      set tmp_res [eval wca_l3_route_delete -device_id $device_id $aOut($idx)]
      if {$tmp_res} {
        if {$res == 0 } {set res $tmp_res}
        break
      }
    }
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_nexthop_add {args} {
  # input: -device_id xx 
  set ifnm wca_l3_nexthop_add
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id }
  set v_key_l {attr_flags intf_id da_mac aging_timer addr}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut nexthop_id
   
  set cmd "ca_l3_nexthop_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set pmac [ca_l3_nexthop_get_da_mac $pt]
    set pip [ca_l3_nexthop_get_addr $pt]  
    set cmd "ca_uint16_create 0"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0} {
    set pnh $aTmp(-err)  
    foreach var $v_key_l {
      if {[info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        if {$var == "da_mac"} {
          set mac_l [split $aIn(-da_mac) :]
          set new_mac_l ""
          foreach e $mac_l {
            lappend new_mac_l 0x$e
          }
          set cmd "ca_mac_addr_set $pmac $new_mac_l"
          set res [helper_cmd_exec -cmd $cmd]
          if {$res} {
            break
          }
          continue
        }
        if {$var == "addr"} {
          set res [helper_ca_ip_address_entry_config -ref $pip -ip_addr $aIn(-addr) -out aTmp]
          if {$res} {break}
          continue
        }
        set cmd "ca_l3_nexthop_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {break}
      }
    }
  }

  if {$res == 0 } {
    set cmd [list ca_l3_nexthop_add $device_id $pt $pnh]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
    set aOut(-nexthop_id) [ca_uint16_get $pnh]
  }
  foreach p {pt pnh} {
    catch {ca_data_free [set $p]} err
  }
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_nexthop_update {args} {
  set docStr "Only mac can be updated"
  set ifnm wca_l3_nexthop_update
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id nexthop_id}
  set v_key_l {attr_flags intf_id da_mac aging_timer addr}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_l3_nexthop_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)  
    set pmac [ca_l3_nexthop_get_da_mac $pt]
    set pip [ca_l3_nexthop_get_addr $pt]
  }
  
  foreach var $v_key_l {
    if {[info exists aIn(-$var)] && 
      [string compare [string tolower $aIn(-$var)] "dontcare"]} {
      if {$var == "da_mac"} {
        set mac_l [split $aIn(-da_mac) :]
        set new_mac_l ""
        foreach e $mac_l {
          lappend new_mac_l 0x$e
        }
        set cmd "ca_mac_addr_set $pmac $new_mac_l"
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {
          break
        }
        continue
      }
      if {$var == "addr"} {
        set res [helper_ca_ip_address_entry_config -ref $pip -ip_addr $aIn(-addr) -out aOut]
        if {$res} {break}
        continue
      }
      set cmd "ca_l3_nexthop_set_$var $pt $aIn(-$var)"
      set res [helper_cmd_exec -cmd $cmd]
      if {$res} {break}
    }
  }
  if {$res == 0 } {
    set cmd [list ca_l3_nexthop_update $device_id $pt $nexthop_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_nexthop_get {args} {
  set ifnm wca_l3_nexthop_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id nexthop_id}
  set v_o_key_l {attr_flags intf_id da_mac aging_timer addr nexthop_id}
  set ip_key_l {ip_addr addr_len afi}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut $v_o_key_l 
  set cmd "ca_l3_nexthop_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd [list ca_l3_nexthop_get $device_id $nexthop_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
    foreach var $v_o_key_l {
      set val [ca_l3_nexthop_get_$var $pt]
      if {$var == "da_mac"} {
        set mac_l ""
        for {set i 0 } {$i < 6} {incr i} {
          lappend mac_l [format %02x [ca_mac_addr_get $val $i]]
        }
        set aOut(-da_mac) [join $mac_l :]
      } elseif {$var == "addr"} {
        set pip [ca_l3_nexthop_get_addr $pt]
          set res [eval helper_ca_ip_address_entry_parse -ref $pip -out aTmp] 
          if {$res == 0 } {
            set aOut(-addr) $aTmp(-ip_addr)
          }
      } else {
        set aOut(-$var) $val
      }
    }   
  }   
  if {$res == 0 } {
    if {$aOut(-nexthop_id) == $nexthop_id} {
    
    } else {
      log -tag error -msg "Returned nh_id is different with the specified one"
      set res -1
    }
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_nexthop_delete_all {args} {
  set ifnm wca_l3_nexthop_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set aIn(-afi) DONTCARE
  set m_key_l {device_id }
  set v_key_l {afi}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  if {[string toupper $aIn(-afi)] == "DONTCARE" || [string trim $aIn(-afi)] == ""} {
    set afi [list 0 1]
  } else {
    set afi $aIn(-afi)
  }  
  array set aTmp ""  
  set res [wca_l3_nexthop_get_all -device_id $device_id -afi $afi -exp_args "nexthop_id" -out aTmp -print_res 0]
  if {$res == 0 || [array size aTmp] > 0} {
    set l [array names aTmp]    
    foreach idx $l {
      log -tag debug -msg "To delete entry: $aTmp($idx)"
      set tmp_res [eval wca_l3_nexthop_delete -device_id $device_id $aTmp($idx)]
      if {$tmp_res} {
        if {$res == 0 } {set res $tmp_res}
        break
      }
    }
  }  
  log -tag itfend
  return $res      
}
proc ::gw::wca_l3_nexthop_get_all {args} {
  global errorInfo
  set ifnm wca_l3_nexthop_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l {cpi} 
  set v_out_key_l {afi attr_flags intf_id da_mac aging_timer addr nexthop_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  #set default value
  set aIn(-print_res) 1
  set aIn(-afi) DONTCARE
  set aIn(-cpi) 10
  set aIn(-exp_args) DONTCARE
  array set aIn $args
  set cpi $aIn(-cpi)
  helper_output_declare aIn
  helper_output_init aOut  
  set exp_args $aIn(-exp_args)
  
  if {[string toupper $aIn(-afi)] == "DONTCARE" || [string trim $aIn(-afi)] == ""} {
    set afi_l [list 0 1]
  } else {
    set afi_l $aIn(-afi)
  }

  set idx 0
  foreach afi $afi_l {   
    log -tag info -msg "Walk through nexthop table for afi $afi"
    set aTmp(-iterator_pointer) NULL
    for {set max 0 } {$max < 10000 && $res == 0} {incr max} {
      set res [helper_iterate -device_id $device_id \
          -data_type ca_l3_nexthop_t\
          -iterate_func ca_l3_nexthop_iterate \
          -parse_func DONTCARE -cpi $cpi \
          -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) \
          -earg0 $afi -out aTmp]
      if {$res  } {
        if {$res == 9 } { set res 0}
        break
      }
      foreach npdx $aTmp(-element_data_pointers) {
        if {$res} {break}      
        catch {array unset aVars} err
        array set aVars ""
        foreach var $v_out_key_l {
          if {[string compare [string toupper $exp_args] "DONTCARE"] 
            && [lsearch $exp_args $var] < 0 } {continue}
          if {$var == "afi"} {continue}
          set val [ca_l3_nexthop_get_$var $npdx]
          if {$var == "da_mac"} {
            set mac_l ""
            for {set mi 0 } {$mi < 6} {incr mi} {
            lappend mac_l [format %02x [ca_mac_addr_get $val $mi]]
            }
            set aVars(-da_mac) [join $mac_l :]
          } elseif {$var == "addr"} {
            set pip $val
              set res [eval helper_ca_ip_address_entry_parse -ref $pip -out aTmp] 
              if {$res == 0 } {
                set aVars(-addr) $aTmp(-ip_addr)
              }
          } else {
            set aVars(-$var) $val
          }
        } ;#end of foreach key
        set aOut($idx) [array get aVars]
        incr idx
      };#end of freach npdx
    };#end of for max  
    if {$max >= 10000 } {
      log -tag warning -msg "seems infinit loop issue"
    }  
    if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
      log -tag warning -msg $err
    }
    if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
      log -tag warning -msg $err
    }  
  } ;#end of foreach-api  
  if {$aIn(-print_res)} {
    puts "\nTotal Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1 
  }
  log -tag itfend
  helper_print_status_enum_name $res
  return $res    
}
proc ::gw::wca_l3_nexthop_get_by_ip {args} {
  set ifnm wca_l3_nexthop_get_by_ip
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id nh_ip}
  set v_out_key_l {attr_flags intf_id da_mac aging_timer addr nexthop_id}
  set ip_key_l {ip_addr addr_len afi}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l 
  set cmd "ca_l3_nexthop_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  if {$res == 0 } {
    set pip [ca_ip_address_create] 
    set res [helper_ca_ip_address_entry_config -ref $pip -ip_addr $aIn(-nh_ip) -out aTmp] 
  }
  if {$res == 0 } {  
    set cmd [list ca_l3_nexthop_get_by_ip $device_id $pip $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
    foreach var $v_out_key_l {
      set val [ca_l3_nexthop_get_$var $pt]
      if {$var == "da_mac"} {
        set mac_l ""
        for {set i 0 } {$i < 6} {incr i} {
          lappend mac_l [ca_mac_addr_get $val $i]
        }
        set aOut(-da_mac) [join $mac_l :]
      } elseif {$var == "addr"} {
        set pip [ca_l3_nexthop_get_addr $pt]
          set res [eval helper_ca_ip_address_entry_parse -ref $pip -out aTmp] 
          if {$res == 0 } {
            set aOut(-addr) $aTmp(-ip_addr)
          }
      } else {
        set aOut(-$var) $val
      }
    }   
  } 
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name $res;return $res
}
proc ::gw::wca_l3_nexthop_delete {args} {
  set ifnm wca_l3_nexthop_delete
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id nexthop_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args 
  if {$res == 0 } {
    set cmd [list ca_l3_nexthop_delete $device_id $nexthop_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_nexthop_aging_timer_set {args} {
  set ifnm wca_l3_nexthop_aging_timer_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id time }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
 
  if {$res == 0 } {
    set cmd [list ca_l3_nexthop_aging_timer_set $device_id $time]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_l3_nexthop_aging_timer_get {args} {
  set ifnm wca_l3_nexthop_aging_timer_get
  set res 0
  log -tag itfbgn -msg $args
 
  set m_key_l {device_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut time   
  set cmd "ca_uint32_create 0 "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd [list ca_l3_nexthop_aging_timer_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
    set aOut(-time) [ca_uint32_get $pt ]
  }  
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
#---------------------------------------------------------
#Section: Multicast Management
#---------------------------------------------------------
#------------------------------
#Section: Multicast Management - L2 Multicast Management
#------------------------------
proc ::gw::wca_mcast_config_set {args} {
  return [eval wca_l2_mcast_config_set $args]
}
proc ::gw::wca_mcast_config_set {args} {
  set docStr "mode: MAC(1),IP(2)"
  set ifnm wca_l2_mcast_config_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  set v_key_l {unknown_multicast_flooding_enable mode igmp_use_mc_vlan mld_use_mc_vlan}
  set aIn(-data_init) 1
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  set data_init $aIn(-data_init)
  
  set cmd "ca_l2_mcast_config_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
 
  if {$res == 0} {
    set pt $aTmp(-err)
    if {$data_init == 1 } {
      #Initialize data structure with current system values
      set cmd [list ca_l2_mcast_config_get $device_id $pt]
      set res [helper_cmd_exec -cmd $cmd]
    }
  }
  if {$res == 0 } {
    #Configure the structure with input values. Ignore those "dontcare" elements.
    foreach var $v_key_l {
      if {[info exists aIn(-$var)] && [string compare [string tolower $aIn(-$var)] "dontcare"]} {
          if {$var == "mode" } {
            helper_h2s -table "CA_MCAST_ADDRESSING_MODE_T" -source [string toupper $aIn(-$var)] 
            set aIn(-mode) $aOut(-target)
          }
        set cmd "ca_l2_mcast_config_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {break}
      }
    }
  }
  if {$res == 0 } {
    set cmd [list ca_l2_mcast_config_set $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]  
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res            
}
proc ::gw::wca_mcast_config_get {args} {
  set ifnm wca_mcast_config_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut   
  set res [eval wca_l2_mcast_config_get $args -out aOut]
  log -tag itfend
  return $res   
  
}
proc ::gw::wca_l2_mcast_config_get {args} {  
  set ifnm wca_l2_mcast_config_get
  set res 0
  log -tag itfbgn -msg $args
 
  set m_key_l {device_id}
  set v_o_key_l {igmp_use_mc_vlan mld_use_mc_vlan}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut [list unknown_multicast_flooding_enable mode]   
  set cmd "ca_l2_mcast_config_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd [list ca_l2_mcast_config_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd]
  }
  if {$res == 0} {
    set aOut(-unknown_multicast_flooding_enable) [ca_l2_mcast_config_get_unknown_multicast_flooding_enable $pt ]
    set aOut(-mode) [ca_l2_mcast_config_get_mode $pt ]
    helper_s2h -table "CA_MCAST_ADDRESSING_MODE_T" -source [string toupper $aOut(-mode)] -out aTmp
    set aOut(-mode_v) $aTmp(-target)
  }  
  foreach okey $v_o_key_l {
    set aOut(-$okey) [ca_l2_mcast_config_get_$okey $pt]
  }
  catch {ca_data_free $pt} err
  if {$aIn(-print_res)} {
    helper_parray aOut
  }
  log -tag itfend
  return $res          
}
proc ::gw::wca_l2_mcast_group_add {args} {
  set ifnm wca_l2_mcast_group_add
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id  }
  set v_key_l {mcast_vlan replication_id group_mac_addr group_ip_addr src_ip_address}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut mcg_id
  
  set cmd "ca_l2_mcast_entry_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    foreach var $v_key_l {
      if {[info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        if {$var == "group_mac_addr" } {
          set mac_l ""
            foreach m [split $aIn(-$var) :] {
              lappend mac_l "0x$m"
            }  
            set cmd "ca_mac_addr_create $mac_l"
            set res [helper_cmd_exec -cmd $cmd -out aTmp]
            if {$res == 0 } {
              set cmd "ca_l2_mcast_entry_set_group_mac_addr $pt $aTmp(-err)"
              set res [helper_cmd_exec -cmd $cmd]
            }
        } elseif {$var == "src_ip_address" || $var == "group_ip_addr" } {
          set pip [ca_l2_mcast_entry_get_$var $pt]
          set res [eval helper_ca_ip_address_entry_config -ref $pip  -ip_addr $aIn(-$var)]
        } else {
          set cmd "ca_l2_mcast_entry_set_$var $pt $aIn(-$var)"
          set res [helper_cmd_exec -cmd $cmd]
        }
        if {$res} {break}
      } 
    }
  }
  if {$res == 0 } {
    #ca_l2_mcast_entry_dump $pt
    set cmd [list ca_l2_mcast_group_add $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  if {($res == 0) || ($res == 14)} {
    set mcg_id [ca_l2_mcast_entry_get_mcg_id $pt]
    set aOut(-mcg_id) $mcg_id
   
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_parray aOut
  return $res                     
}
proc ::gw::wca_l2_mcast_group_delete_all {args} {
  set ifnm wca_l2_mcast_group_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set v_key_l {}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }

  if {$res == 0 } {
    set cmd [list ca_l2_mcast_group_delete_all $device_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  log -tag itfend
  helper_parray aOut
  return $res                     
}

proc ::gw::wca_l2_mcast_group_delete {args} {
  set ifnm wca_l2_mcast_group_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id mcg_id}
  set v_key_l {}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }

  if {$res == 0 } {
    set cmd [list ca_l2_mcast_group_delete $device_id $mcg_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  log -tag itfend
  helper_parray aOut
  return $res                     
}
proc ::gw::wca_l2_mcast_group_get {args} {
  set ifnm wca_l2_mcast_group_get
  set res 0
  set CA_MC_EGRESS_ACTION_RESERVED  32
  set CA_MAX_L2_MC_MEMBER 64
  log -tag itfbgn -msg $args
  set m_key_l {device_id mcg_id}
  #mc_entry + group_members; group_members = mcg_id + member_count +member
  #  member = action_mask + new_mac_da + vlan_action + vid + reserved + memer_port
  #  action_mask = .. + ..
  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args
  set print_res $aIn(-print_res)
  helper_output_declare aIn
  helper_output_init aOut  [list member_count members]
  set aOut(-members) ""
  array set aMembers ""
  set cmd {ca_l2_mcast_iterator_entry_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  catch {array unset aTmp} 

  if {$res == 0} {
    set cmd [list ca_l2_mcast_group_get $device_id $mcg_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]  
  }  
  if {$res == 0 } {
    set res [helper_ca_l2_mcast_iterator_entry_parse -ref $pt -out aOut ]
  }   
  catch {ca_data_free $pt} err
  if {$aIn(-print_res)} { 
    array set aTmp [array get aOut]
    #parray aTmp
    array set aMembers $aTmp(-members)
    unset aTmp(-members)
    helper_parray aTmp
  
    puts "\nL2 Multicast Group Members (Count=$aOut(-member_count)):"
    #parray aMembers
    helper_parray aMembers  "-dictionary" 1
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_l2_mcast_group_get_all {args} {
  global errorInfo
  variable gwenv
  set ifnm wca_l2_mcast_group_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l {cpi print_res}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-cpi) 1
  set aIn(-print_res) 1
  array set aIn $args  
  set cpi $aIn(-cpi)
  set print_res $aIn(-print_res)
  helper_output_declare aIn
  helper_output_init aOut 
  array set aMembers ""    
 
  set aTmp(-iterator_pointer) NULL    
  set tot_ent_index 0
  for {set max 0} {$max < 10000 && $res == 0} {incr max} {
    set res [helper_iterate -device_id $device_id -data_size 2500 \
      -data_type ca_l2_mcast_iterator_entry_t \
      -iterate_func ca_l2_mcast_group_iterate \
      -parse_func helper_ca_l2_mcast_iterator_entry_parse \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) \
      -cpi $cpi -out aTmp]     
    if {$gwenv(REPORT_LEVEL) == 0} {
       parray aTmp
    }             
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    } 
    foreach idx [array names aTmp] {
      if {[regexp {^\d$} $idx ] == 0} continue
      array set aTmp0 $aTmp($idx)
      set aOut($tot_ent_index) [array get aTmp0]    
      array set aMembers $aTmp0(-members)
      unset aTmp0(-members)
      set aPrtTmp($tot_ent_index) [array get aTmp0]
      incr tot_ent_index
    } 
  }
  if {$max >= 10000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  }   
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    log -tag warning -msg $err
  } 
  
  if {$print_res} {
    puts "\nTotal L2 Multicast Group Entry Count : [array size aPrtTmp]\n"
    helper_parray aPrtTmp "-integer" 1
    puts "\nL2 Multicast Group Member Lists:"
    helper_parray aMembers "-dictionary" 1
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_l2_mcast_member_delete {args} {
  set ifnm wca_l2_mcast_member_delete
  set res 0
  log -tag itfbgn -msg $args
  
  set res [eval wca_l2_mcast_member_cmd -operation "delete" $args]
  log -tag itfend 
  return $res    
}
proc ::gw::wca_l2_mcast_member_add {args} {
  set ifnm wca_l2_mcast_member_add
  set res 0
  log -tag itfbgn -msg $args
  
  set res [eval wca_l2_mcast_member_cmd -operation "add" $args]
  log -tag itfend 
  return $res
}
proc ::gw::wca_l2_mcast_member_cmd {args} {
  variable CA_MC_EGRESS_ACTION_RESERVED
  set docStr {
    Usage: wca_l2_mcast_member_<cmd>  [-device_id device_id] -mcg_id mcg_id [-member_count member_count] -member_port <port1,port2,...> -vid <vid1,vid2,...> ...
        value count of , such as, member_port and vid, equals to "member_count"
        vid1,port1 is value of member port 1; vid2,port2 is value of the 2nd member port, and so forth.
        If member_count and count of member_port is 2, but the given vid count is only 1, to say vid count is less then port count.
          Then, the vid value list will be extended automatically, to make length of every value are same.
          e.g. <cmd> -member_count 1 -member_port 0x10007,0x30000,0x30001 -vid 10,20 will be same as 
              <cmd> -member_count 3 -member_port 0x10007,0x30000,0x30001 -vid 10,20,10
  }
  set CA_MC_EGRESS_ACTION_RESERVED 4    
  set ifnm wca_l2_mcast_member_cmd
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id mcg_id}
  set l  [helper_probe_struct_members -struct ca_mcast_egress_action_mask]
  set v_action_mask_key_l ""
  foreach e $l {lappend v_action_mask_key_l mask_$e} 
  set l [helper_probe_struct_members -struct ca_l2_mcast_member]
  set idx [lsearch $l action_mask]
  set v_member_key_l "[lrange $l 0 $idx-1] [lrange $l $idx+1 end]" 
  set v_key_l "member_count $v_member_key_l $v_action_mask_key_l"
  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  set aIn(-data_init) 1
  set aIn(-operation) "add"  
  set aIn(-member_count) 1
  foreach x "$v_action_mask_key_l $v_member_key_l" {
      set aIn(-$x) ""
  } 
  array set aIn $args  
  #parray aIn
  
  set operation $aIn(-operation)
  set member_count $aIn(-member_count)

  foreach x "$v_action_mask_key_l $v_member_key_l" {
    helper_expand_list -set $aIn(-$x) -out aLst         
    set ${x}_l $aLst(-l)
  }  
  set port_count [llength $member_port_l]
  if {$member_count < $port_count}  {
     set member_count $port_count
  }
  foreach x "$v_action_mask_key_l $v_member_key_l" {
     if {$x == "member_port" } {continue}
    
     set element_count [llength [set ${x}_l] ] 
     if {$element_count == 0} {
       set ${x}_l [string repeat "dontcare " $port_count]
     } else {
         if {$element_count < $port_count} {
             set times [expr int($port_count / ($element_count * 1.0)) + 1]   
             set ${x}_l [string repeat "[set ${x}_l] "  $times]
         }
        
         for {set i 0} {$i < $port_count} {incr i } {
          set elm [lindex [set ${x}_l] $i]
          if {[string trim $elm] == "" || [string trim $elm] == "/" } {
              set ${x}_l [lreplace [set ${x}_l] $i $i "dontcare"]
          }
        }   
     }     
  }  
     
  set cmd "ca_l2_mcast_group_members_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)  
  }  
  if {$res == 0 } {
    set cmd "ca_l2_mcast_group_members_set_member_count $pt $member_count"
    set res [helper_cmd_exec -cmd $cmd ]
  }  
  if {$res == 0 } {
    set cmd "ca_l2_mcast_group_members_set_mcg_id $pt $mcg_id"
    set res [helper_cmd_exec -cmd $cmd ]
  }    

  for {set pidx 0 } {($pidx < $port_count) && $res == 0} {incr pidx} {
    set port [lindex $member_port_l $pidx]
    set pmem [ca_l2_mcast_group_members_get_member $pt $pidx]    
    set pmask [ca_l2_mcast_member_get_action_mask $pmem]
    set need_cfg_msk 0
    foreach var $v_member_key_l {
          set value [string trim [lindex [set ${var}_l] $pidx]]
          if {$value == ""} {
              set value "dontcare"
          }
          if {$res == 0  && [string compare -nocase $value "dontcare"]} {            
            if {$var == "new_mac_da" || $var == "new_mac_sa" } {
              set partname [string range $var 3 end]
              set mac_l [split $value :]
              set n_mac_l ""
              foreach mac $mac_l {
                lappend n_mac_l 0x$mac
               }
              set cmd "ca_mac_addr_set [ca_l2_mcast_member_get_$var $pmem] $n_mac_l"
              set res [helper_cmd_exec -cmd $cmd ] 
              set need_cfg_msk 1
              set mask_overwrite [string trim [lindex [set mask_${partname}_overwrite_l $pidx] ] ]
              if {[string compare -nocase $mask_overwrite  "dontcare"] == 0} {
                set mask_${partname}_overwrite_l [lreplace [set mask_${partname}_overwrite_l] $pidx $pidx 1]
              }      
            } elseif {$var == "reserved" } {
               helper_expand_list -set $value -out aRtn
               set new_l $aRtn(-l)
               for {set i 0 } {$i < [llength $aRtn(-l)]} {incr i} {
                 if {[lindex $new_l $i] == "/"} {continue}
                 set cmd [ca_l2_mcast_member_set_reserved $pmem [lindex $new_l $i] $i]
                 set res [helper_cmd_exec -cmd $cmd ] 
                 if {$res} {break}
               }
            } else {
              if {$var == "vlan_action"} {
                set need_cfg_mask 1
                set mask_value [lindex $mask_vlan_action_l $pidx]
                if {[string compare -nocase $mask_value  "dontcare"] == 0} {
                  set mask_vlan_action_l [lreplace $mask_vlan_action_l $pidx $pidx  1]
                }               
              }
            set cmd "ca_l2_mcast_member_set_$var $pmem $value"
            set res [helper_cmd_exec -cmd $cmd ]          
          }
        } 
    }

    foreach var $v_action_mask_key_l {
       set value [string trim [lindex [set ${var}_l] $pidx]]
      
       if {$value == ""} {
           set value "dontcare"
       }
      if {$res == 0 && [string compare $value "dontcare"]}  {
          set cmd "ca_mcast_egress_action_mask_set_[string range $var 5 end] $pmask $value"
          set res [helper_cmd_exec -cmd $cmd ]
      }
    }  
  } ;#end of loop port
  
  if {$res == 0 } {
    #ca_l2_mcast_group_members_dump $pt
    set cmd [list ca_l2_mcast_member_$operation $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}
proc ::gw::wca_l2_mcast_member_get_all {args} {
  set ifnm wca_l2_mcast_member_get_all
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id}  
  set v_key_l {mcg_id print_res}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-print_res) 1
  array set aIn $args
  set print_res $aIn(-print_res)
  helper_output_declare aIn
  helper_output_init aOut
   
  if {[info exists aIn(-mcg_id)] && [string compare -nocase $aIn(-mcg_id) "dontcare"]} {  
    set res [wca_l2_mcast_group_get -device_id $device_id -mcg_id $aIn(-mcg_id)  -out aTmp -print_res 0]
    if {$res == 0 } {
     array set aOut $aTmp(-members)
    }
  } else {
    set res [wca_l2_mcast_group_get_all -device_id $device_id -out aTmp -print_res 0]
    if {$res == 0} {
      foreach elm [array names aTmp] {
        array set aElem $aTmp($elm)
        array set aOut $aElem(-members)
      }
    }
  }
 
  if {$print_res} { 
    puts "\nTotal L2 Multicast Group Member Count : [array size aOut]\n"  
    helper_parray aOut "-dictionary" 1
  } 
  log -tag itfend 
  return $res
}
proc ::gw::wca_l2_mcast_member_delete_all {args} {
  set ifnm wca_l2_mcast_member_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set v_key_l {mcg_id}

  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-mcg_id) DONTCARE
  array set aIn $args
  
  set res [wca_l2_mcast_member_get_all -device_id $device_id -mcg_id $aIn(-mcg_id) -out aMembers -print_res 0]
  if {$res == 0 } {
    foreach elm [array names aMembers] {
      set elm_l [split $elm /]
      set mcg_id [lindex $elm_l 0]
      catch {array unset aTmp} ignore
      array set aTmp $aMembers($elm)
      log -tag info -msg "To delete mcast member in group mcg_id=$mcg_id  [array get aTmp] "
      set res [eval wca_l2_mcast_member_delete -device_id $device_id -mcg_id $mcg_id [array get aTmp] ]
      if {$res} {break}
    }   
  }
  log -tag itfend
  return $res                  
}
#------------------------------
#Section: Multicast Management - L3 Multicast Management
#------------------------------
proc ::gw::wca_l3_mcast_group_add {args} {
 set ifnm wca_l3_mcast_group_add
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id  }
  set v_key_l {  group_ip_addr src_ip_address}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut mcg_id 
  
  set cmd "ca_l3_mcast_entry_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    foreach var $v_key_l {
      if {[info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        if {$var == "src_ip_address" || $var == "group_ip_addr"} {
          set pip [ca_l3_mcast_entry_get_$var $pt]
          set res [eval helper_ca_ip_address_entry_config -ref $pip  -ip_addr $aIn(-$var)]
        } else {
          set cmd "ca_l3_mcast_entry_set_$var $pt $aIn(-$var)"
          set res [helper_cmd_exec -cmd $cmd]
        }
        if {$res} {break}
      } 
    }
  }
  if {$res == 0 } {
    set cmd [list ca_l3_mcast_group_add $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  if {$res == 0 || $res == 14} {
    set mcg_id [ca_l3_mcast_entry_get_mcg_id $pt]
    set aOut(-mcg_id) $mcg_id
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_parray aOut
  return $res                     
}
proc ::gw::wca_l3_mcast_group_delete_all {args} {
  set ifnm wca_l3_mcast_group_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set v_key_l {}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }

  if {$res == 0 } {
    set cmd [list ca_l3_mcast_group_delete_all $device_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  log -tag itfend
  helper_parray aOut
  return $res                     
}
proc ::gw::wca_l3_mcast_group_delete {args} {
  set ifnm wca_l3_mcast_group_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id mcg_id}
  set v_key_l {}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  if {$res == 0 } {
    set cmd [list ca_l3_mcast_group_delete $device_id $mcg_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  log -tag itfend
  helper_parray aOut
  return $res                     
}
proc ::gw::wca_l3_mcast_group_get_all {args} {
  global errorInfo
  variable gwenv
  set ifnm wca_l3_mcast_group_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l {cpi print_res}
 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  
  set aIn(-cpi) 1
  set aIn(-print_res) 1
  array set aIn $args  
  set cpi $aIn(-cpi)
  set print_res $aIn(-print_res)
  helper_output_declare aIn
  helper_output_init aOut
  array set aMembers ""    
  #http://bugs/show_bug.cgi?id=50685  entry size is 2112 bytes
  set aTmp(-iterator_pointer) NULL    
  set tot_ent_index 0
  for {set max 0} {$max < 10000 && $res == 0} {incr max} {
    set res [helper_iterate -device_id $device_id \
      -data_type ca_l3_mcast_iterator_entry_t \
      -iterate_func ca_l3_mcast_group_iterate \
      -parse_func helper_ca_l3_mcast_iterator_entry_parse \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) \
      -cpi $cpi -uint32_size 600 -data_size 2400 -out aTmp]     
    if {$gwenv(REPORT_LEVEL) == 0} {
       parray aTmp
    }             
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    } 
    foreach idx [array names aTmp] {
      if {[regexp {^\d$} $idx ] == 0} continue
      array set aTmp0 $aTmp($idx)
      set aOut($tot_ent_index) [array get aTmp0]    
      array set aMembers $aTmp0(-members)
      unset aTmp0(-members)
      set aPrtTmp($tot_ent_index) [array get aTmp0]
      incr tot_ent_index
    } 
  }
  if {$max >= 10000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  }   
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    log -tag warning -msg $err
  }   
  if {$print_res} {
    puts "\nTotal L3 Multicast Group Entry Count : [array size aPrtTmp]\n"
    helper_parray aPrtTmp "-integer" 1
    puts "\nL3 Multicast Group Member Lists:"
    helper_parray aMembers "-dictionary" 1
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_l3_mcast_group_get {args} {
  set ifnm wca_l3_mcast_group_get
  set res 0
  set CA_MC_EGRESS_ACTION_RESERVED  32
  log -tag itfbgn -msg $args
  set m_key_l {device_id mcg_id} 
  set v_key_l {print_res}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut [list members member_count]
  set aOut(-members) ""
  set aOut(-member_count) 0
  catch {array unset aMembers}  
  array set aMembers ""
  set cmd {ca_l3_mcast_iterator_entry_create}
  set res [helper_cmd_exec -cmd $cmd -out aRes]
  if {$res == 0} {
    set pt $aRes(-err)    
  }
  if {$res == 0} {
    set cmd [list ca_l3_mcast_group_get $device_id $mcg_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]  
  }  
  if {$res == 0 } {
    set res [helper_ca_l3_mcast_iterator_entry_parse -ref $pt -out aOut ]
  } 
  catch {ca_data_free $pt} err
  
  if {$res == 0 && $aIn(-print_res)} {
    array set aTmp [array get aOut]
    array set aMembers $aTmp(-members)
    unset aTmp(-members)
    helper_parray aTmp 
    
    puts "\nL3 Multicast Group Members (Count=$aOut(-member_count)):"    
    helper_parray aMembers  "-dictionary" 1

  }
  log -tag itfend
  return $res    
}
proc ::gw::wca_l3_mcast_member_delete {args} {
  set ifnm wca_l3_mcast_member_delete
  set res 0
  log -tag itfbgn -msg $args  
  set res [eval wca_l3_mcast_member_cmd -operation "delete" $args -validate 0]
  log -tag itfend 
  return $res
}

proc ::gw::wca_l3_mcast_member_add {args} {
  set ifnm wca_l3_mcast_member_add
  set res 0
  log -tag itfbgn -msg $args  
  set res [eval wca_l3_mcast_member_cmd -operation "add" $args]
  log -tag itfend 
  return $res
}

proc ::gw::wca_l3_mcast_member_get_all {args} {
  global errorInfo
  set ifnm wca_l3_mcast_member_get_all
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id}  
  set v_key_l {mcg_id print_res}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut 
  set print_res $aIn(-print_res)
  if {[info exists aIn(-mcg_id)] && [string compare -nocase $aIn(-mcg_id) "dontcare"]} {  
    set res [wca_l3_mcast_group_get -device_id $device_id -mcg_id $aIn(-mcg_id) -out aTmp -print_res 0]
    if {$res == 0 } {
      array set aOut $aTmp(-members)
    }
  } else {
    set res [wca_l3_mcast_group_get_all -device_id $device_id -out aTmp -print_res 0]
    if {$res == 0} {
      foreach elm [array names aTmp] {
        array set aElem $aTmp($elm)
        array set aOut $aElem(-members)
      }
    }
  }    
  if {$print_res } {
    puts "\nTotal L3 Multicast Group Entry Count : [array size aOut]\n"
    helper_parray aOut "dontcare" 1
  } 
  log -tag itfend 
  return $res
}

proc ::gw::wca_l3_mcast_member_cmd {args} {
  variable CA_MC_EGRESS_ACTION_RESERVED
  set CA_MC_EGRESS_ACTION_RESERVED 4    
  set ifnm wca_l3_mcast_member_cmd
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id mcg_id}  
  set v_action_mask_key_l [helper_probe_struct_members -struct ca_mcast_egress_action_mask]
  set l [helper_probe_struct_members -struct ca_l3_mcast_member]
  set idx [lsearch $l action_mask]
  set v_member_key_l "[lrange $l 0 $idx-1] [lrange $l $idx+1 end]" 
  set v_key_l $v_member_key_l
  foreach v $v_action_mask_key_l {
    lappend v_key_l mask_$v    
  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
 
  set aIn(-data_init) 1
  set aIn(-operation) "add"  
  array set aIn $args  
  
  set operation $aIn(-operation)
  
  set cmd "ca_l3_mcast_group_members_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)  
    set pmem [ca_l3_mcast_group_members_get_member $pt 0]    
    set pmask [ca_l3_mcast_member_get_action_mask $pmem]
  }
  
  if {$res == 0 } {
    set cmd "ca_l3_mcast_group_members_set_member_count $pt 1"
    set res [helper_cmd_exec -cmd $cmd ]
  }
  if {$res == 0 } {
    set cmd "ca_l3_mcast_group_members_set_mcg_id $pt $mcg_id"
    set res [helper_cmd_exec -cmd $cmd ]
  }  
  set need_cfg_msk 0
  foreach var $v_member_key_l {
      if {$res == 0  && 
        [info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} {        
          if {$var == "new_mac_da" } {
            set mac_l [split $aIn(-new_mac_da) :]
            set n_mac_l ""
            foreach mac $mac_l {
              lappend n_mac_l 0x$mac
             }
            set cmd "ca_mac_addr_set [ca_l3_mcast_member_get_new_mac_da $pmem] $n_mac_l"
            set res [helper_cmd_exec -cmd $cmd ] 
            set need_cfg_msk 1
            if {[info exists aIn(-mask_mac_da_overwrite)] == 0 || 
              [string compare -nocase $aIn(-mask_mac_da_overwrite)  "dontcare"] == 0} {
              set aIn(-mask_mac_da_overwrite) 1
            }      
          } elseif {$var == "reserved" } {
             helper_expand_list -set $aIn(-reserved) -out aRtn
             set new_l $aRtn(-l)
             for {set i 0 } {$i < [llength $aRtn(-l)]} {incr i} {
               if {[lindex $new_l $i] == "/"} {continue}
               set cmd [ca_l3_mcast_member_set_reserved $pmem [lindex $new_l $i] $i]
               set res [helper_cmd_exec -cmd $cmd ] 
               if {$res} {break}
             }
          } else {            
            set cmd "ca_l3_mcast_member_set_$var $pmem $aIn(-$var)"
            set res [helper_cmd_exec -cmd $cmd ]    
            if {([lsearch $v_action_mask_key_l $var] >=0 ) || 
                ([info exists aIn(-mask_$var)] == 0 || 
                  [string compare -nocase $aIn(-mask_$var)  "dontcare"] == 0) } {
              set aIn(-mask_mac_da_overwrite) 1
            }                 
        }
      } 
  }

  foreach var $v_action_mask_key_l {
      if {$res == 0 && 
        [info exists aIn(-mask_$var)] && 
        [string compare [string tolower $aIn(-mask_$var)] "dontcare"]}  {
          set cmd "ca_mcast_egress_action_mask_set_$var $pmask $aIn(-mask_$var)"
          set res [helper_cmd_exec -cmd $cmd ]
      }
  }
  if {$res == 0 } {
    #ca_l3_mcast_group_members_dump $pt
    set cmd [list ca_l3_mcast_member_$operation $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res            
}
proc ::gw::wca_l3_mcast_member_delete_all {args} {
  set ifnm wca_l3_mcast_member_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set v_key_l {mcg_id}

  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-mcg_id) DONTCARE
  array set aIn $args
  
  set res [wca_l3_mcast_member_get_all -device_id $device_id -mcg_id $aIn(-mcg_id) -out aMembers -print_res 0]
  if {$res == 0 } {
    foreach elm [array names aMembers] {
      set elm_l [split $elm /]
      set mcg_id [lindex $elm_l 0]
      catch {array unset aTmp} ignore
      array set aTmp $aMembers($elm)
      log -tag info -msg "To delete mcast member in group mcg_id=$mcg_id  [array get aTmp] "
      set res [eval wca_l3_mcast_member_delete -device_id $device_id -mcg_id $mcg_id [array get aTmp] ]
      if {$res} {break}
    }   
  }
  log -tag itfend
  return $res      
}
#--------------------------------------------------------------------------
#Section: NAT Management
#--------------------------------------------------------------------------
proc ::gw::wca_nat_config_set {args} {
  set ifnm wca_nat_config_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  set v_key_l {miss_to_cpu tcp_ctrl_to_cpu aging_time}
  set aIn(-data_init) 1
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  array set aIn $args  
  set data_init $aIn(-data_init)
  set cmd "ca_nat_config_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  if {$res == 0 } {
    if {$data_init == 1} {
      set cmd "ca_nat_config_get $device_id $pt"
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    }
  }
  if {$res == 0} {
    foreach var $v_key_l {
      if {[info exists aIn(-$var)] && [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        set cmd "ca_nat_config_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd ]
        if {$res} {break}
      }
    }
  }
  if {$res == 0 } {
    set cmd [list ca_nat_config_set $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}

proc ::gw::wca_nat_config_get {args} {
  set ifnm wca_nat_config_get
  set res 0
  log -tag itfbgn -msg $args
 
  set m_key_l {device_id}
  set v_out_key_l {miss_to_cpu tcp_ctrl_to_cpu aging_time}  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  array set aIn $args 
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l 
  set cmd "ca_nat_config_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd [list ca_nat_config_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
    if {$res == 0} {
      foreach var $v_out_key_l {
        set aOut(-$var) [ca_nat_config_get_$var $pt ]
      }
    }  
  }  
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}

proc ::gw::wca_nat_entry_add {args} {
  set ifnm wca_nat_entry_add
  set res 0
  log -tag itfbgn -msg $args  
  set res [eval wca_nat_entry_cmd -operation "add" $args ]
  log -tag itfend 
  return $res
}
proc ::gw::wca_nat_entry_delete {args} {
  set ifnm wca_nat_entry_delete
  set res 0
  log -tag itfbgn -msg $args  
  set res [eval wca_nat_entry_cmd -operation "delete" $args]
  log -tag itfend 
  return $res
}
proc ::gw::wca_nat_entry_get {args} {
  set ifnm wca_nat_entry_get
  set res 0
  log -tag itfbgn -msg $args  
  helper_output_declare aIn
  helper_output_init aOut
  set res [eval wca_nat_entry_cmd "-operation get -out aOut $args"]
  helper_parray aOut
  log -tag itfend 
  return $res
}
proc ::gw::wca_nat_entry_cmd {args} {
  set docStr "xlats_flags:
      SRC_IP  = 0x1 << 0  = 1
      DST_IP  = 0x1 << 1  = 2
      L4_PORT = 0x1 << 2  = 4
      STATIC  = 0X1 << 3  = 8"
  set ifnm wca_nat_entry_cmd
  set res 0
  log -tag itfbgn -msg $args  
  set aIn(-operation) "add" 
  set aIn(-data_init) 0
  set aIn(-dump_data) 0
  set m_key_l {device_id }
  set v_key_l {xlate_flags src_ip_addr src_l4_port dst_ip_addr dst_l4_port ip_proto 
    new_src_ip_addr new_src_l4_port new_dst_ip_addr new_dst_l4_port aging_timer nexthop_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  set aIn(-nexthop_id) 0xffff
  array set aIn $args
  set operation $aIn(-operation)
  if {$operation == "get"} {
    helper_output_declare aIn
    helper_output_init aOut  $v_key_l  
  }
  set cmd "ca_nat_entry_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    foreach var $v_key_l {
      if {[info exists aIn(-$var)] == 0 
        || [string compare [string tolower $aIn(-$var)] "dontcare"] == 0} {
        continue    
      }    
      if {[string first "_ip_addr" $var] > 0 } {
        #handle ip address
        set pip [ca_nat_entry_get_$var $pt]
        set res [eval helper_ca_ip_address_entry_config -ref $pip -ip_addr $aIn(-$var) -out aTmp]      
      } else {  
        set cmd "ca_nat_entry_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd ]
      }
      if {$res} {break}
    }
  }
  if {$res == 0 && $aIn(-dump_data)} {
    ca_nat_entry_dump $pt
  }
  if {$res == 0 } {
    set cmd [list ca_nat_entry_$operation $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
    if {$res == 0 && $operation == "get"} {
      foreach var $v_key_l {
        if {[string first "_ip_addr" $var] > 0 } {
          set aTmp(-ip_addr) ""
          set pip [ca_nat_entry_get_$var $pt]
          set res [helper_ca_ip_address_entry_parse -ref $pip -out aTmp]
          set aOut(-$var) $aTmp(-ip_addr)
        } else {
          set aOut(-$var) [ca_nat_entry_get_$var $pt]
        }
      }
    }
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res                
}
proc ::gw::wca_nat_entry_get_all {args} {
  global errorInfo
  set ifnm wca_nat_entry_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l { cpi }
  set v_out_key_l {xlate_flags src_ip_addr src_l4_port dst_ip_addr dst_l4_port ip_proto 
    new_src_ip_addr new_src_l4_port new_dst_ip_addr new_dst_l4_port aging_timer nexthop_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-cpi) 3
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut
  set cpi $aIn(-cpi) 
  set print_res $aIn(-print_res)
  
  set aTmp(-iterator_pointer) NULL    
  set idx 0
  for {set max 0} {$max < 10000 && $res == 0 } {incr max} {
    set res [helper_iterate -device_id $device_id \
      -data_type ca_nat_entry_t\
      -iterate_func ca_nat_entry_iterate \
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer)  -out aTmp]
    if {$res} {
      if {$res == 9} {set res 0}
      break
    }
    foreach npdx $aTmp(-element_data_pointers) {
      set ent_l ""
      catch {array unset aVars}
      array set aVars ""
      foreach var $v_out_key_l {
        set val [ca_nat_entry_get_$var $npdx]
        if {[string first "_ip_addr" $var ] >0 } {
          set res [eval helper_ca_ip_address_entry_parse -ref $val -out aTmp0]
          set aVars(-$var) $aTmp0(-ip_addr)
        } else {        
          set aVars(-$var) $val      
        }
      } 
      set aOut($idx) [array get aVars]    
      incr idx
    }
  }  
  if {$max >= 10000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  }
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    #log -tag warning -msg $err
  }
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    #log -tag warning -msg $err
  }     
  
  if {$print_res} {
    puts "\nTotal Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_nat_entry_delete_all {args} {
  set ifnm wca_nat_entry_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id  }
  if {[helper_m_args_check -args $args -m_key_l $m_key_l] } {
    return -1
  } 
  if {$res == 0 } {
    set cmd [list ca_nat_entry_delete_all $device_id ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
#--------------------------------------------------------------------------
#Section: Tunnel Management
#--------------------------------------------------------------------------
proc ::gw::wca_tunnel_add {args} {
  set ifnm wca_tunnel_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id type}  
  eval helper_ca_tunnel_cu_usage $args
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]

  if {$res} {
    return $res
  }
  helper_output_declare aIn
  helper_output_init aOut tunnel_id
  set res [eval helper_ca_tunnel_cfg_entry_config -out aTmp -ref "dontcare" $args] 
  
  set ptid [ca_uint16_create 0] 
  if {$res == 0} {
    set pt $aTmp(-ref)
    set cmd "ca_tunnel_add  $device_id  $pt  $ptid"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    catch {ca_data_free $pt} err
  } 
  if {$res == 0 } {
    set aOut(-tunnel_id) [ca_uint16_get $ptid]
  }
  catch {ca_data_free $ptid} err
  log -tag itfend
  return $res                
}
proc ::gw::wca_tunnel_delete {args} {
  set ifnm wca_tunnel_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id tunnel_id}
 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  if {$res == 0} {
    set cmd "ca_tunnel_delete $device_id  $tunnel_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res      
}
proc ::gw::wca_tunnel_update {args} {
  set ifnm wca_tunnel_update
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id type tunnel_id}    
  eval helper_ca_tunnel_cu_usage $args
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  

  array set aIn $args
  array set aTmp ""
  set res [eval helper_ca_tunnel_cfg_entry_config -out aTmp -ref "dontcare" $args]   
  if {$res == 0} {
    set pt $aTmp(-ref)
    set cmd "ca_tunnel_update  $device_id  $pt $tunnel_id"
    set res [helper_cmd_exec -cmd $cmd]      
  }   
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res                  
}
proc ::gw::wca_tunnel_get_all {args} {
  global errorInfo
  set ifnm wca_tunnel_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l {cpi}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-cpi) 2
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut
  set cpi $aIn(-cpi) 
  set print_res $aIn(-print_res)
 
  set aTmp(-iterator_pointer) NULL    
  set idx 0
  for {set max 0} {$max < 10000 && $res == 0} {incr max} {
    set res [helper_iterate -device_id $device_id \
      -data_type ca_tunnel_iterate_entry_t\
      -iterate_func ca_tunnel_iterate \
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    }      
    foreach npdx $aTmp(-element_data_pointers) {
      catch {array unset aRtn}
      array set aRtn ""
      set pCfg [ca_tunnel_iterate_entry_get_tunnel $npdx]
      set res [helper_ca_tunnel_cfg_entry_parse -ref $pCfg -out aRtn]
      set aRtn(-tunnel_id) [ca_tunnel_iterate_entry_get_tunnel_id $npdx]
      set aOut($idx) [array get aRtn]
      incr idx
    }
  }  
  if {$max >= 10000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  }   
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {$print_res} {
    puts "\nTotal Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  }
  log -tag itfend
  return $res   
}
proc ::gw::wca_tunnel_get {args} {
  # to be finished ..., when ca_port_encap_get_xxx is ready
  set ifnm wca_tunnel_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id tunnel_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  
  set cmd "ca_tunnel_cfg_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  if {$res == 0} {
    set cmd [list ca_tunnel_get $device_id $tunnel_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    set res [helper_ca_tunnel_cfg_entry_parse -ref $pt -out aOut]
  }
  catch {ca_data_free $pt} err
  helper_parray aOut  
  log -tag itfend
  return $res              
}
proc ::gw::wca_tunnel_delete_all {args} {
  set ifnm wca_tunnel_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  if {$res == 0} {
    set cmd "ca_tunnel_delete_all $device_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res        
}
#-----------------------------------------
#Section: Tunnel Management - PPPOE Tunnel Management
#-----------------------------------------
proc ::gw::wca_tunnel_pppoe_tunnel_add {args} {
  set ifnm wca_tunnel_pppoe_tunnel_add
  set res 0
  set CA_PORT_VLAN_TAG_MAX 2
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l $v_pppoe_com_key_l"
  
  set aIn(-type) PPPOE ;#pppoe
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_output_declare aIn
  helper_output_init aOut tunnel_id
   
  set cmd {ca_uint16_create 0} 
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set ptid $aTmp(-err)
    set cmd {ca_tunnel_cfg_create}
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  #Three layers: ca_tunnel_cfg_t ->(union) ->  ca_pppoe_tunnel_cfg_t -> ca_port_encap_t 
  if {$res == 0 } {
    set pt $aTmp(-err)
    set res [eval helper_ca_tunnel_cfg_entry_config -type 1 -ref $pt $args]    
  }
  catch {array unset aOut} err  
  set aOut(-tunnel_id) unknown
  if {$res == 0} {
    set cmd "ca_tunnel_add  $device_id  $pt  $ptid"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      set aOut(-tunnel_id) [ca_uint16_get $ptid]
    }    
  } 
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res                
}
proc ::gw::wca_tunnel_pppoe_tunnel_update {args} {
  set ifnm wca_tunnel_pppoe_tunnel_update
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id tunnel_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l $v_pppoe_com_key_l"
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-type) 1 ;#pppoe
  array set aIn $args
  
  set cmd {ca_tunnel_cfg_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    #Read system config
    set cmd [list ca_tunnel_get $device_id $tunnel_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
  }   
  if {$res == 0 } {
     set res [eval helper_ca_tunnel_cfg_entry_config -type 1 -ref $pt $args] 
  }
  if {$res == 0} {    
    set cmd "ca_tunnel_update  $device_id  $pt  $tunnel_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res                
}
#-----------------------------------------
#Section: Tunnel Management - L2TP Tunnel Management
#-----------------------------------------

proc ::gw::wca_tunnel_l2tp_tunnel_add {args} {
  set ifnm wca_tunnel_l2tp_tunnel_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l $v_l2tp_com_key_l"
  set aIn(-type) 2 ;#l2tp
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut tunnel_id
  
  set cmd {ca_uint16_create 0} 
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set ptid $aTmp(-err)
    set cmd {ca_tunnel_cfg_create}
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
 
  if {$res == 0 } {
    set pt $aTmp(-err)
    set res [eval helper_ca_tunnel_cfg_entry_config -type $aIn(-type) -ref $pt $args]    
  }
  ca_tunnel_cfg_dump $pt
  catch {array unset aOut} err  
  set aOut(-tunnel_id) unknown
  if {$res == 0} {    
    set cmd "ca_tunnel_add  $device_id  $pt  $ptid"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      set aOut(-tunnel_id) [ca_uint16_get $ptid]
    }    
  } 
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res                
}
proc ::gw::wca_tunnel_l2tp_tunnel_update {args} {
  set ifnm wca_tunnel_l2tp_tunnel_update  
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id tunnel_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l $v_l2tp_com_key_l"
  
  set aIn(-type) 2 ;#l2tp
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
 
  set cmd {ca_tunnel_cfg_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    #Read system config
    set cmd [list ca_tunnel_get $device_id $tunnel_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
  }   
  if {$res == 0 } {
     set res [eval helper_ca_tunnel_cfg_entry_config -type 2 -ref $pt $args]
  }
  if {$res == 0} {    
    set cmd "ca_tunnel_update  $device_id  $pt  $tunnel_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res                
}
#-----------------------------------------
#Section: Tunnel Management - IPSEC Tunnel Management
#-----------------------------------------
proc ::gw::wca_ipsec_init {args} {
  set ifnm wca_ipsec_init
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
 if {$res == 0 } {
    set cmd [list ca_ipsec_init $device_id ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_ipsec_shut {args} {
  set ifnm wca_ipsec_shut
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  if {$res == 0 } {
    set cmd [list ca_ipsec_shut $device_id ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res                
}

proc ::gw::wca_ipsec_sa_add {args} {
  set docStr "Note:
    "
  set ifnm wca_ipsec_sa_add
  set res 0
  log -tag itfbgn -msg $args
  variable MAX_ENC_KEY_LEN
  variable MAX_AUTH_KEY_LEN
  set m_key_l {device_id}

  set v_key_l {replay_window spi sequence_number ekey \
    akey ip_version protocol tunnel ealg ealg_mode encryption_keylen \
    iv_len aalg auth_keylen icv_trunclen etherIP reserved \
    is_natt src_l4_port dest_l4_port sa_dir max_enc_key_len max_auth_key_len} 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut sa_id
  
  if {[info exists aIn(-max_enc_key_len)] &&
     [string compare [string tolower $aIn(-max_enc_key_len)] "dontcare"] } {
    set maxEncKeyLen $aIn(-max_enc_key_len)  
  } else {
    set maxEncKeyLen $MAX_ENC_KEY_LEN    
  }
  if {[info exists aIn(-max_auth_key_len)] &&
     [string compare [string tolower $aIn(-max_auth_key_len)] "dontcare"] } {
    set maxAuthKeyLen $aIn(-max_auth_key_len)  
  } else {
    set maxAuthKeyLen $MAX_AUTH_KEY_LEN    
  }  
  set cmd "ca_ipsec_sa_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd "ca_uint32_create 0"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  } 
  if {$res == 0 } {
    set pid $aTmp(-err)    
    foreach var $v_key_l {
      if {$res} {break}
      if {$var == "max_enc_key_len" || $var == "max_auth_key_len"} {continue}
      if {[info exists aIn(-$var)] == 0  
        || [string compare [string tolower $aIn(-$var)] "dontcare"] == 0} {
        continue    
      }  
      if {$var == "ekey" || $var == "akey"} {        
          helper_expand_list -set $aIn(-$var) -out aTmp
          set v_l $aTmp(-l)
          set len [llength $v_l]

          for {set idx 0 } {$idx < $len} {incr idx} {
            set cmd "ca_ipsec_sa_set_$var $pt [lindex $v_l $idx] $idx"
            set res [helper_cmd_exec -cmd $cmd]
            if {$res} {break}
          }
      } elseif {$var == "tunnel_saddr" || $var == "tunnel_daddr"} {
        set pip [ca_ipsec_sa_get_$var $pt]
        set res [eval helper_ca_ip_address_entry_config -ref $pip  -ip_addr $aIn(-$var)]
      } elseif {$var == "sa_dir" } {      
        helper_h2s -table CA_IPSEC_SPD_ENCRYPT_T -source $aIn(-sa_dir) -out aH
        set sa_dir $aH(-target)
        set cmd "ca_ipsec_sa_set_sa_dir $pt $sa_dir"
        set res [helper_cmd_exec -cmd $cmd]  
      } else  {      
        set cmd "ca_ipsec_sa_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd]
      }
    }
  }

  if {$res == 0 } {
    set cmd [list ca_ipsec_sa_add $device_id $pt $pid]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    set aOut(-sa_id) [ca_uint32_get $pid]
  }
  catch {ca_data_free $pt} err
  catch {ca_data_free $pid} err
  
  helper_parray aOut
  log -tag itfend

  return $res                  
}
proc ::gw::wca_ipsec_sa_delete {args} {
  set ifnm wca_ipsec_sa_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id sa_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  if {$res == 0 } {
    set cmd [list ca_ipsec_sa_delete $device_id $sa_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_ipsec_sa_delete_all {args} {
  set ifnm wca_ipsec_sa_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aOut ""
  if {$res == 0 } {
    set rest [wca_ipsec_sa_get_all -out aOut -print_res 0]
  }  
  if {$res == 0} {
    foreach idx [array names aOut] {
      array set aTmp $aOut($idx)
      log -tag info -msg "To remove ipsec sa entry: $aTmp(-sa_id)"
      set cmd [list ca_ipsec_sa_delete $device_id $aTmp(-sa_id)]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
      if {$res} {break}
    }
  }
  log -tag itfend
  return $res                  
}
proc ::gw::wca_ipsec_sa_get_all {args} {
  global errorInfo
  variable MAX_ENC_KEY_LEN
  variable MAX_AUTH_KEY_LEN
  set default_max_enc_key_len 32
  set default_max_auth_key_len 64
  set ifnm wca_ipsec_sa_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l {cpi print_res}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-cpi) 2
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut
  set cpi $aIn(-cpi)
  set print_res $aIn(-print_res)

  set aTmp(-iterator_pointer) NULL    
  for {set idx 0} {$idx < 10000 && $res == 0} {} {
    set res [helper_iterate -device_id $device_id \
      -data_type ca_ipsec_sa_iterate_entry_t\
      -iterate_func ca_ipsec_sa_iterate \
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]            
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    }  
    foreach npd $aTmp(-element_data_pointers) {
      catch {array unset aVars}
      array set aVars ""
      set npdx [ca_ipsec_sa_iterate_entry_get_ipsec_sa $npd]
      set res [helper_ipsec_sa_entry_parse -ref $npdx -out aVars]
      set aVars(-sa_id) [ca_ipsec_sa_iterate_entry_get_sa_id $npd]
      if {$res} {break}
      set aOut($idx) [array get aVars]    
      incr idx
    }
  }
  if {$idx >= 10000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  }
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    log -tag warning -msg $err
  }  
  
  if {$print_res} {
    puts "\nTotal IPSEC SA Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  }
  log -tag itfend
  return $res     
}
proc ::gw::wca_ipsec_sa_get {args} {
  set ifnm wca_ipsec_sa_get
  set res 0
  log -tag itfbgn -msg $args
  variable MAX_ENC_KEY_LEN
  variable MAX_AUTH_KEY_LEN  
  set default_max_enc_key_len 32
  set default_max_auth_key_len 64
  set m_key_l {device_id sa_id} 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l] 
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut 
  set cmd {ca_ipsec_sa_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)  
    set cmd [list ca_ipsec_sa_get $device_id $sa_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]  
  }    
  if {$res == 0} {    
    set res [helper_ipsec_sa_entry_parse -ref $pt -out aOut]  
  }   
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res 
}
proc ::gw::helper_ipsec_sa_entry_parse {args} {
  set ifnm helper_ipsec_sa_entry_parse
  set res 0
  log -tag itfbgn -msg $args
  variable MAX_ENC_KEY_LEN
  variable MAX_AUTH_KEY_LEN  
  set default_max_enc_key_len 32
  set default_max_auth_key_len 64  
  set v_out_key_l {replay_window spi sequence_number ekey \
    akey ip_version protocol tunnel ealg ealg_mode encryption_keylen iv_len aalg auth_keylen\
    icv_trunclen etherIP reserved is_natt src_l4_port dest_l4_port sa_dir}   
  set res [helper_m_args_check -args $args]
 
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l
  set pt $aIn(-ref)
  if {$res == 0 } {
    foreach var $v_out_key_l {
      if {$var == "tunnel_saddr"  || $var == "tunnel_daddr"} {
        set pip [ca_ipsec_sa_get_$var $pt]            
        set res [eval helper_ca_ip_address_entry_parse -ref $pip -out aTmp]
        set aOut(-$var) -$var $aTmp(-ip_addr)
      }   elseif {$var == "ekey" || $var == "akey" } {
        if {$var == "ekey"} {
          #set cnt $MAX_ENC_KEY_LEN
          set cnt $default_max_enc_key_len
          set act_len [ca_ipsec_sa_get_encryption_keylen $pt]
        } else {
          #set cnt $MAX_AUTH_KEY_LEN
          set cnt $default_max_auth_key_len
          set act_len [ca_ipsec_sa_get_auth_keylen $pt]
        }
       # if {$cnt > $act_len} {set cnt $act_len}
        set l ""
        for {set ci 0 } {$ci < $cnt} {incr ci} {
          lappend l [ca_ipsec_sa_get_$var $pt $ci]
        }
        set aOut(-$var) [join $l ,]
      } elseif {$var == "sa_dir"} {
        set aOut(-sa_dir) [ca_ipsec_sa_get_sa_dir $pt]
        helper_s2h -table CA_IPSEC_SPD_ENCRYPT_T -source $aOut(-sa_dir) -out aH
        set aOut(-sa_dir_v)  $aH(-target)
      } else {     
        set aOut(-$var) [ca_ipsec_sa_get_$var $pt]      
      }
    }  
  }
  log -tag itfend
  return $res   
}
proc ::gw::wca_tunnel_ipsec_tunnel_add {args} {
  set ifnm wca_tunnel_ipsec_tunnel_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l $v_ipsec_com_key_l"
  
  set aIn(-type) 3 ;#ipsec
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut tunnel_id
  set cmd {ca_uint16_create 0} 
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set ptid $aTmp(-err)
    set cmd {ca_tunnel_cfg_create}
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
    set res [eval helper_ca_tunnel_cfg_entry_config -type 3 -ref $pt $args]  
  }
  catch {array unset aOut} err  
  set aOut(-tunnel_id) unknown
  if {$res == 0} {    
    set cmd "ca_tunnel_add  $device_id  $pt  $ptid"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      set aOut(-tunnel_id) [ca_uint16_get $ptid]
    }    
  } 
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res                
}

proc ::gw::wca_tunnel_ipsec_tunnel_update {args} {
  set ifnm wca_tunnel_ipsec_tunnel_update
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id tunnel_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l $v_ipsec_com_key_l"
  
  set aIn(-type) 3 ;#ipsec
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  array set aIn $args  

  set cmd {ca_tunnel_cfg_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    #Read system config
    set cmd [list ca_tunnel_get $device_id $tunnel_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
  }  
  if {$res == 0 } {
    set res [eval helper_ca_tunnel_cfg_entry_config -type 3 -ref $pt $args]
  }
 
  if {$res == 0} {    
    set cmd "ca_tunnel_update  $device_id  $pt  $tunnel_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_print_status_enum_name  $res  
  return $res                
}
#-----------------------------------------
#Section: Tunnel Management - DsLite Tunnel Management
#-----------------------------------------
proc ::gw::wca_tunnel_dslite_tunnel_add {args} {
  set ifnm wca_tunnel_dslite_tunnel_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l $v_dslite_com_key_l"  

  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }    
  set aIn(-type) 6 ;#dslite
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut tunnel_id
  set aOut(-tunnel_id) unknown        
  set cmd {ca_uint16_create 0} 
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set ptid $aTmp(-err)
    set cmd {ca_tunnel_cfg_create}
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }

  if {$res == 0 } {
    set pt $aTmp(-err)
    set res [eval helper_ca_tunnel_cfg_entry_config  -ref $pt [array get aIn]]  
  }
  catch {array unset aOut} err  
  set aOut(-tunnel_id) unknown
  if {$res == 0} {    
    set cmd "ca_tunnel_add  $device_id  $pt  $ptid"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      set aOut(-tunnel_id) [ca_uint16_get $ptid]
    }    
  } 
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res                
}
proc ::gw::wca_tunnel_dslite_tunnel_update {args} {
  set ifnm wca_tunnel_dslite_tunnel_update
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id tunnel_id}
  helper_ca_tunnel_cfg_entry_params_declare 
  set v_key_l "$v_com_key_l $v_dslite_com_key_l"
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-type) 6 ;#dslite
  array set aIn $args

  set cmd {ca_tunnel_cfg_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    #Read system config
    set cmd [list ca_tunnel_get $device_id   $tunnel_id  $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
  }  
  if {$res == 0 } {
    set res [eval helper_ca_tunnel_cfg_entry_config -ref $pt [array get aIn]] 
  }

  if {$res == 0} {    
    set cmd "ca_tunnel_update  $device_id  $pt $tunnel_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_print_status_enum_name  $res  
  return $res                
}
#-----------------------------------------
#Section: Tunnel Management - MAP-E/T Tunnel Management
#-----------------------------------------
proc ::gw::wca_tunnel_mape_tunnel_add {args} {
  set ifnm wca_tunnel_mape_tunnel_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l  $v_mape_com_key_l"  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut tunnel_id 
  set res [eval wca_tunnel_map_tunnel_add $args -type MAPE -out aOut]
  log -tag itfend 
  #helper_parray aOut
  return $res
}
proc ::gw::wca_tunnel_mapt_tunnel_add {args} {
  set ifnm wca_tunnel_mapt_tunnel_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l  $v_mape_com_key_l"  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut tunnel_id  
  set res [eval wca_tunnel_map_tunnel_add $args -type MAPT  -out aOut]
  log -tag itfend 
  #helper_parray aOut  
  return $res
}
proc ::gw::wca_tunnel_mape_tunnel_update {args} {
  set ifnm wca_tunnel_mape_tunnel_update
  set res 0
  log -tag itfbgn -msg $args
  set res [eval wca_tunnel_map_tunnel_update $args -type MAPE]
  log -tag itfend 
  return $res
}
proc ::gw::wca_tunnel_mapt_tunnel_update {args} {
  set ifnm wca_tunnel_mapt_tunnel_update
  set res 0
  log -tag itfbgn -msg $args
  set res [eval wca_tunnel_map_tunnel_update $args -type MAPT]
  log -tag itfend 
  return $res
}
proc ::gw::wca_tunnel_map_tunnel_add {args} {
  set docStr "This command will invoke helper_ca_tunnel_cfg_entry_config to configure fields of entry
      type: MAPE or MAPT"
  set ifnm wca_tunnel_map_tunnel_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l  $v_mape_com_key_l"  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut tunnel_id
  
  set cmd {ca_uint16_create 0} 
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set ptid $aTmp(-err)
    set cmd {ca_tunnel_cfg_create}
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
    set res [eval helper_ca_tunnel_cfg_entry_config -type $aIn(-type) -ref $pt $args] 
  }
  catch {array unset aOut} err  
  set aOut(-tunnel_id) unknown
  if {$res == 0} {    
    set cmd "ca_tunnel_add  $device_id  $pt  $ptid"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      set aOut(-tunnel_id) [ca_uint16_get $ptid]
    }    
  } 
  catch {ca_data_free $pt} err
  catch {ca_data_free $ptid} err
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name  $res  
  return $res                
}
proc ::gw::wca_tunnel_map_tunnel_update {args} {
  set ifnm wca_tunnel_map_tunnel_update
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id tunnel_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l  $v_mape_com_key_l"
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  if {$res == 0 } {
    set cmd {ca_tunnel_cfg_create}
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
    #Read system config
    set cmd [list ca_tunnel_get $device_id $tunnel_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
  }
  if {$res == 0 } {
    set res [eval helper_ca_tunnel_cfg_entry_config -type $aIn(-type) -ref $pt $args] 
  } 
  if {$res == 0} {    
    set cmd "ca_tunnel_update  $device_id  $pt  $tunnel_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1] 
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res      
}

#-----------------------------------------
#Section: Tunnel Management - 6RD Tunnel Management
#-----------------------------------------
proc ::gw::wca_tunnel_6rd_tunnel_add {args} {
  set docStr "This command will invoke helper_ca_tunnel_cfg_entry_config to configure fields of entry"
  set ifnm wca_tunnel_6rd_tunnel_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l  $v_6rd_com_key_l"
  
  set aIn(-type) 7 ;#6rd
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut tunnel_id 
  
  set cmd {ca_uint16_create 0} 
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set ptid $aTmp(-err)
    set cmd {ca_tunnel_cfg_create}
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
    set res [eval helper_ca_tunnel_cfg_entry_config -type $aIn(-type) -ref $pt $args] 
  }
  catch {array unset aOut} err  
  set aOut(-tunnel_id) unknown
  if {$res == 0} {    
    set cmd "ca_tunnel_add  $device_id  $pt  $ptid"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      set aOut(-tunnel_id) [ca_uint16_get $ptid]
    }    
  } 
  catch {ca_data_free $pt} err
  catch {ca_data_free $ptid} err
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name  $res  
  return $res                
}

proc ::gw::wca_tunnel_6rd_tunnel_update {args} {
  set ifnm wca_tunnel_6rd_tunnel_update
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id tunnel_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l  $v_6rd_com_key_l"
  
  set aIn(-type) 7 ;#6rd
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  if {$res == 0 } {
    set cmd {ca_tunnel_cfg_create}
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
    #Read system config
    set cmd [list ca_tunnel_get $device_id $tunnel_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
  }
  if {$res == 0 } {
    set res [eval helper_ca_tunnel_cfg_entry_config -type $aIn(-type) -ref $pt $args] 
  } 
  if {$res == 0} {    
    set cmd "ca_tunnel_update  $device_id  $pt  $tunnel_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1] 
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res                
}
#-----------------------------------------
#Section: Tunnel Management - PPTP Tunnel Management
#-----------------------------------------
proc ::gw::wca_pptp_key_change {args} {
  set ifnm wca_pptp_key_change
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id tunnel_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  array set aIn $args 
  if {$res == 0 } {
    set cmd [list ca_pptp_key_change $device_id $tunnel_id]
    set res [helper_cmd_exec -cmd $cmd]
  }
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res        
}
proc ::gw::wca_pptp_sa_add {args} {
  set docStr "Note:
    crypto type could be one of: INVALIDE(-1),NONE(0),MPPE40(1),MPPE128(3)
    direction: upstream(0), or downstream(1)
    mac keylen: defined in system is CA_PPTP_DEFAULT_KEY_LENGTH=16"
  set ifnm wca_pptp_sa_add
  set res 0
  log -tag itfbgn -msg $args 
  variable CA_PPTP_KEY_LEN_MAX  
  set m_key_l {device_id}
  set v_key_l {direction call_id state_less crypto_type key keylen sequence_number}  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut sa_id 
    
  set cmd "ca_pptp_sa_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd "ca_uint32_create 0"
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  } 
  if {$res == 0 } {
    set pid $aTmp(-err)    
    foreach var $v_key_l {
      if {$res} {break}
      if {[info exists aIn(-$var)] == 0  
        || [string compare [string tolower $aIn(-$var)] "dontcare"] == 0} {
        continue    
      }  
      if {$var == "key" } {        
          helper_expand_list -set $aIn(-$var) -out aTmp
          set v_l $aTmp(-l)
          set len [llength $v_l]
         if { $len > $CA_PPTP_KEY_LEN_MAX} {
            set len $CA_PPTP_KEY_LEN_MAX
          }
          for {set idx 0 } {$idx < $len} {incr idx} {
            set cmd "ca_pptp_sa_set_$var $pt [lindex $v_l $idx] $idx"
            set res [helper_cmd_exec -cmd $cmd]
            if {$res} {break}
          }
      } elseif {$var == "crypto_type"} {
        helper_h2s -table CA_PPTP_CRYPTO_TYPE_T -source $aIn(-crypto_type) -out aH
        set ctype $aH(-target)
        log -tag info -msg "Input crypto_type is ${ctype}($aIn(-crypto_type))"
        set cmd "ca_pptp_sa_set_crypto_type $pt $ctype"
        set res [helper_cmd_exec -cmd $cmd]          
      } elseif {$var == "direction"} {      
        helper_h2s -table CA_PPTP_DIRECTION_T -source $aIn(-$var) -out aH
        set dir $aH(-target)        
        set cmd "ca_pptp_sa_set_direction $pt $dir"
        set res [helper_cmd_exec -cmd $cmd]  
      } else  {      
        set cmd "ca_pptp_sa_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd]
      }
    }
  }

  if {$res == 0 } {
    set cmd [list ca_pptp_sa_add $device_id $pt $pid]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    set aOut(-sa_id) [ca_uint32_get $pid]
  }
  catch {ca_data_free $pt} err
  catch {ca_data_free $pid} err
  
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res                  
}
proc ::gw::wca_pptp_sa_delete {args} {
  set ifnm wca_pptp_sa_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id sa_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  if {$res == 0 } {
    set cmd [list ca_pptp_sa_delete $device_id $sa_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res                  
}
proc ::gw::wca_pptp_sa_delete_all {args} {
  global errorInfo
  set ifnm wca_pptp_sa_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  if {$res == 0 } {   
    set res [wca_pptp_sa_get_all -out aOut -print_res 0]
  }
  if {$res == 0 } {
    set idx_l [array names aOut]
    foreach idx $idx_l {
      catch {array unset aEnt}
      if {[catch {array set aEnt $aOut($idx)} err] } {
        log -tag error -msg "$err. $errorInfo"
        set res -1
        break
      }
      set sa_id $aEnt(-sa_id)
      log -tag info -msg "To delete pptp sa entry with sa_id=$sa_id"
      set res [wca_pptp_sa_delete -device_id $device_id -sa_id $sa_id]
      if {$res} {break}
    }
  }
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res                  
}
proc ::gw::wca_pptp_sa_get_all {args} {
  global errorInfo
  variable CA_PPTP_KEY_LEN_MAX
  set ifnm wca_pptp_sa_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l {cpi}
  set v_out_key_l {direction call_id state_less crypto_type key keylen sequence_number}  
  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-cpi) 2
  set aIn(-print_res) 1
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  
  set cpi $aIn(-cpi)
  set print_res $aIn(-print_res)
  set aTmp(-iterator_pointer) NULL    
  set idx 0
  for {set max 0} {$max < 10000 && $res == 0} {incr max} {
    set res [helper_iterate -device_id $device_id \
      -data_type ca_pptp_sa_iterate_entry_t\
      -iterate_func ca_pptp_sa_iterate \
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]            
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    }  
    foreach npdx $aTmp(-element_data_pointers) {
      catch {array unset aVars} err
      array set aVars ""
      set npd [ca_pptp_sa_iterate_entry_get_pptp_sa $npdx]
      set res [helper_pptp_sa_entry_parse -out aVars -ref $npd]
      set aVars(-sa_id) [ca_pptp_sa_iterate_entry_get_sa_id $npdx]
      set aOut($idx) [array get aVars]
      incr idx 
      if {$res} {break}
    }
  }
  if {$max >= 10000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  }   
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {$print_res} {
    puts "\nTotal Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1  
    helper_print_status_enum_name  $res
  }
  log -tag itfend
  return $res   
}
proc ::gw::wca_pptp_sa_get {args} {
  set ifnm wca_pptp_sa_get
  set res 0
  log -tag itfbgn -msg $args
  variable CA_PPTP_KEY_LEN_MAX
  set m_key_l {device_id sa_id}
  set v_out_key_l {direction call_id state_less crypto_type key keylen sequence_number}  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l

 set cmd {ca_pptp_sa_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd [list ca_pptp_sa_get $device_id $sa_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]    
  } 
  if {$res == 0} {  
    set res [helper_pptp_sa_entry_parse -out aOut -ref $pt -print_res 0]
  }  
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res      

}
proc ::gw::helper_pptp_sa_entry_parse {args} {
  set ifnm helper_pptp_sa_entry_parse
  set res 0
  log -tag itfbgn -msg $args
  variable CA_PPTP_KEY_LEN_MAX
  set m_key_l {ref}
  set v_out_key_l {direction call_id state_less crypto_type key keylen sequence_number}   
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 0
  array set aIn $args
  set print_res $aIn(-print_res)
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l 

  set pt $aIn(-ref) 
  if {$res == 0 } {
    foreach var $v_out_key_l {
      if {$var == "key" } {
        set cnt $CA_PPTP_KEY_LEN_MAX
        set act_len [ca_pptp_sa_get_keylen $pt]        
        #if {$cnt > $act_len} {set cnt $act_len}
        set l ""
        for {set ci 0 } {$ci < $cnt} {incr ci} {
          lappend l [ca_pptp_sa_get_key $pt $ci]
        }
        set aOut(-key) [join $l ,]
      } elseif {$var == "crypto_type"} {
        set ctype [ca_pptp_sa_get_$var $pt]
        helper_s2h -table CA_PPTP_CRYPTO_TYPE_T -source $ctype -out aH
        set aOut(-$var)  $aH(-target)
      } elseif {$var == "direction"} {
        set aOut(-$var)  [ca_pptp_sa_get_direction $pt]
        helper_s2h -table CA_PPTP_DIRECTION_T -source $aOut(-$var) -out aH
        set aOut(-direction_v) $aH(-target) 
      } else {     
        set aOut(-$var) [ca_pptp_sa_get_$var $pt]      
      }
    }  
  }
  if {$print_res} {
    helper_parray aOut
  }
  log -tag itfend 
  return $res 
}
proc ::gw::wca_tunnel_pptp_tunnel_add {args} {
  set ifnm wca_tunnel_pptp_tunnel_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l $v_pptp_com_key_l"
  
  set aIn(-type) 4 ;#pptp
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut tunnel_id 
  
  set cmd {ca_uint16_create 0} 
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set ptid $aTmp(-err)
    set cmd {ca_tunnel_cfg_create}
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }
  if {$res == 0 } {
    set pt $aTmp(-err)
    set res [eval helper_ca_tunnel_cfg_entry_config -type $aIn(-type) -ref $pt $args] 
  }
  catch {array unset aOut} err  
  set aOut(-tunnel_id) unknown
  if {$res == 0} {    
    set cmd "ca_tunnel_add  $device_id  $pt  $ptid"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      set aOut(-tunnel_id) [ca_uint16_get $ptid]
    }    
  } 
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res                
}
proc ::gw::wca_tunnel_pptp_tunnel_update {args} {
  set ifnm wca_tunnel_pptp_tunnel_update
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id tunnel_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l $v_pptp_com_key_l"
  
  set aIn(-type) 4 ;#l2tp
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args 

  set cmd {ca_tunnel_cfg_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    #Read system config
    set cmd [list ca_tunnel_get $device_id $tunnel_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
  }     
  if {$res == 0 } {
    set res [eval helper_ca_tunnel_cfg_entry_config -type $aIn(-type) -ref $pt $args]
  }
  
  if {$res == 0} {    
    set cmd "ca_tunnel_update  $device_id  $pt  $tunnel_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err
  
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res                
}
#-----------------------------------------
#Section: Tunnel Management - SRv6 ENDDX2 Management
#-----------------------------------------
proc ::gw::wca_srv6_enddx2_tunnel_global_set {args} {
  # input: -device_id xx 
  set ifnm wca_srv6_enddx2_tunnel_global_set
  set res 0
  log -tag itfbgn -msg $args
  set aIn(-data_init) 1
  set m_key_l {device_id }
  set v_key_l [helper_probe_struct_members -struct ca_srv6_enddx2_tunnel_global_config]
  set idx [lsearch $v_key_l "egress_vlan" ]
  if {$idx >=0 } {
    set v_key_l "[lrange $v_key_l 0 $idx-1] [lrange $v_key_l $idx+1 end]"
  }
  set vlan_args [helper_probe_struct_members -struct ca_vlan]
  foreach arg $vlan_args {
      lappend v_key_l egress_vlan_$arg
  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  
  set cmd " ca_srv6_enddx2_tunnel_global_config_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  if {$res == 0} {
    foreach var $v_key_l {
      if {[info exists aIn(-$var)] && 
        [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        if {$var == "mac_sa" || $var == "mac_da"} {
          set pmac [ca_srv6_enddx2_tunnel_global_config_get_$var $pt]
          set mac_l [split $aIn(-$var) :]
          set new_mac_l ""
          foreach e $mac_l {
            lappend new_mac_l 0x$e
          }
          set cmd "ca_mac_addr_set $pmac $new_mac_l"
          set res [helper_cmd_exec -cmd $cmd]
          if {$res} {
            break
          }
          continue
        }
        if {$var == "ip_sa_prefix" || $var == "ip_da_prefix"} {
          set pip [ ca_srv6_enddx2_tunnel_global_config_get_$var $pt]
          set res [helper_ca_ip_address_entry_config -ref $pip -ip_addr $aIn(-$var) -out aTmp]
          if {$res} {break}
          continue
        }
        if {[string first "egress_vlan_" $var] == 0 } {
            set len [string length "egress_vlan_"]
            set vlan_arg [string range $var $len end]
            set p_egress_vlan [ca_srv6_enddx2_tunnel_global_config_get_egress_vlan $pt]
            set cmd "ca_vlan_set_${vlan_arg} $p_egress_vlan $aIn(-$var)"            
        } else {
            set cmd " ca_srv6_enddx2_tunnel_global_config_set_$var $pt $aIn(-$var)"
        }
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {break}
      }
    }
  }

  if {$res == 0 } {
    set cmd [list ca_srv6_enddx2_tunnel_global_set $device_id $pt ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
 
  catch {ca_data_free $pt} err  
  log -tag itfend
  return $res
}
proc ::gw::wca_srv6_enddx2_tunnel_global_get {args} {
  set ifnm wca_srv6_enddx2_tunnel_global_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id }
  set v_o_key_l [helper_probe_struct_members -struct ca_srv6_enddx2_tunnel_global_config]
  set idx [lsearch $v_o_key_l "egress_vlan" ]
  if {$idx >=0 } {
    set v_o_key_l "[lrange $v_o_key_l 0 $idx-1] [lrange $v_o_key_l $idx+1 end]"
  }
  set vlan_args [helper_probe_struct_members -struct ca_vlan]

  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut $v_o_key_l 
  set cmd " ca_srv6_enddx2_tunnel_global_config_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd [list ca_srv6_enddx2_tunnel_global_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
    foreach var $v_o_key_l {
      set val [ca_srv6_enddx2_tunnel_global_config_get_$var $pt]
      if {$var == "mac_sa" || $var== "mac_da"} {
        set mac_l ""
        for {set i 0 } {$i < 6} {incr i} {
          lappend mac_l [format %02x [ca_mac_addr_get $val $i]]
        }
        set aOut(-$var) [join $mac_l :]
      } elseif {$var == "ip_sa_prefix" || $var == "ip_da_prefix"} {
          set res [eval helper_ca_ip_address_entry_parse -ref $val -out aTmp] 
          if {$res == 0 } {
            set aOut(-$var) $aTmp(-ip_addr)
          }
      } else {
        set aOut(-$var) $val
      }
    }   
  }   
  if {$res == 0 } {
      set p_egress_vlan [ca_srv6_enddx2_tunnel_global_config_get_egress_vlan $pt]
      foreach var $vlan_args {      
          set aOut(-egress_vlan_$var) [ca_vlan_get_${var} $p_egress_vlan] 
      }             
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_tunnel_srv6_enddx2_tunnel_add {args} {
  set ifnm wca_tunnel_srv6_enddx2_tunnel_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  helper_ca_tunnel_cfg_entry_params_declare
  set v_key_l "$v_com_key_l $v_srv6_enddx2_com_key_l"  

  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l $v_key_l]
  if {$res} {
    return $res
  }    
  set aIn(-type) SRV6_ENDDX2 ;#srv6_enddx2, 12
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut tunnel_id
  set aOut(-tunnel_id) unknown        
  set cmd {ca_uint16_create 0} 
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set ptid $aTmp(-err)
    set cmd {ca_tunnel_cfg_create}
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
  }

  if {$res == 0 } {
    set pt $aTmp(-err)
    set res [eval helper_ca_tunnel_cfg_entry_config  -ref $pt [array get aIn]]  
  }
  catch {array unset aOut} err  
  set aOut(-tunnel_id) unknown
  if {$res == 0} {    
    set cmd "ca_tunnel_add  $device_id  $pt  $ptid"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      set aOut(-tunnel_id) [ca_uint16_get $ptid]
    }    
  } 
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name  $res
  return $res                
}
proc ::gw::wca_tunnel_srv6_enddx2_tunnel_update {args} {
  set ifnm wca_tunnel_srv6_enddx2_tunnel_update
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id tunnel_id}
  helper_ca_tunnel_cfg_entry_params_declare 
  set v_key_l "$v_com_key_l $v_srv6_enddx2_com_key_l"
  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l $v_key_l]
  if {$res} {
    return $res
  }
  set aIn(-type) SRV6_ENDDX2;#12
  array set aIn $args

  set cmd {ca_tunnel_cfg_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    #Read system config
    set cmd [list ca_tunnel_get $device_id   $tunnel_id  $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
  }  
  if {$res == 0 } {
    set res [eval helper_ca_tunnel_cfg_entry_config -ref $pt [array get aIn]] 
  }

  if {$res == 0} {    
    set cmd "ca_tunnel_update  $device_id  $pt $tunnel_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_print_status_enum_name  $res  
  return $res                
}
#--------------------------------------------------------------------------
#Section: Traffic Management
#--------------------------------------------------------------------------
#-----------------------------------------
#Section: Traffic Management - QoS Map,Remark and Translate Configuration
#-----------------------------------------
proc ::gw::wca_qos_config_set {args} {
  set ifnm wca_qos_config_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id}
  set v_key_l {qos_map_mode  dot1p_remap_mode dscp_remap_mode}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  array set aIn $args
  set data_init $aIn(-data_init)
  
  set cmd "ca_qos_config_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    if {$data_init == 1} {
      #Use system current configuration to initialize data structure
      set cmd [list ca_qos_config_get $device_id $port_id $pt]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    }
    foreach var $v_key_l {
      if {[info exists aIn(-$var)] && [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        if {$var == "qos_map_mode" } {
          helper_h2s -table CA_QOS_MAP_MODE_T -source $aIn(-$var) -out aH
          set aIn(-$var) $aH(-target)
        }
        if {$var == "dot1p_remap_mode" } {
          helper_h2s -table CA_1P_MAP_MODE_T -source $aIn(-$var) -out aH
          set aIn(-$var) $aH(-target)
        }
        if {$var == "dscp_remap_mode" } {
          helper_h2s -table CA_DSCP_MAP_MODE_T -source $aIn(-$var) -out aH
          set aIn(-$var) $aH(-target)
        }                
        set cmd "ca_qos_config_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {break}
      }
    }
  }
  if {$res == 0 } {
    set cmd [list ca_qos_config_set $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err  
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_config_get {args} {
  set ifnm wca_qos_config_get
  set res 0
  log -tag itfbgn -msg $args  
  set m_key_l {device_id port_id}
  set v_key_l {qos_map_mode  dot1p_remap_mode dscp_remap_mode}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut [list  qos_map_mode dot1p_remap_mode dscp_remap_mode]
  
  set cmd "ca_qos_config_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd [list ca_qos_config_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
    set aOut(-qos_map_mode) [ca_qos_config_get_qos_map_mode $pt ]
    set aOut(-dot1p_remap_mode) [ca_qos_config_get_dot1p_remap_mode $pt ]
    set aOut(-dscp_remap_mode) [ca_qos_config_get_dscp_remap_mode $pt ]

    helper_s2h -table CA_QOS_MAP_MODE_T -source $aOut(-qos_map_mode) -out aH
    set aOut(-qos_map_mode_v) $aH(-target)
    helper_s2h -table CA_1P_MAP_MODE_T -source $aOut(-dot1p_remap_mode) -out aH
    set aOut(-dot1p_remap_mode_v) $aH(-target)
    helper_s2h -table CA_DSCP_MAP_MODE_T -source $aOut(-dscp_remap_mode) -out aH
    set aOut(-dscp_remap_mode_v) $aH(-target)    
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res            
}
proc ::gw::wca_qos_dot1p_map_set {args} {
  #for multi map entry configure:
  #dot1p/priority in list, splitor is comma ","
  set ifnm wca_qos_dot1p_map_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id egress dot1p priority}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  
  set res [helper_expand_list -set $aIn(-dot1p) -out aTmp]
  set dot1p_l $aTmp(-l)
  set res [helper_expand_list -set $aIn(-priority) -out aTmp]
  set pri_l $aTmp(-l)
  if {[llength $dot1p_l ] > [llength $pri_l]} {
    set pl [llength $pri_l]
    set dl [llength $dot1p_l]
    set r [expr int(fmod($dl,$pl))]
    set c [expr int($dl/$pl)]
    set new_l [string repeat "$pri_l " $c]
    set new_l "$new_l [lrange $pri_l 0 [expr $r -1 ] ]"
    set pri_l $new_l
  }
  
  foreach d $dot1p_l p $pri_l {
    if {$res} {break}
    if {$d == "/" || $p == "/"} { continue}
    set cmd [list ca_qos_dot1p_map_set $device_id $port_id $egress $d $p]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_dot1p_map_get {args} {
  set ifnm wca_qos_dot1p_map_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id egress dot1p}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut priority
   
  set res [helper_expand_list -set $aIn(-dot1p) -out aTmp]
  set dot1p_l $aTmp(-l)
   
  set cmd "ca_uint8_create 0"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  set r_l ""
  foreach d $dot1p_l {
    if {$res} {break}
    if {$d == "/"} {lappend r_l unknown; continue}
    set cmd [list ca_qos_dot1p_map_get $device_id $port_id $egress $d $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      lappend r_l [ca_uint8_get $pt]
    }
  }  
  if {$res == 0} {
    set aOut(-priority) [join $r_l ","]
  }  
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_dot1p_remark_set {args} {
  set ifnm wca_qos_dot1p_remark_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id old_dot1p new_dot1p}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set res [helper_expand_list -set $aIn(-old_dot1p) -out aTmp]
  set dot1p_l $aTmp(-l)
  set res [helper_expand_list -set $aIn(-new_dot1p) -out aTmp]
  set new_dot1p_l $aTmp(-l)
  if {[llength $dot1p_l ] > [llength $new_dot1p_l]} {
    set pl [llength $new_dot1p_l]
    set dl [llength $dot1p_l]
    set r [expr int(fmod($dl,$pl))]
    set c [expr int($dl/$pl)]
    set new_l [string repeat "$new_dot1p_l " $c]
    set new_l "$new_l [lrange $new_dot1p_l 0 [expr $r -1 ] ]"
    set new_dot1p_l $new_l
  }
    
  foreach d $dot1p_l p $new_dot1p_l {
    if {$res} {break}
    if {$d == "/" || $p == "/"} {continue}
    set cmd [list ca_qos_dot1p_remark_set $device_id $port_id $d $p]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_dot1p_remark_get {args} {
  set ifnm wca_qos_dot1p_remark_get
  set res 0
  log -tag itfbgn -msg $args 
  set m_key_l {device_id port_id old_dot1p}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  helper_output_declare aIn
  helper_output_init aOut new_dot1p 
  set res [helper_expand_list -set $aIn(-old_dot1p) -out aTmp]
  set dot1p_l $aTmp(-l)
   
  set cmd "ca_uint8_create 0"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
  }
  set r_l ""
  foreach d $dot1p_l {  
    if {$res} {break}
    if {$d == "/"} {lappend r_l unknown; continue}
    set cmd [list ca_qos_dot1p_remark_get $device_id $port_id $d $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      lappend r_l [ca_uint8_get $pt]
    } 
  }
  if {$res == 0} {
    set aOut(-new_dot1p) [join $r_l ","]
  }  
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_dscp_map_set {args} {
  #Usage: wca_qos_dscp_map_set -device_id 0 -port_id 0 -dscp 1,3-5,4 -priority 2
  set ifnm wca_qos_dscp_map_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id dscp priority}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  
  helper_expand_list -set $dscp -out aTmp
  set dscp_l $aTmp(-l)
  helper_expand_list -set $priority -out aTmp
  set pri_l $aTmp(-l)
  if {[llength $dscp_l ] > [llength $pri_l]} {
    set pl [llength $pri_l]
    set dl [llength $dscp_l]
    set r [expr int(fmod($dl,$pl))]
    set c [expr int($dl/$pl)]
    set new_l [string repeat "$pri_l " $c]
    set new_l "$new_l [lrange $pri_l 0 [expr $r -1 ] ]"
    set pri_l $new_l
  }  
  foreach dscp $dscp_l priority $pri_l {
      if {$res } {break}
      if {$dscp == "/" || $priority == "/"} { continue}
      set cmd [list ca_qos_dscp_map_set $device_id $port_id $dscp $priority]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1] 
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_dscp_map_get {args} {
  set ifnm wca_qos_dscp_map_get
  set res 0
  log -tag itfbgn -msg $args 
  set m_key_l {device_id port_id dscp}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut priority    
  set res [helper_expand_list -set $aIn(-dscp) -out aTmp]
  set dscp_l $aTmp(-l)
    
  set cmd "ca_uint8_create 0"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
  }
  set r_l ""
  foreach dscp $dscp_l {
    if {$res} {break}
    if {$dscp == "/"} {lappend r_l unknown; continue}
    set cmd [list ca_qos_dscp_map_get $device_id $port_id $dscp $pt]
    set res [helper_cmd_exec -cmd $cmd -out aTmp]
    if {$res == 0 } {lappend r_l [ca_uint8_get $pt ]}
  }
  if {$res == 0} {
    set aOut(-priority) [join $r_l ,]
  }  
  catch {ca_data_free $pt} err
  helper_parray aOut 
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_dscp_remark_set {args} {
  set ifnm wca_qos_dscp_remark_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id old_dscp new_dscp}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set res [helper_expand_list -set $old_dscp -out aTmp]
  set dscp_l $aTmp(-l)
  set res [helper_expand_list -set $new_dscp -out aTmp]
  set new_dscp_l $aTmp(-l)
  if {[llength $dscp_l ] > [llength $new_dscp_l]} {
    set pl [llength $new_dscp_l]
    set dl [llength $dscp_l]
    set r [expr int(fmod($dl,$pl))]
    set c [expr int($dl/$pl)]
    set new_l [string repeat "$new_dscp_l " $c]
    set new_l "$new_l [lrange $new_dscp_l 0 [expr $r -1 ] ]"
    set new_dscp_l $new_l
  }
    
  foreach d $dscp_l p $new_dscp_l {
    if {$res} {break}
    if {$d == "/" || $p == "/" } {continue}
    set cmd [list ca_qos_dscp_remark_set $device_id $port_id $d $p]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_dscp_remark_get {args} {
  set ifnm wca_qos_dscp_remark_get
  set res 0
  log -tag itfbgn -msg $args
 
  set m_key_l {device_id port_id old_dscp}
   set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut new_dscp 
  
  set res [helper_expand_list -set $old_dscp -out aTmp]
  set dscp_l $aTmp(-l)
    
  set cmd "ca_uint8_create 0"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  set r_l ""
  foreach old_dscp $dscp_l {
    if {$res} {break}
    if {$old_dscp == "/"} {lappend r_l unknown; continue}
    set cmd [list ca_qos_dscp_remark_get $device_id $port_id $old_dscp $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      lappend r_l  [ca_uint8_get $pt ]
    }
  }
  if {$res == 0} {
    set aOut(-new_dscp) [join $r_l ,]
  }  
  catch {ca_data_free $pt} err
  helper_parray aOut 
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_dscp_dot1p_translate_set {args} {
  set ifnm wca_qos_dscp_dot1p_translate_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id dscp dot1p}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set res [helper_expand_list -set $dscp -out aTmp]
  set dscp_l $aTmp(-l)
  set res [helper_expand_list -set $dot1p -out aTmp]
  set dot1p_l $aTmp(-l)
  if {[llength $dscp_l ] > [llength $dot1p_l]} {
    set pl [llength $dot1p_l]
    set dl [llength $dscp_l]
    set r [expr int(fmod($dl,$pl))]
    set c [expr int($dl/$pl)]
    set new_l [string repeat "$dot1p_l " $c]
    set new_l "$new_l [lrange $dot1p_l 0 [expr $r -1 ] ]"
    set dot1p_l $new_l
  }
     
  foreach dscp $dscp_l dot1p $dot1p_l {
    if {$res} {break}
    if {$dscp == "/" || $dot1p == "/"} {continue}
    set cmd [list ca_qos_dscp_dot1p_translate_set $device_id $port_id $dscp $dot1p]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_dscp_dot1p_translate_get {args} {
  set ifnm wca_qos_dscp_dot1p_translate_get
  set res 0
  log -tag itfbgn -msg $args

  set m_key_l {device_id port_id dscp}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut dot1p 
   
  set res [helper_expand_list -set $aIn(-dscp) -out aTmp]
  set dscp_l $aTmp(-l)
    
  set cmd "ca_uint8_create 0"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
  }
  set r_l ""
  foreach dscp $dscp_l {
    if {$res} {break}
    if {$dscp == "/"} {lappend r_l unknown; continue}
    set cmd [list ca_qos_dscp_dot1p_translate_get $device_id $port_id $dscp $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } { 
      lappend r_l [ca_uint8_get $pt]
    }
  }
  if {$res == 0} {
    set aOut(-dot1p) $r_l
  }  
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_tc_map_set {args} {
  set ifnm wca_qos_tc_map_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tc priority}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  array set aIn $args
  
  set res [helper_expand_list -set $tc -out aTmp]
  set tc_l $aTmp(-l)
  set res [helper_expand_list -set $priority -out aTmp]
  set pri_l $aTmp(-l)
  if {[llength $tc_l ] > [llength $pri_l]} {
    set pl [llength $pri_l]
    set dl [llength $tc_l]
    set r [expr int(fmod($dl,$pl))]
    set c [expr int($dl/$pl)]
    set new_l [string repeat "$pri_l " $c]
    set new_l "$new_l [lrange $pri_l 0 [expr $r -1 ] ]"
    set pri_l $new_l
  }  
  foreach tc $tc_l priority $pri_l {
      if {$res } {break}
      if {$tc == "/" || $priority == "/"} {continue}
      set cmd [list ca_qos_tc_map_set $device_id $port_id $tc $priority]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1] 
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_tc_remark_get {args} {
  set ifnm wca_qos_tc_remark_get
  set res 0
  log -tag itfbgn -msg $args

  set m_key_l {device_id port_id old_tc}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
   helper_output_declare aIn
  helper_output_init aOut new_tc
  set aOut(-new_tc) unknown

  set res [helper_expand_list -set $old_tc -out aTmp]
  set tc_l $aTmp(-l)
    
  set cmd "ca_uint8_create 0"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  set r_l ""
  foreach old_tc $tc_l {
    if {$res} {break}
    if {$old_tc == "/"} {lappend r_l unknown; continue}
    set cmd [list ca_qos_tc_remark_get $device_id $port_id $old_tc $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      lappend r_l  [ca_uint8_get $pt ]
    }
  }
  if {$res == 0} {
    set aOut(-new_tc) [join $r_l ,]
  }  
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_tc_remark_set {args} {
  set ifnm wca_qos_tc_remark_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id old_tc new_tc}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set res [helper_expand_list -set $old_tc -out aTmp]
  set tc_l $aTmp(-l)
  set res [helper_expand_list -set $new_tc -out aTmp]
  set new_tc_l $aTmp(-l)
  if {[llength $tc_l ] > [llength $new_tc_l]} {
    set pl [llength $new_tc_l]
    set dl [llength $tc_l]
    set r [expr int(fmod($dl,$pl))]
    set c [expr int($dl/$pl)]
    set new_l [string repeat "$new_tc_l " $c]
    set new_l "$new_l [lrange $new_tc_l 0 [expr $r -1 ] ]"
    set new_tc_l $new_l
  }
    
  foreach d $tc_l p $new_tc_l {
    if {$res} {break}
    if {$d == "/" || $p == "/"} {continue}
    set cmd [list ca_qos_tc_remark_set $device_id $port_id $d $p]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
 
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_tc_map_get {args} {
  set ifnm wca_qos_tc_map_get
  set res 0
  log -tag itfbgn -msg $args

  set m_key_l {device_id port_id tc}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut priority 
  set res [helper_expand_list -set $aIn(-tc) -out aTmp]
  set tc_l $aTmp(-l)
     
  set cmd "ca_uint8_create 0"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  set r_l ""
  foreach tc $tc_l {
    if {$res} {break}
    if {$tc == "/"} {lappend r_l unknown; continue}
    set cmd [list ca_qos_tc_map_get $device_id $port_id $tc $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      lappend r_l [ca_uint8_get $pt ]
    }
  }
  if {$res == 0 } {
    set aOut(-priority) [join $r_l , ]
  }  
  catch {ca_data_free $pt} err 
  helper_parray aOut 
  log -tag itfend
  return $res
}
proc ::gw::wca_qos_tc_dot1p_translate_set {args} {
  set ifnm wca_qos_tc_dot1p_translate_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id tc dot1p}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set res [helper_expand_list -set $tc -out aTmp]
  set tc_l $aTmp(-l)
  set res [helper_expand_list -set $dot1p -out aTmp]
  set dot1p_l $aTmp(-l)
  if {[llength $tc_l ] > [llength $dot1p_l]} {
    set pl [llength $dot1p_l]
    set dl [llength $tc_l]
    set r [expr int(fmod($dl,$pl))]
    set c [expr int($dl/$pl)]
    set new_l [string repeat "$dot1p_l " $c]
    set new_l "$new_l [lrange $dot1p_l 0 [expr $r -1 ] ]"
    set dot1p_l $new_l
  }
     
  foreach tc $tc_l dot1p $dot1p_l {
    if {$res} {break} 
    if {$tc == "/" || $dot1p == "/"} { continue}
    set cmd [list ca_qos_tc_dot1p_translate_set $device_id $port_id $tc $dot1p]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }

  log -tag itfend
  return $res
}
proc ::gw::wca_qos_tc_dot1p_translate_get {args} {
  set ifnm wca_qos_tc_dot1p_translate_get
  set res 0
  log -tag itfbgn -msg $args

  set m_key_l {device_id port_id tc}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut dot1p 
  
  set res [helper_expand_list -set $tc -out aTmp]
  set tc_l $aTmp(-l) 
  
  set cmd "ca_uint8_create 0"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  }
  set r_l ""
  foreach tc $tc_l {
    if {$res} {break}
    if {$tc == "/"} {lappend r_l unknown; continue}
    set cmd [list ca_qos_tc_dot1p_translate_get $device_id $port_id $tc $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {lappend r_l [ca_uint8_get $pt ]}
  }
  if {$res == 0} {
    set aOut(-dot1p) [join $r_l , ]
  }  
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
#-----------------------------------------
#Section: Traffic Management - Policer and Shaper Configuration
#-----------------------------------------
proc ::gw::wca_policer_config_set {args} {
  set ifnm wca_policer_config_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set v_key_l {overhead mark_ecn drop_ecn}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  array set aIn $args
  
  set data_init $aIn(-data_init) 
  
  set cmd "ca_policer_config_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)  
    if {$data_init == 1 } {
      set cmd [list ca_policer_config_get $device_id $pt]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    }
  } 
  if {$res == 0 } {
    foreach var $v_key_l {
      if {[info exists aIn(-$var)] 
        && [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        set cmd "ca_policer_config_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd -out aTmp]
        if {$res} {break}
      }
    }
  }
  if {$res == 0 } {
    set cmd [list ca_policer_config_set $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}
proc ::gw::wca_policer_config_get {args} {
  set ifnm wca_policer_config_get
  set res 0
  log -tag itfbgn -msg $args

  set m_key_l {device_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut [list overhead mark_ecn drop_ecn]
  
  set cmd "ca_policer_config_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd [list ca_policer_config_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
    set aOut(-overhead) [ca_policer_config_get_overhead $pt ]
    set aOut(-mark_ecn) [ca_policer_config_get_mark_ecn $pt ]
    set aOut(-drop_ecn) [ca_policer_config_get_drop_ecn $pt ]
  }  
  catch {ca_data_free $pt} err  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_policer_set {args} {
  set ifnm wca_port_policer_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id  }
  set v_key_l {mode pps cir cbs pir pbs}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  array set aIn $args  
  set data_init $aIn(-data_init)
  if {[info exists aIn(-mode)]} {
    helper_h2s -source $aIn(-mode) -table CA_POLICER_MODE_T -out aX
    set aIn(-mode) $aX(-target)
  }
  
  array set aTmp ""
  set cmd "ca_policer_create "
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    if {$data_init == 1} {
      #Initialize struct with system current configuration
      set cmd [list ca_port_policer_get $device_id $port_id $pt]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    }
  }
  if {$res == 0 } {
    set res [helper_struct_config -struct ca_policer -key_l $v_key_l -ref $pt -arg_arr aIn]
  }
  if {$res == 0 } {
    set cmd "ca_port_policer_set $device_id $port_id $pt"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}
proc ::gw::wca_port_policer_get {args} {
  set ifnm wca_port_policer_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id }
  set v_o_key_l {mode pps cir cbs pir pbs}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut "v_o_key_l"
  
  foreach var $v_o_key_l {
    set aOut(-$var) unknown
  }  
  set aTmp(-err) ""
 
  set res [helper_cmd_exec -cmd {ca_policer_create } -out aTmp]  
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_port_policer_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    foreach var $v_o_key_l {
      set aOut(-$var) [ca_policer_get_$var $pt]
    }
  }
  helper_s2h -source $aOut(-mode) -table CA_POLICER_MODE_T -out aX
  set aOut(-mode_v) $aX(-target)
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_policer_stats_get {args} {
  set docStr "read_clear: default is 1, clear after read"
  set ifnm wca_port_policer_stats_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id}
  set v_key_l {read_clear}
  set v_out_key_l {green_packets yellow_packets red_packets}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-read_clear) 1
  array set aIn $args
  foreach key {read_clear} {
    set $key $aIn(-$key)
    if {[string toupper $aIn(-$key)] == "DONTCARE"} {
      set $key 1
    }  
  }    
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l 
  set aOut(-read_clear) $read_clear
  set aTmp(-err) "" 
  set res [helper_cmd_exec -cmd {ca_policer_stats_create } -out aTmp]  
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_port_policer_stats_get $device_id $port_id $read_clear $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    foreach var $v_out_key_l {
      set aOut(-$var) [ca_policer_stats_get_$var $pt]
    }
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_policer_stats_clear {args} {
  set docStr "port_id: support multi ports in a list as '0x30000,0x30003'"
  set ifnm wca_port_policer_stats_clear
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  set port_id_l [split $port_id ,]
  foreach port_id $port_id_l {
    if {$res } {break}
    set cmd "ca_port_policer_stats_clear $device_id $port_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err  
  log -tag itfend
  return $res
}
proc ::gw::wca_flow_policer_set {args} {
  set ifnm wca_flow_policer_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id flow_id  }
  set v_key_l {mode pps cir cbs pir pbs}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  array set aIn $args  
  set data_init $aIn(-data_init)
  if {[info exists aIn(-mode)]} {
    helper_h2s -source $aIn(-mode) -table CA_POLICER_MODE_T -out aX
    set aIn(-mode) $aX(-target)
  }
    
  array set aTmp ""
  set cmd "ca_policer_create "
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    if {$data_init == 1} {
      set cmd [list ca_flow_policer_get $device_id $flow_id $pt]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    }
  }
  if {$res == 0 } {
    set res [helper_struct_config -struct ca_policer -key_l $v_key_l -ref $pt -arg_arr aIn]
  }
  if {$res == 0 } {
    set cmd "ca_flow_policer_set $device_id $flow_id $pt"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err  
  log -tag itfend
  return $res
}
proc ::gw::wca_flow_policer_get {args} {
  set ifnm wca_flow_policer_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id flow_id }
  set v_key_l {mode pps cir cbs pir pbs}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_key_l 
  set aTmp(-err) ""
 
  set res [helper_cmd_exec -cmd {ca_policer_create } -out aTmp]  
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_flow_policer_get $device_id $flow_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    foreach var $v_key_l {
      set aOut(-$var) [ca_policer_get_$var $pt]
    }
  }
  helper_s2h -source $aOut(-mode) -table CA_POLICER_MODE_T -out aX
  set aOut(-mode_v) $aX(-target)  
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_flow_policer_stats_get {args} {
  set docStr "    read_clear: default is 1, clear after read"
  set ifnm wca_flow_policer_stats_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id flow_id }
  set v_key_l {read_clear}
  set v_out_key_l {green_packets yellow_packets red_packets}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-read_clear) 1
  array set aIn $args
  foreach key { read_clear} {
    set $key $aIn(-$key)
    if {[string toupper $aIn(-$key)] == "DONTCARE"} {
      set $key 1
    }  
  }
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l 
  set aOut(-read_clear) $read_clear 
  set aTmp(-err) "" 
  set res [helper_cmd_exec -cmd {ca_policer_stats_create } -out aTmp]  
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_flow_policer_stats_get $device_id $flow_id $read_clear $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    foreach var $v_out_key_l {
      set aOut(-$var) [ca_policer_stats_get_$var $pt]
    }
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_flow_policer_stats_clear {args} {
  set docStr "flow_id: support mutli flow_id input as a list, e.g. '-flow_id 0x30000,0x30004'"
  set ifnm wca_flow_policer_stats_clear
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id flow_id  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  set flow_id_l [split $flow_id ,]
  foreach flow_id $flow_id_l {
    if {$res} { break}
    set cmd "ca_flow_policer_stats_clear $device_id $flow_id"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_shaper_config_set {args} {
  set ifnm wca_shaper_config_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  }
  set v_key_l {overhead}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  array set aIn $args
  set data_init $aIn(-data_init) 
  
  array set aTmp ""
  set res [helper_cmd_exec -cmd {ca_shaper_config_create} -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    if {$data_init == 1} {
      set cmd [list ca_shaper_config_get $device_id $pt]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
    }
  }
  if {$res == 0 } {
    set res [helper_struct_config -struct ca_shaper_config -key_l $v_key_l -ref $pt -arg_arr aIn]
  }
  if {$res == 0 } {
    set cmd "ca_shaper_config_set $device_id $pt"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err  
  log -tag itfend
  return $res
}
proc ::gw::wca_shaper_config_get {args} {
  set ifnm wca_shaper_config_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set v_out_key_l {overhead}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l 
  set aTmp(-err) "" 
  set res [helper_cmd_exec -cmd {ca_shaper_config_create } -out aTmp]  
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_shaper_config_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    set aOut(-overhead) [ca_shaper_config_get_overhead $pt ]
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_port_shaper_set {args} {
  set ifnm wca_port_shaper_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id}
  set v_key_l {enable pps rate burst_size}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  
  array set aIn $args
  set data_init $aIn(-data_init)
  
  array set aTmp ""
  set res [helper_cmd_exec -cmd {ca_shaper_create} -check_return_value 0 -out aTmp]
  if {$res == 0 } {
     set pt $aTmp(-err)
     if {$data_init == 1} {
       set cmd [list ca_port_shaper_get $device_id $port_id $pt]
       set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
     }
  }
  if {$res == 0 } {
    set res [helper_struct_config -struct ca_shaper -key_l $v_key_l -ref $pt -arg_arr aIn]
  }
  if {$res == 0 } {
    set cmd [list ca_port_shaper_set $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}
proc ::gw::wca_port_shaper_get {args} {
  set ifnm wca_port_shaper_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id}
  set v_out_key_l {enable pps rate burst_size}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l 
  set aTmp(-err) "" 
  set res [helper_cmd_exec -cmd {ca_shaper_create } -out aTmp]  
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_port_shaper_get $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    foreach var $v_out_key_l {
      set aOut(-$var) [ca_shaper_get_$var $pt]
    }
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_shaper_set {args} {
  set ifnm wca_queue_shaper_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id queue_id}
  set v_key_l {pps rate burst_size enable}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-data_init) 1
  set aIn(-pps) /
  set aIn(-rate) /
  set aIn(-burst_size) /
  set aIn(-enable) /
  foreach key $v_key_l {
    set aIn(-$key) dontcare
  }
  array set aIn $args
  set data_init $aIn(-data_init) 
  #set queue_id $aIn(-queue_id)
  set pps $aIn(-pps)
  set rate $aIn(-rate)
  set burst_size $aIn(-burst_size)
  set enable $aIn(-enable)
  
  helper_expand_list -set $queue_id -out aTmp
  set queue_l $aTmp(-l) 
  catch {array unset aTmp}
  helper_expand_list -set $pps -out aTmp
  set pps_l $aTmp(-l)   
  catch {array unset aTmp}
  helper_expand_list -set $rate -out aTmp
  set rate_l $aTmp(-l)  
  catch {array unset aTmp}  
  helper_expand_list -set $burst_size -out aTmp
  set burst_size_l $aTmp(-l)  
  catch {array unset aTmp}  
  helper_expand_list -set $enable -out aTmp
  set enable_l $aTmp(-l)  
  foreach p_l [list pps_l rate_l burst_size_l enable_l] {  
    set x_l [set $p_l]
    if {[llength $queue_l ] > [llength $x_l ]} {
      set pl [llength $x_l]
      set dl [llength $queue_l]
      set r [expr int(fmod($dl,$pl))]
      set c [expr int($dl/$pl)]
      set new_l [string repeat "$x_l " $c]
      set new_l "$new_l [lrange $x_l 0 [expr $r -1 ] ]"
      set $p_l $new_l
    }  
  }
  array set aTmp ""
  set res [helper_cmd_exec -cmd {ca_shaper_create}  -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
  }
  foreach queue_id $queue_l pps $pps_l rate $rate_l burst_size $burst_size_l enable $enable_l {
    if {$res} {break}  
    if {$queue_id == "/"} {continue}
    if {$pps == "/"} {set pps "dontcare"}
    if {$rate == "/"} {set rate "dontcare"}
    if {$burst_size == "/" } {set burst_size "dontcare"}
    if {$enable == "/" } {set enable  "dontcare"}
    
    if {$data_init == 1} {
      set cmd [list ca_queue_shaper_get $device_id $port_id $queue_id $pt]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
    }

    if {$res == 0 } {
      array set aArgArr [list -pps $pps -rate $rate -burst_size $burst_size -enable $enable]
      set res [helper_struct_config -struct ca_shaper -key_l $v_key_l -ref $pt \
        -arg_arr aArgArr ]
    }
    if {$res == 0 } {
      set cmd [list ca_queue_shaper_set $device_id $port_id $queue_id $pt]
      set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    }
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_shaper_get {args} {
  set ifnm wca_queue_shaper_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id queue_id}
  set v_out_key_l {pps rate burst_size enable}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l 
  helper_expand_list -set $queue_id -out aTmp
  set queue_l $aTmp(-l) 
  
  set aTmp(-err) "" 
  set res [helper_cmd_exec -cmd {ca_shaper_create } -out aTmp]  
  if {$res == 0 } {
    set pt $aTmp(-err)
  }
  set pps_l ""
  set rate_l ""
  set bs_l ""
  set enable_l ""
  foreach queue_id $queue_l {
    if {$res} {break}
    if {$queue_id == "/"} {
      lappend pps_l "unknown"
      lappend rate_l "unknown"
      lappend bs_l "unknown"
      lappend enable_l "unknown"
      continue
    }
    set cmd [list ca_queue_shaper_get $device_id $port_id $queue_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      lappend pps_l [ca_shaper_get_pps $pt]
      lappend rate_l [ca_shaper_get_rate $pt]
      lappend bs_l  [ca_shaper_get_burst_size $pt]
      lappend enable_l [ca_shaper_get_enable $pt]
    }
  }
  if {$res == 0 } {
    set aOut(-pps) [join $pps_l ,]
    set aOut(-rate)  [join $rate_l ,]
    set aOut(-burst_size)  [join $bs_l ,]
    set aOut(-enable) [join $enable_l ,]
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
#-----------------------------------------
#Section: Traffic Management - Queue Management
#-----------------------------------------
proc ::gw::wca_queue_length_set {args} {
  set docStr "queue: support queue list"
  set ifnm wca_queue_length_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id queue length}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res}   {
    return $res
  }
  array set aIn $args
  
  helper_expand_list -set $queue -out aTmp
  set queue_l $aTmp(-l) 
  helper_expand_list -set $length -out aTmp
  set len_l $aTmp(-l)   
  if {[llength $queue_l ] > [llength $len_l]} {
    set pl [llength $len_l]
    set dl [llength $queue_l]
    set r [expr int(fmod($dl,$pl))]
    set c [expr int($dl/$pl)]
    set new_l [string repeat "$len_l " $c]
    set new_l "$new_l [lrange $len_l 0 [expr $r -1 ] ]"
    set len_l $new_l
  }  
  foreach queue $queue_l length $len_l {
    if {$queue == "/" || $length == "/" } { continue}
    set cmd [list ca_queue_length_set $device_id $port_id $queue $length]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res} {break}    
  }
  log -tag itfend
  return $res
}

proc ::gw::wca_queue_length_get {args} {
  set ifnm wca_queue_length_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id queue}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut length
  set aOut(-length) unknown
  helper_expand_list -set $queue -out aTmp
  set queue_l $aTmp(-l)
    
  set aTmp(-err) "" 
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]  
  if {$res == 0 } {
    set pt $aTmp(-err)
  } 
  
  set r_l "" 
  foreach queue $queue_l {
    if {$res } {break}
    if {$queue == "/"} {lappend r_l unknown; continue}
    set cmd [list ca_queue_length_get $device_id $port_id $queue $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      lappend r_l [ca_uint32_get $pt]
    }
  }
  if {$res == 0 } {
    set aOut(-length) [join $r_l ,]
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_flush {args} {
  set ifnm wca_queue_flush
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  port_id queue}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res}   {
    break
  }
  array set aIn $args
  
  helper_expand_list -set $queue -out aTmp
  set queue_l $aTmp(-l) 
  
  foreach queue $queue_l {
    if {$queue == "/"  } { continue}
    set cmd [list ca_queue_flush $device_id $port_id $queue ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res} {break}
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_pause_threshold_set {args} {
  set ifnm wca_queue_pause_threshold_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"

  set m_key_l {device_id port_id queue}
  set v_key_l {xon_threshold xoff_threshold pause_quanta}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res } {
    return $res
  }  
  array set aIn $args
  set res [wca_queue_pause_threshold_get -device_id $device_id -port_id $port_id -queue $queue -out aSys -print_res 0]
  if {$res} {
    return $res
  }
  foreach key $v_key_l {
    if {[info exists aIn(-$key)] && [string toupper $aIn(-$key)] ne "DONTCARE"} {
      set $key $aIn(-$key)
    } else {
      set $key $aSys(-$key)
    }
  } 
  helper_expand_list -set $queue -out aTmp
  set queue_l $aTmp(-l) 
  helper_expand_list -set $xon_threshold -out aTmp
  set xon_l $aTmp(-l)   
  helper_expand_list -set $xoff_threshold -out aTmp
  set xoff_l $aTmp(-l)  
  helper_expand_list -set $pause_quanta -out aTmp
  set quanta_l $aTmp(-l)  
    
  foreach p_l [list xon_l xoff_l quanta_l] {  
    set x_l [set $p_l]
    if {[llength $queue_l ] > [llength $x_l ]} {
      set pl [llength $x_l]
      set dl [llength $queue_l]
      set r [expr int(fmod($dl,$pl))]
      set c [expr int($dl/$pl)]
      set new_l [string repeat "$x_l " $c]
      set new_l "$new_l [lrange $x_l 0 [expr $r -1 ] ]"
      set $p_l $new_l
    }  
  }
  foreach queue $queue_l xon $xon_l xoff $xoff_l quanta $quanta_l {
    if {$res} {break}
    if {$queue == "/" || $xon == "/" || $xoff == "/" || $quanta == "/"} {continue}
    set cmd [list ca_queue_pause_threshold_set $device_id $port_id $queue $xon $xoff $quanta]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_pause_threshold_get {args} {
  set ifnm wca_queue_pause_threshold_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id queue}
  set v_out_key_l {  xon_threshold  xoff_threshold}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-print_res) 1
  array set aIn $args
  set print_res $aIn(-print_res)
  helper_output_declare aIn
  helper_output_init aOut [list xon_threshold xoff_threshold] 
  helper_expand_list -set $queue -out aTmp
  set queue_l $aTmp(-l)   
  set aTmp(-err) "" 
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]  
  if {$res == 0 } {
    set pxon $aTmp(-err)
  }
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]  
  if {$res == 0 } {
    set pxoff $aTmp(-err)
    set res [helper_cmd_exec -cmd {ca_uint16_create 0 } -out aTmp]
  }
  if {$res == 0 } {
    set pquanta $aTmp(-err)
  }
  
  set on_l ""
  set off_l ""
  set quanta_l ""
  foreach queue $queue_l {
    if {$res } {break}
    if {$queue == "/"} {lappend on_l unknown; lappend off_l unknown; continue}
    set cmd [list ca_queue_pause_threshold_get $device_id $port_id $queue $pxon $pxoff $pquanta]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res == 0 } {
      lappend on_l [ca_uint32_get $pxon]
      lappend off_l [ca_uint32_get $pxoff]
      lappend quanta_l [ca_uint16_get $pquanta]
    }
  }
  if {$res == 0 } {
    set aOut(-xon_threshold) [join $on_l ,]
    set aOut(-xoff_threshold) [join $off_l ,]
    set aOut(-pause_quanta) [join $quanta_l ,]
  }
  catch {ca_data_free $pxon} err
  catch {ca_data_free $pxoff} err
  if {$print_res} {
    helper_parray aOut
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_schedule_set {args} {
  set docStr "mode: SP(0)-Strict Priority, DWRR(1)-Deficit Weight Round Robin, DRR(2)-Deficit Round Robin,
    WRR(3)-Weight Round Robin, RR(4)-Round Robin, SPRR(5)-SP Round Robin"
  set ifnm wca_queue_schedule_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id port_id }
  set v_key_l {mode weights}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}
  set aIn(-data_init) 1
  set aIn(-weights) "dontcare"
  set aIn(-mode) "dontcare"
  array set aIn $args
  set data_init $aIn(-data_init)
  
  set cmd "ca_queue_weights_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pw $aTmp(-err)    
    if {$data_init == 1} {
      set cmd "ca_uint32_create 0"
      set res [helper_cmd_exec -cmd $cmd -out aTmp]
      if {$res == 0 } {
        set pmode $aTmp(-err)
        set cmd [list ca_queue_schedule_get $device_id $port_id $pmode $pw]
        set res [helper_cmd_exec -cmd $cmd -check_return_value 1] 
      }       
      if {$res == 0 } {
        if {[string compare [string tolower $aIn(-mode)] "dontcare"] == 0} {
          set aIn(-mode) $aTmp(-mode)
        } 
      }    
    }
  } 
  helper_h2s -table CA_QUEUE_SCHEDULE_MODE_T -source $aIn(-mode) -out aH
  set aIn(-mode) $aH(-target)
  if {$res == 0 && [string compare [string tolower $aIn(-weights)] "dontcare"]} {
    set w_l [split $aIn(-weights) ","]
    set n_w_l ""
    foreach w $w_l {      
      if {[string first "*" $w] >= 0 } {
        set vc_l [split $w "*"]
        set v [string trim [lindex $vc_l 0]]
        set c [string trim [lindex $vc_l 1]]
        set n_w_l ${n_w_l}[string repeat " $v"  $c]
      } else {
        set n_w_l "$n_w_l $w"
      }
    }
    set count [helper_constant_value_get -param CA_QUEUE_COUNT]
    #set count 8
    if {$count > [llength $n_w_l]} {set count [llength $n_w_l]}
    for {set i 0 } {$i < [llength $n_w_l]} {incr i} {
      set cmd "ca_queue_weights_set_weights $pw [lindex $n_w_l $i] $i"
      set res [helper_cmd_exec -cmd $cmd -check_return_value 0]
      if {$res} {break}
    }
  }  
  if {$res == 0 } {
    set cmd [list ca_queue_schedule_set $device_id $port_id $aIn(-mode) $pw]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pw} err
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_schedule_get {args} {
  set ifnm wca_queue_schedule_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut [list mode weights]
  set aTmp(-err) "" 
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]  
  if {$res == 0 } {
    set pm $aTmp(-err)
  }
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_queue_weights_create } -out aTmp]  
  if {$res == 0 } {
    set pw $aTmp(-err)
  }  
  if {$res == 0 } {
    set cmd [list ca_queue_schedule_get $device_id $port_id $pm $pw]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    set aOut(-mode) [ca_uint32_get $pm]
    set w_l ""
    for {set i 0 } {$i < 8 } {incr i } {
      lappend w_l [ca_queue_weights_get_weights $pw $i]
    }
    set aOut(-weights) [join $w_l ","]
  }
  helper_s2h -table CA_QUEUE_SCHEDULE_MODE_T -source $aOut(-mode) -out aH
  set aOut(-mode_v) $aH(-target)
  catch {ca_data_free $pm} err
  catch {ca_data_free $pw} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_wred_set {args} {
  set docStr "dp: max number is 64, to reduce input list length: 
    / * n --> skip n entries, num * n -> repeat entry with value=num for n times
    -xx_dp 1,3,/*8,2*54"
  set ifnm wca_queue_wred_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id queue marked_dp unmarked_dp}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-profile) "" 
  array set aIn $args
  set max_count 64
  set new_marked_dp_l ""
  set mdp_l [split $marked_dp ,]
  foreach ent $mdp_l {
    if {[regexp {.*\*.*} $ent]} {
      set t_l [split $ent "*"]
      set v [string trim [lindex $t_l 0]]
      set t [string trim [lindex $t_l 1]]
      set nv [string repeat " $v" $t]
      set new_marked_dp_l "$new_marked_dp_l $nv"      
    } else {
      lappend new_marked_dp_l $ent
    }
  }
  set marked_count $max_count
  set unmarked_count $max_count
  if {[llength $new_marked_dp_l] < $marked_count} {
    set marked_count [llength $new_marked_dp_l]
    #set new_marked_dp_l "$new_marked_dp_l [string repeat { /} [expr $max_count - [llength $new_marked_dp_l]]]"
  }
  set new_unmarked_dp_l ""
  set udp_l [split $unmarked_dp ","]
  foreach ent $udp_l {
    if {[regexp {.*\*.*} $ent]} {
      set t_l [split $ent "*"]
      set v [string trim [lindex $t_l 0]]
      set t [string trim [lindex $t_l 1]]
      set nv [string repeat " $v" $t]
      set new_unmarked_dp_l "$new_unmarked_dp_l $nv"      
    } else {
      lappend new_unmarked_dp_l $ent
    }
  }
  if {[llength $new_unmarked_dp_l] < $unmarked_count} {
    set unmarked_count [llength $new_unmarked_dp_l]
    #set new_unmarked_dp_l "$new_unmarked_dp_l [string repeat { /} [expr $max_count - [llength $new_unmarked_dp_l]]]"
  }
  #puts "marked_dp to set: $new_marked_dp_l"
  #puts "unmarked_dp to set: $new_unmarked_dp_l"
  set cmd "ca_queue_wred_profile_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    for {set i 0 } {$i < $marked_count} {incr i} {
        if {[string first "/" [lindex $new_marked_dp_l $i]] >= 0} {continue}
      set cmd "ca_queue_wred_profile_set_marked_dp $pt [lindex $new_marked_dp_l $i] $i"
      set res [helper_cmd_exec -cmd $cmd]
      if {$res} {break    }
    }
  }
  if {$res == 0} {
    for {set i 0 } {$i < $unmarked_count} {incr i} {
        if {[string first "/" [lindex $new_unmarked_dp_l $i]] >= 0} {continue}
      set cmd "ca_queue_wred_profile_set_unmarked_dp $pt [lindex $new_unmarked_dp_l $i] $i"
      set res [helper_cmd_exec -cmd $cmd]
      if {$res} {break    }
    }    
  }
  if {$res == 0 } {
    set cmd [list ca_queue_wred_set $device_id $port_id $queue $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_wred_get {args} {
  set ifnm wca_queue_wred_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id queue }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  [list marked_dp unmarked_dp]
  set max_count 64
  set cmd "ca_queue_wred_profile_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd [list ca_queue_wred_get $device_id $port_id $queue $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
    set md_l ""
    set ud_l ""
    for {set i 0 } {$i < $max_count } {incr i } {
      lappend md_l [ca_queue_wred_profile_get_marked_dp $pt $i]
      lappend ud_l [ca_queue_wred_profile_get_unmarked_dp $pt $i]
      
    }
    set aOut(-marked_dp) [join $md_l ","]
    set aOut(-unmarked_dp) [join $ud_l ","]
  }  
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_wred_ecn_set {args} {
  set ifnm wca_queue_wred_ecn_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id ecn_support}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  array set aIn $args
  if {$res == 0} {
    set cmd [list ca_queue_wred_ecn_set $device_id $ecn_support]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_wred_ecn_get {args} {
  set ifnm wca_queue_wred_ecn_get
  set res 0
  log -tag itfbgn -msg $args 
  set m_key_l {device_id }
   set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  ecn_support
  set pt [helper_ca_boolean_create]
  set cmd [list ca_queue_wred_ecn_get $device_id $pt]
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  
  if {$res == 0} {
    set aOut(-ecn_support) [helper_ca_boolean_get $pt]
  }  
  helper_data_free $pt
  helper_parray aOut 
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_stats_clear {args} {
  set ifnm wca_queue_stats_clear
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id queue}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  helper_expand_list -set $queue -out aTmp
  set queue_l $aTmp(-l)  
  foreach queue $queue_l {
    set cmd [list ca_queue_stats_clear $device_id $port_id $queue]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
    if {$res} {break}
  }
  log -tag itfend
  return $res
}
proc ::gw::wca_queue_stats_get {args} {
  set docStr "
    read_clear:  Default is 1, means read and then clear stats"
  set ifnm wca_queue_stats_get
  set res 0
  log -tag itfbgn -msg $args

  set m_key_l {device_id port_id queue }
  set v_key_l {read_clear}
  set v_out_key_l [helper_probe_struct_members  -struct ca_queue_stats]

  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l "read_clear name_style"]
  if {$res} {
    return $res
  }
  set aIn(-read_clear) 1
  array set aIn $args 
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l 
  foreach key $v_key_l {
    set $key $aIn(-$key)
    if {[string toupper $aIn(-$key)] == "DONTCARE"} {
      set $key 1
    }  
  }

  set aOut(-read_clear) $read_clear
  set cmd "ca_queue_stats_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
    set cmd [list ca_queue_stats_get $device_id $port_id  $queue $read_clear $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0} {
    foreach var $v_out_key_l {
      set aOut(-$var) [ca_queue_stats_get_$var $pt ]
    }
  }  
  catch {ca_data_free $pt} err  

  helper_parray aOut
  log -tag itfend
  return $res
}
#-----------------------------------------
#Section: Traffic Management - Classifier Configuration
#-----------------------------------------
proc ::gw::helper_clz_key_members_declare {args} { 
    array set aIn $args
    if {[info exists aIn(-out)] } {
        upvar $aIn(-out) vClz
    } else {
        upvar vClz vClz
    }
    array set vClz {}
    if {[info exists vClz(in_param_l)] == 0} {
        set vClz(in_param_l) ""
    } 
    set vClz(vKey.m) [helper_probe_struct_members  -struct ca_classifier_key]
    set vClz(vKey.m.spec) {l2 ip l4 ext key_handle }
    foreach var $vClz(vKey.m) {
        if {[lsearch -exact $vClz(vKey.m.spec) $var] >=0 } continue;  
        lappend vClz(in_param_l) $var
    }    
    set vClz(vKey.handle.m)  [helper_probe_struct_members  -struct ca_classifier_handle]
    set vClz(in_param_l) "$vClz(in_param_l) $vClz(vKey.handle.m)"
    
    #L2 sub layer, mac_sa=mac_sa_min, mac_da=mac_da_min
    set vClz(vKey.l2.m) [helper_probe_struct_members -struct ca_classifier_l2]
    set vClz(vKey.l2.m.spec) {vlan_otag vlan_itag is_multicast}
    foreach var $vClz(vKey.l2.m) {
        if {[lsearch -exact $vClz(vKey.l2.m.spec) $var] >=0 } continue;
        lappend vClz(in_param_l) $var
    }  
    lappend vClz(in_param_l) l2_is_multicast; 
    lappend vClz(in_param_l) mac_sa_max  
    lappend vClz(in_param_l) mac_da_max
    
    set vClz(vKey.vlan.m) [helper_probe_struct_members -struct ca_classifier_vlan]  
    set vClz(vKey.vlan.orient) [list otag itag] 
    set vClz(vKey.vlan_range.m) {min max} ;#ca_classifier_vlan_range_t  
    foreach vlan_type $vClz(vKey.vlan.orient) {
      foreach vlan_field $vClz(vKey.vlan.m) {
        lappend vClz(in_param_l) vlan_${vlan_type}_${vlan_field}
        lappend vClz(in_param_l) vlan_${vlan_type}_${vlan_field}_max      
      } 
    }  
            
    set vClz(vKey.ip.m) [helper_probe_struct_members -struct ca_classifier_ip]
    set skip_l {is_multicast}
    foreach var $vClz(vKey.ip.m)  {
        if {[lsearch -exact $skip_l $var] >=0 } continue;
        lappend vClz(in_param_l) $var
    }         
    lappend vClz(in_param_l) "l3_is_multicast" 
    
    set vClz(vKey.l4.m) [helper_probe_struct_members -struct ca_classifier_l4] 
    set skip_l   {src_port dst_port}
    foreach var $vClz(vKey.l4.m)  {
        if {[lsearch -exact $skip_l $var] >=0 } {
            lappend vClz(in_param_l) l4_$var
            lappend vClz(in_param_l) l4_${var}_min l4_${var}_max
            continue
        }
        lappend vClz(in_param_l) $var
    }
    set vClz(vKey.l4.port.range) [helper_probe_struct_members -struct ca_classifier_l4_port_range]
    set vClz(vKey.ext.m)     [helper_probe_struct_members -struct ca_classifier_ext]   
    foreach var $vClz(vKey.ext.m) {
        lappend vClz(in_param_l) "ext_$var"
    }                   
}
proc ::gw::helper_clz_key_mask_members_declare {args} {
    array set aIn $args
    if {[info exists aIn(-out)] } {
        upvar $aIn(-out) vClz
    } else {
        upvar vClz vClz
    }
    array set vClz {}
    if {[info exists vClz(in_param_l)] == 0} {
        set vClz(in_param_l) ""
    }
    
    set vClz(vKey.msk.m) [helper_probe_struct_members  -struct ca_classifier_key_mask]
    set skip_l {l2_mask ip_mask l4_mask}    
    foreach var $vClz(vKey.msk.m) {
        if {[lsearch -exact $skip_l $var] >=0 } continue;
        lappend vClz(in_param_l) mask_$var
    }
    
    #ca_classifier_l2_mask_t, exclude 2 sub mask struct : vlan_otag_mask , vlan_itag_mask
    set vClz(vKey.msk.l2.m) [helper_probe_struct_members -struct ca_classifier_l2_mask]
    set skip_l {vlan_otag_mask vlan_itag_mask is_multicast}
    foreach var $vClz(vKey.msk.l2.m) {
        if {[lsearch -exact $skip_l $var] >=0 } continue;
        lappend vClz(in_param_l) mask_$var
    } 
    lappend vClz(in_param_l) mask_l2_is_multicast
          
    #ca_classifier_vlan_mask      
    set vClz(vKey.msk.vlan.m) [helper_probe_struct_members -struct ca_classifier_vlan_mask]
    foreach vlan_type {vlan_otag vlan_itag} {
      foreach vlan_field $vClz(vKey.msk.vlan.m) {
        lappend vClz(in_param_l) mask_${vlan_type}_${vlan_field}    
      } 
    }      
  
    set vClz(vKey.msk.ip.m)      [helper_probe_struct_members -struct ca_classifier_ip_mask]
    foreach var $vClz(vKey.msk.ip.m) {
        if {$var == "is_multicast"} {lappend vClz(in_param_l) mask_l3_is_multicast;continue;}        
        lappend vClz(in_param_l) mask_$var
    }
        
    set vClz(vKey.msk.l4.m)      [helper_probe_struct_members -struct ca_classifier_l4_mask]
    foreach var $vClz(vKey.msk.l4.m) {
        if {$var == "src_port" || $var == "dst_port"} {lappend vClz(in_param_l) mask_l4_$var;continue;  }      
        lappend vClz(in_param_l) mask_$var
    }    
}
proc ::gw::helper_clz_action_members_declare {args} {
    array set aIn $args
    if {[info exists aIn(-out)] } {
        upvar $aIn(-out) vClz
    } else {
        upvar vClz vClz
    }
    array set vClz {}
    if {[info exists vClz(in_param_l)] == 0} {
        set vClz(in_param_l) ""
    }
    
    set vClz(vAct.m)             [list forward]
    lappend vClz(in_param_l)     action_forward
    
    set vClz(vAct.dest.m)            [helper_probe_struct_members -struct ca_classifier_action_dest]
    foreach var $vClz(vAct.dest.m) {
        lappend vClz(in_param_l)    action_dest_$var
    }
    set vClz(vAct.option.m)            [helper_probe_struct_members -struct ca_classifier_action_option]  
    set vClz(vAct.option.handle.m)     [helper_probe_struct_members  -struct ca_classifier_handle]  
    set skip_l {masks action_handle}
    foreach var $vClz(vAct.option.m) {
        if {$var == "masks"} continue;
        if {$var == "action_handle" } {
            set handle_members  [helper_probe_struct_members  -struct ca_classifier_handle]
            foreach m $handle_members {
                lappend vClz(in_param_l) action_option_$m
            }
            continue
        }        
        lappend vClz(in_param_l)    action_option_$var
    }    
    set vClz(vAct.msk.option.m)    [helper_probe_struct_members -struct ca_classifier_action_option_mask]
    foreach var $vClz(vAct.msk.option.m) {
        lappend vClz(in_param_l)    mask_action_option_$var
    }                 
}
proc ::gw::helper_clz_rule_args_declare {args} {
    array set aIn $args
    if {[info exists aIn(-out)] } {
        upvar $aIn(-out) vClz
    } else {
        upvar vClz vClz
    }
    array set vClz {}
    if {[info exists vClz(in_param_l)] == 0} {
        set vClz(in_param_l) ""
    }
    helper_clz_key_members_declare
    helper_clz_key_mask_members_declare
    helper_clz_action_members_declare             
}
proc ::gw::helper_clz_key_set {args} {
  variable gwenv 
  set ifnm helper_clz_rule_key_entry_config 
  set res 0  
  set EXT_DATA_MAX_LEN 8 ;#8 bytes
  set DEFAULT_MASK_VALUE 0x1
  log -tag itfbgn -msg $args
  
  set m_key_l {p_key kargs}   
  set v_key_l {mask_arr}
  helper_clz_key_members_declare
  #helper_clz_key_mask_member_declare
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aVar $args
  array set aIn $kargs
  if {[info exists aVar(-mask_arr)] == 0} {
    set aVar(-mask_arr) aKeyMask
  }
  upvar $aVar(-mask_arr) aMask
  array set aMask ""
  foreach var {mac_sa mac_da } {
    if {[info exists aIn(-${var}_max)] == 0 && [info exists aIn(-${var})]} {    
      set aIn(-${var}_max)  $aIn(-$var)
    }
  }
  foreach xtag {vlan_otag vlan_itag} {
    foreach var $vClz(vKey.vlan.m) {
      set var ${xtag}_${var}
      if {[info exists aIn(-${var}_max)] == 0 && [info exists aIn(-${var})]} {    
        set aIn(-${var}_max)  $aIn(-${var})
      }     
    }
  }  
  foreach key {l4_src_port l4_dst_port} {
    foreach mm {min max} {
      set var ${key}_${mm}
      if {[info exists aIn(-${var})] == 0 && [info exists aIn(-${key})]} {    
        set aIn(-${var})  $aIn(-${key})
      }     
    }
  }  
  set p_handle [ca_classifier_key_get_key_handle $p_key]
  set p_l2 [ca_classifier_key_get_l2 $p_key]
  set p_ip [ca_classifier_key_get_ip $p_key]
  set p_l4 [ca_classifier_key_get_l4 $p_key]
  set p_l4_src_port [ca_classifier_l4_get_src_port $p_l4 ]
  set p_l4_dst_port [ca_classifier_l4_get_dst_port $p_l4 ]
  set p_ext [ca_classifier_key_get_ext $p_key]  
  set p_vlan_otag [ca_classifier_l2_get_vlan_otag $p_l2]
  set p_vlan_itag [ca_classifier_l2_get_vlan_itag $p_l2]
     
  set skip_l "$vClz(vKey.m.spec) handle_type"
  foreach key $vClz(vKey.m) {
    if {$res} {break}  
    if {[lsearch -exact $skip_l $key] >=0 } continue;
    if {[is_unspec_var aIn $key]} {continue}
    set cmd "ca_classifier_key_set_$key $p_key $aIn(-$key)"
    set res [helper_cmd_exec -cmd $cmd]
    if {$res} {break}
    set mskVarName mask_$key
    if {[string first "packet_length_" $key] == 0 } {
      set mskVarName mask_packet_length
    } 
    if {[is_unspec_var aIn $mskVarName] } {   
      set aMask(-$mskVarName) $DEFAULT_MASK_VALUE
    }
  }
  if {$res == 0 } {
    if {[is_unspec_var aIn handle_type] == 0} {
        helper_h2s -table CA_CLASSIFIER_HANDLE_TYPE_T -source $aIn(-handle_type) -out aH
        set handle_type $aH(-target)
        set cmd "ca_classifier_key_set_handle_type $p_key $handle_type"
        set res [helper_cmd_exec -cmd $cmd]
        if {[is_unspec_var aIn mask_key_handle] } { 
          set aMask(-mask_key_handle) $DEFAULT_MASK_VALUE
        }
    }
  } 

  foreach key $vClz(vKey.handle.m) {    
      if {$res} {break} 
      if {[is_unspec_var aIn $key]} {continue}  
      set cmd "ca_classifier_handle_set_$key $p_handle $aIn(-$key)"
      set res [helper_cmd_exec -cmd $cmd]  
      if {[is_unspec_var aIn mask_key_handle] } { 
        set aMask(-mask_key_handle) $DEFAULT_MASK_VALUE   
      } 
  }

  set mask_flag 0
  set skip_l $vClz(vKey.l2.m.spec)
  foreach key "$vClz(vKey.l2.m) mac_sa_max mac_da_max l2_is_multicast" {
    if {$res} {break} 
    if {[lsearch -exact $skip_l $key] >=0 } continue;    
    if {[is_unspec_var aIn $key]} {continue}   
    if {[lsearch {mac_sa mac_da mac_sa_max mac_da_max} $key] >= 0} {
      if {$key == "mac_sa" || $key == "mac_sa_max" } {
        set p_mac_range [ca_classifier_l2_get_mac_sa $p_l2]
      } else {
        set p_mac_range [ca_classifier_l2_get_mac_da $p_l2]
      }
      if {$key == "mac_sa" || $key == "mac_da"} {
        set p_mac [ca_classifier_mac_addr_range_get_mac_min $p_mac_range]
      } else {
        set p_mac [ca_classifier_mac_addr_range_get_mac_max $p_mac_range]
      }
      set mac_l [split [set aIn(-$key)] :]
      set new_mac_l ""
      foreach mac $mac_l {
        lappend new_mac_l 0x$mac
      }
      set cmd "ca_mac_addr_set $p_mac $new_mac_l"
    } elseif {$key == "l2_is_multicast"} {
      set cmd "ca_classifier_l2_set_is_multicast $p_l2 $aIn(-l2_is_multicast)"
    } else {
      set cmd "ca_classifier_l2_set_${key} $p_l2 $aIn(-$key)"
    }
    
    set res [helper_cmd_exec -cmd $cmd ]
    if {$res} {break}
    
    set mask_flag 1
    set mskVarName mask_$key
    if {$key == "mac_sa" || $key == "mac_sa_max" } {
        set mskVarName mask_mac_sa 
    } elseif {$key == "mac_da" || $key == "mac_da_max"} {
        set mskVarName mask_mac_da 
    }
    if {[is_unspec_var aIn $mskVarName]} {
        set aMask(-$mskVarName) $DEFAULT_MASK_VALUE ;
    }    
  }

  if {$mask_flag  && [is_unspec_var aIn mask_l2]} {
      set aMask(-mask_l2) $DEFAULT_MASK_VALUE
  }

  foreach xtag "otag itag" {
      set mask_flag 0
      set p_vlan_xtag [set p_vlan_$xtag]
      foreach mm {min max} {
        set p_vlan_tag_mm [ca_classifier_vlan_range_get_vlan_${mm} $p_vlan_xtag]
        foreach key $vClz(vKey.vlan.m) {
          if {$res} {break} 
          if {$mm == "min"} { 
              set varName vlan_${xtag}_${key}
          } else {
              set varName vlan_${xtag}_${key}_max
          } 
          set mskVarName mask_vlan_${xtag}_${key}        
          if {[is_unspec_var aIn $varName]} {continue}   
          set mask_flag 1     
          set cmd "ca_classifier_vlan_set_${key} ${p_vlan_tag_mm} $aIn(-$varName)"
          if {[is_unspec_var aIn $mskVarName] } {
              set aMask(-$mskVarName) 1
          }
          set res [helper_cmd_exec -cmd $cmd ]
        }
      }
      if {$mask_flag && $res == 0 } {
        if {[is_unspec_var aIn mask_vlan_${xtag}]} {
            set aMask(-mask_vlan_${xtag}) $DEFAULT_MASK_VALUE
        } 
        if {[is_unspec_var aIn mask_l2]} {
            set aMask(-mask_l2) $DEFAULT_MASK_VALUE
        }      
      }        
  }  
  #ip section
  set mask_flag 0
  set skip_l {is_multicast}  
  foreach key $vClz(vKey.ip.m) {
      if {$res} {break}
      if {[lsearch -exact $skip_l $key] >=0 } continue;   
      if {[is_unspec_var aIn $key]} {continue} 
      if {[lsearch {ip_sa ip_da ip_sa_max ip_da_max} $key] >=0 } {
          set p_ip_address_t [ca_classifier_ip_get_$key $p_ip]   
          set p_ip_l3_address_t [ca_ip_address_get_ip_addr $p_ip_address_t];#addr, ipv4_addr , ipv6_addr     
          set res [helper_ca_ip_address_entry_config -ref $p_ip_address_t -ip_addr $aIn(-$key)  ]
      } else {
          set cmd "ca_classifier_ip_set_${key} $p_ip $aIn(-$key)"
          set res [helper_cmd_exec -cmd $cmd ]
      }
      set mask_flag 1
      if {$key == "dscp_mask" } {set key "dscp"}
      if {[is_unspec_var aIn mask_$key]} {
          set aMask(-mask_$key) $DEFAULT_MASK_VALUE
      }  
  } 
  if {$res == 0 && ([is_unspec_var aIn l3_is_multicast] == 0) } {
    set cmd "ca_classifier_ip_set_is_multicast $p_ip $aIn(-l3_is_multicast)"
    set res [helper_cmd_exec -cmd $cmd ]
    if {$res eq 0 } {
      set mask_flag 1
      if {[is_unspec_var aIn mask_l3_is_multicast]} {
         set aMask(-mask_l3_is_multicast) $DEFAULT_MASK_VALUE
      }  
    }  
  }    
  if {$mask_flag && $res == 0 && [is_unspec_var aIn mask_ip] } {
      set aMask(-mask_ip) $DEFAULT_MASK_VALUE
  }  
  #l4 section
  set mask_flag 0
  set skip_l {src_port dst_port}
  foreach key $vClz(vKey.l4.m) {
    if {$res} {break} 
    if {[lsearch -exact $skip_l $key] >=0 } continue;   
    if {[is_unspec_var aIn $key]} {continue} 
    set cmd "ca_classifier_l4_set_${key} $p_l4 $aIn(-$key)"
    set res [helper_cmd_exec -cmd $cmd]   
    if {$res} {break}
    set mask_flag 1
    if {[is_unspec_var aIn mask_$key]} {
      if {$key == "tcp_flags" } {
        set aMask(-mask_$key) 0x1ff ;#9bits
      } else {
        set aMask(-mask_$key) $DEFAULT_MASK_VALUE
      }
    } 
  } 
  foreach port {src_port dst_port} {
    if {$res} {break} 
    set l4_spec_mask_flag 0
    foreach mm {min max} {
      set varName l4_${port}_${mm}
      if {[is_unspec_var aIn $varName]} {continue} 
      set cmd "ca_classifier_l4_port_range_set_$mm [set p_l4_${port}] $aIn(-$varName)"
      set res [helper_cmd_exec -cmd $cmd ] 
      if {$res} {break}
      set l4_spec_mask_flag 1
    }
    if {$res} {break}
    if {$l4_spec_mask_flag} {
      set mask_flag 1
      if {[is_unspec_var aIn mask_l4_$port]} {
        set aMask(-mask_l4_$port) $DEFAULT_MASK_VALUE
      }
    } 
  }
  if {$mask_flag && $res == 0 && [is_unspec_var aIn mask_l4] } {
      set aMask(-mask_l4) $DEFAULT_MASK_VALUE
  }    
  set mask_flag 0
  if {[is_unspec_var aIn ext_data] == 0} {
      if {[is_unspec_var aIn ext_mask]} {
          set lx [join $aIn(-ext_data) ""]
          set aMask(-ext_mask) [string repeat "f" [string length $lx]]
      }
  }
  foreach key $vClz(vKey.ext.m) {
    if {$res} {break} 
    set varName ext_$key
    if {[is_unspec_var aIn $varName]} {continue}     
    if {"$key" == "data" || "$key" == "mask"} {
      set d_l $aIn(-$varName)
      for {set i 0 } {$i < [llength $d_l] } {incr i} {        
        set cmd "ca_classifier_ext_set_$key $p_ext 0x[lindex $d_l $i] $i"
        set res [helper_cmd_exec -cmd $cmd ]
        if {$res} {break}
      }
      if {$res} {break}
      set mask_flag 1      
      continue
    }    
    if {"$key" == "starting_location" } {
      if {[llength [info commands ca_classifier_ext_get_starting_location]] eq 0} {
        # patch for saturn kt, 20190401. saturn kt currently does not support this config
        continue
      }    
      helper_h2s -table CA_CLASSIFIER_KEY_OFFSET_START_T -source $aIn(-ext_starting_location) -out aH
      set aIn(-ext_starting_location) $aH(-target)
    }
    set cmd "ca_classifier_ext_set_${key} $p_ext $aIn(-$varName)"
    set res [helper_cmd_exec -cmd $cmd ]
    if {$res == 0} {set mask_flag 1}
  }
  if {$mask_flag && $res == 0 && [is_unspec_var aIn mask_ext]} {
      set aMask(-mask_ext) $DEFAULT_MASK_VALUE
  }
  
  parray aMask
  
  log -tag itfend
  return $res
}
proc ::gw::helper_clz_key_mask_set {args} {
  set ifnm helper_clz_key_mask_set
  log -tag itfbgn -msg $args 
  set res 0  
  set DEFAULT_MASK_VALUE 0x1
  set m_key_l {p_key_mask kargs} 
  helper_clz_key_mask_members_declare
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {return $res}
  array set aIn $kargs 
 
  set p_l2_mask [ca_classifier_key_mask_get_l2_mask $p_key_mask]
  set p_ip_mask [ca_classifier_key_mask_get_ip_mask $p_key_mask]
  set p_l4_mask [ca_classifier_key_mask_get_l4_mask $p_key_mask]
  set p_vlan_otag_mask [ca_classifier_l2_mask_get_vlan_otag_mask $p_l2_mask ]
  set p_vlan_itag_mask [ca_classifier_l2_mask_get_vlan_itag_mask $p_l2_mask ]
  
  #Configure masks
  set skip_l {l2_mask ip_mask l4_mask}    
  foreach key $vClz(vKey.msk.m) {
    if {[lsearch $skip_l $key] >= 0 } {continue}
    if {$res} {break}
    set varName mask_$key
    if {[string first "packet_length_" $key] == 0 } {
      set key packet_length
      set varName mask_packet_length
    }
    if {[is_unspec_var aIn $varName]} {continue}
    set cmd "ca_classifier_key_mask_set_$key $p_key_mask $aIn(-$varName)"
    set res [helper_cmd_exec -cmd $cmd ]    
  }
  
  set mask_flag 0
  set skip_l {vlan_otag_mask vlan_itag_mask is_multicast}  
  foreach key "$vClz(vKey.msk.l2.m) l2_is_multicast" {    
    if {$res} {break}    
    set varName mask_$key
    if {[lsearch $skip_l $key] >= 0 || [is_unspec_var aIn $varName] } {continue} 
    if {$key == "l2_is_multicast"} {set key "is_multicast"}
    set cmd "ca_classifier_l2_mask_set_$key $p_l2_mask $aIn(-$varName)"
    set res [helper_cmd_exec -cmd $cmd ]
    if {$res == 0 } {set mask_flag 1}
  } 
  foreach xtag {otag itag} {
      if {$res  } {break} 
      set p_vlan_mask [set p_vlan_${xtag}_mask]
      foreach key $vClz(vKey.msk.vlan.m) {   
        set varName mask_vlan_${xtag}_$key   
        if {[is_unspec_var aIn $varName]} {continue}    
        if {$aIn(-$varName)} {set mask_flag 1}
        set cmd "ca_classifier_vlan_mask_set_$key $p_vlan_mask $aIn(-$varName)"
        set res [helper_cmd_exec -cmd $cmd ] 
        if {$res} {break}
        set mask_flag 1
      }    
  }
  if {$res == 0 && $mask_flag == 1 &&  [is_unspec_var aIn mask_l2]} { 
      set aIn(-mask_l2) 1
  }  
  if {$res == 0 && [is_unspec_var aIn mask_l2] == 0} {  
      set cmd "ca_classifier_key_mask_set_l2 $p_key_mask $aIn(-mask_l2)"
      set res [helper_cmd_exec -cmd $cmd ]
  } 
  set mask_flag 0
  foreach key $vClz(vKey.msk.ip.m) {
    if {$res} {break}
    set varName mask_$key
    if {$key == "is_multicast" } { set varName mask_l3_is_multicast}
    if {[is_unspec_var aIn $varName]} {  continue }    
    set cmd "ca_classifier_ip_mask_set_$key $p_ip_mask $aIn(-$varName)"
    set res [helper_cmd_exec -cmd $cmd ]
    if {$aIn(-$varName)} {set mask_flag 1}
  } 
  if { $res == 0 && $mask_flag && [is_unspec_var aIn mask_ip]} { 
      set aIn(-mask_ip) 1
  }  
  if {$res == 0  && [is_unspec_var aIn mask_ip] == 0} {
      set cmd "ca_classifier_key_mask_set_ip $p_key_mask $aIn(-mask_ip)"
      set res [helper_cmd_exec -cmd $cmd ]
  }

  set mask_flag 0
  foreach key $vClz(vKey.msk.l4.m) {
    if {$res} {break}  
    set varName mask_$key
    if {$key == "src_port" || $key == "dst_port"} {set varName mask_l4_$key}
    if {[is_unspec_var aIn $varName]} {   continue    }    
    set cmd "ca_classifier_l4_mask_set_$key $p_l4_mask $aIn(-$varName)"
    set res [helper_cmd_exec -cmd $cmd ]     
    if {$aIn(-$varName)} {set mask_flag 1}
  }
  if { $res == 0 && $mask_flag && [is_unspec_var aIn mask_l4]} { 
      set aIn(-mask_l4) 1
  }  
  if {$res == 0  && [is_unspec_var aIn mask_l4] == 0} { 
      set cmd "ca_classifier_key_mask_set_l4 $p_key_mask $aIn(-mask_l4)"
      set res [helper_cmd_exec -cmd $cmd ]
  }    
 
  if {$res == 0 && [is_unspec_var aIn mask_ext] == 0} { 
      set cmd "ca_classifier_key_mask_set_ext $p_key_mask $aIn(-mask_ext)"
      set res [helper_cmd_exec -cmd $cmd]
  } 
  
  log -tag itfend -msg $args
  return $res
}
proc ::gw::helper_clz_action_set {args} {
  log -tag itfbgn -msg $args
  set res 0
  set DEFAULT_MASK_VALUE 0x1  
  set m_key_l {p_action kargs}   
  helper_clz_action_members_declare
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $kargs 
  set p_action_dest [ca_classifier_action_get_dest $p_action] 
  set p_action_option [ca_classifier_action_get_options $p_action]
  set p_action_option_action_handle [ca_classifier_action_option_get_action_handle $p_action_option]
  set p_action_option_mask [ca_classifier_action_option_get_masks $p_action_option]  
  
  foreach key $vClz(vAct.m) {
    if {$res} {break}  
    set varName action_$key
    if {[is_unspec_var aIn $varName]} {continue} 
    if {"$key" == "forward" } {
      helper_h2s -table CA_CLASSIFIER_FORWARD_FLAG_T -source $aIn(-$varName) -out aH
      set aIn(-$varName) $aH(-target)
    }   
    set cmd "ca_classifier_action_set_${key} $p_action $aIn(-$varName)"
    set res [helper_cmd_exec -cmd $cmd]      
  }
  foreach key $vClz(vAct.dest.m) {
    if {$res} {break}  
    set varName action_dest_$key
    if {[is_unspec_var aIn $varName]} {continue} 
    if {"$key" == "fe" } {
      helper_h2s -table CA_CLASSIFIER_ACTION_DEST_FE_T -source $aIn(-$varName) -out aH
      set aIn(-$varName) $aH(-target)
    }     
    set cmd "ca_classifier_action_dest_set_${key} $p_action_dest $aIn(-$varName)"
    set res [helper_cmd_exec -cmd $cmd ]    
  }  
  
  set skip_l {masks action_handle}
  foreach key $vClz(vAct.option.m) {
    if {$res} {break}  
    if {[lsearch $skip_l $key] >=0} {continue}
    set varName action_option_$key
    if {[is_unspec_var aIn $varName]} {continue} 
    if {$key == "handle_type"} {
        helper_h2s -table CA_CLASSIFIER_HANDLE_TYPE_T -source $aIn(-$varName) -out aH
        set aIn(-$varName) $aH(-target)
    } 
    if {$key == "inner_vlan_act" || $key == "outer_vlan_act" } {
        helper_h2s -table CA_CLASSIFIER_VLAN_ACTION_T -source $aIn(-$varName) -out aH
        set aIn(-$varName) $aH(-target)
    }   
    if {$key == "sw_id"} {
      set sw_id_l [split $aIn(-$varName) "."]
      for {set i 0 } {$i < 4} {incr i} {
        set cmd "ca_classifier_action_option_set_sw_id $p_action_option [lindex $sw_id_l $i] $i"
        set res [helper_cmd_exec -cmd $cmd]
      }  
    } elseif {$key == "mac_da" } {
        set p_mac [ca_classifier_action_option_get_$key $p_action_option]
        set res [helper_mac_set $p_mac $aIn(-$varName)]
    } else { 
      set cmd "ca_classifier_action_option_set_${key} $p_action_option $aIn(-$varName)"
      set res [helper_cmd_exec -cmd $cmd ]  
    }
 
    if {$res} {break}
    if {$key == "outer_vid" || $key == "inner_vid"} {
      #vid shares same mask bit with act
      set orig [lindex [split $key _] 0]
      set mskVarName mask_action_option_${orig}_vlan_act
    }  elseif {$key == "handle_type" } {
      set mskVarName mask_action_option_action_handle
    } else {
      set mskVarName mask_action_option_$key
    }
    if {[is_unspec_var aIn $mskVarName]} {
        set aIn(-$mskVarName) $DEFAULT_MASK_VALUE ;#shared mask bit
    }   
  }
  
  #configure action_option_action_handle
  set mask_flag 0
  foreach key $vClz(vAct.option.handle.m) {
    if {$res} {break}  
    set varName action_option_$key
    if {[is_unspec_var aIn $varName]} {continue}
    set cmd "ca_classifier_handle_set_${key} $p_action_option_action_handle $aIn(-$varName)"
    set res [helper_cmd_exec -cmd $cmd ]  
    if {$res} {break}
    set mskVarName mask_action_option_action_handle
    if {[is_unspec_var aIn $mskVarName]} {
        set aIn(-$mskVarName) $DEFAULT_MASK_VALUE
    }        
  }  

  foreach key $vClz(vAct.msk.option.m) {
    if {$res} {break}
    set varName mask_action_option_$key
    if {[is_unspec_var aIn $varName]} {continue}
    set cmd "ca_classifier_action_option_mask_set_$key $p_action_option_mask $aIn(-$varName)"
    set res [helper_cmd_exec -cmd $cmd]    
  }  
  log -tag itfend
  return $res   
}
if {0} {
# Cls rule API test scripts
set p_key [ca_classifier_key_create ]
gw::helper_clz_key_set -p_key $p_key -kargs {-flow_id 10}

#test cls key global cfg
wca_classifier_rule_add -priority 3  -orig_src_port 0x30003 -src_port 0x30000 -dest_port 0x30002 -flow_id 10 -handle_type 2 -src_intf 1 -dest_intf 2 -merge_prio 2 -packet_length_low 64 -packet_length_heigh 1518 -ingress_lan 1

#test l2 keys
wca_classifier_rule_add -priority 3 -src_port 0x30000 -ethertype 0x8809 -subtype 3 -vlan_count 2 -l2_is_multicast 1 -is_length 1 -cfm_opcode 2 -ppp_proto 3 
#l2 mac range
wca_classifier_rule_add -priority 3 -src_port 0x30000 -mac_sa 00:11:22:33:44:55 -mac_da 00:aa:bb:cc:dd:ee  
wca_classifier_rule_add -priority 3 -src_port 0x30000 -mac_sa 00:11:22:33:44:55 -mac_sa_max 00:ff:ee:bb:aa:11 -mac_da 00:aa:bb:cc:dd:ee -mac_da_max 00:ee:99:88:77:11 

#vlan
wca_classifier_rule_add -priority 3 -src_port 0x30000 -vlan_otag_vid 100 -vlan_itag_tpid 0x88a8 -vlan_otag_tpid 0x9100
wca_classifier_rule_add -priority 3 -src_port 0x30000 -vlan_otag_vid_max 1100 -vlan_itag_tpid 0x88a8 -vlan_otag_tpid_max 0x9100

#ip & l4
wca_classifier_rule_add -priority 3 -src_port 0x30000 -ip_valid 1 -ip_version 4 -ip_protocol 23 -dscp 4 -ecn 1 -ip_sa 192.168.2.1 -ip_da_max 255.255.0.0 -fragment 1 -have_options 1 -flow_label 9 -ext_header 58 -icmp_type 32 -igmp_type 2 -l3_is_multicast 1

wca_classifier_rule_add -priority 3 -src_port 0x30000 -l4_valid 1 -tcp_flags 0x11 -l4_src_port 30

#ext
wca_classifier_rule_add -priority 3 -src_port 0x30000  -ext_starting_location 30 -ext_offset 12 -ext_length 2 -ext_data "12 11"

#action
wca_classifier_rule_add  -priority 3 -src_port 0x30000 -action_forward  3 -action_dest_port 0x30003  -action_option_flow_id 10  
wca_classifier_rule_add  -priority 3 -src_port 0x30000    -action_option_handle_type 2  -action_option_dscp 33
wca_classifier_rule_add  -priority 3 -src_port 0x30000 -action_option_inner_dot1p 7 -action_option_inner_tpid 0x88a8 
wca_classifier_rule_add  -priority 3 -src_port 0x30000   -action_option_inner_vid 200  
wca_classifier_rule_add  -priority 3 -src_port 0x30000   -action_option_inner_vid 200   -action_option_inner_vlan_act 1
wca_classifier_rule_add  -priority 3 -src_port 0x30000      -action_option_outer_dot1p 6 -action_option_outer_tpid   0x9100   -action_option_outer_dei 1   -action_option_outer_vid 99   -action_option_outer_vlan_act 2 
wca_classifier_rule_add  -priority 3 -src_port 0x30000         -action_option_mac_da 00:11:22:44:55:33  -action_option_sw_id 3.4.2.1  -action_option_sw_shaper_id  6 
wca_classifier_rule_add  -priority 3 -src_port 0x30000       -action_option_mcg_id   2    -action_option_llid_cos_index 4

}

proc ::gw::wca_classifier_rule_add {args} {
  set docStr "
  Usage: 
    a)Due to classifier rule complex struct, name of some input argument here may be variant from 
    definition in SDK API. For example, both L2 and IP sub section has field 'is_multicast', to 
    distingush them in input argument list, argument with prefix 'l2' as 'l2_is_multicast' and 
    'l3' as 'l3_is_multicast' are used to replace field 'is_multicast' in L2 and IP sub section 
    respectivly. 
    
    b)For action section, prefix 'action' will be used.xx_mac to be used for xx_mac_min. 
    vlan_otag/itag_<var>_max to be used for var in vlan_otag/itag_max.For all variant argument 
    names, please refer to input argument list in help info.
    
    c)Format of ext_data and ext_mask should be in hex as '0a 0b' and '0f 01 00' respectively.
    
    d)mac_sa/mac_da: identical to mac_sa_min/mac_da_min.If mac_sa_max/mac_da_max is not given, they
    will be set as input mac_sa/mac_da as well, which means then mac_sa_max == mac_sa_min / mac_da_max
    == mac_da_min. Or else, mac_sa/da_max should be specified.
    
    e)vlan_otag/vlan_itag: identical to vlan_otag_min/vlan_itag_min.If vlan_otag_max/vlan_itag_max is not given, they
    will be set as input vlan_otag/vlan_itag as well, so then xx_min==xx_max. 
  "
  set res 0    
  log -tag itfbgn -msg $args  
  set m_key_l {device_id priority } 
  helper_clz_rule_args_declare 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l -v_key_l [lsort $vClz(in_param_l)] ]
  if {$res} {  return $res }
  array set aIn $args 
  
  helper_output_declare aIn
  helper_output_init aOut  index
  
  set p_key [ca_classifier_key_create ]    
  set p_key_mask [ca_classifier_key_mask_create] 
  set p_action [ca_classifier_action_create]
  set p_index [ca_uint32_create 99999]
  
  array set aKeyAutoMask {}
  if {$res == 0 } {
      set res [helper_clz_key_set -p_key $p_key -kargs [array get aIn ] -mask_arr aKeyAutoMask]
  }
  if {$res == 0 } {
      array set aIn [array get aKeyAutoMask]
      set res [helper_clz_key_mask_set -p_key_mask $p_key_mask -kargs [array get aIn ]]
  }
  if {$res == 0 } {
      set res [helper_clz_action_set -p_action $p_action -kargs [array get aIn ]]
  }  
     
  #Call sdk api
  if {$res == 0 } {
  #  if {[info exists gwenv(REPORT_LEVEL)] && $gwenv(REPORT_LEVEL) <=1 } {
  #    puts "\n---Debug: Input values:---"
  #    parray aIn
  #    set p_action_option [ca_classifier_action_get_options $p_action]
  #    set p_action_option_mask [ca_classifier_action_option_get_masks $p_action_option]    
  #    puts "\n---Debug: classifier_rule_entry content:---"
  #    catch {ca_classifier_key_dump $p_key} 
  #    puts "\n---Debug: classifier key_mask content:---\n"
  #    catch {ca_classifier_key_mask_dump $p_key_mask}
  #    puts "\n---Debug: classifier action content:---\n"
  #    catch {ca_classifier_action_dump $p_action}  
  #    puts "\n---Debug: classifier action options:---\n"
  #    catch {ca_classifier_action_option_dump $p_action_option}       
  #    puts "\n---Debug: classifier action option masks:---\n"
  #    catch {ca_classifier_action_option_mask_dump $p_action_option_mask}      
   # }
    set cmd [list ca_classifier_rule_add $device_id $priority $p_key $p_key_mask $p_action $p_index]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
    set aOut(-index) [ca_uint32_get $p_index]
  }
  catch {ca_data_free $p_key} err
  catch {ca_data_free $p_key_mask} err
  catch {ca_data_free $p_action} err
  catch {ca_data_free $p_index} err
  
 # helper_parray aOut   
  log -tag itfend
  return $res
}
proc ::gw::helper_classifier_key_parse {args} {
  set ifnm helper_classifier_key_parse
  set res 0 
  set EXT_DATA_MAX_LEN 8 ;#8 bytes
  log -tag itfbgn -msg $args
  set m_key_l {p_key}
  set v_key_l {print_res }
  helper_clz_key_members_declare 
  if {[helper_m_args_check -args $args -m_key_l $m_key_l] } {return 1}
  set aIn(-print_res) 0
  array set aIn $args

  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  catch {array unset aOut} err
  array set aOut ""
  
  foreach key $vClz(in_param_l) {
    set aOut(-$key) unknown
  }   
  set print_res $aIn(-print_res)

  set p_handle [ca_classifier_key_get_key_handle $p_key]
  set p_l2 [ca_classifier_key_get_l2 $p_key]
  set p_ip [ca_classifier_key_get_ip $p_key]
  set p_l4 [ca_classifier_key_get_l4 $p_key]
  set p_l4_src_port [ca_classifier_l4_get_src_port $p_l4 ]
  set p_l4_dst_port [ca_classifier_l4_get_dst_port $p_l4 ]  
  set p_ext [ca_classifier_key_get_ext $p_key]
  
  set p_vlan_otag [ca_classifier_l2_get_vlan_otag $p_l2]
  set p_vlan_itag [ca_classifier_l2_get_vlan_itag $p_l2]
  set p_priority [ca_uint32_create 0]
  
  # Read out parameter value one by one
  set skip_l {}
  foreach key "$vClz(vKey.m)" { 
    if {[lsearch -exact $vClz(vKey.m.spec) $key] >=0 } continue;
    set aOut(-$key) [ca_classifier_key_get_$key $p_key]
    if {$key == "src_port" || $key == "dest_port" } {
      if {$aOut(-$key) ne 0 } {
        set aOut(-$key) [format "0x%05x" $aOut(-$key)]
      }
    }
    if {$key == "src_intf" || $key == "dst_intf"} {
      if {$aOut(-$key) ne 0 } {
        set aOut(-$key) [format "0x%0x" $aOut(-$key)]
      }
    }    
  }
  #set aOut(-handle_type) [ca_classifier_key_get_handle_type $p_key]
  helper_s2h -table CA_CLASSIFIER_HANDLE_TYPE_T -source $aOut(-handle_type) -out aHd
  set aOut(-handle_type_v) $aHd(-target)  
  
  #Get key_handle elements
  foreach key $vClz(vKey.handle.m) {
    set tmpVal [ca_classifier_handle_get_${key} ${p_handle} ]
    if {$tmpVal == 0} {
      set  aOut(-$key) 0
    } else {
      set aOut(-$key) [format "0x%04x" $tmpVal]
    }   
  }    
  #Get L2 elements
  #set skip_l $vClz(vKey.l2.m.spec)
  set skip_l {vlan_otag vlan_itag is_multicast}
  foreach key $vClz(vKey.l2.m) {
    if {[lsearch -exact $skip_l $key] >=0 } continue;     
    if {$key == "mac_sa" || $key == "mac_da" } {
      set p_mac [ca_classifier_l2_get_$key $p_l2]
      foreach range {min max } { 
          set mac_l ""
          set pmac [ca_classifier_mac_addr_range_get_mac_${range} $p_mac]
          for {set i 0 } {$i < 6} {incr i} {
              lappend mac_l [format %02x [ca_mac_addr_get $pmac $i]]      
          }
          if {$range == "min"} {
              set aOut(-${key}_${range}) [join $mac_l :]
              set aOut(-${key}) [join $mac_l :]
          } else {
              set aOut(-${key}_${range}) [join $mac_l :] 
          }
      }
    } elseif {$key == "ethertype" } {
      set aOut(-$key) [format "0x%04x" [ca_classifier_l2_get_${key} $p_l2]]
    } else {        
      set aOut(-$key) [ca_classifier_l2_get_${key} $p_l2]
    }
  }
  set aOut(-l2_is_multicast) [ca_classifier_l2_get_is_multicast $p_l2]
  
  set p_vlan_otag_min [ca_classifier_vlan_range_get_vlan_min ${p_vlan_otag} ]
  set p_vlan_otag_max [ca_classifier_vlan_range_get_vlan_max ${p_vlan_otag} ]
  set p_vlan_itag_min [ca_classifier_vlan_range_get_vlan_min ${p_vlan_itag} ]
  set p_vlan_itag_max [ca_classifier_vlan_range_get_vlan_max ${p_vlan_itag} ] 
  foreach key $vClz(vKey.vlan.m) {
    set aOut(-vlan_otag_$key) [ca_classifier_vlan_get_${key} ${p_vlan_otag_min} ]
    set aOut(-vlan_otag_${key}_max) [ca_classifier_vlan_get_${key} ${p_vlan_otag_max}]
    set aOut(-vlan_itag_$key) [ca_classifier_vlan_get_${key} ${p_vlan_itag_min} ]
    set aOut(-vlan_itag_${key}_max) [ca_classifier_vlan_get_${key} ${p_vlan_itag_max}]      
  }
    
  #Get IP
  set skip_l {is_multicast}
  foreach key $vClz(vKey.ip.m) {
    if {[lsearch -exact $skip_l $key] >=0 } continue; 
    if {$key == "ip_sa" || $key == "ip_da" || $key == "ip_sa_max" || $key == "ip_da_max" } {
      set pl3ip [ca_classifier_ip_get_$key $p_ip]
      set res [helper_ca_ip_address_entry_parse -ref $pl3ip -out aTmp]
      if {$res == 0 } {
        set aOut(-$key) $aTmp(-ip_addr)
      }
    } else {
      set aOut(-$key) [ca_classifier_ip_get_${key} $p_ip]
    }
  } 
  set aOut(-l3_is_multicast) [ca_classifier_ip_get_is_multicast $p_ip]
    
  #Get L4
  set skip_l {src_port dst_port}
  foreach key $vClz(vKey.l4.m) { 
    if {[lsearch -exact $skip_l $key] >=0 } continue; 
    set aOut(-$key) [ca_classifier_l4_get_${key} $p_l4 ] 
  }
  foreach key [list src_port dst_port] {
    set pref "l4_${key}_"
    foreach rang $vClz(vKey.l4.port.range) {
      set aOut(-${pref}${rang}) [ca_classifier_l4_port_range_get_$rang [set p_l4_$key]]
    }
  }
   
  #Get extension data
  set pref "ext_"
  set ext_len [ca_classifier_ext_get_length $p_ext]
  set ext_offset [ca_classifier_ext_get_offset $p_ext]
  #set aOut(-ext_len) $ext_len
  set aOut(-ext_length) $ext_len
  set aOut(-ext_offset) $ext_offset
  foreach key {data mask} {
    set data_lst ""
    for {set i 0 } {$i < $EXT_DATA_MAX_LEN} {incr i} {
      lappend data_lst [format %02x [ca_classifier_ext_get_${key} $p_ext $i]]
    }
    set aOut(-ext_$key) $data_lst
  }
  if {[llength [info commands ca_classifier_ext_get_starting_location]]} {
    #patch for saturn kt, 20190401.saturn kt currently does not support this config
    set aOut(-ext_starting_location) [ca_classifier_ext_get_starting_location $p_ext]
    helper_s2h -table CA_CLASSIFIER_KEY_OFFSET_START_T -source $aOut(-ext_starting_location) -out aH
    set aOut(-ext_starting_location_v) $aH(-target)
  } 
  if {$print_res} { helper_parray aOut}
  log -tag itfend
  return $res
}
proc ::gw::helper_classifier_key_mask_parse {args} {
  set ifnm helper_classifier_key_mask_parse
  set res 0 
  log -tag itfbgn -msg $args
  set m_key_l {p_key_mask}
  set v_key_l {print_res out }
  helper_clz_key_mask_members_declare 
  if {[helper_m_args_check -args $args -m_key_l $m_key_l] } {return 1}
  set aIn(-print_res) 0
  array set aIn $args

  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  catch {array unset aOut} err
  array set aOut ""
  
  foreach key $vClz(in_param_l) {
    set aOut(-$key) unknown
  }  
  
  set print_res $aIn(-print_res)

  set p_l2_mask [ca_classifier_key_mask_get_l2_mask $p_key_mask]
  set p_ip_mask [ca_classifier_key_mask_get_ip_mask $p_key_mask]
  set p_l4_mask [ca_classifier_key_mask_get_l4_mask $p_key_mask]
  set p_vlan_otag_mask [ca_classifier_l2_mask_get_vlan_otag_mask $p_l2_mask ]
  set p_vlan_itag_mask [ca_classifier_l2_mask_get_vlan_itag_mask $p_l2_mask ]
  
  set skip_l {l2_mask ip_mask l4_mask}
  foreach key $vClz(vKey.msk.m) {
    if {[lsearch -exact $skip_l $key] >=0 } continue;
    if {[string first "packet_length_" $key] == 0 } {
      set aOut(-mask_packet_length) [ca_classifier_key_mask_get_packet_length $p_key_mask]
      continue
    }
    set aOut(-mask_$key) [ca_classifier_key_mask_get_$key $p_key_mask ]
  }  
  set skip_l {vlan_otag_mask vlan_itag_mask is_multicast}
  foreach key "$vClz(vKey.msk.l2.m)" {
    if {[lsearch -exact $skip_l $key] >=0 } continue;
    set aOut(-mask_$key) [ca_classifier_l2_mask_get_$key $p_l2_mask ]
  }
  set aOut(-mask_vlan_otag) [ca_classifier_l2_mask_get_vlan_otag $p_l2_mask ]
  set aOut(-mask_vlan_itag) [ca_classifier_l2_mask_get_vlan_itag $p_l2_mask ]
  set aOut(-mask_l2_is_multicast) [ca_classifier_l2_mask_get_is_multicast $p_l2_mask]
 
  foreach key $vClz(vKey.msk.vlan.m) {
    set aOut(-mask_vlan_otag_$key) [ca_classifier_vlan_mask_get_$key $p_vlan_otag_mask ]
  }
  foreach key $vClz(vKey.msk.vlan.m) {
    set aOut(-mask_vlan_itag_$key) [ca_classifier_vlan_mask_get_$key $p_vlan_itag_mask ]
  }      
  
  set skip_l {is_multicast dscp_mask}  
  foreach key $vClz(vKey.msk.ip.m) {
   if {[lsearch -exact $skip_l $key] >=0 } continue;
   set aOut(-mask_$key) [ca_classifier_ip_mask_get_$key $p_ip_mask ]
  } 
  set aOut(-mask_l3_is_multicast) [ca_classifier_ip_mask_get_is_multicast $p_ip_mask]
  
  set skip_l {src_port dst_port}
  foreach key $vClz(vKey.msk.l4.m) {
    if {[lsearch -exact $skip_l $key] >=0 } continue;
    set aOut(-mask_$key) [ca_classifier_l4_mask_get_$key $p_l4_mask ]
  }
  foreach key {src_port dst_port} {
    set pref "l4_"        
    set aOut(-mask_$pref$key) [ca_classifier_l4_mask_get_$key $p_l4_mask ]
  }
  if {$print_res} { helper_parray aOut}
  log -tag itfend
  return $res
}
proc ::gw::helper_classifier_action_parse {args} {
  set ifnm helper_classifier_action_parse
  set res 0 
  set EXT_DATA_MAX_LEN 8 ;#8 bytes
  log -tag itfbgn -msg $args
  set m_key_l { p_action}
  set v_key_l {print_res }
  helper_clz_action_members_declare 
  if {[helper_m_args_check -args $args -m_key_l $m_key_l] } {return 1}
  set aIn(-print_res) 0
  array set aIn $args

  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  catch {array unset aOut} err
  array set aOut ""
  
  foreach key $vClz(in_param_l) {
    set aOut(-$key) unknown
  }  
  set print_res $aIn(-print_res)

  set p_action_dest [ca_classifier_action_get_dest $p_action] ;# to be checked
  set p_action_option [ca_classifier_action_get_options $p_action]
  set p_action_option_action_handle [ca_classifier_action_option_get_action_handle $p_action_option]
  set p_action_option_mask [ca_classifier_action_option_get_masks $p_action_option]

  foreach key $vClz(vAct.m) {
    set pref "action_"
    set aOut(-$pref$key) [ca_classifier_action_get_${key} $p_action]
    if {$key eq "forward"} {
      helper_s2h -table CA_CLASSIFIER_FORWARD_FLAG_T -source $aOut(-action_forward) -out aH
      set aOut(-action_forward_v) $aH(-target)
    }
  }
  foreach key $vClz(vAct.dest.m) {
    set pref "action_dest_"
    set aOut(-${pref}$key) [ca_classifier_action_dest_get_${key} $p_action_dest ]
    if {$key == "intf" || $key == "port" || $key == "tunnel_id"}  {
      set tmpVal [format "0x%04x" $aOut(-${pref}$key) ]
      if {$tmpVal == 0} {
        set  aOut(-${pref}$key) 0
      } else {
        set aOut(-${pref}$key) [format "0x%04x" $tmpVal]
      }
    }
    if {$key == "fe" } {
      helper_s2h -table CA_CLASSIFIER_ACTION_DEST_FE_T -source $aOut(-${pref}fe) -out aH
      set aOut(-${pref}fe_v) $aH(-target)
    }
  }  
  #action option
  set skip_l {masks action_handle}
  foreach key $vClz(vAct.option.m) {
    if {[lsearch -exact $skip_l $key] >=0 } continue; 
    set pref "action_option_"
    if {$key == "sw_id"} {
      set sw_id_l ""
      for {set i 0 } {$i < 4} {incr i} {
        lappend sw_id_l [ca_classifier_action_option_get_sw_id $p_action_option $i]
      }
      set aOut(-${pref}sw_id) [join $sw_id_l "."]
    } elseif {$key == "mac_da" } {
      set mac_l ""
      set pmac [ca_classifier_action_option_get_mac_da $p_action_option]
      for {set i 0 } {$i < 6} {incr i} {
        lappend mac_l [format %02x [ca_mac_addr_get $pmac $i]]
      }
      set aOut(-${pref}mac_da) [join $mac_l :]       
    } elseif {$key == "inner_tpid" || $key == "outer_tpid"} {
      set tmpVal [ca_classifier_action_option_get_${key} $p_action_option ]
      if {$tmpVal == 0} {
        set  aOut(-${pref}${key}) 0
      } else {
        set aOut(-${pref}${key}) [format "%04x" $tmpVal]
      }
    } else {
      set aOut(-${pref}${key}) [ca_classifier_action_option_get_${key} $p_action_option ]
    } 
    if {$key == "handle_type"} {
      helper_s2h -table CA_CLASSIFIER_HANDLE_TYPE_T -source $aOut(-${pref}${key}) -out aH
      set aOut(-${pref}${key}_v) $aH(-target)
    } 
    if {$key == "inner_vlan_act" || $key == "outer_vlan_act"} {
      helper_s2h -table CA_CLASSIFIER_VLAN_ACTION_T -source $aOut(-${pref}${key}) -out aH
      set aOut(-${pref}${key}_v) $aH(-target)    
    }
  }
  
  foreach key $vClz(vAct.option.handle.m) {
    set pref "action_option_"
    set tmpVal [ca_classifier_handle_get_${key} $p_action_option_action_handle ]
    if {$tmpVal == 0} {
      set  aOut(-${pref}${key}) 0
    } else {
      set aOut(-${pref}${key}) [format "0x%04x" $tmpVal]
    }
  }  
 
  foreach key $vClz(vAct.msk.option.m) {
    set pref "action_option_"
    if {$key == "inner_vid" || $key == "outer_vid" || $key == "handle_type" } {continue}
    set aOut(-mask_$pref$key) [ca_classifier_action_option_mask_get_$key $p_action_option_mask ]
  } 
  if {$print_res} { helper_parray aOut}
  log -tag itfend
  return $res
}
proc ::gw::helper_classifier_rule_parse {args} {
  set ifnm helper_classifier_rule_parse
  set res 0 
  log -tag itfbgn -msg $args
  set m_key_l {p_key p_key_mask p_action}
  set v_key_l {exp_args print_res supress_zero_mask }
  if {[helper_m_args_check -args $args -m_key_l $m_key_l] } {return 1}
  set aIn(-exp_args) DONTCARE
  set aIn(-print_res) 0
  set aIn(-supress_zero_mask) 0
  array set aIn $args

  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aVar
  catch {array unset aVar} err
  array set aVar ""
  
  set exp_args  $aIn(-exp_args)
  set print_res $aIn(-print_res)
  set supress_zero_mask $aIn(-supress_zero_mask)

  array set aKeyValues {}
  helper_classifier_key_parse -p_key $p_key -out aKeyValues 
  array set aOut [array get aKeyValues]
  
  array set aKeyMask {}
  helper_classifier_key_mask_parse -p_key_mask $p_key_mask -out aKeyMask 
  array set aOut [array get aKeyMask]
  
  array set aActionValues {}
  helper_classifier_action_parse  -p_action $p_action -out aActionValues
  array set aOut [array get aActionValues]    

  #Filter output args according to exp_args list
  array set aVar {}
  if {[string toupper $exp_args] eq "DONTCARE" || [llength $exp_args] == 0 } {
    array set aVar [array get aOut]
  } else {
    foreach okey [array names aOut] { 
      set okey [string trimleft $okey "-"]
      if {[lsearch $exp_args $okey] < 0 } {continue}
      set aVar(-$okey) $aOut(-$okey)
    }
  }
  if {$supress_zero_mask} {    
    foreach msk [array names aVar {-mask_*}] {
      if {$aVar($msk) == 0 } {
          unset aVar($msk)
      }
    }
  }
  if {[info exists aVar(-l4_src_port_min)]} {
    set aVar(-l4_src_port) $aVar(-l4_src_port_min)
  }
  if {[info exists aVar(-l4_dst_port_min)]} {
    set aVar(-l4_dst_port) $aVar(-l4_dst_port_min)
  }
  if {$print_res} { helper_parray aVar}
  log -tag itfend
  return $res
}
proc ::gw::wca_classifier_rule_get {args} {
  set docStr "
    exp_args:  expected variables to be returned and printed.
    supress_zero_mask: only return nonzero mask.
    
  "
  variable gwenv
  set ifnm wca_classifier_rule_get
  set res 0 
  set EXT_DATA_MAX_LEN 8 ;#8 bytes
  log -tag itfbgn -msg $args
  set m_key_l {device_id index }
  set v_key_l {exp_args supress_zero_mask}
  #helper_classifier_rule_args -operation get  
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-exp_args) DONTCARE
  set aIn(-supress_zero_mask) 0
  array set aIn $args
  set exp_args $aIn(-exp_args)
  set supress_zero_mask $aIn(-supress_zero_mask)
  helper_output_declare aIn
  helper_output_init aOut "priority"
  
  set p_key [ca_classifier_key_create ]   
  set p_key_mask [ca_classifier_key_mask_create] 
  set p_action [ca_classifier_action_create]  
  set p_priority [ca_uint32_create 0]
  if {$res == 0 } {
    set cmd [list ca_classifier_rule_get $device_id $index $p_priority $p_key $p_key_mask $p_action]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    if {[info exists gwenv(REPORT_LEVEL)] && $gwenv(REPORT_LEVEL) <=1 } {
      puts "------------DUMP DATA---------------------"    
      puts "***** key: *****"
      ca_classifier_key_dump $p_key
      puts "***** key mask: *****"
      ca_classifier_key_mask_dump $p_key_mask
      puts "***** action: *****"
      ca_classifier_action_dump $p_action
      puts "---------------------------------------------"
    }  
    set res [helper_classifier_rule_parse -p_key $p_key -p_key_mask $p_key_mask -p_action $p_action -exp_args $exp_args -supress_zero_mask $supress_zero_mask -out aOut] 
    set aOut(-priority) [ca_uint32_get $p_priority]
  }

  catch {ca_data_free $p_key} err
  catch {ca_data_free $p_priority} err
  catch {ca_data_free $p_key_mask} err
  catch {ca_data_free $p_action} err
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_classifier_rule_get_all {args} {
  global errorInfo  
  set ifnm wca_classifier_rule_get_all
  set docStr "
  Usage:  $ifnm ?-src_port src_port? ?-exp_args {expected argument list}?
    exp_args:  expected fields to show in table.
               e.g. -exp_args {src_port flow_id}. This will be only show two fields 
               'src_port' and 'flow_id', which can make the displayed table more clear
    print_res: 0/1. whether to print classifier rule table or not. default is 1              
    cpi:       count per iterate. default is 2, means every iterate returns 2 entries. 
    supress_zero_mask: only return nonzero mask.
            
    "   
  set res 0  
  set EXT_DATA_MAX_LEN 8 ;#8 bytes
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l {exp_args src_port print_res cpi}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-exp_args) DONTCARE
  set aIn(-src_port) DONTCARE
  set aIn(-print_res) 1
  set aIn(-cpi) 2
  set aIn(-supress_zero_mask) 0
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut 
  set cpi $aIn(-cpi)
  set exp_args [string tolower [string trim $aIn(-exp_args)]]
  set print_res $aIn(-print_res)
  set supress_zero_mask $aIn(-supress_zero_mask)
  
  set aTmp(-iterator_pointer) NULL    
  set idx 0
  for {set max 0} {$max < 2000 && $res == 0} {incr max} {
    set res [helper_iterate -device_id $device_id \
      -data_type ca_classifier_rule_t\
      -iterate_func ca_classifier_rule_iterate \
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]            
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    }
    foreach npdx $aTmp(-element_data_pointers) {
      catch {array unset aVars} ignore
      array set aVars ""
      set p_key [ca_classifier_rule_get_key $npdx]
      
      #If src_port is provided as a filter condition, then match element's src_port 
      if {[info exists aIn(-src_port)] && 
          [string compare [string toupper $aIn(-src_port)] "DONTCARE"] } {
         set sys_port_id [ca_classifier_key_get_src_port $p_key]
         if {$sys_port_id  == $aIn(-src_port)} {
         } else {
             log -tag debug -msg "skip one cls rule on port [format 0x%05x $sys_port_id]"
             continue
         } 
      }      
      set p_key_mask [ca_classifier_rule_get_key_mask $npdx]
      set p_action   [ca_classifier_rule_get_action $npdx]
      set res [helper_classifier_rule_parse -p_key $p_key -p_key_mask $p_key_mask -p_action $p_action -exp_args $exp_args -supress_zero_mask $supress_zero_mask -out aVars]       
      set aVars(-priority) [ca_classifier_rule_get_priority $npdx]
      set aVars(-index)    [ca_classifier_rule_get_index $npdx]     
      set aOut($idx) [array get aVars]
      incr idx
    } 
  }
  if {$max >= 2000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  } 
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {$print_res} {
    puts "\nTotal Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_classifier_rule_delete {args} {
  set ifnm wca_classifier_rule_delete
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id index  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  if {$res == 0 } {
    set cmd "ca_classifier_rule_delete $device_id $index"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
 
  log -tag itfend
  return $res
}
proc ::gw::wca_classifier_rule_delete_all {args} {
  set ifnm wca_classifier_rule_delete_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  if {$res == 0 } {
    set cmd "ca_classifier_rule_delete_all $device_id "
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  log -tag itfend
  return $res
}
proc ::gw::wca_classifier_port_default_action_set {args} {
  set ifnm wca_classifier_port_default_action_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id port_id}
  set v_key_l {action_type dest_port dest_intf dest_drop dest_fe }
  if {[is_struct_field -struct ca_classifier_action_dest -member tunnel_id]} {
    lappend v_key_l dest_tunnel_id
  }
  if {[is_struct_field -struct ca_classifier_action_dest -member no_drop]} {
    lappend v_key_l dest_no_drop
  }    
  set aIn(-data_init) 1
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args  
  set data_init $aIn(-data_init)
  
  set cmd "ca_classifier_default_action_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
 
  if {$res == 0} {
    set pt $aTmp(-err)
    if {$data_init == 1 } {
      #Initialize data structure with current system values
      set res [ca_classifier_port_default_action_get $device_id $port_id $pt]
    }
  }
  if {$res == 0 } {
    set pd [ca_classifier_default_action_get_dest $pt]
    #Configure the structure with input values. Ignore those "dontcare" elements.
    foreach var $v_key_l {
      if {[info exists aIn(-$var)] && [string compare [string tolower $aIn(-$var)] "dontcare"]} {
        if {[string first "dest_" $var] >= 0} {
          set cmd "ca_classifier_action_dest_set_[string range $var 5 end] $pd $aIn(-$var)"
        } else {
          if {$var == "action_type"} {
              helper_h2s -table CA_CLASSIFIER_FORWARD_FLAG_T -source $aIn(-action_type) -out aH
              set aIn(-action_type) $aH(-target)
          }
          set cmd "ca_classifier_default_action_set_$var $pt $aIn(-$var)"
        }
        set res [helper_cmd_exec -cmd $cmd]
        if {$res} {
          break
        }
      }
    }
  }
  if {$res == 0 } {
    set cmd [list ca_classifier_port_default_action_set $device_id $port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]    
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}
proc ::gw::wca_classifier_port_default_action_get {args} {
  set ifnm wca_classifier_port_default_action_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id port_id}
  set v_out_key_l {action_type}
  set v_out_dest_key_l {drop fe port intf }
  if {[is_struct_field -struct ca_classifier_action_dest -member tunnel_id]} {
    lappend v_out_dest_key_ tunnel_id
  }
  if {[is_struct_field -struct ca_classifier_action_dest -member no_drop]} {
    lappend v_out_dest_key_l no_drop
  }    
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_out_key_l 
  set cmd "ca_classifier_default_action_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
 
  if {$res == 0} {
    set pt $aTmp(-err)
    set pd [ca_classifier_default_action_get_dest $pt]
  }

  if {$res == 0} {
    set cmd [list ca_classifier_port_default_action_get $device_id $port_id  $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
    if {$res == 0} {
      foreach key $v_out_key_l {
          set aOut(-$key) [ca_classifier_default_action_get_$key $pt]
      }
      foreach key $v_out_dest_key_l {
          set aOut(-dest_$key) [format 0x%02x [ca_classifier_action_dest_get_$key $pd] ]
      }      
    }
  }    
  helper_s2h -table CA_CLASSIFIER_FORWARD_FLAG_T -source $aOut(-action_type) -out aH
  set aOut(-action_type_v) $aH(-target)
  
  catch {ca_data_free $pR} err
  helper_parray aOut
  log -tag itfend
  return $res
}
#---------------------------------------
#Section: Flow Management
#---------------------------------------
proc ::gw::helper_ca_flow_key_type_entry_config {args } {
  set ifnm helper_flow_key_type_entry_config 
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  #set m_key_l {device_id }
  set v_o_key_l {key_type prio }

  set v_mask_l      [helper_probe_struct_members -struct  ca_flow_key_mask -exclude_list {l2_mask l3_mask l4_mask}]
  set v_l2_mask_l   [helper_probe_struct_members -struct  ca_flow_key_l2_mask -exclude_list {outer_vlan inner_vlan}]
  set v_vlan_mask_l [helper_probe_struct_members -struct  ca_classifier_vlan ]
  set v_l3_mask_l   [helper_probe_struct_members -struct  ca_flow_key_l3_mask ]
  set v_l4_mask_l   [helper_probe_struct_members -struct  ca_flow_key_l4_mask ]
 
  set v_key_l $v_o_key_l
  foreach elm $v_mask_l {
    lappend v_key_l mask_$elm
  }
  foreach elm $v_l2_mask_l {
    lappend v_key_l l2mask_$elm
  }
  foreach elm $v_vlan_mask_l {
    lappend v_key_l l2mask_outer_vlan_$elm
  }
  foreach elm $v_vlan_mask_l {
    lappend v_key_l l2mask_inner_vlan_$elm
  }
  foreach elm $v_l3_mask_l {
    lappend v_key_l l3mask_$elm
  }
  foreach elm $v_l4_mask_l {
    lappend v_key_l l4mask_$elm
  }    
  array set aParam $args
  set res [helper_m_args_check -args $aParam(-args)]
  if {$res} {
    return $res
  } 

  array set aIn $aParam(-args)  
  set key_type [string toupper $aIn(-key_type)]
  set pt $aParam(-refer)
  set pt_key_mask [ca_flow_key_type_config_get_key_mask $pt]
  set pt_l2_key_mask [ca_flow_key_mask_get_l2_mask $pt_key_mask]
  set pt_l2_outer_vlan_key_mask [ca_flow_key_l2_mask_get_outer_vlan $pt_l2_key_mask]
  set pt_l2_inner_vlan_key_mask [ca_flow_key_l2_mask_get_inner_vlan $pt_l2_key_mask]
  set pt_l3_key_mask [ca_flow_key_mask_get_l3_mask $pt_key_mask]
  set pt_l4_key_mask [ca_flow_key_mask_get_l4_mask $pt_key_mask]
  
  foreach elm $v_o_key_l {
    if {$res == 0 } {
       set pre ""
       if {[info exists aIn(-$elm)] && 
         [string compare [string tolower $aIn(-$elm)] "dontcare"] } { 
         set cmd "ca_flow_key_type_config_set_$elm $pt $aIn(-$elm)"
         set res [helper_cmd_exec -cmd $cmd]
       }
     }
  } 
  foreach elm $v_mask_l {
    if {$res == 0 } {
       set pelm mask_$elm
       if {[info exists aIn(-$pelm)] && 
         [string compare [string tolower $aIn(-$pelm)] "dontcare"] } { 
         set cmd "ca_flow_key_mask_set_$elm $pt_key_mask $aIn(-$pelm)"
         set res [helper_cmd_exec -cmd $cmd]
       }
     }
  }  
  foreach elm $v_l2_mask_l {
    if {$res == 0 } {
       set pelm l2mask_$elm
       if {[info exists aIn(-$pelm)] && 
         [string compare [string tolower $aIn(-$pelm)] "dontcare"] } { 
         set cmd "ca_flow_key_l2_mask_set_$elm $pt_l2_key_mask $aIn(-$pelm)"
         set res [helper_cmd_exec -cmd $cmd]
       }
     } 
  }
  foreach elm $v_vlan_mask_l {
    if {$res == 0 } {
       set pelm l2mask_outer_vlan_$elm
       if {[info exists aIn(-$pelm)] && 
         [string compare [string tolower $aIn(-$pelm)] "dontcare"] } { 
         set cmd "ca_classifier_vlan_mask_set_$elm $pt_l2_outer_vlan_key_mask $aIn(-$pelm)"
         set res [helper_cmd_exec -cmd $cmd]
       }
     }
  }  
  foreach elm $v_vlan_mask_l {
    if {$res == 0 } {
       set pelm l2mask_inner_vlan_$elm
       if {[info exists aIn(-$pelm)] && 
         [string compare [string tolower $aIn(-$pelm)] "dontcare"] } { 
         set cmd "ca_classifier_vlan_mask_set_$elm $pt_l2_inner_vlan_key_mask $aIn(-$pelm)"
         set res [helper_cmd_exec -cmd $cmd]
       }
     } 
  } 
  foreach elm $v_l3_mask_l {
    if {$res == 0 } {
       set pelm l3mask_$elm
       if {[info exists aIn(-$pelm)] && 
         [string compare [string tolower $aIn(-$pelm)] "dontcare"] } { 
         set cmd "ca_flow_key_l3_mask_set_$elm $pt_l3_key_mask $aIn(-$pelm)"
         set res [helper_cmd_exec -cmd $cmd]
       }
     }
  }  
  foreach elm $v_l4_mask_l {
    if {$res == 0 } {
       set pelm l4mask_$elm
       if {[info exists aIn(-$pelm)] && 
         [string compare [string tolower $aIn(-$pelm)] "dontcare"] } { 
         if {[is_struct_field -struct ca_flow_key_l4_mask -member dst_l4_port] } {
           set elm dst_l4_port
         } else {
           set elm dest_l4_port
         }  
         set cmd "ca_flow_key_l4_mask_set_$elm $pt_l4_key_mask $aIn(-$pelm)"
         set res [helper_cmd_exec -cmd $cmd]
       }
     }
  }
  if {$gw::gwenv(REPORT_LEVEL) <= 1 } {
    puts "---DEBUG: dump data of ca_flow_key_type_t---"
    ca_flow_key_type_config_dump $pt
    puts "------------------"
  }
  log -tag itfend
  return $res    
}
proc ::gw::helper_ca_flow_key_type_entry_parse {args} {
  set ifnm wca_flow_key_type_get
  set res 0
  log -tag itfbgn -msg $args
  
  #set m_key_l {device_id key_type}
  set v_o_key_l {key_type prio }
  set v_mask_l      [helper_probe_struct_members -struct  ca_flow_key_mask -exclude_list {l2_mask l3_mask l4_mask}]
  set v_l2_mask_l   [helper_probe_struct_members -struct  ca_flow_key_l2_mask -exclude_list {outer_vlan inner_vlan}]
  set v_vlan_mask_l [helper_probe_struct_members -struct  ca_classifier_vlan ]
  set v_l3_mask_l   [helper_probe_struct_members -struct  ca_flow_key_l3_mask ]
  set v_l4_mask_l   [helper_probe_struct_members -struct  ca_flow_key_l4_mask ]
 
  array set aParam $args
  set pt $aParam(-refer)
  array set aIn $aParam(-args)
  helper_output_declare aParam
  helper_output_init aOut $v_o_key_l 
  if {$res == 0 && [info exists aIn(-key_type)] && 
         [string compare [string tolower $aIn(-key_type)] "dontcare"] } {
    set cmd "ca_flow_key_type_config_set_key_type $pt $aIn(-key_type)"
    set res [helper_cmd_exec -cmd $cmd]
  }

#  if {$res == 0} {
#    set cmd [list ca_flow_key_type_get $device_id  $pt]
#    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]
#    
#  }
#  if {$res == 0} {
#      foreach key $v_o_key_l {
#          set aOut(-$key) [ca_flow_key_type_config_get_$key $pt]
#      } 
#  }  
  set pt_key_mask [ca_flow_key_type_config_get_key_mask $pt]
  set pt_l2_key_mask [ca_flow_key_mask_get_l2_mask $pt_key_mask]
  set pt_l2_outer_vlan_key_mask [ca_flow_key_l2_mask_get_outer_vlan $pt_l2_key_mask]
  set pt_l2_inner_vlan_key_mask [ca_flow_key_l2_mask_get_inner_vlan $pt_l2_key_mask]
  set pt_l3_key_mask [ca_flow_key_mask_get_l3_mask $pt_key_mask]
  set pt_l4_key_mask [ca_flow_key_mask_get_l4_mask $pt_key_mask]
  if {$res == 0 } { 
    foreach elm $v_mask_l {    
       set pelm mask_$elm
       set aOut(-$pelm) [ca_flow_key_mask_get_$elm $pt_key_mask]
    }
  
    foreach elm $v_l2_mask_l {
       set pelm l2mask_$elm
       set aOut(-$pelm)  [ca_flow_key_l2_mask_get_$elm $pt_l2_key_mask ]

    }
    foreach elm $v_vlan_mask_l {
       set pelm l2mask_outer_vlan_$elm
       set aOut(-$pelm)  [ca_classifier_vlan_mask_get_$elm $pt_l2_outer_vlan_key_mask ]

    }  
    foreach elm $v_vlan_mask_l {
       set pelm l2mask_inner_vlan_$elm    
       set aOut(-$pelm)  [ca_classifier_vlan_mask_get_$elm $pt_l2_inner_vlan_key_mask]

    } 
    foreach elm $v_l3_mask_l {
      set pelm l3mask_$elm
       set aOut(-$pelm)  [ca_flow_key_l3_mask_get_$elm $pt_l3_key_mask ]
    }
  
    foreach elm $v_l4_mask_l {    
       set pelm l4mask_$elm
       if {$elm == "dst_l4_port"} {
         #Patch for name changes dst_port to dest_l4_port then to dst_l4_port
         if {[is_struct_field -struct ca_flow_key_l4_mask -member dst_l4_port]} {
           set elm dst_l4_port
         } else {
           set elm dest_l4_port
         }
       }
       set aOut(-$pelm)  [ca_flow_key_l4_mask_get_$elm $pt_l4_key_mask]
    }
  }    
  log -tag itfend
  return $res   
}
proc ::gw::helper_ca_flow_entry_config_obsolete {args } {
  set ifnm helper_ca_flow_entry_config
  global errorInfo
  variable CA_FLOW_VLAN_ACTION_T
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }
  set v_o_key_l {key_type aging_time }
  #flow_key_t:
  set v_flow_key_l {sw_id flow_id } ;#sw_id  
  set v_flow_key_l2_l [helper_probe_struct_members -struct  ca_flow_key_l2 -exclude_list {outer_vlan inner_vlan mac_sa_range mac_da_range}]
  lappend v_flow_key_l2_l  mac_sa_range_min mac_sa_range_max mac_da_range_min mac_da_range_max
  set v_vlan_l   [helper_probe_struct_members -struct  ca_classifier_vlan ]
  set v_flow_key_l3_l   [helper_probe_struct_members -struct  ca_flow_key_l3]
  set v_flow_key_l4_l   [helper_probe_struct_members -struct  ca_flow_key_l4]  

  #flow_action_t:
  set v_flow_action_l {forward} ;#CA_CLASSIFIER_FORWARD_DENY,FE,INTERFACE,PORT 
  set v_flow_action_dest_l   [helper_probe_struct_members -struct  ca_classifier_action_dest] 
  set v_flow_action_option_l [helper_probe_struct_members -struct ca_flow_action_option -exclude_list {masks}] ;#mac,ip, sw_id
  set v_flow_action_option_mask_l [helper_probe_struct_members -struct ca_flow_action_option_mask]
 
  #generate input argument list
  set v_key_l "$v_o_key_l $v_flow_key_l $v_flow_key_l2_l"
 
  foreach e $v_vlan_l {
    lappend v_key_l outer_$e ;#prefix "outer_"
  }
  foreach e $v_vlan_l {
    lappend v_key_l inner_$e ;#prefix "inner_"
  } 
  set v_key_l "$v_key_l $v_flow_key_l3_l $v_flow_key_l4_l"
  
  foreach e $v_flow_action_l {
    lappend v_key_l act_$e ;#prefix "act_"
  }
  foreach e $v_flow_action_dest_l {
    lappend v_key_l act_dest_$e ;#prefix "act_dest_"
  } 
  foreach e "$v_flow_action_option_l" {
    lappend v_key_l act_opt_$e ;#prefix "act_opt_"
  }  
  foreach e $v_flow_action_option_mask_l {
    lappend v_key_l act_opt_msk_$e   ;#prefix "act_opt_msk_"
  }
  
  if {[catch {array set aParam $args} err]} {
    log -tag error -msg "$err. $errorInfo"    
    return -1
  }    
  set res [helper_m_args_check -args $aParam(-args) -m_key_l $m_key_l]
  if {$res} {
    return $res
  }

  set aIn(-act_opt_inner_vlan_act) dontcare
  set aIn(-act_opt_outer_vlan_act) dontcare
  array set aIn $aParam(-args)
    
  helper_h2s -source [string toupper $aIn(-act_opt_inner_vlan_act)] -table CA_FLOW_VLAN_ACTION_T -out aX
  set aIn(-act_opt_inner_vlan_act) $aX(-target)

  helper_h2s -source [string toupper $aIn(-act_opt_outer_vlan_act)] -table CA_FLOW_VLAN_ACTION_T -out aX
  set aIn(-act_opt_outer_vlan_act) $aX(-target)

  set pt $aParam(-refer)
  if {$res == 0 } {    
    set pt_flow_key [ca_flow_get_key $pt]
    set pt_flow_key_l2   [ca_flow_key_get_l2_key $pt_flow_key]
    set pt_flow_key_l2_outer_vlan [ca_flow_key_l2_get_outer_vlan $pt_flow_key_l2]
    set pt_flow_key_l2_inner_vlan [ca_flow_key_l2_get_inner_vlan $pt_flow_key_l2]
    
    set pt_flow_key_l3 [ca_flow_key_get_l3_key $pt_flow_key]
    set pt_flow_key_l4 [ca_flow_key_get_l4_key $pt_flow_key]    
    
    set pt_flow_action [ca_flow_get_actions $pt]
    set pt_flow_action_dest [ca_flow_action_get_dest $pt_flow_action]
    set pt_flow_action_option [ca_flow_action_get_options $pt_flow_action]
    set pt_flow_action_option_masks [ca_flow_action_option_get_masks $pt_flow_action_option]
  }  
  foreach elm $v_o_key_l {
    if {$res} { break}
    if {[info exists aIn(-$elm)] && 
       [string compare [string tolower $aIn(-$elm)] "dontcare"] } { 
       set cmd "ca_flow_set_$elm $pt $aIn(-$elm)"
       set res [helper_cmd_exec -cmd $cmd]
    }   
  }  
  foreach elm $v_flow_key_l {
    if {$res} { break}
    if {[info exists aIn(-$elm)] && 
      [string compare [string tolower $aIn(-$elm)] "dontcare"] } {
      if {$elm == "sw_id"} {
        set sw_id_l [split $aIn(-sw_id) "."]
        for {set i 0 } {$i < 4} {incr i} {
          set cmd "ca_flow_key_set_sw_id $pt_flow_key [lindex $sw_id_l $i] $i"
          set res [helper_cmd_exec -cmd $cmd]
        }  
        continue
      } 
      set cmd "ca_flow_key_set_$elm $pt_flow_key $aIn(-$elm)"
      set res [helper_cmd_exec -cmd $cmd]
    }   
  } 
  #l2
  foreach elm $v_flow_key_l2_l {
    if {$res} {break}
    if {[info exists aIn(-$elm)] == 0 ||  
      [string compare [string tolower $aIn(-$elm)] "dontcare"] == 0 } { 
      continue
    }    
    if {[regexp {mac_(da|sa)} $elm skip dir] > 0 } {
      set mac_l [split $aIn(-$elm) :]
      set new_mac_l ""
      foreach mac $mac_l {
        lappend new_mac_l 0x$mac
      }
      if {[regexp {range_(max|min)} $elm skip type] > 0 } {
        set prange [ca_flow_key_l2_get_mac_${dir}_range $pt_flow_key_l2]      
        set cmd "ca_mac_addr_set [ca_classifier_mac_addr_range_get_mac_${type} $prange] $new_mac_l"
      } else {
        set cmd "ca_mac_addr_set [ca_flow_key_l2_get_mac_${dir} $pt_flow_key_l2] $new_mac_l"
      }
    } else {
      set cmd "ca_flow_key_l2_set_$elm $pt_flow_key_l2 $aIn(-$elm)"
    }
    set res [helper_cmd_exec -cmd $cmd]     
  }
  #l2 vlan
  foreach elm $v_vlan_l {
    set pe "inner_$elm"
    if {$res} {break}
     if {[info exists aIn(-$pe)] && 
      [string compare [string tolower $aIn(-$pe)] "dontcare"] } {
      set cmd "ca_classifier_vlan_set_$elm $pt_flow_key_l2_inner_vlan $aIn(-$pe)"
     set res [helper_cmd_exec -cmd $cmd]            
    }   
  }
  foreach elm $v_vlan_l {
    set pe "outer_$elm"
    if {$res} {break}
     if {[info exists aIn(-$pe)] && 
      [string compare [string tolower $aIn(-$pe)] "dontcare"] } {
      set cmd "ca_classifier_vlan_set_$elm $pt_flow_key_l2_outer_vlan $aIn(-$pe)"
     set res [helper_cmd_exec -cmd $cmd]            
    }       
  }  
  
  #l3
  foreach elm $v_flow_key_l3_l {
    if {$res} {break}    
     if {[info exists aIn(-$elm)] && 
      [string compare [string tolower $aIn(-$elm)] "dontcare"] } {      
      if {[string first "ip_sa" $elm] == 0 || [string first "ip_da" $elm] == 0} {
        set p_ip_address_t [ca_flow_key_l3_get_$elm $pt_flow_key_l3]   
        set p_ip_l3_address_t [ca_ip_address_get_ip_addr $p_ip_address_t];#addr, ipv4_addr , ipv6_addr     
        set res [helper_ca_ip_address_entry_config -ref $p_ip_address_t   -ip_addr $aIn(-$elm)  ]  
        continue       
      }      
      set cmd "ca_flow_key_l3_set_$elm $pt_flow_key_l3 $aIn(-$elm)"
     set res [helper_cmd_exec -cmd $cmd]            
    }    
  }
  
  #l4
  foreach elm $v_flow_key_l4_l {
    set pe $elm
    if {$res} {break}
    if {[info exists aIn(-$pe)] && 
      [string compare [string tolower $aIn(-$pe)] "dontcare"] } {
      set cmd "ca_flow_key_l4_set_$elm $pt_flow_key_l4 $aIn(-$pe)"
      set res [helper_cmd_exec -cmd $cmd]        
    }           
  }
  
  #action
  foreach elm $v_flow_action_l {
    set pe act_$elm    
    if {$res} {break}
    if {[info exists aIn(-$pe)] == 0 ||  
      [string compare [string tolower $aIn(-$pe)] "dontcare"] == 0 } { 
      continue
    }    
    set cmd "ca_flow_action_set_$elm $pt_flow_action $aIn(-$pe)"
    set res [helper_cmd_exec -cmd $cmd]       
  }
  
  foreach elm $v_flow_action_dest_l {
    set pe act_dest_$elm    
    if {$res} {break}
    if {[info exists aIn(-$pe)] == 0 ||  
      [string compare [string tolower $aIn(-$pe)] "dontcare"] == 0 } { 
      continue
    }    
    set cmd "ca_classifier_action_dest_set_$elm $pt_flow_action_dest $aIn(-$pe)"
    set res [helper_cmd_exec -cmd $cmd]    
  }  
  #action option 
  foreach elm $v_flow_action_option_l {
    set pe act_opt_$elm    
    if {$res} {break}
    if {[info exists aIn(-$pe)] == 0 ||  
      [string compare [string tolower $aIn(-$pe)] "dontcare"] == 0 } { 
      continue
    }    
    if {$elm == "sw_id"} {
      set sw_id_l [split $aIn(-$pe) "."]
      for {set i 0 } {$i < 4} {incr i} {
        set cmd "ca_flow_action_option_set_sw_id $pt_flow_action_option [lindex $sw_id_l $i] $i"
        set res [helper_cmd_exec -cmd $cmd]
      }      
    } elseif {$elm == "mac_sa" || $elm == "mac_da"} {
      set mac_l [split $aIn(-$pe) :]
      set new_mac_l ""
      foreach mac $mac_l {
        lappend new_mac_l 0x$mac
      }
      set cmd "ca_mac_addr_set [ca_flow_action_option_get_$elm $pt_flow_action_option] $new_mac_l"      
      set res [helper_cmd_exec -cmd $cmd ]   
    } elseif {$elm == "ip_sa" || $elm == "ip_da"} {
      set p_ip_address_t [ca_flow_action_option_get_$elm $pt_flow_action_option]   
      set p_ip_l3_address_t [ca_ip_address_get_ip_addr $p_ip_address_t];#addr, ipv4_addr , ipv6_addr     
      set res [helper_ca_ip_address_entry_config -ref $p_ip_address_t   -ip_addr $aIn(-$pe)  ]      
    } else {
      set cmd "ca_flow_action_option_set_$elm $pt_flow_action_option $aIn(-$pe)"
      set res [helper_cmd_exec -cmd $cmd]     
   }
   
   #auto calculate the specific mask value
   set pme act_opt_msk_$elm 
   if {$elm == "pppoe_session_id"} {
     set pme act_opt_msk_egress_pppoe_action
   }
   if  {[info exists aIn(-$pme)] == 0 ||  
      [string compare [string tolower $aIn(-$pme)] "dontcare"] == 0 } { 
      set aIn(-$pme) 1
    }
  }
  
  #action option mask
  foreach elm $v_flow_action_option_mask_l {
    set pe act_opt_msk_$elm
    if {$res} {break}
    if {[info exists aIn(-$pe)] == 0 ||  
      [string compare [string tolower $aIn(-$pe)] "dontcare"] == 0 } { 
      continue
    }
    set cmd "ca_flow_action_option_mask_set_$elm $pt_flow_action_option_masks $aIn(-$pe)"   
    set res [helper_cmd_exec -cmd $cmd] 
  }
  if {$gw::gwenv(REPORT_LEVEL) <= 1 } {
      puts "--Debug: flow entry before add operation:"
      ca_flow_dump $pt
      puts "--Debug: flow_key:"
      ca_flow_key_dump $pt_flow_key
      puts "--Debug: action:"
      ca_flow_action_dump $pt_flow_action
  }
  log -tag itfend
  return $res    
}
proc ::gw::helper_ca_flow_entry_config {args } {
  set ifnm helper_ca_flow_entry_config
  global errorInfo
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }
  set v_o_key_l {key_type aging_time }
  #flow_key_t:
  set v_flow_key_l {sw_id flow_id } ;#sw_id  
  set v_flow_key_l2_l [helper_probe_struct_members -struct  ca_flow_key_l2 -exclude_list {outer_vlan inner_vlan mac_sa_range mac_da_range}]
  lappend v_flow_key_l2_l  mac_sa_range_min mac_sa_range_max mac_da_range_min mac_da_range_max
  set v_vlan_l   [helper_probe_struct_members -struct  ca_classifier_vlan ]
  set v_flow_key_l3_l   [helper_probe_struct_members -struct  ca_flow_key_l3]
  set v_flow_key_l4_l   [helper_probe_struct_members -struct  ca_flow_key_l4]  

  #flow_action_t:
  set v_flow_action_l {forward} ;#CA_CLASSIFIER_FORWARD_DENY,FE,INTERFACE,PORT 
  set v_flow_action_dest_l   [helper_probe_struct_members -struct  ca_classifier_action_dest] 
  set v_flow_action_option_l [helper_probe_struct_members -struct ca_flow_action_option -exclude_list {masks}] ;#mac,ip, sw_id
  set v_flow_action_option_mask_l [helper_probe_struct_members -struct ca_flow_action_option_mask]
 
  #generate input argument list
  set v_key_l "$v_o_key_l $v_flow_key_l $v_flow_key_l2_l"
 
  foreach e $v_vlan_l {
    lappend v_key_l outer_$e ;#prefix "outer_"
  }
  foreach e $v_vlan_l {
    lappend v_key_l inner_$e ;#prefix "inner_"
  } 
  set v_key_l "$v_key_l $v_flow_key_l3_l $v_flow_key_l4_l"
  
  foreach e $v_flow_action_l {
    lappend v_key_l act_$e ;#prefix "act_"
  }
  foreach e $v_flow_action_dest_l {
    lappend v_key_l act_dest_$e ;#prefix "act_dest_"
  } 
  foreach e "$v_flow_action_option_l" {
    lappend v_key_l act_opt_$e ;#prefix "act_opt_"
  }  
  foreach e $v_flow_action_option_mask_l {
    lappend v_key_l act_opt_msk_$e   ;#prefix "act_opt_msk_"
  }
  
  if {[catch {array set aParam $args} err]} {
    log -tag error -msg "$err. $errorInfo"    
    return -1
  }    
  set res [helper_m_args_check -args $aParam(-args) -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $aParam(-args)
  set pt $aParam(-refer)
  if {$res == 0 } {    
    set pt_flow_key [ca_flow_get_key $pt]
    set pt_flow_action [ca_flow_get_actions $pt]
  }    
  
  foreach elm $v_o_key_l {
    if {$res} { break}
    if {[info exists aIn(-$elm)] && 
       [string compare [string tolower $aIn(-$elm)] "dontcare"] } { 
       set cmd "ca_flow_set_$elm $pt $aIn(-$elm)"
       set res [helper_cmd_exec -cmd $cmd]
    }   
  } 
  if {$res == 0 } {
      set res [helper_ca_flow_key_entry_config -refer $pt_flow_key -args  $aParam(-args) -print_res 0]
  }
  if {$res == 0 } {
      set res [helper_ca_flow_action_entry_config -refer $pt_flow_action -args  $aParam(-args) -print_res 0 ]
  } 
  
  if {$gw::gwenv(REPORT_LEVEL) <= 1 } {
      puts "--Debug: flow entry before add operation:"
      ca_flow_dump $pt
      puts "--Debug: flow_key:"
      ca_flow_key_dump $pt_flow_key
      puts "--Debug: action:"
      ca_flow_action_dump $pt_flow_action
  }
  log -tag itfend
  return $res    
}
proc ::gw::helper_ca_flow_key_entry_config {args } {
  set ifnm helper_ca_flow_key_entry_config
  global errorInfo
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"

  #flow_key_t:
  set v_flow_key_l {sw_id flow_id } ;#sw_id  
  set v_flow_key_l2_l [helper_probe_struct_members -struct  ca_flow_key_l2 -exclude_list {outer_vlan inner_vlan mac_sa_range mac_da_range}]
  lappend v_flow_key_l2_l  mac_sa_range_min mac_sa_range_max mac_da_range_min mac_da_range_max
  set v_vlan_l   [helper_probe_struct_members -struct  ca_classifier_vlan ]
  set v_flow_key_l3_l   [helper_probe_struct_members -struct  ca_flow_key_l3]
  set v_flow_key_l4_l   [helper_probe_struct_members -struct  ca_flow_key_l4]  
  set aParam(-print_res) 1
  if {[catch {array set aParam $args} err]} {
    log -tag error -msg "$err. $errorInfo"    
    return -1
  }    
  set res [helper_m_args_check -args $aParam(-args)]
  if {$res} {
    return $res
  }
  set print_res $aParam(-print_res)
  array set aIn $aParam(-args)   
  set pt_flow_key $aParam(-refer)
  if {$res == 0 } {  
    set pt_flow_key_l2   [ca_flow_key_get_l2_key $pt_flow_key]
    set pt_flow_key_l2_outer_vlan [ca_flow_key_l2_get_outer_vlan $pt_flow_key_l2]
    set pt_flow_key_l2_inner_vlan [ca_flow_key_l2_get_inner_vlan $pt_flow_key_l2]
    
    set pt_flow_key_l3 [ca_flow_key_get_l3_key $pt_flow_key]
    set pt_flow_key_l4 [ca_flow_key_get_l4_key $pt_flow_key]   
  }  

  foreach elm $v_flow_key_l {
    if {$res} { break}
    if {[info exists aIn(-$elm)] && 
      [string compare [string tolower $aIn(-$elm)] "dontcare"] } {
      if {$elm == "sw_id"} {
        set sw_id_l [split $aIn(-sw_id) "."]
        for {set i 0 } {$i < 4} {incr i} {
          set cmd "ca_flow_key_set_sw_id $pt_flow_key [lindex $sw_id_l $i] $i"
          set res [helper_cmd_exec -cmd $cmd]
        }  
        continue
      } 
      set cmd "ca_flow_key_set_$elm $pt_flow_key $aIn(-$elm)"
      set res [helper_cmd_exec -cmd $cmd]
    }   
  } 
  #l2
  foreach elm $v_flow_key_l2_l {
    if {$res} {break}
    if {[info exists aIn(-$elm)] == 0 ||  
      [string compare [string tolower $aIn(-$elm)] "dontcare"] == 0 } { 
      continue
    }    
    if {[regexp {mac_(da|sa)} $elm skip dir] > 0 } {
      set mac_l [split $aIn(-$elm) :]
      set new_mac_l ""
      foreach mac $mac_l {
        lappend new_mac_l 0x$mac
      }
      if {[regexp {range_(max|min)} $elm skip type] > 0 } {
        set prange [ca_flow_key_l2_get_mac_${dir}_range $pt_flow_key_l2]      
        set cmd "ca_mac_addr_set [ca_classifier_mac_addr_range_get_mac_${type} $prange] $new_mac_l"
      } else {
        set cmd "ca_mac_addr_set [ca_flow_key_l2_get_mac_${dir} $pt_flow_key_l2] $new_mac_l"
      }
    } else {
      set cmd "ca_flow_key_l2_set_$elm $pt_flow_key_l2 $aIn(-$elm)"
    }
    set res [helper_cmd_exec -cmd $cmd]     
  }
  #l2 vlan
  foreach elm $v_vlan_l {
    set pe "inner_$elm"
    if {$res} {break}
     if {[info exists aIn(-$pe)] && 
      [string compare [string tolower $aIn(-$pe)] "dontcare"] } {
      set cmd "ca_classifier_vlan_set_$elm $pt_flow_key_l2_inner_vlan $aIn(-$pe)"
     set res [helper_cmd_exec -cmd $cmd]            
    }   
  }
  foreach elm $v_vlan_l {
    set pe "outer_$elm"
    if {$res} {break}
     if {[info exists aIn(-$pe)] && 
      [string compare [string tolower $aIn(-$pe)] "dontcare"] } {
      set cmd "ca_classifier_vlan_set_$elm $pt_flow_key_l2_outer_vlan $aIn(-$pe)"
     set res [helper_cmd_exec -cmd $cmd]            
    }       
  }  
  
  #l3
  foreach elm $v_flow_key_l3_l {
    if {$res} {break}    
     if {[info exists aIn(-$elm)] && 
      [string compare [string tolower $aIn(-$elm)] "dontcare"] } {      
      if {[string first "ip_sa" $elm] == 0 || [string first "ip_da" $elm] == 0} {
        set p_ip_address_t [ca_flow_key_l3_get_$elm $pt_flow_key_l3]   
        set p_ip_l3_address_t [ca_ip_address_get_ip_addr $p_ip_address_t];#addr, ipv4_addr , ipv6_addr     
        set res [helper_ca_ip_address_entry_config -ref $p_ip_address_t   -ip_addr $aIn(-$elm)  ]  
        continue       
      }      
      set cmd "ca_flow_key_l3_set_$elm $pt_flow_key_l3 $aIn(-$elm)"
     set res [helper_cmd_exec -cmd $cmd]            
    }    
  }
  
  #l4
  foreach elm $v_flow_key_l4_l {
    set pe $elm
    if {$res} {break}
    if {[info exists aIn(-$pe)] && 
      [string compare [string tolower $aIn(-$pe)] "dontcare"] } {
      set cmd "ca_flow_key_l4_set_$elm $pt_flow_key_l4 $aIn(-$pe)"
      set res [helper_cmd_exec -cmd $cmd]        
    }           
  } 
  if {$gw::gwenv(REPORT_LEVEL) <= 1 || $print_res } { 
      puts "---dump flow key struct---"
      ca_flow_key_dump $pt_flow_key
  }
  log -tag itfend
  return $res    
}
proc ::gw::helper_ca_flow_action_entry_config {args } {
  set ifnm helper_ca_flow_action_entry_config
  global errorInfo
  variable CA_FLOW_VLAN_ACTION_T
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  #flow_action_t:
  set v_flow_action_l {forward} ;#CA_CLASSIFIER_FORWARD_DENY,FE,INTERFACE,PORT 
  set v_flow_action_dest_l   [helper_probe_struct_members -struct  ca_classifier_action_dest] 
  set v_flow_action_option_l [helper_probe_struct_members -struct ca_flow_action_option -exclude_list {masks}] ;#mac,ip, sw_id
  set v_flow_action_option_mask_l [helper_probe_struct_members -struct ca_flow_action_option_mask]

  #generate input argument list
  set v_key_l ""
  
  foreach e $v_flow_action_l {
    lappend v_key_l act_$e ;#prefix "act_"
  }
  foreach e $v_flow_action_dest_l {
    lappend v_key_l act_dest_$e ;#prefix "act_dest_"
  } 
  foreach e "$v_flow_action_option_l" {
    lappend v_key_l act_opt_$e ;#prefix "act_opt_"
  }  
  foreach e $v_flow_action_option_mask_l {
    lappend v_key_l act_opt_msk_$e   ;#prefix "act_opt_msk_"
  }
  set aParam(-print_res) 1  
  if {[catch {array set aParam $args} err]} {
    log -tag error -msg "$err. $errorInfo"    
    return -1
  }    
  set res [helper_m_args_check -args $aParam(-args)]
  if {$res} {
    return $res
  }
  set print_res $aParam(-print_res)
  set aIn(-act_opt_inner_vlan_act) dontcare
  set aIn(-act_opt_outer_vlan_act) dontcare
  array set aIn $aParam(-args)
    
  helper_h2s -source [string toupper $aIn(-act_opt_inner_vlan_act)] -table CA_FLOW_VLAN_ACTION_T -out aX
  set aIn(-act_opt_inner_vlan_act) $aX(-target)

  helper_h2s -source [string toupper $aIn(-act_opt_outer_vlan_act)] -table CA_FLOW_VLAN_ACTION_T -out aX
  set aIn(-act_opt_outer_vlan_act) $aX(-target)

  set pt_flow_action $aParam(-refer)
  if {$res == 0 } {
    set pt_flow_action_dest [ca_flow_action_get_dest $pt_flow_action]
    set pt_flow_action_option [ca_flow_action_get_options $pt_flow_action]
    set pt_flow_action_option_masks [ca_flow_action_option_get_masks $pt_flow_action_option]
  }   
  #action
  foreach elm $v_flow_action_l {
    set pe act_$elm    
    if {$res} {break}
    if {[info exists aIn(-$pe)] == 0 ||  
      [string compare [string tolower $aIn(-$pe)] "dontcare"] == 0 } { 
      continue
    }    
    set cmd "ca_flow_action_set_$elm $pt_flow_action $aIn(-$pe)"
    set res [helper_cmd_exec -cmd $cmd]       
  }
  
  foreach elm $v_flow_action_dest_l {
    set pe act_dest_$elm    
    if {$res} {break}
    if {[info exists aIn(-$pe)] == 0 ||  
      [string compare [string tolower $aIn(-$pe)] "dontcare"] == 0 } { 
      continue
    }    
    set cmd "ca_classifier_action_dest_set_$elm $pt_flow_action_dest $aIn(-$pe)"
    set res [helper_cmd_exec -cmd $cmd]    
  }  
  #action option 
  foreach elm $v_flow_action_option_l {
    set pe act_opt_$elm    
    if {$res} {break}
    if {[info exists aIn(-$pe)] == 0 ||  
      [string compare [string tolower $aIn(-$pe)] "dontcare"] == 0 } { 
      continue
    }    
    if {$elm == "sw_id"} {
      set sw_id_l [split $aIn(-$pe) "."]
      for {set i 0 } {$i < 4} {incr i} {
        set cmd "ca_flow_action_option_set_sw_id $pt_flow_action_option [lindex $sw_id_l $i] $i"
        set res [helper_cmd_exec -cmd $cmd]
      }      
    } elseif {$elm == "mac_sa" || $elm == "mac_da"} {
      set mac_l [split $aIn(-$pe) :]
      set new_mac_l ""
      foreach mac $mac_l {
        lappend new_mac_l 0x$mac
      }
      set cmd "ca_mac_addr_set [ca_flow_action_option_get_$elm $pt_flow_action_option] $new_mac_l"      
      set res [helper_cmd_exec -cmd $cmd ]   
    } elseif {$elm == "ip_sa" || $elm == "ip_da"} {
      set p_ip_address_t [ca_flow_action_option_get_$elm $pt_flow_action_option]   
      set p_ip_l3_address_t [ca_ip_address_get_ip_addr $p_ip_address_t];#addr, ipv4_addr , ipv6_addr     
      set res [helper_ca_ip_address_entry_config -ref $p_ip_address_t   -ip_addr $aIn(-$pe)  ]      
    } else {
      set cmd "ca_flow_action_option_set_$elm $pt_flow_action_option $aIn(-$pe)"
      set res [helper_cmd_exec -cmd $cmd]     
   }
   
   #auto calculate the specific mask value
   set pme act_opt_msk_$elm 
   if {$elm == "pppoe_session_id"} {
     set pme act_opt_msk_egress_pppoe_action
   }
   if  {[info exists aIn(-$pme)] == 0 ||  
      [string compare [string tolower $aIn(-$pme)] "dontcare"] == 0 } { 
      set aIn(-$pme) 1
    }
  }
  
  #action option mask
  foreach elm $v_flow_action_option_mask_l {
    set pe act_opt_msk_$elm
    if {$res} {break}
    if {[info exists aIn(-$pe)] == 0 ||  
      [string compare [string tolower $aIn(-$pe)] "dontcare"] == 0 } { 
      continue
    }
    set cmd "ca_flow_action_option_mask_set_$elm $pt_flow_action_option_masks $aIn(-$pe)"   
    set res [helper_cmd_exec -cmd $cmd] 
  }
  if {$gw::gwenv(REPORT_LEVEL) <= 1 || $print_res } {
      puts "---dump action struct---"
      ca_flow_action_dump $pt_flow_action
  }
  log -tag itfend
  return $res    
}
proc ::gw::helper_ca_flow_entry_parse {args} {
  set ifnm helper_parse_flow_entry
  variable CA_FLOW_VLAN_ACTION_T
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {ref}
  set v_key_l {exp_args} 

  set v_o_key_l {key_type aging_time index}

  #flow_key_t:
  set v_flow_key_l {sw_id flow_id } ;#sw_id
  set v_flow_action_l {forward} ;#CA_CLASSIFIER_FORWARD_DENY,FE,INTERFACE,PORT  
  set v_flow_key_l2_l [helper_probe_struct_members -struct  ca_flow_key_l2 -exclude_list {outer_vlan inner_vlan mac_sa_range mac_da_range}]
  lappend v_flow_key_l2_l  mac_sa_range_min mac_sa_range_max mac_da_range_min mac_da_range_max
  set v_vlan_l   [helper_probe_struct_members -struct  ca_classifier_vlan ]
  set v_flow_key_l3_l   [helper_probe_struct_members -struct  ca_flow_key_l3]
  set v_flow_key_l4_l   [helper_probe_struct_members -struct  ca_flow_key_l4]  

  #flow_action_t:
  set v_flow_action_l {forward} ;#CA_CLASSIFIER_FORWARD_DENY,FE,INTERFACE,PORT 
  set v_flow_action_dest_l   [helper_probe_struct_members -struct  ca_classifier_action_dest] 
  set v_flow_action_option_l [helper_probe_struct_members -struct ca_flow_action_option -exclude_list {masks}] ;#mac,ip, sw_id
  set v_flow_action_option_mask_l [helper_probe_struct_members -struct ca_flow_action_option_mask]

  set rtn_key_l "$v_o_key_l $v_flow_key_l $v_flow_key_l2_l "
  foreach e $v_vlan_l {
    lappend rtn_key_l outer_$e ;#prefix "outer_"
  }
  foreach e $v_vlan_l {
    lappend rtn_key_l inner_$e ;#prefix "inner_"
  } 
  set rtn_key_l "$rtn_key_l $v_flow_key_l3_l $v_flow_key_l4_l"
  foreach e $v_flow_action_l {
    lappend rtn_key_l act_$e ;#prefix "act_"
  }
  foreach e $v_flow_action_dest_l {
    lappend rtn_key_l act_dest_$e ;#prefix "act_dest_"
  } 
  foreach e $v_flow_action_option_l {
    lappend rtn_key_l act_opt_$e ;#prefix "act_opt_"
  }  
  foreach e $v_flow_action_option_mask_l {
    lappend rtn_key_l act_opt_msk_$e   ;#prefix "act_opt_msk_"
  }
      
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set aIn(-exp_args) dontcare
  
  array set aIn $args
  set exp_args [string tolower $aIn(-exp_args)]
  helper_output_declare aIn

  if {$exp_args == "dontcare"} {
    set lst $rtn_key_l
  } else {
    set lst $exp_args
  }
  helper_output_init aOut  $lst
  set pt $ref
  if {$res == 0 } {
    #ca_flow_dump $pt
    foreach var $v_o_key_l {
        if {[string compare $exp_args "dontcare"] && [lsearch $exp_args $var] == -1  } {continue}
      set aOut(-$var) [ca_flow_get_$var $pt]
    }
  }
  if {$res == 0 } {
    set pt_flow_key [ca_flow_get_key $pt]
    foreach var $v_flow_key_l {
      if {[string compare $exp_args "dontcare"] && [lsearch $exp_args $var] == -1  } {continue}
      if {$var == "sw_id"} {
        set sw_id_l ""
        for {set act_i 0 } {$act_i < 4} {incr act_i} {
          lappend sw_id_l [ca_flow_key_get_sw_id $pt_flow_key $act_i]
        }
        set aOut(-sw_id) [join $sw_id_l "."]
      } else {
        set aOut(-$var) [ca_flow_key_get_$var $pt_flow_key]
      }
    }
  } 
  if {$res == 0 } {
    set pt_flow_key_l2 [ca_flow_key_get_l2_key $pt_flow_key]
    foreach var "inner_vlan outer_vlan" {
        if {$var == "outer_vlan" } {
          set pre "outer_"
        } else {
          set pre "inner_"
        }
        set pt_vlan [ca_flow_key_l2_get_$var $pt_flow_key_l2]
        foreach vvar $v_vlan_l {
          if {[string compare $exp_args "dontcare"] && [lsearch $exp_args ${pre}$vvar] == -1  } {continue}
          set aOut(-${pre}$vvar) [ca_classifier_vlan_get_$vvar $pt_vlan]
        }    
    }
    foreach var $v_flow_key_l2_l {
      if {[string compare $exp_args "dontcare"] && [lsearch $exp_args $var] == -1  } {continue}
      if {[regexp {mac_(sa|da)} $var skip dir]} {
          if {[regexp {range_(min|max)} $var skip type]} {
            set prange [ca_flow_key_l2_get_mac_${dir}_range $pt_flow_key_l2]
            set pmac [ca_classifier_mac_addr_range_get_mac_${type} $prange]
          } else  {
            set pmac [ca_flow_key_l2_get_$var $pt_flow_key_l2]
          }
          set mac_l ""          
          for {set ao_i 0 } {$ao_i < 6} {incr ao_i} {
            lappend mac_l [format %02x [ca_mac_addr_get $pmac $ao_i]]
          }
          set aOut(-$var) [join $mac_l :]            
      } else {    
        set aOut(-$var) [ca_flow_key_l2_get_$var $pt_flow_key_l2]
      }
    }   
  } 
  if {$res == 0 } {    
    set pt_flow_key_l3 [ca_flow_key_get_l3_key $pt_flow_key]
    foreach var $v_flow_key_l3_l {
      if {[string compare $exp_args "dontcare"] && [lsearch $exp_args $var] == -1  } {continue}
      if {$var == "ip_sa" || $var == "ip_da"} {
          set p_ip_address_t [ca_flow_key_l3_get_$var $pt_flow_key_l3]            
          set res [helper_ca_ip_address_entry_parse -ref $p_ip_address_t -out aTmp]
          if {$res == 0 } {
            set aOut(-$var) $aTmp(-ip_addr)
          }           
      } else {
        set aOut(-$var) [ca_flow_key_l3_get_$var $pt_flow_key_l3]
      }
    }    
  } 
  if {$res == 0 } {
    set pt_flow_key_l4 [ca_flow_key_get_l4_key $pt_flow_key]
    foreach var $v_flow_key_l4_l {
      if {[string compare $exp_args "dontcare"] && [lsearch $exp_args "l4_$var"] == -1  } {continue}     
      set aOut(-$var) [ca_flow_key_l4_get_$var $pt_flow_key_l4]
    }
  } 
   
  if {$res == 0 } {
    set pt_flow_action [ca_flow_get_actions $pt]
    foreach var $v_flow_action_l {
      if {[string compare $exp_args "dontcare"] && [lsearch $exp_args "act_$var"] == -1  } {continue}
      set aOut(-act_$var) [ca_flow_action_get_$var $pt_flow_action]
    }
  }
  if {$res == 0 } {
    set pt_flow_action_dest [ca_flow_action_get_dest $pt_flow_action]
    foreach var $v_flow_action_dest_l {
      if {[string compare $exp_args "dontcare"] && [lsearch $exp_args "act_dest_$var"] == -1  } {continue}
      set aOut(-act_dest_$var) [ca_classifier_action_dest_get_$var $pt_flow_action_dest]
    }
  } 
  if {$res == 0 } {
    set pt_flow_action_option [ca_flow_action_get_options $pt_flow_action]
    foreach var $v_flow_action_option_l {
      if {[string compare $exp_args "dontcare"] && [lsearch $exp_args "act_opt_$var"] == -1  } {continue}
      if {$var == "sw_id"} {
        set sw_id_l ""
        for {set act_i 0 } {$act_i < 4} {incr act_i} {
          lappend sw_id_l [ca_flow_action_option_get_sw_id $pt_flow_action_option $act_i]
        }
        set aOut(-act_opt_sw_id) [join $sw_id_l "."]     
      } elseif {$var == "mac_sa" || $var == "mac_da"} {
          set mac_l ""
          set pmac [ca_flow_action_option_get_$var $pt_flow_action_option]
          for {set ao_i 0 } {$ao_i < 6} {incr ao_i} {
            lappend mac_l [format %02x [ca_mac_addr_get $pmac $ao_i]]
          }
          set aOut(-act_opt_$var) [join $mac_l :]             
      } elseif {$var == "ip_sa" || $var == "ip_da"} {
          set p_ip_address_t [ca_flow_action_option_get_$var $pt_flow_action_option]   
          #set p_ip_l3_address_t [ca_ip_address_get_ip_addr $p_ip_address_t]
          #set pl3ip [ca_classifier_ip_get_$key $p_ip]
          set res [helper_ca_ip_address_entry_parse -ref $p_ip_address_t -out aTmp]
          if {$res == 0 } {
            set aOut(-act_opt_$var) $aTmp(-ip_addr)
          }      
      } elseif {$var == "inner_vlan_act" || $var == "outer_vlan_act"} {
        set act [ca_flow_action_option_get_$var $pt_flow_action_option]
        set aOut(-act_opt_${var}) $act
        helper_s2h -source $act -table CA_FLOW_VLAN_ACTION_T -out aX        
        set aOut(-act_opt_${var}_v) $aX(-target)       
      } else {
        set aOut(-act_opt_$var) [ca_flow_action_option_get_$var $pt_flow_action_option]
      }
    }
  }   
  
 if {$res == 0 } {
    set pt_flow_action_option_mask [ca_flow_action_option_get_masks $pt_flow_action_option]
    foreach var $v_flow_action_option_mask_l {
      if {[string compare $exp_args "dontcare"] && [lsearch $exp_args "act_opt_msk_$var"] == -1  } {continue}
      set aOut(-act_opt_msk_$var) [ca_flow_action_option_mask_get_$var $pt_flow_action_option_mask]
    }
  }     
 # if {$::gw::gwenv(REPORT_LEVEL) <= 1} {
 #   helper_parray aOut 
 # } 
  log -tag itfend
  return $res    
}
proc ::gw::wca_flow_key_type_add {args} {
  set ifnm wca_flow_key_type_add 
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }
  set v_o_key_l {key_type prio }
  helper_m_args_check -args $args -m_key_l $m_key_l ;#not care result 
  array set aTmp ""
  set cmd "ca_flow_key_type_config_create "
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)    
    set res [helper_ca_flow_key_type_entry_config -refer $pt -args $args]
  }

  if {$res == 0 } {    
    set cmd "ca_flow_key_type_add $device_id $pt"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_print_status_enum_name $res  
  return $res    
}
proc ::gw::wca_flow_key_type_get {args} {
  set ifnm wca_flow_key_type_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id key_type}
  set v_o_key_l {key_type prio }
   
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_o_key_l 
  set cmd "ca_flow_key_type_config_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  } 
  if {$res == 0 && [info exists aIn(-key_type)] && 
         [string compare [string tolower $aIn(-key_type)] "dontcare"] } {
    set cmd "ca_flow_key_type_config_set_key_type $pt $aIn(-key_type)"
    set res [helper_cmd_exec -cmd $cmd]
  }
  if {$res == 0} {
    set cmd [list ca_flow_key_type_get $device_id  $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]    
  }  
  if {$res == 0} {
    set res [helper_ca_flow_key_type_entry_parse -refer $pt -args $args -out aOut]
  }   
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name $res  
  return $res    
}
proc ::gw::wca_flow_key_type_delete {args} {
  set ifnm wca_flow_key_type_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id key_type}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  if {$res == 0 } {
    set cmd [list ca_flow_key_type_delete $device_id $key_type ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res        
}
proc ::gw::wca_flow_add {args} {
  set ifnm wca_flow_add
  variable CA_FLOW_VLAN_ACTION_T
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }   
  helper_m_args_check -args $args -m_key_l $m_key_l
 
  array set aTmp ""
  set cmd "ca_flow_create "
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err) 
    set res [helper_ca_flow_entry_config -refer $pt -args $args  ]
  }   
  if {$res == 0 } {  
    array set aIn $args
    helper_output_declare aIn  
    helper_output_init aOut 
    set cmd "ca_flow_add $device_id $pt"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }   
  if {$res == 0 } {
    set aOut(-index) [ca_flow_get_index $pt]
  } else {
    set aOut(-index) unknown
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_parray aOut
  helper_print_status_enum_name $res
  return $res    
}
proc ::gw::wca_flow_get {args} {
  set ifnm wca_flow_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id index }
  set v_key_l {exp_args}

  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-print_res) 1
  set aIn(-exp_args) dontcare
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut 
  
  set print_res $aIn(-print_res)   
  set aTmp(-err) ""
 
  set res [helper_cmd_exec -cmd {ca_flow_create } -out aTmp]  
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_flow_get $device_id $index $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    #ca_flow_dump $pt
    set res [helper_ca_flow_entry_parse -ref $pt -exp_args $aIn(-exp_args) -out aOut]
  }

  catch {ca_data_free $pt} err
  if {$print_res} { 
    helper_parray aOut
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_flow_get_all {args} {
  global errorInfo
  set EXT_DATA_MAX_LEN 8 ;#8 bytes
  set ifnm wca_flow_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l {cpi exp_args}
  #set v_key_l {exp_args} 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-exp_args) dontcare
  set aIn(-print_res) 1
  set aIn(-cpi) 2
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  
  set cpi $aIn(-cpi)
  set exp_args [string tolower [string trim $aIn(-exp_args)]]
  set print_res $aIn(-print_res)
 
  set aTmp(-iterator_pointer) NULL    
  set idx 0
  for {set max 0} {$max < 10000 && $res == 0} {incr max} {
    set res [helper_iterate -device_id $device_id \
      -data_type ca_flow_t\
      -iterate_func ca_flow_iterate \
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]
            
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    }
    foreach npdx $aTmp(-element_data_pointers) {
      catch {array unset aVar}
      array set aTmp ""
      set res [helper_ca_flow_entry_parse -ref $npdx -exp_args $exp_args -out aVar]
      if {$res == 0 } {       
        set aOut($idx) [array get aVar]
        incr idx
      }
    } 
  }
  catch {ca_data_free $p} err
  if {$max >= 10000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  } 
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    #log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    #log -tag warning -msg $err
  }  
  if {$print_res} {
    puts "\nTotal Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_flow_aging_time_get {args} {
  set ifnm wca_flow_aging_time_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id index }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  aging_time  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_flow_aging_time_get $device_id $index $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    set aOut(-aging_time) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_parray aOut
  return $res
}
proc ::gw::wca_flow_aging_time_set {args} {
  set ifnm wca_flow_aging_time_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  index aging_time}

  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  set cmd "ca_flow_aging_time_set $device_id $index $aging_time"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_flow_delete_all {args} {
  set ifnm wca_flow_delete_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  if {$res == 0 } {
    set cmd "ca_flow_delete_all $device_id "
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  log -tag itfend
  return $res  
}
proc ::gw::wca_flow_delete {args} {
  set ifnm wca_flow_delete
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id index  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  if {$res == 0 } {
    set cmd "ca_flow_delete $device_id $index"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  log -tag itfend
  return $res  
}
#---hash flow---
proc ::gw::wca_hash_flow_key_type_add {args} {
  set ifnm wca_hash_flow_key_type_add 
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }
  set v_o_key_l {key_type prio }
  helper_m_args_check -args $args -m_key_l $m_key_l ;#not care result 
  array set aTmp ""
  set cmd "ca_flow_key_type_config_create "
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)    
    set res [helper_ca_flow_key_type_entry_config -refer $pt -args $args]
  }

  if {$res == 0 } {    
    set cmd "ca_hash_flow_key_type_add $device_id $pt"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }  
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_print_status_enum_name $res  
  return $res    
}
proc ::gw::wca_hash_flow_key_type_get {args} {
  set ifnm wca_hash_flow_key_type_get
  set res 0
  log -tag itfbgn -msg $args
  
  set m_key_l {device_id key_type}
  set v_o_key_l {key_type prio }
   
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut $v_o_key_l 
  set cmd "ca_flow_key_type_config_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err)
  } 
  if {$res == 0 && [info exists aIn(-key_type)] && 
         [string compare [string tolower $aIn(-key_type)] "dontcare"] } {
    set cmd "ca_flow_key_type_config_set_key_type $pt $aIn(-key_type)"
    set res [helper_cmd_exec -cmd $cmd]
  }
  if {$res == 0} {
    set cmd [list ca_hash_flow_key_type_get $device_id  $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 ]    
  }  
  if {$res == 0} {
    set res [helper_ca_flow_key_type_entry_parse -refer $pt -args $args -out aOut]
  }   
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  helper_print_status_enum_name $res  
  return $res    
}
proc ::gw::wca_hash_flow_key_type_delete {args} {
  set ifnm wca_hash_flow_key_type_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id key_type}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  if {$res == 0 } {
    set cmd [list ca_hash_flow_key_type_delete $device_id $key_type ]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  log -tag itfend
  return $res        
}
proc ::gw::wca_hash_flow_add {args} {
  set ifnm wca_hash_flow_add
  variable CA_FLOW_VLAN_ACTION_T
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }   
  helper_m_args_check -args $args -m_key_l $m_key_l
 
  array set aTmp ""
  set cmd "ca_flow_create "
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err) 
    set res [helper_ca_flow_entry_config -refer $pt -args $args  ]
  }   
  if {$res == 0 } {  
    array set aIn $args
    helper_output_declare aIn  
    helper_output_init aOut 
    set cmd "ca_hash_flow_add $device_id $pt"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }   
  if {$res == 0 } {
    set aOut(-index) [ca_flow_get_index $pt]
  } else {
    set aOut(-index) unknown
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_parray aOut
  helper_print_status_enum_name $res
  return $res    
}
proc ::gw::wca_hash_flow_get {args} {
  set ifnm wca_hash_flow_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id index }
  set v_key_l {exp_args}

  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-print_res) 1
  set aIn(-exp_args) dontcare
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut 
  
  set print_res $aIn(-print_res)   
  set aTmp(-err) ""
 
  set res [helper_cmd_exec -cmd {ca_flow_create } -out aTmp]  
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_hash_flow_get $device_id $index $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    #ca_flow_dump $pt
    set res [helper_ca_flow_entry_parse -ref $pt -exp_args $aIn(-exp_args) -out aOut]
  }

  catch {ca_data_free $pt} err
  if {$print_res} { 
    helper_parray aOut
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_hash_flow_get_all {args} {
  global errorInfo
  set EXT_DATA_MAX_LEN 8 ;#8 bytes
  set ifnm wca_hash_flow_get_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id }
  set v_key_l {cpi exp_args}
  #set v_key_l {exp_args} 
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-exp_args) dontcare
  set aIn(-print_res) 1
  set aIn(-cpi) 2
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  
  set cpi $aIn(-cpi)
  set exp_args [string tolower [string trim $aIn(-exp_args)]]
  set print_res $aIn(-print_res)
 
  set aTmp(-iterator_pointer) NULL    
  set idx 0
  for {set max 0} {$max < 10000 && $res == 0} {incr max} {
    set res [helper_iterate -device_id $device_id \
      -data_type ca_flow_t\
      -iterate_func ca_hash_flow_iterate \
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]
            
    if {$res } {
      if {$res == 9 } {set res 0}
      break
    }
    foreach npdx $aTmp(-element_data_pointers) {
      catch {array unset aVar}
      array set aTmp ""
      set res [helper_ca_flow_entry_parse -ref $npdx -exp_args $exp_args -out aVar]
      if {$res == 0 } {       
        set aOut($idx) [array get aVar]
        incr idx
      }
    } 
  }
  catch {ca_data_free $p} err
  if {$max >= 10000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  } 
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    #log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    #log -tag warning -msg $err
  }  
  if {$print_res} {
    puts "\nTotal Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  }
  log -tag itfend
  return $res  
}
proc ::gw::wca_hash_flow_aging_time_get {args} {
  set ifnm wca_hash_flow_aging_time_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id index }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  aging_time  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_hash_flow_aging_time_get $device_id $index $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    set aOut(-aging_time) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_parray aOut
  return $res
}
proc ::gw::wca_hash_flow_aging_time_set {args} {
  set ifnm wca_hash_flow_aging_time_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id  index aging_time}

  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  set cmd "ca_hash_flow_aging_time_set $device_id $index $aging_time"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend -ifnm $ifnm
  return $res
}
proc ::gw::wca_hash_default_flow_action_update {args} {
  set ifnm wca_hash_default_flow_action_update
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }   
  helper_m_args_check -args $args -m_key_l $m_key_l
 
  array set aTmp ""
  set cmd "ca_flow_action_create "
  set res [helper_cmd_exec -cmd $cmd  -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err) 
    set res [helper_ca_flow_action_entry_config -refer $pt -args $args  ]
  }   
  if {$res == 0 } {  
    array set aIn $args
    set cmd "ca_hash_default_flow_action_update $device_id $pt"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }   
  
  catch {ca_data_free $pt} err
  log -tag itfend
  helper_print_status_enum_name $res
  return $res    
}
proc ::gw::wca_hash_flow_delete_all {args} {
  set ifnm wca_hash_flow_delete_all
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  if {$res == 0 } {
    set cmd "ca_hash_flow_delete_all $device_id "
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  log -tag itfend
  return $res  
}
proc ::gw::wca_hash_flow_delete {args} {
  set ifnm wca_hash_flow_delete
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id index  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  if {$res == 0 } {
    set cmd "ca_hash_flow_delete $device_id $index"
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  log -tag itfend
  return $res  
}
#------------------------------------------
#Section: Offload Port Management 
#------------------------------------------
proc ::gw::wca_offload_port_mode_set {args} {
  set ifnm wca_offload_port_mode_set
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id offload_port_id offload_mode }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  set cmd "ca_offload_port_mode_set $device_id $offload_port_id $offload_mode"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  
  log -tag itfend
  return $res
}
proc ::gw::wca_offload_port_stat_clear {args} {
  set ifnm wca_offload_port_stat_clear
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg "$args"
  set m_key_l {device_id offload_port_id  }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set cmd "ca_offload_port_stat_clear $device_id $offload_port_id"
  set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  log -tag itfend
  return $res
}
proc ::gw::wca_offload_port_stats_get {args} {
  set ifnm wca_offload_port_stats_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id offload_port_id}
  set v_o_key_l [helper_probe_struct_members -struct ca_offload_port_stats]
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_mib_offload_create} -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_offload_port_stats_get $device_id $offload_port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    foreach var $v_key_l {
      set aOut(-$var) [ca_offload_port_stats_get_$var $pt]
    }
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_offload_port_mode_get {args} {
  set ifnm wca_offload_port_mode_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id offload_port_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
   helper_output_declare aIn
  helper_output_init aOut  offload_mode
  
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_uint32_create 0 } -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_offload_port_mode_get $device_id $offload_port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-offload_mode) [ca_uint32_get $pt]
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_offload_port_status_get {args} {
  set ifnm wca_offload_port_status_get
  set res 0
  log -tag itfbgn -ifnm $ifnm -msg $args
  set m_key_l {device_id offload_port_id}
  set v_o_key_l {offload_mode vpn_offload_mode}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  array set aIn $args
  helper_output_declare aIn
  helper_output_init aOut  $v_o_key_l
  set max_level [helper_constant_value_get -name CA_MAX_VPN_OFFLOAD_TUNNEL_LEVELS]
  set aTmp(-err) ""
  set res [helper_cmd_exec -cmd {ca_offload_port_status_create} -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
    set cmd [list ca_offload_port_status_get $device_id $offload_port_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1 -out aTmp]
  }
  if {$res == 0 } {
    set aOut(-offload_mode) [ca_offload_port_status_get_offload_mode $pt]
    set l ""
    for {set i 0 } {$i < $max_level} {incr i} {
      lappend l [ca_offload_port_status_get_vpn_offload_mode $pt $i]
    }
    set aOut(-vpn_offload_mode) $l
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
#-----------------------------------
# US RATE MANAGER
#-----------------------------------
proc ::gw::wca_us_rate_manager_global_configuration_get {args} {
  set ifnm wca_us_rate_manager_global_configuration_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  set v_out_key_l {max_rate_manager_app_spec_streams default_stream_bandwidth_percentage \
   remaining_bandwidth_distribution_scheme default_stream_scheduler \
   default_stream_voq_weigths max_egress_rate}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  array set aIn $args 
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  catch {array unset aOut} err
  foreach var $v_out_key_l {
    set aOut(-$var) unknown
  }
  array set aTmp ""
  set cmd {us_rate_manager_global_control_create}
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0 } {
    set pt $aTmp(-err)
  } 
  if {$res == 0 } {
    set cmd [list ca_us_rate_manager_global_configuration_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  #us_rate_manager_global_control_dump $pt
  
  if {$res == 0 } {
    foreach var $v_out_key_l {
      if {$var == "default_stream_voq_weigths" } {
        set mac_l ""
        for {set i 0 } {$i < 8} {incr i} {
          lappend mac_l [us_rate_manager_global_control_get_default_stream_voq_weigths $pt $i]
        }
        set aOut(-default_stream_voq_weigths) [join $mac_l ,]
        continue 
      }          
      set aOut(-$var) [us_rate_manager_global_control_get_$var $pt]          
    }  
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res  
}
proc ::gw::wca_us_rate_manager_global_configuration_set {args} {
  set ifnm wca_us_rate_manager_global_configuration_set
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  set v_key_l {max_rate_manager_app_spec_streams default_stream_bandwidth_percentage \
   remaining_bandwidth_distribution_scheme default_stream_scheduler \
   default_stream_voq_weigths max_egress_rate}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-data_init) 1
  array set aIn $args  
  set cmd "us_rate_manager_global_control_create "
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err) 
  }
 
  foreach var $v_key_l {
      if {$res} {break}
      if {[info exists aIn(-$var)] == 0 || 
        [string compare [string tolower $aIn(-$var)] "dontcare"] == 0} { 
        continue
      }               
      if {$var == "default_stream_voq_weigths" } {
         helper_expand_list -set $aIn(-default_stream_voq_weigths) -out aRtn
         set new_l $aRtn(-l)
         for {set i 0 } {$i < [llength $new_l]} {incr i} {
           if {[lindex $new_l $i] == "/"} {continue}
           set cmd [us_rate_manager_global_control_set_default_stream_voq_weigths $pt [lindex $new_l $i] $i]
         }
      } else {         
        set cmd "us_rate_manager_global_control_set_$var $pt $aIn(-$var)"
        set res [helper_cmd_exec -cmd $cmd ]          
      }  
  } 
  
  if {$res == 0 } {
    set cmd [list ca_us_rate_manager_global_configuration_set $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  catch {ca_data_free $pt} err
  log -tag itfend
  return $res
}
proc ::gw::wca_us_rate_manager_entry_add {args} {
  set ifnm wca_us_rate_manager_entry_add
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id}
  set v_key_l {app_stream_id cir_kbps pir_kbps strict_prio}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-data_init) 1
  array set aIn $args  
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  catch {array unset aOut} err
  set aOut(-app_stream_id) unknown
    
  set cmd "us_rate_manager_app_spec_stream_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err) 
  }
 
  foreach var $v_key_l {
      if {$res} {break}
      if {[info exists aIn(-$var)] == 0 || 
        [string compare [string tolower $aIn(-$var)] "dontcare"] == 0} { 
        continue
      }               
      set cmd "us_rate_manager_app_spec_stream_set_$var $pt $aIn(-$var)"
      set res [helper_cmd_exec -cmd $cmd ] 
  } 
  
  if {$res == 0 } {
    set cmd [list ca_us_rate_manager_entry_add $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    set aOut(-app_stream_id) [us_rate_manager_app_spec_stream_get_app_stream_id $pt]
  }
  catch {ca_data_free $pt} err
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_us_rate_manager_entry_get {args} {
  set ifnm wca_us_rate_manager_entry_get
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id app_stream_id}
  set v_out_key_l {app_stream_id cir_kbps pir_kbps strict_prio}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  } 
  set aIn(-data_init) 1
  array set aIn $args  
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  catch {array unset aOut} err
  foreach var $v_out_key_l {
    set aOut(-$var) unknown
  }
  set aOut(-app_stream_id) $app_stream_id  
  set cmd "us_rate_manager_app_spec_stream_create"
  set res [helper_cmd_exec -cmd $cmd -out aTmp]
  if {$res == 0} {
    set pt $aTmp(-err) 
  } 
  if {$res == 0 } {               
      set cmd "us_rate_manager_app_spec_stream_set_app_stream_id $pt $app_stream_id"
      set res [helper_cmd_exec -cmd $cmd ] 
  }   
  if {$res == 0 } {
    set cmd [list ca_us_rate_manager_entry_get $device_id $pt]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }
  if {$res == 0 } {
    foreach var $v_out_key_l {
      set aOut(-$var) [us_rate_manager_app_spec_stream_get_$var $pt]
    }
  }
  catch {ca_data_free $pt} err
  
  helper_parray aOut
  log -tag itfend
  return $res
}
proc ::gw::wca_us_rate_manager_entry_get_all {args} {
  set ifnm wca_us_rate_manager_entry_get_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set v_key_l {cpi print_res}
  set v_out_key_l {app_stream_id cir_kbps pir_kbps strict_prio}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-cpi) 2
  set aIn(-print_res) 1
  array set aIn $args  
  
  set cpi $aIn(-cpi)
  set print_res $aIn(-print_res)
  
  if {[info exists aIn(-out)] == 0} {
    set aIn(-out) aOut
  }
  upvar $aIn(-out) aOut
  catch {array unset aOut} err
  array set aOut ""
  
  set aTmp(-iterator_pointer) NULL    
  set idx 0
  for {set max 0} {$max < 10000 && $res == 0 } {incr max} {
    set res [helper_iterate -device_id $device_id \
      -data_type us_rate_manager_app_spec_stream_t\
      -iterate_func ca_us_rate_manager_entry_iterate\
      -parse_func DONTCARE -cpi $cpi \
      -auto_release 0 -iterator_pointer $aTmp(-iterator_pointer) -out aTmp]
            
    if {$res == 9 } {
      set res 0
      break
    }
    if {$res} {break}
    
    foreach npdx $aTmp(-element_data_pointers) {
        catch {array unset aRtn} ignore
        array set aRtn ""
        foreach var $v_out_key_l {
          set aRtn(-$var) [us_rate_manager_app_spec_stream_get_$var $npdx]
        }     
        set aOut($idx) [array get aRtn]
        incr idx
    }
  }
  if {$max > 10000 } {
    log -tag warning -msg "Seems infinit loop occurs"
  }
  log -tag debug -msg "To free data memory"  
  if {[catch {ca_data_free $aTmp(-iterator_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {[catch {ca_data_free $aTmp(-iterator_data_pointer)} err]} {
    log -tag warning -msg $err
  }  
  if {$print_res} {
    puts "\nTotal Entry Count : [array size aOut]\n"
    helper_parray aOut "-integer" 1
  } 
  
  log -tag itfend
  return $res
}
proc ::gw::wca_us_rate_manager_entry_delete {args} {
  set ifnm wca_us_rate_manager_entry_delete
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id app_stream_id}
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }   

  if {$res == 0 } {
    set cmd [list ca_us_rate_manager_entry_delete $device_id $app_stream_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  }   
  log -tag itfend
  return $res
}
proc ::gw::wca_us_rate_manager_delete_all {args} {
  set ifnm wca_us_rate_manager_delete_all
  set res 0
  log -tag itfbgn -msg $args
  set m_key_l {device_id }
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }  
  set aIn(-data_init) 1 
  if {$res == 0 } {
    set cmd [list ca_us_rate_manager_delete_all $device_id]
    set res [helper_cmd_exec -cmd $cmd -check_return_value 1]
  } 
  log -tag itfend
  return $res
}
#------------------------------------------------------
# High level APIs  -- START
#------------------------------------------------------
proc gw::helper_atc_startup {args} {
  variable CA_RES_OK 
  variable CA_RES_NOK
  set ifnm helper_atc_startup
  set res $CA_RES_OK
  set ret_res $CA_RES_OK
  log -tag itfbgn -msg $args
  set docStr "
    mode: lan2wan, lan2lan, l3fe.
          lan2wan: add cls rules with src_port=uni ports and dest_port=wan
          l3fe:    add cls rules with src_port=uni ports and action_forward=FE
    cleanup_tables: true|false, or 0|1. To cleanup all system tables"
  set m_key_l {mode}
  set v_key_l {device_id vlan_otag_pri vlan_otag_vid 
      wan_enable_drop_unknown_vlan uni_ports nni_ports flow_id cleanup_tables}
      
  #Check input variable values or print help info (as -h or --help is given)
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set res [helper_sys_cfg_get -out aSysCfg]
  if {$res ne $CA_RES_OK } {
    log -tag error -msg "Failed to get system configuration"
    return $CA_RES_NOK
  } 
  
  #Set default variable values
  set aIn(-device_id) 0
  set aIn(-uni_ports) $aSysCfg(-lan_ports)
  set aIn(-nni_ports) $aSysCfg(-wan_ports)
  set aIn(-mode)      lan2lan
  set aIn(-vlan_otag_pri)  0
  set aIn(-vlan_otag_vid)  DONTCARE
  set aIn(-flooding_rate) 0xffffffff
  set aIn(-wan_enable_drop_unknown_vlan) DONTCARE
  set aIn(-cleanup_tables) true
#  if {$aSysCfg(-node_name) eq "g3-eng"} {
#    set aIn(-flow_id) 0
#  } else {
#    set aIn(-flow_id) 0xf08
#  }
  if {$aSysCfg(-pon_mode) eq "GPON"} {
    set aIn(-flow_id) 0xf08
  } else {
    set aIn(-flow_id) 0
  }
   
  #populate input values to aIn
  array set aIn $args
  
  #Define local variables
  set product $aSysCfg(-node_name)
  set ponMode $aSysCfg(-pon_mode)
  set uniList $aIn(-uni_ports)
  set wanPort [lindex $aIn(-nni_ports) 0]
  set devId $aIn(-device_id)
  set flowId  $aIn(-flow_id)
  log -tag info -msg "To use flow_id=$flowId"
  set mode    $aIn(-mode)
  set vlanOtagPri [string tolower $aIn(-vlan_otag_pri)]
  set vlanOtagVid [string tolower $aIn(-vlan_otag_vid)]
  set floodingRate $aIn(-flooding_rate)
  set wanEnableDropUnknownVlan [string toupper $aIn(-wan_enable_drop_unknown_vlan)]
  set cleanupTables $aIn(-cleanup_tables)
  if {$cleanupTables == "true" || $cleanupTables } {
    #cleanup all system tables
    set res [helper_tables_cleanup]
    if {$res ne $CA_RES_OK} {set ret_res $CA_RES_NOK}
  }
  if {[string first "saturn" $product] >= 0 || [string first "hgu" $product] >= 0} {
      foreach uniPort $uniList {
        #modify flow rate
        set res [wca_l2_flooding_rate_get -device_id $devId \
          -port_id $uniPort -ptype 1 -out aFR]
        if {$res ne $CA_RES_OK} {
          log -tag error -msg "Failed to get flooding rate for port $uniPort & type 1"
          set ret_res $CA_RES_NOK
        }
        set res [wca_l2_flooding_rate_set -device_id $devId \
          -port_id $uniPort -ptype 1 -pps 0 -rate $floodingRate]
        if {$res ne $CA_RES_OK} {
          log -tag error -msg "Failed to set flooding rate for port $uniPort & type 1"
          set ret_res $CA_RES_NOK
        }
        set res [wca_l2_flooding_rate_get -device_id $devId \
          -port_id $uniPort -ptype 2  -out aFR]
        if {$res ne $CA_RES_OK} {
          log -tag error -msg "Failed to get flooding rate for port $uniPort & type 2"
          set ret_res $CA_RES_NOK
        }
        set res [wca_l2_flooding_rate_set -device_id $devId \
          -port_id $uniPort -ptype 2 -pps 0 -rate $floodingRate]   
        if {$res ne $CA_RES_OK} {
          log -tag error -msg "Failed to set flooding rate for port $uniPort & type 2"
          set ret_res $CA_RES_NOK
        }          
       
        #create cls rule for lan2wan
        if {$mode == "lan2wan"} {;#cls rule for lan2wan   
          if {($vlanOtagPri eq "dontcare") || ($vlanOtagVid eq "dontcare")} {
            log -tag warning -msg "vlan_otag_pri and vlan_otag_vlan should be provided"
            #set ret_res $CA_RES_NOK; continue
          }
          set res [wca_classifier_rule_add  -device_id $devId -priority 0  \
              -src_port $uniPort \
              -mask_src_port 1 -action_forward 3 \
              -action_dest_port $wanPort \
              -action_option_flow_id $flowId \
              -mask_action_option_action_handle 1 \
              -vlan_otag_pri $vlanOtagPri \
              -vlan_otag_vid $vlanOtagVid]
          if {$res ne $CA_RES_OK} {
              log -tag error -msg "Failed to add cls rule as src_port=$uniPort & dst_port=$wanPort"
              set ret_res $CA_RES_NOK;        
          } 
        }   
    }

    if { $wanEnableDropUnknownVlan ne "DONTCARE"} {
      set res [wca_l2_vlan_port_control_set -device_id $devId  \
          -port_id  $wanPort -drop_unknown_vlan $wanEnableDropUnknownVlan ]
      if {$res ne $CA_RES_OK} {set ret_res $CA_RES_NOK}
    }
  }
  if {$mode == "l3fe" } {;#add l3 fe cls rules for all uni ports
      foreach uniPort $uniList {
          set res [wca_classifier_rule_add  -device_id $devId -priority 0  \
              -src_port $uniPort \
              -mask_src_port 1 -action_forward 1 \
              -action_dest_fe 1 \
              -action_option_priority 7 \
              -mask_action_option_priority 1]
          if {$res ne $CA_RES_OK} {
              log -tag error -msg "Failed to add l3 fe cls rule for uni port $uniPort"
              set ret_res $CA_RES_NOK;        
          }       
      }
  }  
  
  log -tag itfend
  return $ret_res
}
proc gw::helper_atc_cleanup {args} {
  variable CA_RES_OK 
  variable CA_RES_NOK
  set ifnm helper_atc_cleanup
  set res $CA_RES_OK
  set ret_res $CA_RES_OK
  log -tag itfbgn -msg $args
  set m_key_l {}
  set v_key_l {device_id wan_enable_drop_unknown_vlan uni_ports nni_ports cleanup_tables}
      
  #Check input variable values or print help info (as -h or --help is given)
  set res [helper_m_args_check -args $args -m_key_l $m_key_l]
  if {$res} {
    return $res
  }
  set res [helper_sys_cfg_get -out aSysCfg]
  if {$res ne $CA_RES_OK } {
    log -tag error -msg "Failed to get system configuration"
    return $CA_RES_NOK
  } 
  
  #Set default variable values
  set aIn(-device_id) 0
  set aIn(-uni_ports) $aSysCfg(-lan_ports)
  set aIn(-nni_ports) $aSysCfg(-wan_ports)
  set aIn(-flooding_rate) 2000
  set aIn(-wan_enable_drop_unknown_vlan) DONTCARE
  set aIn(-cleanup_tables) true
  
  #populate input values to aIn
  array set aIn $args
  
  #Define local variables
  set nodeName $aSysCfg(-node_name)
  set uniList $aIn(-uni_ports)
  set wanPort [lindex $aIn(-nni_ports) 0]
  set devId $aIn(-device_id)
  set floodingRate $aIn(-flooding_rate)
  set wanEnableDropUnknownVlan [string toupper $aIn(-wan_enable_drop_unknown_vlan)]
  set cleanupTables $aIn(-cleanup_tables)
    
  #cleanup all system tables
  if {$cleanupTables == "true" || $cleanupTables } {
    #cleanup all system tables
    set res [helper_tables_cleanup]
    if {$res ne $CA_RES_OK} {set ret_res $CA_RES_NOK}
  }
  if {$res ne $CA_RES_OK} {set ret_res $CA_RES_NOK}
  if {[string first "saturn" $nodeName] >= 0} {
    foreach uniPort $uniList {
      #modify flow rate
      set res [wca_l2_flooding_rate_get -device_id $devId \
        -port_id $uniPort -ptype 1 -out aFR]
      if {$res ne $CA_RES_OK} {
        log -tag warning -msg "Failed to get flooding rate for port $uniPort & type 1"
        set ret_res $CA_RES_NOK
      }
      set res [wca_l2_flooding_rate_set -device_id $devId \
        -port_id $uniPort -ptype 1 -pps 0 -rate $floodingRate]
      if {$res ne $CA_RES_OK} {
        log -tag warning -msg "Failed to set flooding rate for port $uniPort & type 1"
        set ret_res $CA_RES_NOK
      }
      set res [wca_l2_flooding_rate_get -device_id $devId \
        -port_id $uniPort -ptype 2  -out aFR]
      if {$res ne $CA_RES_OK} {
        log -tag warning -msg "Failed to get flooding rate for port $uniPort & type 2"
        set ret_res $CA_RES_NOK
      }
      set res [wca_l2_flooding_rate_set -device_id $devId \
        -port_id $uniPort -ptype 2 -pps 0 -rate $floodingRate]   
      if {$res ne $CA_RES_OK} {
        log -tag warning -msg "Failed to set flooding rate for port $uniPort & type 2"
        set ret_res $CA_RES_NOK
      } 
    }    
    if { $wanEnableDropUnknownVlan ne "DONTCARE"} {
      set res [wca_l2_vlan_port_control_set -device_id $devId  \
          -port_id  $wanPort -drop_unknown_vlan $wanEnableDropUnknownVlan ]
      if {$res ne $CA_RES_OK} {set ret_res $CA_RES_NOK}
    }
  }  
  log -tag itfend
  return $ret_res
}
#------------------------------------------------------
# High level APIs  -- END
#------------------------------------------------------