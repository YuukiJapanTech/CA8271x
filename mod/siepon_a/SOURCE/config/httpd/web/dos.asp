<!- Copyright (C) 1991-2016 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   "http://www.gnu.org/licenses/".  ->
<!- This header is separate from features.h so that the compiler can
   include it implicitly at the start of every compilation.  It must
   not itself include "features.h" or any other header that includes
   "features.h" because the implicit include comes before any feature
   test macros that may be defined in a source file before it first
   explicitly includes a system header.  GCC knows the name of this
   header in order to preinclude it.  ->
<!- glibc's intent is to support the IEC 559 math functionality, real
   and complex.  If the GCC (4.9 and later) predefined macros
   specifying compiler intent are available, use them to determine
   whether the overall intent is to support these features; otherwise,
   presume an older compiler has intent to support these features and
   define these macros by default.  ->
<!- wchar_t uses Unicode 8.0.0.  Version 8.0 of the Unicode Standard is
   synchronized with ISO/IEC 10646:2014, plus Amendment 1 (published
   2015-05-15).  ->
<!- We do not support C11 "threads.h".  ->
<html>
<! Copyright (c) Realtek Semiconductor Corp., 2003. All Rights Reserved. ->
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title>DoS<% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js"> </script>
<script>
var dosEnabled=0 ;
var rg_config=<% checkWrite("config_rtk_rg"); %>;
function setDosEnabled() {
}
function dosEnabledClick(){
 if(document.DosCfg.dosEnabled.checked){
  enableTextField(document.DosCfg.sysfloodSYN);
  enableTextField(document.DosCfg.sysfloodFIN);
  enableTextField(document.DosCfg.sysfloodUDP);
  enableTextField(document.DosCfg.sysfloodICMP);
  enableTextField(document.DosCfg.sysfloodSYNcount);
  enableTextField(document.DosCfg.sysfloodFINcount);
  enableTextField(document.DosCfg.sysfloodUDPcount);
  enableTextField(document.DosCfg.sysfloodICMPcount);
  enableTextField(document.DosCfg.ipfloodSYN);
  enableTextField(document.DosCfg.ipfloodFIN);
  enableTextField(document.DosCfg.ipfloodUDP);
  enableTextField(document.DosCfg.ipfloodICMP);
  enableTextField(document.DosCfg.ipfloodSYNcount);
  enableTextField(document.DosCfg.ipfloodFINcount);
  enableTextField(document.DosCfg.ipfloodUDPcount);
  enableTextField(document.DosCfg.ipfloodICMPcount);
  enableTextField(document.DosCfg.TCPUDPPortScan);
  enableTextField(document.DosCfg.portscanSensi);
  enableTextField(document.DosCfg.ICMPSmurfEnabled);
  enableTextField(document.DosCfg.IPLandEnabled);
  enableTextField(document.DosCfg.IPSpoofEnabled);
  enableTextField(document.DosCfg.IPTearDropEnabled);
  enableTextField(document.DosCfg.PingOfDeathEnabled);
  enableTextField(document.DosCfg.TCPScanEnabled);
  enableTextField(document.DosCfg.TCPSynWithDataEnabled);
  enableTextField(document.DosCfg.UDPBombEnabled);
  enableTextField(document.DosCfg.UDPEchoChargenEnabled);
  enableTextField(document.DosCfg.sourceIPblock);
  enableTextField(document.DosCfg.IPblockTime);
 }
 else{
  document.DosCfg.sysfloodSYN.checked=0;
  document.DosCfg.sysfloodFIN.checked=0;
  document.DosCfg.sysfloodUDP.checked=0;
  document.DosCfg.sysfloodICMP.checked=0;
  document.DosCfg.ipfloodSYN.checked=0;
  document.DosCfg.ipfloodFIN.checked=0;
  document.DosCfg.ipfloodUDP.checked=0;
  document.DosCfg.ipfloodICMP.checked=0;
  document.DosCfg.TCPUDPPortScan.checked=0;
  document.DosCfg.ICMPSmurfEnabled.checked=0;
  document.DosCfg.IPLandEnabled.checked=0;
  document.DosCfg.IPSpoofEnabled.checked=0;
  document.DosCfg.IPTearDropEnabled.checked=0;
  document.DosCfg.PingOfDeathEnabled.checked=0;
  document.DosCfg.TCPScanEnabled.checked=0;
  document.DosCfg.TCPSynWithDataEnabled.checked=0;
  document.DosCfg.UDPBombEnabled.checked=0;
  document.DosCfg.UDPEchoChargenEnabled.checked=0;
  document.DosCfg.sourceIPblock.checked=0;
  disableTextField(document.DosCfg.sysfloodSYN);
  disableTextField(document.DosCfg.sysfloodFIN);
  disableTextField(document.DosCfg.sysfloodUDP);
  disableTextField(document.DosCfg.sysfloodICMP);
  disableTextField(document.DosCfg.sysfloodSYNcount);
  disableTextField(document.DosCfg.sysfloodFINcount);
  disableTextField(document.DosCfg.sysfloodUDPcount);
  disableTextField(document.DosCfg.sysfloodICMPcount);
  disableTextField(document.DosCfg.ipfloodSYN);
  disableTextField(document.DosCfg.ipfloodFIN);
  disableTextField(document.DosCfg.ipfloodUDP);
  disableTextField(document.DosCfg.ipfloodICMP);
  disableTextField(document.DosCfg.ipfloodSYNcount);
  disableTextField(document.DosCfg.ipfloodFINcount);
  disableTextField(document.DosCfg.ipfloodUDPcount);
  disableTextField(document.DosCfg.ipfloodICMPcount);
  disableTextField(document.DosCfg.TCPUDPPortScan);
  disableTextField(document.DosCfg.portscanSensi);
  disableTextField(document.DosCfg.ICMPSmurfEnabled);
  disableTextField(document.DosCfg.IPLandEnabled);
  disableTextField(document.DosCfg.IPSpoofEnabled);
  disableTextField(document.DosCfg.IPTearDropEnabled);
  disableTextField(document.DosCfg.PingOfDeathEnabled);
  disableTextField(document.DosCfg.TCPScanEnabled);
  disableTextField(document.DosCfg.TCPSynWithDataEnabled);
  disableTextField(document.DosCfg.UDPBombEnabled);
  disableTextField(document.DosCfg.UDPEchoChargenEnabled);
  disableTextField(document.DosCfg.sourceIPblock);
  disableTextField(document.DosCfg.IPblockTime);
 }
}
function SelectAll(){
 if(document.DosCfg.dosEnabled.checked){
  document.DosCfg.sysfloodSYN.checked=1;
  document.DosCfg.sysfloodFIN.checked=1;
  document.DosCfg.sysfloodUDP.checked=1;
  document.DosCfg.sysfloodICMP.checked=1;
  document.DosCfg.ipfloodSYN.checked=1;
  document.DosCfg.ipfloodFIN.checked=1;
  document.DosCfg.ipfloodUDP.checked=1;
  document.DosCfg.ipfloodICMP.checked=1;
  document.DosCfg.TCPUDPPortScan.checked=1;
  document.DosCfg.ICMPSmurfEnabled.checked=1;
  document.DosCfg.IPLandEnabled.checked=1;
  document.DosCfg.IPSpoofEnabled.checked=1;
  document.DosCfg.IPTearDropEnabled.checked=1;
  document.DosCfg.PingOfDeathEnabled.checked=1;
  document.DosCfg.TCPScanEnabled.checked=1;
  document.DosCfg.TCPSynWithDataEnabled.checked=1;
  document.DosCfg.UDPBombEnabled.checked=1;
  document.DosCfg.UDPEchoChargenEnabled.checked=1;
 }
}
function ClearAll(){
 if(document.DosCfg.dosEnabled.checked){
  document.DosCfg.sysfloodSYN.checked=0;
  document.DosCfg.sysfloodFIN.checked=0;
  document.DosCfg.sysfloodUDP.checked=0;
  document.DosCfg.sysfloodICMP.checked=0;
  document.DosCfg.ipfloodSYN.checked=0;
  document.DosCfg.ipfloodFIN.checked=0;
  document.DosCfg.ipfloodUDP.checked=0;
  document.DosCfg.ipfloodICMP.checked=0;
  document.DosCfg.TCPUDPPortScan.checked=0;
  document.DosCfg.ICMPSmurfEnabled.checked=0;
  document.DosCfg.IPLandEnabled.checked=0;
  document.DosCfg.IPSpoofEnabled.checked=0;
  document.DosCfg.IPTearDropEnabled.checked=0;
  document.DosCfg.PingOfDeathEnabled.checked=0;
  document.DosCfg.TCPScanEnabled.checked=0;
  document.DosCfg.TCPSynWithDataEnabled.checked=0;
  document.DosCfg.UDPBombEnabled.checked=0;
  document.DosCfg.UDPEchoChargenEnabled.checked=0;
 }
}
function saveChanges(){
 if(rg_config=="yes"){
  if(document.DosCfg.sysfloodSYN.checked){
   if(document.DosCfg.sysfloodSYNcount.value < 5){
    alert('<% multilang("2064" "LANG_MUST_LARGER_THAN_5_PACKETS_SECOND"); %>');
    return false;
   }
  }
  if(document.DosCfg.sysfloodFIN.checked){
   if(document.DosCfg.sysfloodFINcount.value < 5){
    alert('<% multilang("2064" "LANG_MUST_LARGER_THAN_5_PACKETS_SECOND"); %>');
    return false;
   }
  }
  if(document.DosCfg.sysfloodICMP.checked){
   if(document.DosCfg.sysfloodICMPcount.value < 5){
    alert('<% multilang("2064" "LANG_MUST_LARGER_THAN_5_PACKETS_SECOND"); %>');
    return false;
   }
  }
 }
 return true;
}
</script>
</head>
<blockquote>
<h2><font color="#0000FF">DoS<% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<body>
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr><td> <font size=2>
  <% multilang("770" "LANG_DOS_DENIAL_OF_SERVICE_ATTACK_WHICH_IS_LAUNCHED_BY_HACKER_AIMS_TO_PREVENT_LEGAL_USER_FROM_TAKING_NORMAL_SERVICES_IN_THIS_PAGE_YOU_CAN_CONFIGURE_TO_PREVENT_SOME_KINDS_OF_DOS_ATTACK"); %>
 </font><br></td></tr>
 <checkWrite("ModifyTip");>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=0 cellpadding=0>
