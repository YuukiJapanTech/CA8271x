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
<title>DHCP <% multilang("305" "LANG_SETTINGS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
var pool_ipprefix;
var initialDhcp;
function skip () { this.blur(); }
function openWindow(url, windowName) {
 var wide=600;
 var high=400;
 if (document.all)
  var xMax = screen.width, yMax = screen.height;
 else if (document.layers)
  var xMax = window.outerWidth, yMax = window.outerHeight;
 else
    var xMax = 640, yMax=480;
 var xOffset = (xMax - wide)/2;
 var yOffset = (yMax - high)/3;
 var settings = 'width='+wide+',height='+high+',screenX='+xOffset+',screenY='+yOffset+',top='+yOffset+',left='+xOffset+', resizable=yes, toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes';
 window.open( url, windowName, settings );
}
function showdns()
{
 if (document.dhcpd.dhcpdns[0].checked == true) {
  if (document.getElementById) // DOM3 = IE5, NS6
   document.getElementById('dnsset').style.display = 'none';
  else {
   if (document.layers == false) // IE4
    document.all.dnsset.style.display = 'none';
  }
 } else {
  if (document.getElementById) // DOM3 = IE5, NS6
   document.getElementById('dnsset').style.display = 'block';
  else {
   if (document.layers == false) // IE4
    document.all.dnsset.style.display = 'block';
  }
 }
}
function showDhcpSvr(ip)
{
 var html;
 if (document.dhcpd.dhcpdenable[0].checked == true)
  document.getElementById('displayDhcpSvr').innerHTML=
   '<input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save">&nbsp;&nbsp;';
 else if (document.dhcpd.dhcpdenable[1].checked == true)
  document.getElementById('displayDhcpSvr').innerHTML=
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
   '<tr><font color="#000000" size=2>'+
   '<% multilang("282" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_DHCP_SERVER_IP_ADDRESS_FOR_DHCP_RELAY"); %>'+
   '</font></tr>'+
   '<tr><td><hr size=1 noshade align=top></td></tr>'+
   '</table>'+
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
   '<tr>'+
   '<td width="40%"><font size=2><b>DHCP <% multilang("71" "LANG_SERVER"); %> <% multilang("69" "LANG_IP_ADDRESS"); %>:</b></td>'+
   '<td width="60%"><font size=2><input type="text" name="dhcps" size="18" maxlength="15" value=<% getInfo("wan-dhcps"); %>></td>'+
   '</tr>'+
   '</table>'+
   '<input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveClick()">&nbsp;&nbsp;';
 else if (document.dhcpd.dhcpdenable[2].checked == true) {
  html=
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
   '<tr><font color="#000000" size=2>'+
   '<% multilang("283" "LANG_ENABLE_THE_DHCP_SERVER_IF_YOU_ARE_USING_THIS_DEVICE_AS_A_DHCP_SERVER_THIS_PAGE_LISTS_THE_IP_ADDRESS_POOLS_AVAILABLE_TO_HOSTS_ON_YOUR_LAN_THE_DEVICE_DISTRIBUTES_NUMBERS_IN_THE_POOL_TO_HOSTS_ON_YOUR_NETWORK_AS_THEY_REQUEST_INTERNET_ACCESS"); %>'+
   '</font></tr>'+
   '<tr><td><hr size=1 noshade align=top></td></tr>'+
   '<tr><td><font color="#000000" size=2><b><% multilang("6" "LANG_LAN"); %> <% multilang("69" "LANG_IP_ADDRESS"); %>: </b><% getInfo("dhcplan-ip"); %>&nbsp;&nbsp;&nbsp;'+
   '<b><% multilang("70" "LANG_SUBNET_MASK"); %>: </b><% getInfo("dhcplan-subnet"); %>'+
   '</font></td></tr>'+
   '</table>'+
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
   '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("284" "LANG_IP_POOL_RANGE"); %>:</b></td>';
  if (pool_ipprefix)
   html+=
    '<td width="70%"><font size=2><b>'+pool_ipprefix+'<input type="text" name="dhcpRangeStart" size=3 maxlength=3 value="<% getInfo("lan-dhcpRangeStart"); %>">'+
    '<font face="Arial" size="5">- </font><font size=2>'+pool_ipprefix+'<input type="text" name="dhcpRangeEnd" size=3 maxlength=3 value="<% getInfo("lan-dhcpRangeEnd"); %>">&nbsp;';
  else
   html+=
    '<td width="70%"><input type="text" name="dhcpRangeStart" size=15 maxlength=15 value="<% getInfo("lan-dhcpRangeStart"); %>">'+
    '<font face="Arial" size="5">- <input type="text" name="dhcpRangeEnd" size=15 maxlength=15 value="<% getInfo("lan-dhcpRangeEnd"); %>">&nbsp;';
  html+=
   '<input type="button" value="<% multilang("285" "LANG_SHOW_CLIENT"); %>" name="dhcpClientTbl" onClick="dhcpTblClick(\'/dhcptbl.asp\')" >'+
   '</td>'+
   '</tr>';
  if (!pool_ipprefix)
  {
   html +='<tr>'+
    '<td width="30%"><font size=2><b><% multilang("70" "LANG_SUBNET_MASK"); %>:</b></td>'+
    '<td width="70%"><font size=2>'+
    '<input type="text" name="dhcpSubnetMask" size=15 maxlength=15 value="<% getInfo("lan-dhcpSubnetMask"); %>">&nbsp;'+
    '</td>'+
    '</tr>';
  }
  html += '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("286" "LANG_MAX_LEASE_TIME"); %>:</b></td>'+
   '<td width="70%"><font size=2>'+
   '<input type="text" name="ltime" size=10 maxlength=9 value="<% getInfo("lan-dhcpLTime"); %>"><b> <% multilang("287" "LANG_SECONDS"); %></b><b> (<% multilang("288" "LANG_MINUS_1_INDICATES_AN_INFINITE_LEASE"); %>)</b>'+
   '</td>'+
   '</tr>'+
   '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("349" "LANG_DOMAIN"); %><% multilang("604" "LANG_NAME"); %>:</b></td>'+
   '<td width="70%">'+
   '<input type="text" name="dname" size=32 maxlength=29 value="<% getInfo("lan-dhcpDName"); %>">'+
   '</td>'+
   '</tr>'+
   '<tr>'+
   '<td width="30%"><font size=2><b><% multilang("289" "LANG_GATEWAY_ADDRESS"); %>:</b></td>'+
   '<td width="70%"><input type="text" name="ip" size="15" maxlength="15" value=<% getInfo("lan-dhcp-gateway"); %>></td>'+
   '</tr>'+
   '</table>';
  if (en_dnsopt == 0)
   html += '<div ID=optID style="display:none">';
  else
   html += '<div ID=optID style="display:block">';
  html +=
   '<table border=0 width="500" cellspacing=4 cellpadding=0><tr>'+
   '<td width="30%"><font size=2><b>DNS option:</b></td>'+
   '<td width=70%><input type=radio name=dhcpdns value=0 onClick=showdns()>Use DNS Relay&nbsp;&nbsp;'+
   '<input type=radio name=dhcpdns value=1 onClick=showdns()>Set Manually&nbsp;&nbsp;</td>'+
   '</tr></table></div>'+
   '<div ID=dnsset style="display:none">'+
   '<table border=0 width="500" cellspacing=4 cellpadding=0>'+
   '<tr><td width=30%><b>DNS1:</b></td><td width=70%><input type=text name=dns1 value=<% getInfo("dhcps-dns1"); %>></td></tr>'+
   '<tr><td width=30%><b>DNS2:</b></td><td width=70%><input type=text name=dns2 value=<% getInfo("dhcps-dns2"); %>></td></tr>'+
   '<tr><td width=30%><b>DNS3:</b></td><td width=70%><input type=text name=dns3 value=<% getInfo("dhcps-dns3"); %>></td></tr></table></div>'+
   '<input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">&nbsp;&nbsp;'+
   '<input type="button" value="<% multilang("290" "LANG_MAC_BASED_ASSIGNMENT"); %>" name="macIpTbl" onClick="macIpClick(\'/macIptbl.asp\')">'+
   '<input type="button" value="<% multilang("4" "LANG_DEVICE"); %> <% multilang("653" "LANG_IP_RANGE"); %>" name="clientIpTbl" onClick="clientIpClick(\'/devicetbl.asp\')">';
  document.getElementById('displayDhcpSvr').innerHTML=html;
  if (en_dnsopt) {
   document.dhcpd.dhcpdns[dnsopt].checked = true;
   showdns();
  }
 }
}
function checkInputIP(ip)
{
 var i, ip_d;
 for (i=1; i<5; i++) {
  ip_d = getDigit(ip, i);
 }
 if ((ip_d >= parseInt(document.dhcpd.dhcpRangeStart.value, 10)) && (ip_d <= parseInt(document.dhcpd.dhcpRangeEnd.value, 10))) {
  return false;
 }
 return true;
}
function saveClick()
{
 if (!checkHostIP(document.dhcpd.dhcps, 1)) {
    return false;
   }
 return true;
}
function checkSubnet(ip, mask, client)
{
  ip_d = getDigit(ip, 4);
  mask_d = getDigit(mask, 4);
  if ( (ip_d & mask_d) != (client & mask_d ) )
 return false;
  return true;
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
   if ( includeSpace(document.dhcpd.dname.value)) {
  alert('<% multilang("2000" "LANG_INVALID_DOMAIN_NAME"); %>');
  document.dhcpd.dname.focus();
  return false;
  }
 if (checkString(document.dhcpd.dname.value) == 0) {
  alert('<% multilang("2000" "LANG_INVALID_DOMAIN_NAME"); %>');
  document.dhcpd.dname.focus();
  return false;
 }
 if (pool_ipprefix) {
 if (document.dhcpd.dhcpRangeStart.value=="") {
  alert('<% multilang("2001" "LANG_PLEASE_INPUT_DHCP_IP_POOL_RANGE_"); %>');
  document.dhcpd.dhcpRangeStart.value = document.dhcpd.dhcpRangeStart.defaultValue;
  document.dhcpd.dhcpRangeStart.focus();
  return false;
 }
 if ( validateKey( document.dhcpd.dhcpRangeStart.value ) == 0 ) {
  alert('<% multilang("2002" "LANG_INVALID_DHCP_CLIENT_START_RANGE_IT_SHOULD_BE_1_254"); %>');
  document.dhcpd.dhcpRangeStart.value = document.dhcpd.dhcpRangeStart.defaultValue;
  document.dhcpd.dhcpRangeStart.focus();
  return false;
 }
 if ( !checkDigitRange(document.dhcpd.dhcpRangeStart.value,1,1,254) ) {
  alert('<% multilang("2002" "LANG_INVALID_DHCP_CLIENT_START_RANGE_IT_SHOULD_BE_1_254"); %>');
  document.dhcpd.dhcpRangeStart.value = document.dhcpd.dhcpRangeStart.defaultValue;
  document.dhcpd.dhcpRangeStart.focus();
  return false;
 }
 if ( !checkSubnet(document.dhcpd.lan_ip.value,document.dhcpd.lan_mask.value,document.dhcpd.dhcpRangeStart.value)) {
  alert('<% multilang("2003" "LANG_INVALID_DHCP_CLIENT_START_ADDRESSIT_SHOULD_BE_LOCATED_IN_THE_SAME_SUBNET_OF_CURRENT_IP_ADDRESS"); %>');
  document.dhcpd.dhcpRangeStart.value = document.dhcpd.dhcpRangeStart.defaultValue;
  document.dhcpd.dhcpRangeStart.focus();
  return false;
 }
 if (document.dhcpd.dhcpRangeEnd.value=="") {
  alert('<% multilang("2004" "LANG_PLEASE_INPUT_DHCP_IP_POOL_RANGE"); %>');
  document.dhcpd.dhcpRangeEnd.value = document.dhcpd.dhcpRangeEnd.defaultValue;
  document.dhcpd.dhcpRangeEnd.focus();
  return false;
 }
 if ( validateKey( document.dhcpd.dhcpRangeEnd.value ) == 0 ) {
  alert('<% multilang("2005" "LANG_INVALID_DHCP_CLIENT_END_ADDRESS_RANGE_IT_SHOULD_BE_1_254"); %>');
  document.dhcpd.dhcpRangeEnd.value = document.dhcpd.dhcpRangeEnd.defaultValue;
  document.dhcpd.dhcpRangeEnd.focus();
  return false;
 }
 if ( !checkDigitRange(document.dhcpd.dhcpRangeEnd.value,1,1,254) ) {
  alert('<% multilang("2006" "LANG_INVALID_DHCP_CLIENT_END_RANGE_IT_SHOULD_BE_1_254"); %>');
  document.dhcpd.dhcpRangeEnd.value = document.dhcpd.dhcpRangeEnd.defaultValue;
  document.dhcpd.dhcpRangeEnd.focus();
  return false;
 }
 if ( !checkSubnet(document.dhcpd.lan_ip.value,document.dhcpd.lan_mask.value,document.dhcpd.dhcpRangeEnd.value)) {
  alert('<% multilang("2007" "LANG_INVALID_DHCP_CLIENT_END_ADDRESSIT_SHOULD_BE_LOCATED_IN_THE_SAME_SUBNET_OF_CURRENT_IP_ADDRESS"); %>');
  document.dhcpd.dhcpRangeEnd.value = document.dhcpd.dhcpRangeEnd.defaultValue;
  document.dhcpd.dhcpRangeEnd.focus();
  return false;
 }
 if ( parseInt(document.dhcpd.dhcpRangeStart.value, 10) >= parseInt(document.dhcpd.dhcpRangeEnd.value, 10) ) {
  alert('<% multilang("2008" "LANG_INVALID_DHCP_CLIENT_ADDRESS_RANGEENDING_ADDRESS_SHOULD_BE_GREATER_THAN_STARTING_ADDRESS"); %>');
  document.dhcpd.dhcpRangeStart.focus();
  return false;
 }
 }
 else {
  if (!checkHostIP(document.dhcpd.dhcpRangeStart, 1)) {
   document.dhcpd.dhcpRangeStart.value = document.dhcpd.dhcpRangeStart.defaultValue;
   document.dhcpd.dhcpRangeStart.focus();
   return false;
  }
  if (!checkHostIP(document.dhcpd.dhcpRangeEnd, 1)) {
   document.dhcpd.dhcpRangeEnd.value = document.dhcpd.dhcpRangeEnd.defaultValue;
   document.dhcpd.dhcpRangeEnd.focus();
   return false;
  }
 }
 if (!checkInputIP(document.dhcpd.lan_ip.value)) {
  alert('<% multilang("2009" "LANG_INVALID_IP_POOL_RANGE_LAN_IP_MUST_BE_EXCLUDED_FROM_DHCP_IP_POOL"); %>');
  document.dhcpd.dhcpRangeStart.focus();
  return false;
 }
 if ( document.dhcpd.ltime.value=="") {
  alert('<% multilang("2010" "LANG_PLEASE_INPUT_DHCP_LEASE_TIME"); %>');
  document.dhcpd.ltime.focus();
  return false;
 }
 if ( validateKey_leasetime( document.dhcpd.ltime.value ) == 0 ) {
  alert('<% multilang("2011" "LANG_INVALID_DHCP_SERVER_LEASE_TIME_NUMBER"); %>');
  document.dhcpd.ltime.value = document.dhcpd.ltime.defaultValue;
  document.dhcpd.ltime.focus();
  return false;
 }
 if ( !checkDigitRange_leaseTime(document.dhcpd.ltime.value, -1) ) {
  alert('<% multilang("2012" "LANG_INVALID_DHCP_SERVER_LEASE_TIME"); %>');
  document.dhcpd.ltime.value = document.dhcpd.ltime.defaultValue;
  document.dhcpd.ltime.focus();
  return false;
 }
 if (!checkHostIP(document.dhcpd.ip, 1))
  return false;
 /*if (document.dhcpd.ip.value=="") {
		alert("Gateway address cannot be empty! It should be filled with 4 digit numbers as xxx.xxx.xxx.xxx.");
		document.dhcpd.ip.value = document.dhcpd.ip.defaultValue;
		document.dhcpd.ip.focus();
		return false;
  	}
  	if ( validateKey( document.dhcpd.ip.value ) == 0 ) {
		alert("Invalid Gateway address value. It should be the decimal number (0-9).");
		document.dhcpd.ip.value = document.dhcpd.ip.defaultValue;
		document.dhcpd.ip.focus();
		return false;
  	}

  	if( IsLoopBackIP( document.dhcpd.ip.value)==1 ) {
			alert("Invalid Gateway address value.");
			document.dhcpd.ip.focus();
			return false;
  	}

  	if ( !checkDigitRange(document.dhcpd.ip.value,1,0,223) ) {
  	    	alert('Invalid Gateway address range in 1st digit. It should be 0-223.');
		document.dhcpd.ip.value = document.dhcpd.ip.defaultValue;
		document.dhcpd.ip.focus();
		return false;
  	}
  	if ( !checkDigitRange(document.dhcpd.ip.value,2,0,255) ) {
  	    	alert('Invalid Gateway address range in 2nd digit. It should be 0-255.');
		document.dhcpd.ip.value = document.dhcpd.ip.defaultValue;
		document.dhcpd.ip.focus();
		return false;
  	}
  	if ( !checkDigitRange(document.dhcpd.ip.value,3,0,255) ) {
  	    	alert('Invalid Gateway address range in 3rd digit. It should be 0-255.');
		document.dhcpd.ip.value = document.dhcpd.ip.defaultValue;
		document.dhcpd.ip.focus();
		return false;
  	}
  	if ( !checkDigitRange(document.dhcpd.ip.value,4,1,254) ) {
  	    	alert('Invalid Gateway address range in 4th digit. It should be 1-254.');
		document.dhcpd.ip.value = document.dhcpd.ip.defaultValue;
		document.dhcpd.ip.focus();
		return false;
  	}*/
   if (en_dnsopt && document.dhcpd.dhcpdns[1].checked) {
  if (document.dhcpd.dns1.value=="") {
   alert('<% multilang("2020" "LANG_ENTER_DNS_VALUE"); %>');
   document.dhcpd.dhcpdns.value = document.dhcpd.dhcpdns.defaultValue;
   document.dhcpd.dns1.value = document.dhcpd.dns1.defaultValue;
   document.dhcpd.dns1.focus();
   return false;
  }
  if (!checkHostIP(document.dhcpd.dns1, 1)) {
   document.dhcpd.dns1.value = document.dhcpd.dns1.defaultValue;
   document.dhcpd.dns1.focus();
   return false;
  }
  if (document.dhcpd.dns2.value!="") {
   if (!checkHostIP(document.dhcpd.dns2, 0)) {
    document.dhcpd.dns2.value = document.dhcpd.dns2.defaultValue;
    document.dhcpd.dns2.focus();
    return false;
   }
   if (document.dhcpd.dns3.value!="") {
    if (!checkHostIP(document.dhcpd.dns3, 0)) {
     document.dhcpd.dns3.value = document.dhcpd.dns3.defaultValue;
     document.dhcpd.dns3.focus();
     return false;
    }
   }
  }
 }
 return true;
}
function dhcpTblClick(url) {
 openWindow(url, 'DHCPTbl' );
}
function ShowIP2(ipVal) {
 document.write(getDigit(ipVal,1));
 document.write('.');
 document.write(getDigit(ipVal,2));
 document.write('.');
 document.write(getDigit(ipVal,3));
 document.write('.');
}
function ShowIP(ipVal) {
 var str;
 str = getDigit(ipVal, 1) + '.';
 str += getDigit(ipVal, 2) + '.';
 str += getDigit(ipVal, 3) + '.';
 return str;
}
function macIpClick(url)
{
 var wide=600;
 var high=400;
 if (document.all)
  var xMax = screen.width, yMax = screen.height;
 else if (document.layers)
  var xMax = window.outerWidth, yMax = window.outerHeight;
 else
    var xMax = 640, yMax=480;
 var xOffset = (xMax - wide)/2;
 var yOffset = (yMax - high)/3;
 var settings = 'width='+wide+',height='+high+',screenX='+xOffset+',screenY='+yOffset+',top='+yOffset+',left='+xOffset+', resizable=yes, toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes';
 window.open( url, 'MACIPTbl', settings );
}
function clientIpClick(url)
{
 var wide=600;
 var high=400;
 if (document.all)
  var xMax = screen.width, yMax = screen.height;
 else if (document.layers)
  var xMax = window.outerWidth, yMax = window.outerHeight;
 else
    var xMax = 640, yMax=480;
 var xOffset = (xMax - wide)/2;
 var yOffset = (yMax - high)/3;
 var settings = 'width='+wide+',height='+high+',screenX='+xOffset+',screenY='+yOffset+',top='+yOffset+',left='+xOffset+', resizable=yes, toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes';
 window.open( url, 'DEVICETbl', settings );
}
function enabledhcpd()
{
 document.dhcpd.dhcpdenable[2].checked = true;
 //ip = ShowIP(document.dhcpd.lan_ip.value);
 showDhcpSvr(pool_ipprefix);
}
function disabledhcpd()
{
 document.dhcpd.dhcpdenable[0].checked = true;
 showDhcpSvr();
}
function enabledhcprelay()
{
 document.dhcpd.dhcpdenable[1].checked = true;
 showDhcpSvr();
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">DHCP <% multilang("305" "LANG_SETTINGS"); %></font></h2>
<form action=/boaform/formDhcpServer method=POST name="dhcpd">
<input type="hidden" name="lan_ip" value=<% getInfo("dhcplan-ip"); %>>
<input type="hidden" name="lan_mask" value=<% getInfo("dhcplan-subnet"); %>>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font color="#000000" size=2>
    <% multilang("280" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_DHCP_SERVER_AND_DHCP_RELAY"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr>
  <td><font size=2><b>DHCP <% multilang("111" "LANG_MODE"); %>: </b>
  <% checkWrite("dhcpMode"); %>
  </td>
  </tr>
</table>
<table border="0" width="500" cellpadding="0" cellspacing="0">
  <tr><td><hr size=2 noshade align=top></td></tr>
  <tr><td ID="displayDhcpSvr"></td></tr>
</table>
   <br>
      <input type="hidden" value="/dhcpd_sc.asp" name="submit-url">
<script>
 <% initPage("dhcp-mode"); %>
 //ip = ShowIP(document.dhcpd.lan_ip.value);
 showDhcpSvr(pool_ipprefix);
</script>
 </form>
</blockquote>
</body>
</html>
