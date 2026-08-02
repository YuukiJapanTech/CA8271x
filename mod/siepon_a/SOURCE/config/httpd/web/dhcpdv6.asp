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
<title>DHCPv6 <% multilang("305" "LANG_SETTINGS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function showDhcpv6Svr()
{
 var html;
 if (document.dhcpd.dhcpdenable[0].checked == true)
  document.getElementById('displayDhcpSvr').innerHTML=
   '<input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save">&nbsp;&nbsp;';
 else if (document.dhcpd.dhcpdenable[1].checked == true)
  document.getElementById('displayDhcpSvr').innerHTML=
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
   '<tr><font color="#000000" size=2>'+
   '<% multilang("654" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_UPPER_INTERFACE_SERVER_LINK_FOR_DHCPV6_RELAY"); %>'+
   '</font></tr>'+
   '<tr><td><hr size=1 noshade align=top></td></tr>'+
   '</table>'+
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
   '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("655" "LANG_UPPER_INTERFACE"); %>:</b></font></td>'+
   '<td width="35%">'+
   '<select name="upper_if">'+
   '<% if_wan_list("all2"); %>'+
   '</select>'+
   '</td>'+
   '</tr>'+
   '</table>'+
   '<input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save">&nbsp;&nbsp;';
 else if (document.dhcpd.dhcpdenable[2].checked == true) {
  html=
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
   '<tr><font color="#000000" size=2>'+
   '<% multilang("656" "LANG_ENABLE_THE_DHCPV6_SERVER_IF_YOU_ARE_USING_THIS_DEVICE_AS_A_DHCPV6_SERVER_THIS_PAGE_LISTS_THE_IP_ADDRESS_POOLS_AVAILABLE_TO_HOSTS_ON_YOUR_LAN_THE_DEVICE_DISTRIBUTES_NUMBERS_IN_THE_POOL_TO_HOSTS_ON_YOUR_NETWORK_AS_THEY_REQUEST_INTERNET_ACCESS"); %>'+
   '</table>'+
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
   '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("284" "LANG_IP_POOL_RANGE"); %>:</b></td>';
  html+=
   '<td width="70%"><input type="text" name="dhcpRangeStart" size=40 maxlength=39 value="<% getInfo("dhcpv6s_range_start"); %>">'+
   '<font face="Arial" size="5">- <input type="text" name="dhcpRangeEnd" size=40 maxlength=39 value="<% getInfo("dhcpv6s_range_end"); %>">&nbsp;';
  html+= '</td>'+
   '</tr>';
  html += '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("392" "LANG_PREFIX_LENGTH"); %>:</b></font></td>'+
   '<td width="70%"><font size=2>'+
   '<input type="text" name="prefix_len" size=10 maxlength=3 value="<% getInfo("dhcpv6s_prefix_length"); %>">'+
   '</td>'+
   '</tr>';
  html += '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("657" "LANG_VALID_LIFETIME"); %>:</b></td>'+
   '<td width="70%"><font size=2>'+
   '<input type="text" name="Dltime" size=10 maxlength=9 value="<% getInfo("dhcpv6s_default_LTime"); %>"><b> <% multilang("287" "LANG_SECONDS"); %></b>'+
   '</td>'+
   '</tr>'+
   '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("658" "LANG_PREFERRED_LIFETIME"); %>:</b></td>'+
   '<td width="70%"><font size=2>'+
   '<input type="text" name="PFtime" size=10 maxlength=9 value="<% getInfo("dhcpv6s_preferred_LTime"); %>"><b> <% multilang("287" "LANG_SECONDS"); %></b>'+
   '</td>'+
   '</tr>'+
   '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("659" "LANG_RENEW_TIME"); %>:</b></td>'+
   '<td width="70%"><font size=2>'+
   '<input type="text" name="RNtime" size=10 maxlength=9 value="<% getInfo("dhcpv6s_renew_time"); %>"><b> <% multilang("287" "LANG_SECONDS"); %></b>'+
   '</td>'+
   '</tr>'+
   '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("660" "LANG_REBIND_TIME"); %>:</b></td>'+
   '<td width="70%"><font size=2>'+
   '<input type="text" name="RBtime" size=10 maxlength=9 value="<% getInfo("dhcpv6s_rebind_time"); %>"><b> <% multilang("287" "LANG_SECONDS"); %></b>'+
   '</td>'+
   '</tr>'+
   '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("661" "LANG_CLIENT"); %> DUID:</b></td>'+
   '<td width="70%"><font size=2>'+
   '<input type="text" name="clientID" size=42 maxlength=41 value="<% getInfo("dhcpv6s_clientID"); %>">'+
   '</td>'+
   '</tr>'+
   '</table>'+
   '<input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">&nbsp;&nbsp;'+
   '<tr><hr size=1 noshade align=top></tr>'+
   '<tr>'+
   '<td><font size=2><b><% multilang("349" "LANG_DOMAIN"); %>:</b></td>'+
   '<td><input type="text" name="domainStr" size="15" maxlength="50">&nbsp;&nbsp;</td>'+
   '<td><input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="addDomain">&nbsp;&nbsp;</td>'+
   '</tr>'+
   '<br>'+
   '<br>'+
   '<table border=0 width="300" cellspacing=4 cellpadding=0>'+
   '<tr><font size=2><b><% multilang("662" "LANG_DOMAIN_SEARCH_TABLE"); %>:</b></font></tr>'+
   <% showDhcpv6SDOMAINTable(); %>
   '</table>'+
   '<br>'+
   '<input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delDomain">&nbsp;&nbsp;'+
   '<input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="delAllDomain">&nbsp;&nbsp;&nbsp;'+
   '<br>'+
   '<br>'+
   '<tr><hr size=1 noshade align=top></tr>'+
   '<tr>'+
   '<td><font size=2><b><% multilang("663" "LANG_NAME_SERVER"); %> IP:</b></td>'+
   '<td><input type="text" name="nameServerIP" size="15" maxlength="40">&nbsp;&nbsp;</td>'+
   '<td><input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="addNameServer">&nbsp;&nbsp;</td>'+
   '</tr>'+
   '<br>'+
   '<br>'+
   '<table border=0 width="300" cellspacing=4 cellpadding=0>'+
   '<tr><font size=2><b><% multilang("664" "LANG_NAME_SERVER_TABLE"); %>:</b></font></tr>'+
   <% showDhcpv6SNameServerTable(); %>
   '</table>'+
   '<br>'+
   '<input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delNameServer">&nbsp;&nbsp;'+
   '<input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="delAllNameServer">&nbsp;&nbsp;&nbsp;';
  document.getElementById('displayDhcpSvr').innerHTML=html;
 }
 else if (document.dhcpd.dhcpdenable[3].checked == true)
  document.getElementById('displayDhcpSvr').innerHTML=
   '<tr><font color="#000000" size=2>'+
   '<% multilang("665" "LANG_AUTO_CONFIG_BY_PREFIX_DELEGATION_FOR_DHCPV6_SERVER"); %>'+
   '</tr>'+
   '<input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save">&nbsp;&nbsp;';
}
function checkDigitRange_leaseTime(str, min)
{
  d = parseInt(str, 10);
  if ( d < min || d == 0)
       return false;
  return true;
}
function validateKey_leasetime(str)
{
   for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
      (str.charAt(i) == '-' ) )
   continue;
 return 0;
  }
  return 1;
}
function saveChanges()
{
 if (document.dhcpd.dhcpRangeStart.value =="") {
  alert('<% multilang("2021" "LANG_START_IP_ADDRESS_CANNOT_BE_EMPTY_FORMAT_IS_IPV6_ADDRESS_FOR_EXAMPLE_2000_0200_10"); %>');
  document.dhcpd.dhcpRangeStart.value = document.dhcpd.dhcpRangeStart.defaultValue;
  document.dhcpd.dhcpRangeStart.focus();
  return false;
 } else {
  if ( validateKeyV6IP(document.dhcpd.dhcpRangeStart.value) == 0) {
   alert('<% multilang("2022" "LANG_INVALID_START_IP"); %>');
   document.dhcpd.dhcpRangeStart.focus();
   return false;
  }
 }
 if (document.dhcpd.dhcpRangeEnd.value =="") {
  alert('<% multilang("2023" "LANG_END_IP_ADDRESS_CANNOT_BE_EMPTY_FORMAT_IS_IPV6_ADDRESS_FOR_EXAMPLE_2000_0200_20"); %>');
  document.dhcpd.dhcpRangeEnd.value = document.dhcpd.dhcpRangeEnd.defaultValue;
  document.dhcpd.dhcpRangeEnd.focus();
  return false;
 } else {
  if ( validateKeyV6IP(document.dhcpd.dhcpRangeEnd.value) == 0) {
   alert('<% multilang("2024" "LANG_INVALID_END_IP"); %>');
   document.dhcpd.dhcpRangeEnd.focus();
   return false;
  }
 }
 if ( document.dhcpd.prefix_len.value=="") {
  alert('<% multilang("2025" "LANG_PLEASE_INPUT_IP_PREFIX_LENGTH"); %>');
  document.dhcpd.prefix_len.focus();
  return false;
 }
 if ( document.dhcpd.Dltime.value=="") {
  alert('<% multilang("2026" "LANG_PLEASE_INPUT_DHCP_DEFAULT_LEASE_TIME"); %>');
  document.dhcpd.Dltime.focus();
  return false;
 }
 if ( validateKey_leasetime( document.dhcpd.Dltime.value ) == 0 ) {
  alert('<% multilang("2027" "LANG_INVALID_DHCP_SERVER_DEFAULT_LEASE_TIME_NUMBER"); %>');
  document.dhcpd.Dltime.value = document.dhcpd.Dltime.defaultValue;
  document.dhcpd.Dltime.focus();
  return false;
 }
 if ( !checkDigitRange_leaseTime(document.dhcpd.Dltime.value, 0) ) {
  alert('<% multilang("2028" "LANG_INVALID_DHCP_SERVER_DEFAULT_LEASE_TIME"); %>');
  document.dhcpd.Dltime.value = document.dhcpd.Dltime.defaultValue;
  document.dhcpd.Dltime.focus();
  return false;
 }
 if ( document.dhcpd.PFtime.value=="") {
  alert('<% multilang("2029" "LANG_PLEASE_INPUT_DHCP_PREFERED_LIFETIME"); %>');
  document.dhcpd.PFtime.focus();
  return false;
 }
 if ( validateKey_leasetime( document.dhcpd.PFtime.value ) == 0 ) {
  alert('<% multilang("2030" "LANG_INVALID_DHCP_SERVER_PREFERED_LIFETIME_NUMBER"); %>');
  document.dhcpd.PFtime.value = document.dhcpd.PFtime.defaultValue;
  document.dhcpd.PFtime.focus();
  return false;
 }
 if ( !checkDigitRange_leaseTime(document.dhcpd.PFtime.value, 0) ) {
  alert('<% multilang("2031" "LANG_INVALID_DHCP_SERVER_PREFERED_LIFETIME"); %>');
  document.dhcpd.PFtime.value = document.dhcpd.PFtime.defaultValue;
  document.dhcpd.PFtime.focus();
  return false;
 }
 if ( document.dhcpd.RNtime.value=="") {
  alert('<% multilang("2032" "LANG_PLEASE_INPUT_DHCP_RENEW_TIME"); %>');
  document.dhcpd.RNtime.focus();
  return false;
 }
 if ( document.dhcpd.RBtime.value=="") {
  alert('<% multilang("2033" "LANG_PLEASE_INPUT_DHCP_REBIND_TIME"); %>');
  document.dhcpd.RBtime.focus();
  return false;
 }
 if ( document.dhcpd.clientID.value=="") {
  alert('<% multilang("2034" "LANG_PLEASE_INPUT_DHCP_CLIENT_OUID"); %>');
  document.dhcpd.clientID.focus();
  return false;
 }
 return true;
}
function enabledhcpd()
{
 document.dhcpd.dhcpdenable[2].checked = true;
 //ip = ShowIP(document.dhcpd.lan_ip.value);
 showDhcpv6Svr();
}
function disabledhcpd()
{
 document.dhcpd.dhcpdenable[0].checked = true;
 showDhcpv6Svr();
}
function enabledhcprelay()
{
 document.dhcpd.dhcpdenable[1].checked = true;
 showDhcpv6Svr();
}
function autodhcpd()
{
 document.dhcpd.dhcpdenable[3].checked = true;
 showDhcpv6Svr();
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">DHCPv6 <% multilang("305" "LANG_SETTINGS"); %></font></h2>
<form action=/boaform/formDhcpv6Server method=POST name="dhcpd">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font color="#000000" size=2>
    <% multilang("666" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_DHCPV6_SERVER_AND_DHCPV6_RELAY"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr>
  <td><font size=2><b>DHCPv6 <% multilang("111" "LANG_MODE"); %>: </b>
  <% checkWrite("dhcpV6Mode"); %>
  </td>
  </tr>
</table>
<table border="0" width="500" cellpadding="0" cellspacing="0">
  <tr><td><hr size=2 noshade align=top></td></tr>
  <tr><td ID="displayDhcpSvr"></td></tr>
</table>
   <br>
      <input type="hidden" value="/dhcpdv6.asp" name="submit-url">
<script>
 <% initPage("dhcpv6-mode"); %>
 showDhcpv6Svr();
</script>
 </form>
</blockquote>
</body>
</html>