<form action=/boaform/admin/formDosCfg method=POST name="DosCfg">
  <tr><td width="200" ><font size=2><b><input type="checkbox" name="dosEnabled" value="ON" onclick="dosEnabledClick()">&nbsp;&nbsp;<% multilang("771" "LANG_ENABLE_DOS_BLOCK"); %></b></font></td></tr>
  <br>
  <table border="0" width=600>
  <br>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="sysfloodSYN" value="ON" > <font size=2><b> Whole System Flood: SYN </b></font><br></td>
  <td width="40%"><input type="text" name="sysfloodSYNcount" size="6" maxlength="4" value=<% getInfo("syssynFlood"); %> > <font size=2><b> packets/second</b></font><br></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="sysfloodFIN" value="ON" > <font size=2><b> Whole System Flood: FIN </b></font><br></td>
  <td width="40%"><input type="text" name="sysfloodFINcount" size="6" maxlength="4" value=<% getInfo("sysfinFlood"); %> > <font size=2><b> packets/second</b></font><br></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="sysfloodUDP" value="ON" > <font size=2><b> Whole System Flood: UDP </b></font><br></td>
  <td width="40%"><input type="text" name="sysfloodUDPcount" size="6" maxlength="4" value=<% getInfo("sysudpFlood"); %> > <font size=2><b> packets/second</b></font><br></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="sysfloodICMP" value="ON" > <font size=2><b> Whole System Flood: ICMP </b></font><br></td>
  <td width="40%"><input type="text" name="sysfloodICMPcount" size="6" maxlength="4" value=<% getInfo("sysicmpFlood"); %> > <font size=2><b> packets/second</b></font><br></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="ipfloodSYN" value="ON" > <font size=2><b> Per-Source IP Flood: SYN </b></font><br></td>
  <td width="40%"><input type="text" name="ipfloodSYNcount" size="6" maxlength="4" value=<% getInfo("pipsynFlood"); %> > <font size=2><b> packets/second</b></font><br></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="ipfloodFIN" value="ON" > <font size=2><b> Per-Source IP Flood: FIN </b></font><br></td>
  <td width="40%"><input type="text" name="ipfloodFINcount" size="6" maxlength="4" value=<% getInfo("pipfinFlood"); %> > <font size=2><b> packets/second</b></font><br></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="ipfloodUDP" value="ON" > <font size=2><b> Per-Source IP Flood: UDP </b></font><br></td>
  <td width="40%"><input type="text" name="ipfloodUDPcount" size="6" maxlength="4" value=<% getInfo("pipudpFlood"); %> > <font size=2><b> packets/second</b></font><br></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="ipfloodICMP" value="ON" > <font size=2><b> Per-Source IP Flood: ICMP </b></font><br></td>
  <td width="40%"><input type="text" name="ipfloodICMPcount" size="6" maxlength="4" value=<% getInfo("pipicmpFlood"); %> > <font size=2><b> packets/second</b></font><br></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="TCPUDPPortScan" value="ON" > <font size=2><b> TCP/UDP PortScan </b></font></td>
 <td width="40%">
  <select name="portscanSensi">
   <option value=0 > Low </option>
   <option value=1 > High </option>
  </select>
 <font size=2><b> Sensitivity </b></font></td>
  </tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="ICMPSmurfEnabled" value="ON" > <font size=2><b> ICMP Smurf </b></font></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="IPLandEnabled" value="ON" > <font size=2><b> IP Land </b></font></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="IPSpoofEnabled" value="ON" > <font size=2><b> IP Spoof </b></font></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="IPTearDropEnabled" value="ON" > <font size=2><b> IP TearDrop </b></font></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="PingOfDeathEnabled" value="ON" > <font size=2><b> PingOfDeath </b></font></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="TCPScanEnabled" value="ON" > <font size=2><b> TCP Scan </b></font></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="TCPSynWithDataEnabled" value="ON" > <font size=2><b> TCP SynWithData </b></font></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="UDPBombEnabled" value="ON" > <font size=2><b> UDP Bomb </b></font></td></tr>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="UDPEchoChargenEnabled" value="ON" > <font size=2><b> UDP EchoChargen </b></font></td></tr>
    </table>
    <br>
    <input type="button" value="<% multilang("772" "LANG_SELECT_ALL"); %>" name="selectAll" onClick="SelectAll()">&nbsp;&nbsp;
    <input type="button" value="<% multilang("773" "LANG_CLEAR"); %>" name="clearAll" onClick="ClearAll()">&nbsp;&nbsp;
    <br>
    <br>
  <table border="0" width=600>
  <tr><td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="sourceIPblock" value="ON" > <font size=2><b> <% multilang("774" "LANG_ENABLE_SOURCE_IP_BLOCKING"); %> </b></font></td>
   <td width="40%"><input type="text" name="IPblockTime" size="4" maxlength="3" value=<% getInfo("blockTime"); %> > <font size=2><b> <% multilang("775" "LANG_BLOCK_INTERVAL"); %> (<% multilang("287" "LANG_SECONDS"); %>)</b></font><br></td></tr>
  </table>
  <br>
  <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="enableDos" onClick="return saveChanges()">&nbsp;&nbsp;
  <input type="hidden" value="/dos.asp" name="submit-url">
<script>
 <% initPage("dos"); %>
</script>
<script>
 dosEnabledClick();
 </script>
</form>
</table>
</body>
</html>
