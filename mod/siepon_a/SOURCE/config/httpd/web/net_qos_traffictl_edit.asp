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
<head>
<title><% multilang("703" "LANG_ADD_IP_QOS_TRAFFIC_SHAPING_RULE"); %></title>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<script language="javascript" src="common.js"></script>
<script language="javascript" type="text/javascript">
//var waniflst = new it_nr("waniflst");
//<% ifWanList_tc(); %>
function on_init_page() {
 //with(document.forms[0]) {
 //for(var i in waniflst){
 //	if(i == "name"||i=="undefined" ||(typeof waniflst[i] != "string" && typeof waniflst[i] != "number")) continue;
 //	inflist.options.add(new Option(waniflst[i],i));
 //}
 //}
 if ( <% checkWrite("IPv6Show"); %> )
 {
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('ipprotbl').style.display = 'block';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ipprotbl.style.display = 'block';
   }
  }
 }
}
function on_apply() {
 with(document.forms[0]) {
  if (inflist.value == " ")
  {
   inflist.focus();
   alert("<% multilang("2217" "LANG_WAN_INTERFACE_NOT_ASSIGNED"); %>");
   return;
  }
  if(srcip.value != "" && sji_checkip(srcip.value) == false)
  {
   srcip.focus();
   alert("<% multilang("2218" "LANG_SOURCE_IP_INVALID"); %>");
   return;
  }
  if(dstip.value != "" && sji_checkip(dstip.value) == false)
  {
   dstip.focus();
   alert("<% multilang("2219" "LANG_DESTINATION_IP_INVALID"); %>");
   return;
  }
  if(srcnetmask.value != "" && sji_checkip(srcnetmask.value) == false)
  {
   srcnetmask.focus();
   alert("<% multilang("2220" "LANG_SOURCE_IP_MASK_INVALID"); %>");
   return;
  }
  if(dstnetmask.value != "" && sji_checkip(dstnetmask.value) == false)
  {
   dstnetmask.focus();
   alert("<% multilang("2221" "LANG_DESTINATION_IP_MASK_INVALID"); %>");
   return;
  }
  if(sport.value <0 || sport.value > 65536)
  {
   sport.focus();
   alert("<% multilang("2222" "LANG_SOURCE_PORT_INVALID"); %>");
   return;
  }
  if (sport.value > 0 && sport.value < 65535)
  {
   if (protolist.value!= 1 && protolist.value!= 2 && protolist.value!= 4) {
    sport.focus();
    alert("<% multilang("2223" "LANG_PLEASE_ASSIGN_TCP_UDP"); %>");
    return;
   }
  }
  if(dport.value <0 || dport.value > 65536)
  {
   dport.focus();
   alert("<% multilang("2224" "LANG_DESTINATION_PORT_INVALID"); %>");
   return;
  }
  if (dport.value > 0 && dport.value<65535)
  {
   if (protolist.value!= 1 && protolist.value!= 2 && protolist.value!= 4) {
    dport.focus();
    alert("<% multilang("2223" "LANG_PLEASE_ASSIGN_TCP_UDP"); %>");
    return;
   }
  }
  if(rate.value<0)
  {
   rate.focus();
   alert("<% multilang("2225" "LANG_UPLINK_RATE_INVALID"); %>");
   return;
  }
  if ( <% checkWrite("IPv6Show"); %> ) {
   // For IPv6
   if(document.forms[0].IpProtocolType.value == 2) {
    if(sip6.value != ""){
     if (! isGlobalIpv6Address(sip6.value) ){
      alert("<% multilang("2190" "LANG_INVALID_SOURCE_IPV6_ADDRESS"); %>");
      return;
     }
     if ( sip6PrefixLen.value != "" ) {
      var prefixlen= getDigit(sip6PrefixLen.value, 1);
      if (prefixlen > 128 || prefixlen <= 0) {
       alert("<% multilang("2191" "LANG_INVALID_SOURCE_IPV6_PREFIX_LENGTH"); %>");
       return;
      }
     }
    }
    if(dip6.value != ""){
     if (! isGlobalIpv6Address(dip6.value) ){
      alert("<% multilang("2192" "LANG_INVALID_DESTINATION_IPV6_ADDRESS"); %>");
      return;
     }
     if ( dip6PrefixLen.value != "" ) {
      var prefixlen= getDigit(dip6PrefixLen.value, 1);
      if (prefixlen > 128 || prefixlen <= 0) {
       alert("<% multilang("2193" "LANG_INVALID_DESTINATION_IPV6_PREFIX_LENGTH"); %>");
       return;
      }
     }
    }
   }
  }
  // For IPv4 and IPv6
  if ( <% checkWrite("IPv6Show"); %> ) {
   // For IPv4
   if(document.forms[0].IpProtocolType.value == 1){
    lst.value = "inf="+inflist.value+"&proto="+protolist.value+"&IPversion="+IpProtocolType.value+"&srcip="+srcip.value+"&srcnetmask="+srcnetmask.value+
     "&dstip="+dstip.value+"&dstnetmask="+dstnetmask.value+"&sport="+sport.value+"&dport="+dport.value+"&rate="+rate.value+"&direction="+direction.value;
   }
   // For IPv6
   else if (document.forms[0].IpProtocolType.value == 2) {
    lst.value = "inf="+inflist.value+"&proto="+protolist.value+"&IPversion="+IpProtocolType.value+"&sip6="+sip6.value+"&sip6PrefixLen="+sip6PrefixLen.value+
     "&dip6="+dip6.value+"&dip6PrefixLen="+dip6PrefixLen.value+"&sport="+sport.value+"&dport="+dport.value+"&rate="+rate.value+"&direction="+direction.value;
   }
  }
  // For IPv4 only
  else
  {
    lst.value = "inf="+inflist.value+"&proto="+protolist.value+"&srcip="+srcip.value+"&srcnetmask="+srcnetmask.value+
     "&dstip="+dstip.value+"&dstnetmask="+dstnetmask.value+"&sport="+sport.value+"&dport="+dport.value+"&rate="+rate.value+"&direction="+direction.value;
  }
  submit();
 }
}
function protocolChange()
{
 // If protocol is IPv4 only.
 if(document.forms[0].IpProtocolType.value == 1){
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('ip4tbl').style.display = 'block';
   document.getElementById('ip6tbl').style.display = 'none';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ip4tbl.style.display = 'block';
    document.all.ip6tbl.style.display = 'none';
   }
  }
 }
 // If protocol is IPv6 only.
 else if(document.forms[0].IpProtocolType.value == 2){
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('ip4tbl').style.display = 'none';
   document.getElementById('ip6tbl').style.display = 'block';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ip4tbl.style.display = 'none';
    document.all.ip6tbl.style.display = 'block';
   }
  }
 }
}
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init_page();">
<blockquote>
 <DIV align="left" style="padding-left:20px; padding-top:5px;">
  <form id="form" action="/boaform/admin/formQosTraffictlEdit" method="post">
   <h2><font color="#0000FF">Add IP QoS Traffic Shaping Rule</font></h2>
   <div id='ipprotbl' style="display:none">
   <table cellSpacing="1" cellPadding="0" border="0">
    <tr><td width="150px">IP <% multilang("607" "LANG_VERSION"); %>:</td>
     <td><select id="IpProtocolType" onChange="protocolChange()" name="IpProtocolType">
      <option value="1" > IPv4</option>
      <option value="2" > IPv6</option>
      </select>
     </td>
    </tr>
   </table>
   </div>
   <div id='qos_direction' style="display:<% check_display("qos_direction"); %>" >
   <table cellSpacing="1" cellPadding="0" border="0">
   <tr>
     <td width="150px"><% multilang("315" "LANG_DIRECTION");%>:</td>
     <td>
        <select name="direction">
       <option value="0"><% multilang("436" "LANG_UPSTREAM");%></option>
       <option value="1"><% multilang("435" "LANG_DOWNSTREAM");%> </option>
           </select>
     </td>
   </tr>
   </table>
   </div>
   <table cellSpacing="1" cellPadding="0" border="0">
    <tr>
     <td width="150px"><div id='wan_interface' style="display:<% check_display("wan_interface"); %>" ><% multilang("52" "LANG_INTERFACE"); %>:</div></td>
     <td><div id='wan_interface_value' style="display:<% check_display("wan_interface"); %>" ><select id="inflist"><% if_wan_list("queueITF-without-Any"); %></select></div></td>
    </tr>
    <tr>
     <td width="150px"><% multilang("75" "LANG_PROTOCOL"); %>:</td>
     <td>
        <select name="protolist">
       <option value="0"><% multilang("276" "LANG_NONE"); %></option>
       <option value="1">TCP </option>
       <option value="2">UDP </option>
       <option value="3">ICMP</option>
