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
<title><% multilang("290" "LANG_MAC_BASED_ASSIGNMENT"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
var pool_ipprefix;
function checkInputIP(client)
{
 var pool_ip, pool_ipstart, pool_ipend, mask;
 var i, mask_d, pool_start_d, pool_end_d;
 if (pool_ipprefix) {
  pool_ip = document.macBase.lan_ip.value;
  mask = document.macBase.lan_mask.value;
 }
 else {
  pool_ipstart = document.macBase.lan_dhcpRangeStart.value;
  pool_ipend = document.macBase.lan_dhcpRangeEnd.value;
  mask = document.macBase.lan_dhcpSubnetMask.value;
 }
 for( i=1;i<5;i++ ) {
  mask_d = getDigit(mask, i);
  pool_start_d = getDigit(pool_ipstart, i);
  pool_end_d = getDigit(pool_ipend, i);
  client_d = getDigit(client, i);
  if( (pool_start_d & mask_d) != (client_d & mask_d ) ) {
   return false;
  }
  if (client_d < pool_start_d || client_d > pool_end_d)
   return false;
 }
 if (pool_ipprefix) {
  if( (parseInt(document.macBase.lan_dhcpRangeStart.value, 10) > client_d) ||
   (parseInt(document.macBase.lan_dhcpRangeEnd.value, 10) < client_d) ) {
   return false;
  }
 }
 return true;
}
function addClick()
{
 var str = document.macBase.hostMac.value;
 var macdigit = 0;
   if ( str.length != 17) {
  alert("<% multilang("2169" "LANG_INPUT_HOST_MAC_ADDRESS_IS_NOT_COMPLETE_IT_SHOULD_BE_17_DIGITS_IN_HEX"); %>");
  document.macBase.hostMac.focus();
  return false;
   }
 if (document.macBase.hostMac.value=="") {
  alert("<% multilang("2170" "LANG_ENTER_HOST_MAC_ADDRES"); %>");
  document.macBase.hostMac.focus();
  return false;
 }
 for (var i=0; i<str.length; i++) {
  if ((str.charAt(i) == 'f') || (str.charAt(i) == 'F'))
   macdigit ++;
  else
   continue;
 }
 if (macdigit == 12 || str == "00-00-00-00-00-00") {
  alert("<% multilang("2066" "LANG_INVALID_MAC_ADDRESS"); %>");
  document.macBase.hostMac.focus();
  return false;
 }
 if (!checkHostIP(document.macBase.hostIp, 1))
  return false;
 if ( validateKey2( document.macBase.hostMac.value ) == 0 ) {
  alert("<% multilang("2171" "LANG_INVALID_HOST_MAC_ADDRESS_IT_SHOULD_BE_IN_HEX_NUMBER_0_9_OR_A_F_OR_A_F"); %>");
  document.macBase.hostMac.focus();
  return false;
 }
 //cathy, for  bug B017
 if ( !checkInputIP(document.macBase.hostIp.value ) ) {
  alert("<% multilang("2172" "LANG_INVALID_IP_ADDRESS_IT_SHOULD_BE_IN_IP_POOL_RANGE"); %>");
  document.macBase.hostIp.focus();
  return false;
 }
 if ( !checkDigitRangeforMac(document.macBase.hostMac.value,1,0,255) ) {
  alert("<% multilang("2173" "LANG_INVALID_SOURCE_RANGE_IN_1ST_HEX_NUMBER_OF_HOST_MAC_ADDRESS_IT_SHOULD_BE_0X00_0XFF"); %>");
  document.macBase.hostMac.focus();
  return false;
 }
 if ( !checkDigitRangeforMac(document.macBase.hostMac.value,2,0,255) ) {
  alert("<% multilang("2174" "LANG_INVALID_SOURCE_RANGE_IN_2ND_HEX_NUMBER_OF_HOST_MAC_ADDRESS_IT_SHOULD_BE_0X00_0XFF"); %>");
  document.macBase.hostMac.focus();
  return false;
 }
 if ( !checkDigitRangeforMac(document.macBase.hostMac.value,3,0,255) ) {
  alert("<% multilang("2175" "LANG_INVALID_SOURCE_RANGE_IN_3RD_HEX_NUMBER_OF_HOST_MAC_ADDRESS_IT_SHOULD_BE_0X00_0XFF"); %>");
  document.macBase.hostMac.focus();
  return false;
 }
 if ( !checkDigitRangeforMac(document.macBase.hostMac.value,4,0,254) ) {
  alert("<% multilang("2176" "LANG_INVALID_SOURCE_RANGE_IN_4TH_HEX_NUMBER_OF_HOST_MAC_ADDRESS_IT_SHOULD_BE_0X00_0XFF"); %>");
  document.macBase.hostMac.focus();
  return false;
 }
 if ( !checkDigitRangeforMac(document.macBase.hostMac.value,5,0,255) ) {
  alert("<% multilang("2177" "LANG_INVALID_SOURCE_RANGE_IN_5RD_HEX_NUMBER_OF_HOST_MAC_ADDRESS_IT_SHOULD_BE_0X00_0XFF"); %>");
  document.macBase.hostMac.focus();
  return false;
 }
 if ( !checkDigitRangeforMac(document.macBase.hostMac.value,6,0,255) ) {
  alert("<% multilang("2178" "LANG_INVALID_SOURCE_RANGE_IN_6TH_HEX_NUMBER_OF_HOST_MAC_ADDRESS_IT_SHOULD_BE_0X00_0XFF"); %>");
  document.macBase.hostMac.focus();
  return false;
 }
 return true;
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("290" "LANG_MAC_BASED_ASSIGNMENT"); %></font></h2>
<table border=0 width="480" cellspacing=0 cellpadding=0>
  <tr><td><font size=2>
 <% multilang("1045" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_STATIC_IP_BASE_ON_MAC_ADDRESS_YOU_CAN_ASSIGN_DELETE_THE_STATIC_IP_THE_HOST_MAC_ADDRESS_PLEASE_INPUT_A_STRING_WITH_HEX_NUMBER_SUCH_AS_00_D0_59_C6_12_43"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/formmacBase method=POST name="macBase">
<input type="hidden" name="lan_ip" value=<% getInfo("dhcplan-ip"); %>>
<input type="hidden" name="lan_mask" value=<% getInfo("dhcplan-subnet"); %>>
<input type="hidden" name="lan_dhcpRangeStart" value=<% getInfo("lan-dhcpRangeStart"); %>>
<input type="hidden" name="lan_dhcpRangeEnd" value=<% getInfo("lan-dhcpRangeEnd"); %>>
<input type="hidden" name="lan_dhcpSubnetMask" value=<% getInfo("lan-dhcpSubnetMask"); %>>
<tr><td>
     <p><font size=2>
        <b><% multilang("72" "LANG_MAC_ADDRESS"); %> (xx-xx-xx-xx-xx-xx): </b> <input type="text" name="hostMac" size="20" maxlength="17">&nbsp;&nbsp;
     </p>
     <p><font size=2>
        <b><% multilang("729" "LANG_ASSIGNED_IP_ADDRESS"); %> (xxx.xxx.xxx.xxx): </b> <input type="text" name="hostIp" size="20" maxlength="15">&nbsp;&nbsp;
     </p>
</td></tr>
<input type="submit" value="<% multilang("721" "LANG_ASSIGN"); %> IP" name="addIP" onClick="return addClick()">&nbsp;&nbsp;
<input type="submit" value="<% multilang("730" "LANG_DELETE_ASSIGNED_IP"); %>" name="delIP">&nbsp;&nbsp;
<input type="hidden" value="/macIptbl.asp" name="submit-url">
<input type="button" value="<% multilang("644" "LANG_CLOSE"); %>" name="close" onClick="javascript: window.close();">
<tr><hr size=1 noshade align=top></tr>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><font size=2><b><% multilang("290" "LANG_MAC_BASED_ASSIGNMENT"); %><% multilang("1046" "LANG_TABLE_2"); %>:</b></font></tr>
  <% showMACBaseTable(); %>
</table>
<script>
 <% initPage("dhcp-macbase"); %>
</script>
</form>
</blockquote>
</body>
</html>
