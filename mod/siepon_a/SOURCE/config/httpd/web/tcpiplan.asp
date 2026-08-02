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
<title><% multilang("96" "LANG_LAN_INTERFACE_SETTINGS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function resetClick()
{
 document.tcpip.reset;
}
function saveChanges()
{
 var lpm1 = 0;
 var lpm2 = 0;
 if (!checkHostIP(document.tcpip.ip, 1))
  return false;
 if (!checkNetmask(document.tcpip.mask, 1))
  return false;
 // Magician 2013/08/23: LAN port mask.
 with (document.forms[0])
 {
  if(typeof chk_port_mask1 != 'undefined' && chk_port_mask1 != null){
   for (var i = 0; i < chk_port_mask1.length; i++) {
    if (chk_port_mask1[i].checked == true)
     lpm1 |= (0x1 << i);
   }
   lan_port_mask1.value = lpm1;
  }
  if(typeof chk_port_mask2 != 'undefined' && chk_port_mask2 != null){
   for (var i = 0; i < chk_port_mask2.length; i++) {
    if (chk_port_mask2[i].checked == true)
     lpm2 |= (0x1 << i);
   }
   lan_port_mask2.value = lpm2;
  }
  if((ip_version1.selectedIndex != 0) && (ipv6_mode1[1].checked)){ //IPv6 enabled && mode is manual
   if (ipv6_addr1.value =="" || ipv6_addr1.value =="::") {
    alert("<% multilang("2312" "LANG_LAN_IPV6_ADDRESS_CANNOT_BE_EMPTY_FORMAT_IS_IPV6_ADDRESS_FOR_EXAMPLE_3FFE_501_FFFF_100_1"); %>");
    ipv6_addr1.focus();
    return false;
   } else {
    if ( validateKeyV6IP(ipv6_addr1.value) == 0) {
     alert("<% multilang("2313" "LANG_INVALID_LAN_IPV6_IP"); %>");
     ipv6_addr1.focus();
     return false;
    }
   }
   if (ipv6_prefix1.value =="") {
    alert("<% multilang("2314" "LANG_LAN_IPV6_ADDRESS_IPV6_PREFIX1_CANNOT_BE_EMPTY_VALID_NUMBER_IS_0_127"); %>");
    ipv6_prefix1.focus();
    return false;
   } else {
    var prefixInt = parseInt(ipv6_prefix1.value);
    if ( prefixInt>127 ||prefixInt<0) {
     alert("<% multilang("2315" "LANG_INVALID_LAN_IPV6_PREVIX"); %>");
     ipv6_prefix1.focus();
     return false;
    }
   }
  }
 }
 // End Magician
 <% checkIP2(); %>
 return true;
}
function disableRadioGroup (radioArrOrButton)
{
  if (radioArrOrButton.type && radioArrOrButton.type == "radio") {
  var radioButton = radioArrOrButton;
  var radioArray = radioButton.form[radioButton.name];
  }
  else
  var radioArray = radioArrOrButton;
  radioArray.disabled = true;
  for (var b = 0; b < radioArray.length; b++) {
  if (radioArray[b].checked) {
   radioArray.checkedElement = radioArray[b];
   break;
 }
  }
  for (var b = 0; b < radioArray.length; b++) {
  radioArray[b].disabled = true;
  radioArray[b].checkedElement = radioArray.checkedElement;
  }
}
function updateState()
{
  if (document.tcpip.wlanDisabled.value == "ON") {
    disableRadioGroup(document.tcpip.BlockEth2Wir);
  }
}
function ipv6_mode1_change()
{
 with (document.forms[0])
 {
  if(ipv6_mode1[0].checked)
  {
   ipv6_addr1.disabled = true;
   ipv6_prefix1.disabled = true;
  }
  else
  {
   ipv6_addr1.disabled = false;
   ipv6_prefix1.disabled = false;
   if(ipv6_addr1.value =="::")
    ipv6_addr1.value ="";
  }
 }
}
function ipv6_mode2_change()
{
 with (document.forms[0])
 {
  if(ipv6_mode2[0].checked)
  {
   ipv6_addr2.disabled = true;
   ipv6_prefix2.disabled = true;
  }
  else
  {
   ipv6_addr2.disabled = false;
   ipv6_prefix2.disabled = false;
  }
 }
}
function ipv6_version1_change()
{
 with (document.forms[0])
 {
  if(ip_version1.selectedIndex == 0)
  {
   ipv6_mode1[0].disabled = true;
   ipv6_mode1[1].disabled = true;
   ipv6_addr1.disabled = true;
   ipv6_prefix1.disabled = true;
   ip.disabled = false;
   mask.disabled = false;
  }
  else
  {
   ipv6_mode1[0].disabled = false;
   ipv6_mode1[1].disabled = false;
   ipv6_addr1.disabled = false;
   ipv6_prefix1.disabled = false;
   ip.disabled = false;
   mask.disabled = false;
   ipv6_mode1_change();
  }
 }
}
function on_init()
{
 ipv6_version1_change();
}
<% lanScript(); %>
</SCRIPT>
</head>
<BODY onLoad="on_init();">
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("96" "LANG_LAN_INTERFACE_SETTINGS"); %></font></h2>
<form action=/boaform/formTcpipLanSetup method=POST name="tcpip">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("97" "LANG_PAGE_DESC_CONFIG_DEVICE_LAN_INTERFACE"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
 <input type=hidden name="wlanDisabled" value=<% wlanStatus(); %>>
  <tr>
      <td width="30%"><font size=2><b><% multilang("52" "LANG_INTERFACE"); %><% multilang("604" "LANG_NAME"); %>:</b></td>
      <td width="70%"><b>br0</b></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("69" "LANG_IP_ADDRESS"); %>:</b></td>
      <td width="70%"><input type="text" name="ip" size="15" maxlength="15" value=<% getInfo("lan-ip"); %>></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("70" "LANG_SUBNET_MASK"); %>:</b></td>
      <td width="70%"><input type="text" name="mask" size="15" maxlength="15" value="<% getInfo("lan-subnet"); %>"></td>
  </tr>
 <tr id=tr_ipv6_mode1 <% checkWrite("rg_only_function"); %>>
  <td width=150><font size=2><b><% multilang("102" "LANG_IPV6_ADDRESS_MODE"); %>:</b></td>
  <td width=350><font size=2>
   <input type="radio" name="ipv6_mode1" value=0 OnChange="ipv6_mode1_change()" <% checkWrite("lan_ipv6_mode_auto"); %> ><% multilang("136" "LANG_AUTO"); %>
   <input type="radio" name="ipv6_mode1" value=1 OnChange="ipv6_mode1_change()" <% checkWrite("lan_ipv6_mode_manual"); %>><% multilang("391" "LANG_MANUAL"); %>
  </td>
 </tr>
  <tr id=tr_ipv6_addr1 <% checkWrite("rg_only_function"); %>>
      <td width="30%"><font size=2><b><% multilang("83" "LANG_IPV6_ADDRESS"); %>:</b></td>
      <td width="70%"><input type="text" name="ipv6_addr1" size="30" maxlength="60" value=0></td>
  </tr>
  <tr id=tr_ipv6_prefix1 <% checkWrite("rg_only_function"); %>>
      <td width="30%"><font size=2><b><% multilang("103" "LANG_IPV6_PREFIX_LENGTH"); %>:</b></td>
      <td width="70%"><input type="text" name="ipv6_prefix1" size="5" maxlength="5" value=0></td>
  </tr>
   <!-- Hide VID setting temporarily -->
 <tr style="display:none">
  <td width="30%"><font size=2><b><% multilang("104" "LANG_VLAN_ID"); %>:</b></td>
  <td width="70%"><input type="text" name="lan_vlan_id1" size="15" maxlength="15" value="<% getInfo("lan_vlan_id1"); %>"></td>
 </tr>
 <tr <% checkWrite("rg_only_function"); %>>
  <td width="30%"><font size=2><b><% multilang("105" "LANG_IP_VERSION"); %>:</b></td>
  <td width="70%">
   <select size="1" name="ip_version1" OnChange="ipv6_version1_change()">
    <option <% checkWrite("lan_ipverion_v4only"); %> value="0">IPv4</option>
    <option <% checkWrite("lan_ipverion_v4v6"); %> value="2">IPv4/IPv6</option>
   </select>
  </td>
 </tr>
 <tr <% checkWrite("rg_only_function"); %>>
   <% lan_port_mask(); %>
 </tr>
    <tr></tr><tr></tr>
  </table>
    <% lan_setting(); %>
  <br>
      <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">&nbsp;&nbsp;
      <!--input type="reset" value="Undo" name="reset" onClick="resetClick()"-->
      <input type="hidden" value="/tcpiplan.asp" name="submit-url">
   <input type="hidden" name="lan_port_mask1" value=0>
   <input type="hidden" name="lan_port_mask2" value=0>
<script>
 <% initPage("lan"); %>
 updateState();
</script>
 </form>
</blockquote>
</body>
</html>