<!-- <option value="4">TCP/UDP</option> -->
           </select>
     </td>
    </tr>
   </table>
   <div id='ip4tbl' style="display:block;">
   <table cellSpacing="1" cellPadding="0" border="0">
    <tr>
     <td width="150px"><% multilang("319" "LANG_SOURCE"); %> IP:</td>
     <td><input type="text" name="srcip" size="15" maxlength="15" style="width:150px"></td>
    </tr>
    <tr>
     <td width="150px"><% multilang("567" "LANG_SOURCE_MASK"); %>:</td>
     <td><input type="text" name="srcnetmask" size="15" maxlength="15" style="width:150px"></td>
    </tr>
    <tr>
     <td width="150px"><% multilang("320" "LANG_DESTINATION"); %> IP:</td>
     <td><input type="text" name="dstip" size="15" maxlength="15" style="width:150px"></td>
    </tr>
    <tr>
     <td width="150px"><% multilang("568" "LANG_DESTINATION_MASK"); %>:</td>
     <td><input type="text" name="dstnetmask" size="15" maxlength="15" style="width:150px"></td>
    </tr>
   </table>
   </div>
   <div id='ip6tbl' style="display:none;">
   <table cellSpacing="1" cellPadding="0" border="0">
    <tr>
     <td width="150px"><% multilang("319" "LANG_SOURCE"); %> IP:</td>
     <td><input type="text" name="sip6" size="26" maxlength="39" style="width:150px"></td>
    </tr>
    <tr>
       <td width="150px"><% multilang("704" "LANG_SOURCE_PREFIX_LENGTH"); %>:</td>
     <td><input type="text" name="sip6PrefixLen" size="15" maxlength="15" style="width:150px"></td>
    </tr>
    <tr>
      <td width="150px"><% multilang("320" "LANG_DESTINATION"); %> IP:</td>
     <td><input type="text" name="dip6" size="26" maxlength="39" style="width:150px"></td>
    </tr>
    <tr>
       <td width="150px"><% multilang("705" "LANG_DESTINATION_PREFIX_LENGTH"); %>:</td>
     <td><input type="text" name="dip6PrefixLen" size="15" maxlength="15" style="width:150px"></td>
    </tr>
   </table>
   </div>
   <table cellSpacing="1" cellPadding="0" border="0">
    <tr>
     <td width="150px"><% multilang("322" "LANG_SOURCE_PORT"); %>:</td>
     <td><input type="text" name="sport" size="6" style="width:80px"></td>
    </tr>
    <tr>
       <td width="150px"><% multilang("323" "LANG_DESTINATION_PORT"); %>:</td>
     <td><input type="text" name="dport" size="6" style="width:80px"></td>
    </tr>
    <tr>
      <td width="150px"><% multilang("694" "LANG_RATE_LIMIT"); %>:</td>
     <td><input type="text" name="rate" size="6" style="width:80px"> kb/s</td>
    </tr>
   </table><br><br>
   <input type="button" name="return" value="<% multilang("644" "LANG_CLOSE"); %>" onClick="location.href='/net_qos_traffictl.asp';" style="width:80px">
  <input type="button" name="apply" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" onClick="on_apply();" style="width:80px">
   <input type="hidden" name="lst" id="lst" value="">
   <input type="hidden" name="submit-url" value="/net_qos_traffictl.asp">
  </form>
 </DIV>
</blockquote>
</body>
</html>
